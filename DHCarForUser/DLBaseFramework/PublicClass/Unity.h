//
//  Unity.h
//  TickTock
//
//  Created by 卢迎志 on 14-11-26.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#include <mach/mach.h>
#import <QuartzCore/QuartzCore.h>
#import "DefaultType.h"

#define Alert_Message(title,msg);\
{ UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];[alert show]; }

@interface Unity : NSObject

+(UIColor*)getBackColor;
+(UIColor*)getGrayBackColor;
+(UIColor*)getNavBarBackColor;
+(UIColor*)getTableItemSeleteColor;
+(UIColor*)getTabItem_HColor;
+(UIColor*)getTabItemColor;

//根据宽度和字体 自动计算文本高度
+(CGFloat) getLabelHeightWithWidth:(CGFloat)labelWidth andDefaultHeight:(CGFloat)labelDefaultHeight andFontSize:(CGFloat)fontSize andText:(NSString *)text;

//计算文本的宽度
+(CGFloat)getLableWidthWithString:(NSString *)string andFontSize:(CGFloat )fontSize;

//获取文本颜色
+(UIColor *)getColor:(NSString *) stringToConvert;

+(UIViewController*)getViewController:(UIView*)view;

+(void)toViewController:(UINavigationController*)navigationController withLastCount:(int)count;

+(UIImage*)getImageFromRect:(CGRect)rect withView:(UIView*)view;

//解压zip
+(BOOL)unzipFile:(NSString*)filePath withUnZipPath:(NSString*)path;


+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 ;

+(BOOL)isNetworkReachable;

+ (CGFloat) getVideoDuration:(NSURL*) URL;

+ (NSInteger) getFileSize:(NSString*) path;

+(UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
//计算时间间隔
+(NSString *)countTimeLenght:(NSDate *)data;
//计算日期间隔 格式
+(NSString *)dateToHolidayStr:(NSDate *)date;
+(NSString *)dateToWeekStr:(NSDate *)date;
+(NSString *)dateToWeekStrNotYear:(NSDate *)date withShowWeek:(BOOL)sw;
//获取系统push通知状态
+(BOOL)getPushStateFormSystem;
//打电话
+(void)openCallPhone:(NSString*)phone;
//处理 higher图片名_h
+(NSString*)getHighterImageName:(NSString*)name;


+(BOOL)isBlank:(NSString*)str;

//数字转化二进制
+ (NSString *)paddedBinaryString:(NSString*)text;

+(NSString*)getTimeFromTimerLong:(NSString*)time;

//显示时间
+(NSString*)getTimeFromTimer:(NSString*)time;

//普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string;
// 十六进制转换为普通字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString;
//判断是否是中文数字，以及字母
+(BOOL )isKindOfStr:(NSString *)str;
//换算m->km
+ (NSString*)stringToKmString:(NSString*)lat withLon:(NSString*)lng;

+(NSString *)testWithTime:(NSString *)times;
+(NSString *)testWithTime2:(NSString *)times;
+(NSString *)dayOrTime:(NSString *)times;

+ (BOOL)isTelephone:(NSString*)phone;
@end
