//
//  DefaultType.h
//  TickTock
//
//  Created by 卢迎志 on 14-11-26.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#ifndef TickTock_DefaultType_h
#define TickTock_DefaultType_h

#import "AppDelegate.h"

#define APPDELEGATE   ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define DeviceVersion [[UIDevice currentDevice].systemVersion doubleValue]

#define NavigationBarHeight 48
#define TabBarHeight 60
//#define KHost @"http://180.97.15.55:9103"  //测试环境
//#define KHost @"http://192.168.111.166:8081"  //测试环境
#define KHost @"http://api.dhqcsc.com"


//#define KHost @"http://wwwt.dhqcsc.com"
//#define KHost @"http://www.dhqcsc.com"
#define KH5Host @"http://m.dhqcsc.com"//正式
//#define KH5Host @"http://h5t.dhqcsc.com"//测试


//#define KH5Host @"h5.dhqcsc.com/html?k="
//#define KHost @"http://demo.leiyugame.cn"

//#define KHost @"http://180.97.15.56:8103"

//#define KH5Host @"http://180.97.15.56:8102"

#define KPlatform @"IOS"

#define KHttpTimerOut 10

#define TEXT_MAXLENGTH 140

#define KServerVersion @"1_0"
//邀请返现
#define KCash @"/cash"
#define kAppKey         @"1695384370"
#define kRedirectURI    @"https://api.weibo.com/oauth2/default.html"

#define GrayText [Unity getColor:@"#666666"]
#define RedText [Unity getColor:@"#e01722"]
#define GrayView [Unity getColor:@"#eeeeee"]

#define TitleTextFont [UIFont boldSystemFontOfSize:18]
#define ContenTextFont [UIFont SystemFontOfSize:14]
#define NoteTextFont [UIFont SystemFontOfSize:12]

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define  ScreenWidth [UIScreen mainScreen].bounds.size.width
#define  ScreenHeight [UIScreen mainScreen].bounds.size.height
#define  ScreenViewHeight ([UIScreen mainScreen].bounds.size.height - 68)
#define  ScreenHeight_3 ((ScreenHeight-68)/3)
#define  StartX(startx) ScreenWidth*(startx/2)/375
#define  StartY(starty) ScreenHeight*(starty/2)/667
#define  Width(width)   ScreenWidth*(width/2)/375
#define  Height(height) ScreenHeight*(height/2)/667

typedef enum {
    LL_HaveUserHeadImageView,
    LL_HidenUserHeadImageView
}MyUserNameAndPhoneType;

typedef enum {
    LL_MyCarHeadViewNomalViewType,//没颜色，没价格，没button
    LL_MyCarHeadViewHasPriceType,//有价格没颜色
    LL_MyCarHeadViewHaveColorType,
    LL_MyCarHeadViewSendLastPriceType,
    LL_MyCarHeadViewSendFirstPriceType
    
}MyCarHeadViewType;
#endif
