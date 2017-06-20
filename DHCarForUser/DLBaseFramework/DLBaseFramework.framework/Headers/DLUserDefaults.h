//
//  DLUserDefaults.h
//  TickTock
//
//  Created by 卢迎志 on 14-12-5.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DLModel.h"
#import "DLSingleton.h"

@interface DLUserDefaults : NSObject

AS_SINGLETON(DLUserDefaults);

- (NSString*)getAppKey:(NSString*)key;

- (BOOL)hasObjectForKey:(id)key;
- (id)objectForKey:(NSString *)key;
- (void)setObject:(id)value forKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key;
- (void)removeAllObjects;

- (id)objectForKeyedSubscript:(id)key;
- (void)setObject:(id)obj forKeyedSubscript:(id)key;

@end
