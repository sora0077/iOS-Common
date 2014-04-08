//
//  macros.h
//  VividTunes
//
//  Created by 林 達也 on 2013/09/17.
//  Copyright (c) 2013年 林 達也. All rights reserved.
//

#define not !
#define is ==
#define isnot !=
#define and &&
#define or ||

#define or_ ?:

#define inline_return

//#define function(rtype, ...) ^rtype(__VA_ARGS__)
#define function(rtype) ^rtype

#define __HELPER0(x) #x
#define __HELPER1(x) __HELPER0(clang diagnostic ignored x)
#define __HELPER2(y) __HELPER1(#y)
#define PRAGMA_IGNORED(Warnings, Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma(__HELPER2(Warnings)) \
        Stuff \
        _Pragma("clang diagnostic pop") \
    } while(0)

#define PRAGMA_IGNORED_PerformSelectorLeaks(Stuff) \
    PRAGMA_IGNORED(-Warc-performSelector-leaks, Stuff)

#define NAMESPACE_BEGIN {
#define NAMESPACE_END   }
#define NAMESPACE_AND   }{

#define $url(var) [NSURL URLWithString:var]
#define $str(var, ...) [NSString stringWithFormat:var, #__VA_ARGS__]

#define $localize(var) NSLocalizedString((var), @"")

#define VAR(...) _VAR(@""#__VA_ARGS__, __VA_ARGS__)
#define _VAR(...) \
	^NSString *(NSString *format, ...) {\
		va_list args;\
		format = [format stringByReplacingOccurrencesOfString:@", " withString:@","];\
		format = [format stringByReplacingOccurrencesOfString:@" ," withString:@","];\
		NSArray *keys = [format componentsSeparatedByString:@","];\
		\
		NSMutableArray *objects = [NSMutableArray arrayWithCapacity:keys.count];\
		\
		va_start(args, format);\
		for (id key in keys) {\
			id object = va_arg(args, id);\
			object = object ? object : @"nil";\
			[objects addObject:object];\
		}\
		va_end(args);\
		\
		NSMutableString *buffer = [NSMutableString stringWithString:@"{\n"];\
		\
		[objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {\
			id key = [keys objectAtIndex:idx];\
			id description = obj;\
			if ([obj respondsToSelector:@selector(descriptionWithLocale:indent:)]) {\
				description = [obj descriptionWithLocale:nil indent:1];\
			}\
			[buffer appendFormat:@"\t%@ = %@;\n", key, description];\
		}];\
		\
		[buffer appendString:@"}"];\
		return buffer;\
	}(__VA_ARGS__)

#define VARLOG(var, ...) NSLog(@"\n%s at LINE:%d\n%@\n\n", __func__, __LINE__, VAR(var, ##__VA_ARGS__))



#define using_block(ivar) \
    try {} @finally {} \
    do { ivar = [ivar copy]; } while(0)

#define calling_block(ivar, ...) \
    try {} @finally {} \
    do {\
        if (ivar) {\
            ivar(__VA_ARGS__);\
        }\
    } while (0)
