//
//  SRUpdateDevice.h
//  
//
//  Created by 林 達也 on 2014/04/15.
//
//

#import <Foundation/Foundation.h>

@interface SRVersion : NSObject

@property (nonatomic, copy, readonly) NSString *applicationVersion;
@property (nonatomic, copy, readonly) NSString *systemVersion;
@property (nonatomic, copy, readonly) NSString *deviceVersion;

- (id)initWithApplicationVersion:(NSString *)applicationVersion
                   systemVersion:(NSString *)systemVersion
                   deviceVersion:(NSString *)deviceVersion;

@end

@interface SRUpdateDevice : NSObject

- (id)initWithVersion:(SRVersion *)version;

- (BOOL)isUpdateVersion:(SRVersion *)nextVersion;

@end
