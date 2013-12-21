//
//  SOUIEventObserver.h
//  sora0077 Library
//
//  Created by t_hayashi on 12/07/03.
//  Copyright (c) 2012年 . All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const UIEventBeginTrackingNotification;
extern NSString *const UIEventEndTrackingNotification;


@interface UIEventObserver : NSObject
+ (id)sharedObserver;
+ (void)launch;

+ (BOOL)isTracking;
@end
