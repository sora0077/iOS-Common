//
//  SRCacheManifest.h
//  
//
//  Created by 林 達也 on 2014/01/20.
//
//

#import <Foundation/Foundation.h>

@protocol SRCacheManifest <NSObject>
@required
- (void)objectForKey:(NSString *)aKey block:(void (^)(NSString *aKey, id object))block;
- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey;
@end
