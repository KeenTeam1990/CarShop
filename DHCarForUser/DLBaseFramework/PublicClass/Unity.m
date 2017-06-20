//
//  Unity.m
//  TickTock
//
//  Created by 卢迎志 on 14-11-26.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import "Unity.h"

#import "AppDelegate.h"
#import "sys/utsname.h"
#import <AVFoundation/AVFoundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>

@implementation Unity

+(UIColor*)getNavBarBackColor
{
    return [UIColor colorWithRed:0/255.0 green:114/255.0 blue:198/255.0 alpha:1.0];
}

+(UIColor*)getBackColor
{
    return [UIColor whiteColor];
}

+(UIColor*)getGrayBackColor
{
    return [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
}

+(UIColor*)getTableItemSeleteColor
{
    return [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
}
+(UIColor*)getTabItem_HColor
{
    return [UIColor redColor];
}
+(UIColor*)getTabItemColor
{
    return RGBCOLOR(112, 112, 112);
}

+(CGFloat) getLabelHeightWithWidth:(CGFloat)labelWidth andDefaultHeight:(CGFloat)labelDefaultHeight andFontSize:(CGFloat)fontSize andText:(NSString *)text
{
	CGSize constraint = CGSizeMake(labelWidth, 20000.0f);
	
	CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] bySize:constraint];
	
	CGFloat labelHeight = MAX(size.height, labelDefaultHeight);
	
	return labelHeight;
}


+(UIColor *)getColor:(NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+(UIViewController*)getViewController:(UIView*)view {
    
    for (UIView* next = [view superview]; next; next = next.superview) {
        
        UIResponder* nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


+(void)toViewController:(UINavigationController*)navigationController withLastCount:(int)count
{
    NSInteger nvcount = [navigationController.viewControllers count];
    if (count>=0 &&  nvcount >= count) {
        UIViewController* tempviewController = [navigationController.viewControllers objectAtIndex:([navigationController.viewControllers count]-count)];
        if (tempviewController!=nil) {
            [navigationController popToViewController:tempviewController animated:YES];
        }
    }
    
}

+(CGAffineTransform)getOrientation:(UIInterfaceOrientation)orientation
{
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return CGAffineTransformMakeRotation(M_PI*1.5);
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        return CGAffineTransformMakeRotation(M_PI/2);
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return CGAffineTransformMakeRotation(-M_PI);
    } else {
        return CGAffineTransformIdentity;
    }
}
+(BOOL )isKindOfStr:(NSString *)str
{
     NSString *regex = @"[a-zA-Z0-9\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:str];
}
+(UIImage*)getImageFromRect:(CGRect)rect withView:(UIView*)view
{
    UIGraphicsBeginImageContext(view.frame.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    viewImage=[viewImage croppedImage:rect];
    return viewImage;
}


//解压zip
+(BOOL)unzipFile:(NSString*)filePath withUnZipPath:(NSString*)path
{
    BOOL resultunzip= NO;
    DLZipArchive *unzip = [[DLZipArchive alloc] init];
    if ([unzip UnzipOpenFile:filePath]) {
        BOOL result = [unzip UnzipFileTo:path overWrite:YES];
        if (result) {
            resultunzip = result;
            //            NSLog(@"unzip successfully");
        }
        [unzip UnzipCloseFile];
    }
    unzip = nil;
    return resultunzip;
}


+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 {
    UIGraphicsBeginImageContext(image1.size);
    
    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    // Draw image2
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}


+(BOOL)isNetworkReachable
{
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	// Recover reachability flags
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	SCNetworkReachabilityFlags flags;
	
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	
	if (!didRetrieveFlags)
	{
		return NO;
	}
	
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    
    BOOL result = (isReachable && !needsConnection) ? YES : NO;
    
    if (!result) {
        [SVProgressHUD dismiss];
        
        UIAlertView *tempView = [[UIAlertView alloc]initWithTitle:nil message:@"启动蜂窝移动数据或Wi-Fi来访问数据" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [tempView show];
    }
	return result;
}


+ (NSInteger) getFileSize:(NSString*) path
{
    NSFileManager * filemanager = [[NSFileManager alloc]init] ;
    if([filemanager fileExistsAtPath:path]){
        NSDictionary * attributes = [filemanager attributesOfItemAtPath:path error:nil];
        NSNumber *theFileSize;
        if ( (theFileSize = [attributes objectForKey:NSFileSize]) )
            return  [theFileSize intValue]/1024;
        else
            return -1;
    }
    else
    {
        return -1;
    }
}

+ (CGFloat) getVideoDuration:(NSURL*) URL
{
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                     forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:URL options:opts];
    float second = 0;
    second = urlAsset.duration.value/urlAsset.duration.timescale;
    return second;
}

+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        //        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

//计算时间间隔
+(NSString *)countTimeLenght:(NSDate *)data
{
    NSDate *nowData = [NSDate new];
    
    NSString *string = nil;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date1 = [formatter stringFromDate:data];
    NSString *date2 = [formatter stringFromDate:nowData];
    if ([date1 isEqualToString:date2]) {
        //如果是今天的
        NSTimeInterval timeCount = [nowData timeIntervalSinceDate:data];
        if (timeCount/(60)<60) { //分钟
            int count = timeCount/(60);
            if (count == 0) {
                string = @"刚刚";
            }else{
                string = [NSString stringWithFormat:@"%d分钟前",count];
            }
        }else if(timeCount/(60*60)>=1){ //小时
            int count = timeCount/(60*60);
            string = [NSString stringWithFormat:@"%d小时前",count];
        }
    }else{
        //不是今天的
        
//        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        
//        //结束时间
//        NSDate *endDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:data]];
//        //当前时间
//        NSDate *senderDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:nowData]];
//        //得到相差秒数
//        NSTimeInterval time=[endDate timeIntervalSinceDate:senderDate];
        
//        int days = abs(((int)time)/(3600*24));
        //        int hours = ((int)time)%(3600*24)/3600;
        //        int minute = ((int)time)%(3600*24)600/60;
        
//        if (days == 1) {
//            string = @"昨天";
//        }else if(days >= 2 && days<= 7){
//            string = [NSString stringWithFormat:@"%d天前",days];
//        }
//        else{
            string = [data dateToString];
//        }
    }
    
    return string;
}

//计算日期间隔 格式
+(NSString *)dateToHolidayStr:(NSDate *)date
{
    NSDate *nowData = [NSDate new];
    
    NSString *string = nil;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date1 = [formatter stringFromDate:date];
    //    NSString *date2 = [formatter stringFromDate:nowData];
    
    if (date.year == nowData.year ) {
        if (date.month == nowData.month && date.day == nowData.day) {
            string = [NSString stringWithFormat:@"%@ %@",date1,@"今天"];
        }else if (date.month == nowData.month && date.day == nowData.day+1) {
            string = [NSString stringWithFormat:@"%@ %@",date1,@"明天"];
        }else if (date.month == nowData.month && date.day == nowData.day+2) {
            string = [NSString stringWithFormat:@"%@ %@",date1,@"后天"];
            //1.1元旦
        }else if (date.month == 1 && date.day == 1){
            string = [NSString stringWithFormat:@"%@ %@",date1,@"元旦"];
            //2.14情人节
        }else if (date.month == 2 && date.day == 14){
            string = [NSString stringWithFormat:@"%@ %@",date1,@"情人节"];
            //3.8妇女节
        }else if (date.month == 3 && date.day == 8){
            string = [NSString stringWithFormat:@"%@ %@",date1,@"妇女节"];
            //5.1劳动节
        }else if (date.month == 5 && date.day == 1){
            string = [NSString stringWithFormat:@"%@ %@",date1,@"劳动节"];
            //6.1儿童节
        }else if (date.month == 6 && date.day == 1){
            string = [NSString stringWithFormat:@"%@ %@",date1,@"儿童节"];
            //8.1建军节
        }else if (date.month == 8 &&date.day == 1){
            string = [NSString stringWithFormat:@"%@ %@",date1,@"建军节"];
            //9.10教师节
        }else if (date.month == 9 && date.day == 10){
            string = [NSString stringWithFormat:@"%@ %@",date1,@"教师节"];
            //10.1国庆节
        }else if (date.month == 10 &&  date.day == 1){
            string = [NSString stringWithFormat:@"%@ %@",date1,@"国庆节"];
            //11.1植树节
        }else if (date.month == 11 && date.day == 1){
            string = [NSString stringWithFormat:@"%@ %@",date1,@"植树节"];
            //11.11光棍节
        }else if (date.month == 11 && date.day == 11){
            string = [NSString stringWithFormat:@"%@ %@",date1,@"光棍节"];
        }else{
            string = [NSString stringWithFormat:@"%@",date1];
        }
    }else{
        string = [NSString stringWithFormat:@"%@",date1];
    }
    
    return string;
}

//计算日期间隔 格式
+(NSString *)dateToWeekStr:(NSDate *)date
{
    NSDate *nowData = [NSDate new];
    
    NSString *string = nil;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date1 = [formatter stringFromDate:date];
//    NSString *date2 = [formatter stringFromDate:nowData];
    
    if (date.year == nowData.year && date.month == nowData.month ) {
        if (date.day == nowData.day) {
            string = [NSString stringWithFormat:@"%@ %@",date1,@"今天"];
        }else if (date.day == nowData.day+1) {
            string = [NSString stringWithFormat:@"%@ %@",date1,@"明天"];
        }else if (date.day == nowData.day+2) {
            string = [NSString stringWithFormat:@"%@ %@",date1,@"后天"];
        }else{
            NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            NSInteger unitFlags = NSYearCalendarUnit |
            NSMonthCalendarUnit |
            NSDayCalendarUnit |
            NSWeekdayCalendarUnit |
            NSHourCalendarUnit |
            NSMinuteCalendarUnit |
            NSSecondCalendarUnit;
            comps = [calendar components:unitFlags fromDate:date];
            string = [NSString stringWithFormat:@"%@ %@",date1,[arrWeek objectAtIndex:[comps weekday]-1]];
        }
    }else{
        NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit |
        NSMonthCalendarUnit |
        NSDayCalendarUnit |
        NSWeekdayCalendarUnit |
        NSHourCalendarUnit |
        NSMinuteCalendarUnit |
        NSSecondCalendarUnit;
        comps = [calendar components:unitFlags fromDate:date];
        string = [NSString stringWithFormat:@"%@ %@",date1,[arrWeek objectAtIndex:[comps weekday]-1]];
    }
    
    return string;
}

//计算日期间隔 格式
+(NSString *)dateToWeekStrNotYear:(NSDate *)date withShowWeek:(BOOL)sw
{
    NSDate *nowData = [NSDate new];
    
    NSString *string = nil;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd"];
    NSString *date1 = [formatter stringFromDate:date];
    //    NSString *date2 = [formatter stringFromDate:nowData];
    
    if (date.year == nowData.year && date.month == nowData.month ) {
        if (date.day == nowData.day && !sw) {
            string = [NSString stringWithFormat:@"%@ %@",date1,@"今天"];
        }else if (date.day == nowData.day+1 && !sw) {
            string = [NSString stringWithFormat:@"%@ %@",date1,@"明天"];
        }else if (date.day == nowData.day+2 && !sw) {
            string = [NSString stringWithFormat:@"%@ %@",date1,@"后天"];
        }else{
            NSArray * arrWeek=[NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            NSInteger unitFlags = NSYearCalendarUnit |
            NSMonthCalendarUnit |
            NSDayCalendarUnit |
            NSWeekdayCalendarUnit |
            NSHourCalendarUnit |
            NSMinuteCalendarUnit |
            NSSecondCalendarUnit;
            comps = [calendar components:unitFlags fromDate:date];
            string = [NSString stringWithFormat:@"%@ %@",date1,[arrWeek objectAtIndex:[comps weekday]-1]];
        }
    }else{
        NSArray * arrWeek=[NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit |
        NSMonthCalendarUnit |
        NSDayCalendarUnit |
        NSWeekdayCalendarUnit |
        NSHourCalendarUnit |
        NSMinuteCalendarUnit |
        NSSecondCalendarUnit;
        comps = [calendar components:unitFlags fromDate:date];
        string = [NSString stringWithFormat:@"%@ %@",date1,[arrWeek objectAtIndex:[comps weekday]-1]];
    }
    
    return string;
}



//获取系统push通知状态
+(BOOL)getPushStateFormSystem
{
    UIRemoteNotificationType types;
#if SUPPORT_IOS8
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        types = [[UIApplication sharedApplication] currentUserNotificationSettings].types;
    }
    else
#endif
    {
        types = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    }
    if (types == UIRemoteNotificationTypeNone) {
        return NO;
    }
    return YES;
}

//打电话
+(void)openCallPhone:(NSString*)phone
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
//处理 higher图片名_h
+(NSString*)getHighterImageName:(NSString*)name
{
    NSString* tempName = name;
    
    NSString* lastfileName = [tempName lastPathComponent];
    
    NSInteger lastLenght = 0;
    
    if ([lastfileName notEmpty]) {
        lastLenght = [lastfileName length];
    }else{
        lastfileName = @"";
    }
    
    NSString* tempFileName = [tempName substringToIndex:[tempName length]-lastLenght];
    
    return [NSString stringWithFormat:@"%@_h%@",tempFileName,lastfileName];
}

+(BOOL)isBlank:(NSString*)str
{
    if (str == nil) {
        return YES;
        
    }
    if (str == NULL) {
        
        return YES;
        
    }
    if ([str isKindOfClass:[NSNull class]]) {
        
        return YES;
    }
//    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
//        
//        return YES;
//    }
    return NO;
}
+(CGFloat)getLableWidthWithString:(NSString *)string andFontSize:(CGFloat )fontSize
{
    
    return [string sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}].width;
}

+(NSString*)getTimeFromTimerLong:(NSString*)time
{
    if (time == nil || time.length ==0 || [time isEqualToString:@"(null)"]) {
        return @"";
    }
    
    NSString* tempTimer = @"";
    
    NSDate* tempDate = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
    
    tempTimer = [Unity countTimeLenght:tempDate];
    
    return tempTimer;
}

//显示时间
+(NSString*)getTimeFromTimer:(NSString*)time
{
    if (time == nil || time.length ==0 || [time isEqualToString:@"(null)"]) {
        return @"";
    }
    
    NSString* tempTimer = @"";
    
    NSDate* tempDate = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    tempTimer = [formatter stringFromDate:tempDate];
    
    return tempTimer;

}
+(NSString *)testWithTime:(NSString *)times{
    
    NSDate *tempDate = [NSDate dateWithTimeIntervalSince1970:[times doubleValue]];
    NSTimeInterval timetrave = [tempDate timeIntervalSinceNow];
    NSInteger tempMinuteTag = 60;
    NSInteger tempHourTag = 60*60;
    NSInteger tempDayTag = 24*60*60;
    if(0<=timetrave && timetrave <=tempMinuteTag)
    {
        return [NSString stringWithFormat:@"%f秒",timetrave];
    }
    else if(tempMinuteTag<timetrave && timetrave<=tempHourTag)
    {
        NSInteger tempMinue = (NSInteger)timetrave/tempMinuteTag;
        NSInteger tempSecond = (NSInteger)timetrave%tempMinuteTag;
        return [NSString stringWithFormat:@"%ld分%ld秒",(long)tempMinue,(long)tempSecond];
    }
    else if(tempHourTag<timetrave && timetrave<= tempDayTag)
    {
        NSInteger tempHour = (NSInteger)timetrave/tempHourTag;
        NSInteger tempMinue =((NSInteger)timetrave%tempHourTag)/tempMinuteTag;
        NSInteger tempSecond =((NSInteger)timetrave%tempHourTag)%tempMinuteTag;
        return [NSString stringWithFormat:@"%ld时%ld分%ld秒",tempHour,tempMinue,tempSecond];
    }
    else if(tempDayTag <timetrave )
    {
        NSInteger tempDay = (NSInteger)timetrave/tempDayTag;
        NSInteger tempHour = ((NSInteger)timetrave%tempDayTag)/tempHourTag;
        NSInteger tempMinue =(((NSInteger)timetrave%tempDayTag)%tempHourTag)/tempMinuteTag;
        NSInteger tempSecond =(((NSInteger)timetrave%tempDayTag)%tempHourTag)%tempMinuteTag;
        return [NSString stringWithFormat:@"%ld天%ld时%ld分%ld秒",tempDay,tempHour,tempMinue,tempSecond];
    }
    return nil;
}

+(NSString *)dayOrTime:(NSString *)times{
    
    NSDate *tempDate = [NSDate dateWithTimeIntervalSince1970:[times doubleValue]];
    NSTimeInterval timetrave = [tempDate timeIntervalSinceNow];
    NSInteger tempMinuteTag = 60;
    NSInteger tempHourTag = 60*60;
    NSInteger tempDayTag = 24*60*60;
    if(0<=timetrave && timetrave <=tempMinuteTag)
    {
        return [NSString stringWithFormat:@"%ld秒",(long)timetrave];
    }
    else if(tempMinuteTag<timetrave && timetrave<=tempHourTag)
    {
        NSInteger tempMinue = (NSInteger)timetrave/tempMinuteTag;
        NSInteger tempSecond = (NSInteger)timetrave%tempMinuteTag;
        return [NSString stringWithFormat:@"%ld分%ld秒",(long)tempMinue,(long)tempSecond];
    }
    else if(tempHourTag<timetrave && timetrave<= tempDayTag)
    {
        NSInteger tempHour = (NSInteger)timetrave/tempHourTag;
        NSInteger tempMinue =((NSInteger)timetrave%tempHourTag)/tempMinuteTag;
        NSInteger tempSecond =((NSInteger)timetrave%tempHourTag)%tempMinuteTag;
        return [NSString stringWithFormat:@"%ld小时%ld分钟%ld秒",(long)tempHour,tempMinue,tempSecond];
    }
    else if(tempDayTag <timetrave )
    {
        NSInteger tempDay = (NSInteger)timetrave/tempDayTag;
        return [NSString stringWithFormat:@"%ld天",(long)tempDay];
    }
    return nil;
}

+(NSString *)testWithTime2:(NSString *)times{
    
    NSDate *tempDate = [NSDate dateWithTimeIntervalSince1970:[times doubleValue]];
    NSTimeInterval timetrave = [tempDate timeIntervalSinceNow];
    NSInteger tempMinuteTag = 60;
    NSInteger tempHourTag = 60*60;
    NSInteger tempDayTag = 24*60*60;
    if(0<=timetrave && timetrave <=tempMinuteTag)
    {
        return [NSString stringWithFormat:@"%f秒",timetrave];
    }
    else if(tempMinuteTag<timetrave && timetrave<=tempHourTag)
    {
        NSInteger tempMinue = (NSInteger)timetrave/tempMinuteTag;
        NSInteger tempSecond = (NSInteger)timetrave%tempMinuteTag;
        return [NSString stringWithFormat:@"%ld:%ld",(long)tempMinue,(long)tempSecond];
    }
    else if(tempHourTag<timetrave && timetrave<= tempDayTag)
    {
        NSInteger tempHour = (NSInteger)timetrave/tempHourTag;
        NSInteger tempMinue =((NSInteger)timetrave%tempHourTag)/tempMinuteTag;
        NSInteger tempSecond =((NSInteger)timetrave%tempHourTag)%tempMinuteTag;
        return [NSString stringWithFormat:@"%ld:%ld:%ld",tempHour,tempMinue,tempSecond];
    }
    else if(tempDayTag <timetrave )
    {
        NSInteger tempDay = (NSInteger)timetrave/tempDayTag;
        NSInteger tempHour = ((NSInteger)timetrave%tempDayTag)/tempHourTag;
        NSInteger tempMinue =(((NSInteger)timetrave%tempDayTag)%tempHourTag)/tempMinuteTag;
        NSInteger tempSecond =(((NSInteger)timetrave%tempDayTag)%tempHourTag)%tempMinuteTag;
        return [NSString stringWithFormat:@"%ld天%ld:%ld:%ld",tempDay,tempHour,tempMinue,tempSecond];
    }
    return nil;
}
//数字转化二进制
+ (NSString *)paddedBinaryString:(NSString*)text
{
    NSMutableString *string = [NSMutableString string];
    NSInteger value = [text integerValue];
    for (NSInteger i = 0; i < sizeof(value) * 8; i++)
    {
        [string insertString:(value & 1)? @"1": @"0" atIndex:0];
        value /= 2;
    }
    NSInteger teml = [string length]-3;
    return [string substringFromIndex:teml];
}

// 十六进制转换为普通字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString { //
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString;
}

//普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
        {
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        }
        else
        {
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    return hexStr; 
}

//换算m->km
+ (NSString*)stringToKmString:(NSString*)lat withLon:(NSString*)lng
{
    NSString* tempStr = @"";
    
    if (lat == nil || lat.length == 0||lng == nil ||lng.length == 0) {
        return tempStr;
    }
    
    if ([APPDELEGATE.viewController.myLat doubleValue] == 0 || [APPDELEGATE.viewController.myLng doubleValue] == 0) {
        return tempStr;
    }
    
    CLLocation *userL = [[CLLocation alloc] initWithLatitude:[APPDELEGATE.viewController.myLat doubleValue] longitude:[APPDELEGATE.viewController.myLng doubleValue]];
    
    CLLocation *carL = [[CLLocation alloc] initWithLatitude:[lat doubleValue] longitude:[lng doubleValue]];
    
    float distance = [userL distanceFromLocation:carL];
    
    CGFloat kmstr = distance/1000;
    
    tempStr = [NSString stringWithFormat:@"%.02f",kmstr];
    
    return tempStr;
}

+ (BOOL)isTelephone:(NSString*)phone
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9]|7[0678])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[0-27-9]|8[2-478]|7[08])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[356|7[6]])\\d{8}$";
    NSString * CT = @"^1((33|53|8[019]|7[7])[0-9]|349)\\d{7}$";
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    return  [regextestmobile evaluateWithObject:phone]   ||
    //    [regextestphs evaluateWithObject:self]      ||
    [regextestct evaluateWithObject:phone]       ||
    [regextestcu evaluateWithObject:phone]       ||
    [regextestcm evaluateWithObject:phone];
}

@end
