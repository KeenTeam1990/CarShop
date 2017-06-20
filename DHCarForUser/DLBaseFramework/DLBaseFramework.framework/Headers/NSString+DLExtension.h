//
//  NSString+DLExtension.h
//  TickTock
//
//  Created by 卢迎志 on 14-11-28.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLModel.h"

#pragma mark -

typedef NSString *			(^NSStringAppendBlock)( id format, ... );
typedef NSString *			(^NSStringReplaceBlock)( NSString * string, NSString * string2 );

typedef NSMutableString *	(^NSMutableStringAppendBlock)( id format, ... );
typedef NSMutableString *	(^NSMutableStringReplaceBlock)( NSString * string, NSString * string2 );

#pragma mark -

#undef	FORMAT
#define	FORMAT( __fmt, ... )	[NSString stringWithFormat:__fmt, __VA_ARGS__]

#pragma mark -

@interface NSString(DLExtension)

AS_MODEL_READONLY(NSData, toData);
AS_MODEL_READONLY(NSDate, toDate);
AS_MODEL_READONLY(NSString, toMD5);
AS_MODEL_READONLY(NSString, toMD5_Small);
AS_MODEL_READONLY(NSString, toSHA1)

AS_BLOCK(NSStringAppendBlock, APPEND);
AS_BLOCK(NSStringAppendBlock, LINE);
AS_BLOCK(NSStringReplaceBlock, REPLACE);

- (NSArray *)allURLs;

- (NSString *)urlByAppendingDict:(NSDictionary *)params;
- (NSString *)urlByAppendingDict:(NSDictionary *)params encoding:(BOOL)encoding;
- (NSString *)urlByAppendingArray:(NSArray *)params;
- (NSString *)urlByAppendingArray:(NSArray *)params encoding:(BOOL)encoding;
- (NSString *)urlByAppendingKeyValues:(id)first, ...;

+ (NSString *)queryStringFromDictionary:(NSDictionary *)dict;
+ (NSString *)queryStringFromDictionary:(NSDictionary *)dict encoding:(BOOL)encoding;;
+ (NSString *)queryStringFromArray:(NSArray *)array;
+ (NSString *)queryStringFromArray:(NSArray *)array encoding:(BOOL)encoding;;
+ (NSString *)queryStringFromKeyValues:(id)first, ...;

- (NSString *)URLEncoding;
- (NSString *)URLDecoding;

- (NSString *)trim;
- (NSString *)unwrap;
- (NSString *)repeat:(NSUInteger)count;
- (NSString *)normalize;

-(NSString *)replaceUnicode;
-(BOOL)toBool;

- (BOOL)match:(NSString *)expression;
- (BOOL)matchAnyOf:(NSArray *)array;

- (BOOL)empty;
- (BOOL)notEmpty;

- (BOOL)eq:(NSString *)other;
- (BOOL)equal:(NSString *)other;

- (BOOL)is:(NSString *)other;
- (BOOL)isNot:(NSString *)other;

- (BOOL)isValueOf:(NSArray *)array;
- (BOOL)isValueOf:(NSArray *)array caseInsens:(BOOL)caseInsens;

- (BOOL)isNormal;		// thanks to @uxyheaven
- (BOOL)isTelephone;    // match telephone
- (BOOL)isMobilephone;  // match mobilephone, 11 numberic
- (BOOL)isUserName;     // match alphabet 3-20
- (BOOL)isChineseUserName;  // match alphabet and chinese characters, 3-20
- (BOOL)isChineseName;      // match just chinese characters 2-16
- (BOOL)isPassword;
- (BOOL)isEmail;
- (BOOL)isUrl;
- (BOOL)isIPAddress;
- (BOOL)isNumber;
- (BOOL)isFloat;

- (NSString*)isHttpAndAdd;
- (NSString*)asDirPath;

-(NSDate *)stringToDateFormat:(NSString*)format;
-(NSDate *)stringToTimeMM;
-(NSDate *)stringToTime;
-(NSDate *)stringToDate;

-(NSString*)DESEncrypt:(NSString*)key;
-(NSString*)DESDecrypt:(NSString*)key;

+(NSString*)fromInt:(NSInteger)item;
+(NSString*)fromFoalt:(CGFloat)item;
+(NSString*)fromBool:(BOOL)item;
+(NSString*)fromString:(NSString*)item;

- (NSString *)substringFromIndex:(NSUInteger)from untilString:(NSString *)string;
- (NSString *)substringFromIndex:(NSUInteger)from untilString:(NSString *)string endOffset:(NSUInteger *)endOffset;

- (NSString *)substringFromIndex:(NSUInteger)from untilCharset:(NSCharacterSet *)charset;
- (NSString *)substringFromIndex:(NSUInteger)from untilCharset:(NSCharacterSet *)charset endOffset:(NSUInteger *)endOffset;

- (NSUInteger)countFromIndex:(NSUInteger)from inCharset:(NSCharacterSet *)charset;

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
- (CGSize)sizeWithFont:(UIFont *)font byWidth:(CGFloat)width;
- (CGSize)sizeWithFont:(UIFont *)font byHeight:(CGFloat)height;
- (CGSize)sizeWithFont:(UIFont *)font bySize:(CGSize)size;
#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)


@end

#pragma mark -

@interface NSMutableString(DLExtension)

AS_BLOCK(NSMutableStringAppendBlock, APPEND);
AS_BLOCK(NSMutableStringAppendBlock, LINE);
AS_BLOCK(NSMutableStringReplaceBlock, REPLACE);

@end
