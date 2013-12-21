//
//  NSURL+Utility.h
//  VividTunes
//
//  Created by 林 達也 on 2013/11/06.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Utility)


- (NSString *)base64;

- (NSDictionary *)parameters;

- (NSURL *)URLByAppendingQuery:(id)query forKey:(NSString *)key;
@end
