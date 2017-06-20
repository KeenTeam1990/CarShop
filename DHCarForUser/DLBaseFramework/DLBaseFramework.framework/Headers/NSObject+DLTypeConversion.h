//
//  NSObject+DLTypeConversion.h
//  TickTock
//
//  Created by 卢迎志 on 14-11-28.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject(DLTypeConversion)

-(BOOL)isBlankObject;

- (NSInteger)asInteger;
- (float)asFloat;
- (BOOL)asBool;

- (NSNumber *)asNSNumber;
- (NSString *)asNSString;
- (NSDate *)asNSDate;
- (NSData *)asNSData;	// TODO
- (NSArray *)asNSArray;
- (NSMutableArray *)asNSMutableArray;
- (NSDictionary *)asNSDictionary;
- (NSMutableDictionary *)asNSMutableDictionary;

@end
