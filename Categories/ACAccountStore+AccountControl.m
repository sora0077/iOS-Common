//
//  ACAccountStore+AccountControl.m
//  VividTunes
//
//  Created by 林 達也 on 2013/11/24.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import "ACAccountStore+AccountControl.h"

@implementation ACAccountStore (AccountControl)

- (void)requestAccessToAccountsWithType:(ACAccountType *)accountType
                                options:(NSDictionary *)options
                                 select:(void (^)(NSArray *, void (^)(ACAccount *)))select
                             completion:(void (^)(ACAccount *, BOOL, NSError *))completion
{
    NSParameterAssert(select);
    NSParameterAssert(completion);
    select = [select copy];
    completion = [completion copy];
    [self requestAccessToAccountsWithType:accountType options:options completion:^(BOOL granted, NSError *error) {
        if (granted) {
            NSArray *accounts = [self accountsWithAccountType:accountType];
            select(accounts, ^(ACAccount *account) {
                completion(account, granted, error);
            });
        } else {
            completion(nil, granted, error);
        }
    }];
}

@end
