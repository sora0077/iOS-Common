//
//  ACAccountStore+AccountControl.h
//  VividTunes
//
//  Created by 林 達也 on 2013/11/24.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import <Accounts/Accounts.h>

@interface ACAccountStore (AccountControl)


- (void)requestAccessToAccountsWithType:(ACAccountType *)accountType
                                options:(NSDictionary *)options
                                 select:(void (^)(NSArray *accounts, void (^callback)(ACAccount *account)))select
                             completion:(void (^)(ACAccount *account, BOOL granted, NSError *error))completion;

@end
