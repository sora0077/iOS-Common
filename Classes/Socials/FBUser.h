//
//  FBUser.h
//  iOS-Common
//
//  Created by 林 達也 on 2013/12/28.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FBRequest.h>
#import <FacebookSDK/FBSession.h>

#define ENABLE_EMAIL_PERMISSION

/**
 *
 **/

@class FBActiveUser;
@interface FBUser : NSObject

+ (FBActiveUser *)activeUser;

@property (readonly) NSString *id;
@property (readonly) NSString *name;
@property (readonly) NSString *picture;

#ifdef ENABLE_EMAIL_PERMISSION
@property (readonly) NSString *email;
#endif


@property (readonly) NSDictionary *userInfo;

@end

/**
 *
 **/

@interface FBActiveUser : FBUser

@property (readonly) NSArray *logs;

- (void)login:(void (^)(FBUser *user, NSError *error))completion;
- (void)logout;


- (void)read:(FBRequest *)request permissions:(NSArray *)permissions completion:(void (^)(id result, NSError *error))completion;
- (void)publish:(FBRequest *)request permissions:(NSArray *)permissions  audience:(FBSessionDefaultAudience)audience completion:(void (^)(id result, NSError *error))completion;

@end
