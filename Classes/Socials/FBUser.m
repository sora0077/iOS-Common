//
//  FBUser.m
//  iOS-Common
//
//  Created by 林 達也 on 2013/12/28.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import "FBUser.h"
#import <FacebookSDK/FacebookSDK.h>

#ifdef ENABLE_EMAIL_PERMISSION
#   define BASIC_PERMISSION @"email"
#else
#   define BASIC_PERMISSION @"basic_info"
#endif

typedef NS_ENUM(NSInteger, FBActiveUserActionState){
    FBActiveUserActionStateLogin,
    FBActiveUserActionStateLogout,
    FBActiveUserActionStateOther,
};


@interface FBUser ()
@property (strong, nonatomic) NSDictionary *userInfo;
@end

@implementation FBUser
{
    NSDictionary *_userInfo;
}

+ (FBActiveUser *)activeUser
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FBActiveUser alloc] init];
    });
    return instance;
}

- (NSString *)id
{
    return _userInfo[@"id"];
}

- (NSString *)name
{
    return _userInfo[@"name"];
}

- (NSString *)email
{
    return _userInfo[@"email"];
}

- (NSString *)picture
{
    return _userInfo[@"picture"][@"data"][@"url"];
}

@end


@implementation FBActiveUser
{
    FBActiveUserActionState _actionState;
}

+ (void)load
{
    [self activeUser];
}

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidActiveNotification:)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillTerminateNotification:)
                                                     name:UIApplicationWillTerminateNotification
                                                   object:nil];

        if ([FBSession activeSession].state == FBSessionStateCreatedTokenLoaded) {
            [FBSession openActiveSessionWithReadPermissions:@[BASIC_PERMISSION]
                                               allowLoginUI:NO
                                          completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                                              [self sessionStateChanged:session state:status error:error];
                                          }];
        }
    }
    return self;
}

#pragma mark - Public method

- (void)login:(void (^)(FBUser *, NSError *))completion
{
    if ([FBSession activeSession].isOpen) {
        if (self.userInfo) {
            if (completion) completion(self, nil);
        } else {
            FBRequest *request = [FBRequest requestWithGraphPath:@"me"
                                                      parameters:@{@"fields": @"id,name,email,picture.height(200).width(200)"}
                                                      HTTPMethod:@"GET"];
            [self read:request permissions:@[BASIC_PERMISSION] completion:^(id result, NSError *error) {
                self.userInfo = [result dictionaryWithValuesForKeys:[result allKeys]];
                if (completion) completion(self, error);
            }];
        }
    } else {
        _actionState = FBActiveUserActionStateLogin;
        [FBSession openActiveSessionWithReadPermissions:@[BASIC_PERMISSION]
                                           allowLoginUI:YES
                                      completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                                          [self sessionStateChanged:session state:status error:error];
                                          if (_actionState == FBActiveUserActionStateLogin) {
                                              if (session.isOpen) {
                                                  [self login:completion];
                                              } else {
                                                  if (completion) completion(nil, error);
                                              }
                                              _actionState = FBActiveUserActionStateOther;
                                          }
                                      }];
    }
}

- (void)logout
{
    if ([FBSession activeSession].isOpen) {
        [[FBSession activeSession] closeAndClearTokenInformation];
    }
    self.userInfo = nil;
}

- (void)read:(FBRequest *)request permissions:(NSArray *)permissions completion:(void (^)(id, NSError *))completion
{
    if ([FBSession activeSession].isOpen) {
        permissions = [self requiredPermissions:permissions];
        if (permissions.count) {
            [[FBSession activeSession] requestNewReadPermissions:permissions completionHandler:^(FBSession *session, NSError *error) {
                if (session.state == FBSessionStateOpenTokenExtended) {
                    [self read:request permissions:permissions completion:completion];
                } else {
                    if (completion) completion(nil, error);
                }
            }];
        } else {
            [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (completion) {
                    completion(result, error);
                }
            }];
        }
    } else {
        [self login:^(FBUser *user, NSError *error) {
            if (!error) {
                [self read:request permissions:permissions completion:completion];
            } else {
                if (completion) completion(nil, error);
            }
        }];
    }
}

- (void)publish:(FBRequest *)request permissions:(NSArray *)permissions audience:(FBSessionDefaultAudience)audience completion:(void (^)(id, NSError *))completion
{
    if ([FBSession activeSession].isOpen) {
        permissions = [self requiredPermissions:permissions];
        if (permissions.count) {
            [[FBSession activeSession] requestNewPublishPermissions:permissions defaultAudience:audience completionHandler:^(FBSession *session, NSError *error) {
                if (session.state == FBSessionStateOpenTokenExtended) {
                    [self read:request permissions:permissions completion:completion];
                } else {
                    if (completion) completion(nil, error);
                }
            }];
        } else {
            [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (completion) {
                    completion(result, error);
                }
            }];
        }
    } else {
        [self login:^(FBUser *user, NSError *error) {
            if (!error) {
                [self publish:request permissions:permissions audience:audience completion:completion];
            } else {
                if (completion) completion(nil, error);
            }
        }];
    }
}

#pragma mark - Private method

- (NSArray *)requiredPermissions:(NSArray *)permissions
{
    NSSet *set = [NSSet setWithArray:[FBSession activeSession].permissions ? : @[]];
    NSMutableSet *in = [NSMutableSet setWithArray:permissions ?: @[]];

    [in minusSet:set];
    return in.allObjects;
}

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState)state error:(NSError *)error
{
    if (!error && state == FBSessionStateOpen) {
        NSLog(@"%s", __func__);
        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed) {
        self.userInfo = nil;
    }

    if (error) {
        if ([FBErrorUtility shouldNotifyUserForError:error]) {
            NSString *message = [FBErrorUtility userMessageForError:error];
            NSLog(@"%@", message);
        } else {
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"user cancel");
            } else {
                NSDictionary *errorInfo = error.userInfo[@"com.facebook.sdk:ParsedJSONResponseKey"][@"body"][@"error"];
                NSLog(@"%@", errorInfo);
            }
        }
        [[FBSession activeSession] closeAndClearTokenInformation];

        
    }
}

#pragma mark - 

- (void)applicationDidActiveNotification:(NSNotification *)notification
{
    [FBAppCall handleDidBecomeActive];
}

- (void)applicationWillTerminateNotification:(NSNotification *)notification
{
    [[FBSession activeSession] close];
}

@end
