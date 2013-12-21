//
//  SOUIEventObserver.m
//  sora0077 Library
//
//  Created by t_hayashi on 12/07/03.
//  Copyright (c) 2012年 . All rights reserved.
//

#import "UIEventObserver.h"

NSString *const UIEventBeginTrackingNotification = @"UIEventObserver::UIEventBeginTrackingNotification";
NSString *const UIEventEndTrackingNotification = @"UIEventObserver::UIEventEndTrackingNotification";

@interface UIEventObserver ()

@property (assign, atomic, getter = isTracking) BOOL trancking;


- (void)eventTrankingStarted;
- (void)eventTrankingStopped;
@end

@implementation UIEventObserver

+ (UIEventObserver *)sharedObserver
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init
{
	self = [super init];
	if (self) {
		// Custom initialization
		[self eventTrankingStopped];
	}
	return self;
}

- (void)eventTrankingStarted
{
	self.trancking = YES;
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:UIEventBeginTrackingNotification object:self];
        
        [[NSRunLoop mainRunLoop] performSelector:@selector(eventTrankingStopped)
                                          target:self
                                        argument:nil 
                                           order:0 
                                           modes:@[NSDefaultRunLoopMode]];
    });
}

- (void)eventTrankingStopped
{
	self.trancking = NO;
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		[[NSNotificationCenter defaultCenter] postNotificationName:UIEventEndTrackingNotification object:self];
		
		[[NSRunLoop mainRunLoop] performSelector:@selector(eventTrankingStarted) 
                                          target:self
                                        argument:nil
                                           order:0
                                           modes:@[UITrackingRunLoopMode]
         ];
	});
}

+ (void)launch
{
	[self sharedObserver];
}

+ (BOOL)isTracking
{
	return [[self sharedObserver] isTracking];
}

@end
