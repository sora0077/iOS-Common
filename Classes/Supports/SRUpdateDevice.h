//
//  SRUpdateDevice.h
//  
//
//  Created by 林 達也 on 2014/04/15.
//
//

#import <Foundation/Foundation.h>

@interface SRUpdateVersion : NSObject

@property (nonatomic, copy, readonly) NSString *applicationVersion;
@property (nonatomic, copy, readonly) NSString *systemVersion;
@property (nonatomic, copy, readonly) NSString *deviceVersion;

- (id)initWithApplicationVersion:(NSString *)applicationVersion
                   systemVersion:(NSString *)systemVersion
                   deviceVersion:(NSString *)deviceVersion;

@end

@interface SRUpdateDevice : NSObject

- (id)initWithVersion:(SRUpdateVersion *)version;

- (BOOL)isUpdateVersion:(SRUpdateVersion *)nextVersion;

@end
