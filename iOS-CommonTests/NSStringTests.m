//
//  NSStringTests.m
//  iOS-Common
//
//  Created by 林 達也 on 2013/12/28.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import <Kiwi/Kiwi.h>

#import "NSString+Utility.h"

SPEC_BEGIN(NSStringTests)

describe(@"NSString Category", ^{
//    it(@"is sha1", ^{
//
//    });
    context(@"base64 tests", ^{
        it(@"encode/decode result is true", ^{
            NSString *base64 = [@"test" base64Encode];
            [[[base64 base64Decode] should] equal:@"test"];
        });

    });
});

SPEC_END
