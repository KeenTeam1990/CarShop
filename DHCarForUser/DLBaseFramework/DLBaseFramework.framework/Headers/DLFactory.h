//
//  DLFactory.h
//  TickTock
//
//  Created by 卢迎志 on 14-11-28.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLFactory : NSObject

#pragma mark -

#undef	AS_FACTORY
#define AS_FACTORY( __class ) \
    - (instancetype)allocInstance; \
    + (instancetype)allocInstance;

#undef	DEF_FACTORY
#define DEF_FACTORY( __class ) \
    - (instancetype)allocInstance \
    { \
        return [__class allocInstance]; \
    } \
    + (instancetype)allocInstance \
    { \
        return [[[self class] alloc] init]; \
    }
#undef	AS_FACTORY_FRAME
#define AS_FACTORY_FRAME( __class) \
    - (instancetype)allocInstanceFrame:(CGRect)__frame; \
    + (instancetype)allocInstanceFrame:(CGRect)__frame;

#undef	DEF_FACTORY_FRAME
#define DEF_FACTORY_FRAME( __class) \
    - (instancetype)allocInstanceFrame:(CGRect)__frame \
    { \
        return [__class allocInstanceFrame:__frame]; \
    } \
    + (instancetype)allocInstanceFrame:(CGRect)__frame \
    { \
        return [[[self class] alloc] initWithFrame:__frame]; \
    }

#pragma mark -


@end
