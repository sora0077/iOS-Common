//
//  FBUser.h
//  iOS-Common
//
//  Created by 林 達也 on 2013/12/28.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FBRequest.h>

@class FBActiveUser;
@interface FBUser : NSObject

+ (FBActiveUser *)activeUser;


@property (readonly) NSDictionary *userInfo;

@end

@interface FBActiveUser : FBUser

@property (readonly) NSArray *logs;

- (void)request:(FBRequest *)request permissions:(NSArray *)permissions completion:(void (^)(id result, NSError *error))completion;

@end
