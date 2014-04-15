//
//  SRUpdateDevice.m
//  
//
//  Created by 林 達也 on 2014/04/15.
//
//

#import "SRUpdateDevice.h"

@interface SRUpdateVersion ()
@end

@implementation SRUpdateVersion

- (id)initWithApplicationVersion:(NSString *)applicationVersion systemVersion:(NSString *)systemVersion deviceVersion:(NSString *)deviceVersion
{
    self = [super init];
    if (self) {
        _applicationVersion = [applicationVersion copy];
        _systemVersion = [systemVersion copy];
        _deviceVersion = [deviceVersion copy];
    }
    return self;
}

@end

@implementation SRUpdateDevice
{
    SRUpdateVersion *_currentVersion;
}


- (id)initWithVersion:(SRUpdateVersion *)version
{
    self = [super init];
    if (self) {
        _currentVersion = version;
    }
    return self;
}

- (BOOL)isUpdateVersion:(SRUpdateVersion *)nextVersion
{
    if (nextVersion == nil || _currentVersion == nil) {
        return NO;
    }
    if ([_currentVersion.applicationVersion isEqualToString:nextVersion.applicationVersion]
        && [_currentVersion.systemVersion isEqualToString:nextVersion.systemVersion]
        && [_currentVersion.deviceVersion isEqualToString:nextVersion.deviceVersion]) {
        return NO;
    }
    return YES;
}


@end
