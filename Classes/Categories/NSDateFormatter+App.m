//
//  NSDateFormatter+App.m
//  iOS-Common
//
//  Created by 林 達也 on 2014/04/16.
//  Copyright (c) 2014年 林 達也. All rights reserved.
//

#import "NSDateFormatter+App.h"

@implementation NSDateFormatter (App)

+ (instancetype)systemFormatter
{
    NSDateFormatter *formatter = [[self alloc] init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setLocale:[NSLocale systemLocale]];
    [formatter setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]];

    return formatter;
}

@end
