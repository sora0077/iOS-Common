//
//  SRUpdateDevice.m
//  
//
//  Created by 林 達也 on 2014/04/15.
//
//

#import "SRUpdateDevice.h"

@interface SRVersion ()
@end

@implementation SRVersion

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

- (BOOL)isEqual:(SRVersion *)object
{
    if ([self isKindOfClass:[object class]]) {
        if ([self.applicationVersion isEqualToString:object.applicationVersion]
            && [self.systemVersion isEqualToString:object.systemVersion]
            && [self.deviceVersion isEqualToString:object.deviceVersion]) {
            return YES;
        }
    }
    return NO;
}

@end

@implementation SRUpdateDevice
{
    SRVersion *_currentVersion;
}


- (id)initWithVersion:(SRVersion *)version
{
    self = [super init];
    if (self) {
        _currentVersion = version;
    }
    return self;
}

- (BOOL)isUpdateVersion:(SRVersion *)nextVersion
{
    if (nextVersion == nil || _currentVersion == nil) {
        return NO;
    }
    return ![_currentVersion isEqual:nextVersion];
}


@end
