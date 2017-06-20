//
//  DLKeychain.h
//  TickTock
//
//  Created by 卢迎志 on 14-11-28.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DLSingleton.h"
#import "DLModel.h"

#pragma mark -

#undef	DEFAULT_DOMAIN
#define DEFAULT_DOMAIN	@"DLKeychain"

@interface DLKeychain : NSObject

AS_SINGLETON(DLKeychain);

AS_MODEL_STRONG(NSString, defaultDomain);

+ (void)setDefaultDomain:(NSString *)domain;

+ (NSString *)readValueForKey:(NSString *)key;
+ (NSString *)readValueForKey:(NSString *)key andDomain:(NSString *)domain;

+ (void)writeValue:(NSString *)value forKey:(NSString *)key;
+ (void)writeValue:(NSString *)value forKey:(NSString *)key andDomain:(NSString *)domain;

+ (void)deleteValueForKey:(NSString *)key;
+ (void)deleteValueForKey:(NSString *)key andDomain:(NSString *)domain;

@end
