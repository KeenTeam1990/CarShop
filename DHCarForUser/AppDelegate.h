//
//  AppDelegate.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/18.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "D_PayViewController.h"
#import "WXApi.h"

typedef void (^TLocaticonBlock)();

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

AS_MODEL_STRONG(UIWindow,window);
AS_MODEL_STRONG(ViewController,viewController);

AS_MODEL_STRONG(D_PayViewController, myPayController);

-(void)startLocation:(TLocaticonBlock)block1;

// 设置本地通知
- (void)registerLocalNotification:(NSInteger)alertTime
                          withDic:(NSDictionary*)userInfo
                         withBody:(NSString*)body;

@end

