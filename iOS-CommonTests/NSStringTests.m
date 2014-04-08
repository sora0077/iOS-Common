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

    context(@"snake case and camel case tests", ^{
        it(@" be true", ^{
            NSString *snakecase = @"apple_steve_jobs";
            [[[snakecase camelcaseString] should] equal:@"appleSteveJobs"];

            [[[[snakecase camelcaseString] snakecaseString] should] equal:snakecase];
        });

        it(@" be true", ^{
            NSString *camelcase = @"microSoft";
            [[[camelcase snakecaseString] should] equal:@"micro_soft"];

            [[[[camelcase snakecaseString] camelcaseString] should] equal:camelcase];
        });
    });
});

SPEC_END
