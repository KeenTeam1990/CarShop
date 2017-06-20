//
//  AppDelegate.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/18.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "AppDelegate.h"
#import "TTReqEngine.h"
//#import "UMessage.h"
#import "UMFeedback.h"
#import "MobClick.h"
#import "LL_FeedBackViewController.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WeiboSDK.h"
#import "D_MessageViewController.h"
#import "JPUSHService.h"
#import "D_WebViewController.h"

@interface AppDelegate ()<WeiboSDKDelegate,UIAlertViewDelegate>
AS_MODEL_STRONG(NSString, typeValue);
AS_MODEL_STRONG(NSDictionary, notValue);
AS_BOOL(regNotifi);
AS_MODEL_STRONG(UILocalNotification, localNotification)
@end

@implementation AppDelegate
DEF_MODEL(window);
DEF_MODEL(viewController);
DEF_MODEL(typeValue);
DEF_MODEL(notValue);
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"window frame:%@",NSStringFromCGRect(self.window.frame));
     NSString* tempPath = [NSString stringWithFormat:@"%@%@",[DLCache libCachesToTemp],@"aaa"];
    [DLCache writeImage:[UIImage imageNamed:@"1-1@3x"] toDocumentPath:tempPath];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    self.viewController = [[ViewController alloc]init];
    
    DLBaseNavigationController * rootNav = [[DLBaseNavigationController alloc]initWithRootViewController:self.viewController];
    
    rootNav.navigationBarHidden = YES;
    
    self.window.rootViewController = rootNav;
    
    [self.window makeKeyAndVisible];
    
    [self startLocation:^(){
       
    }];
    
    [WeiboSDK registerApp:kAppKey];
    //微信
    [WXApi registerApp:@"wxdcbe9ff16e5533e8"];
    
    [MobClick startWithAppkey:@"5657067567e58ea569002038" reportPolicy:BATCH channelId:@""];//友盟统计
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
//    [UMessage startWithAppkey:@"5657067567e58ea569002038" launchOptions:launchOptions];//推送key
    [UMFeedback setAppkey:@"5657067567e58ea569002038"];//反馈key
    
    
    //极光推送设置相关注册
    if (DeviceVersion >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound
                                                          )
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound)
                                              categories:nil];
    }
    
    //极光推送注册
    [JPUSHService setupWithOption:launchOptions appKey:@"d21225e617e4f168c1d0bb05" channel:@"11" apsForProduction:YES];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

    //关闭状态时点击反馈消息进入反馈页
    /**
     *  第一次启动时调用，判断是否有推送
     */
    NSDictionary *notificationDict = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if(notificationDict)
    {
        //有推送消息，处理推送的消息
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self application:application didReceiveRemoteNotification:notificationDict];
        });
//         [UMFeedback didReceiveRemoteNotification:notificationDict];
        
    }
    UILocalNotification * notificationLocalDict = [launchOptions valueForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (notificationLocalDict!=nil) {
        if (APPDELEGATE.viewController.JPushData == nil) {
            [self application:application didReceiveLocalNotification:notificationLocalDict];
//            [APPDELEGATE.viewController handleJPushData:notificationLocalDict.userInfo];
        }
    }
//    [UMessage setLogEnabled:YES];
//    NSDictionary *notificationDict1 = [launchOptions valueForKey:UIApplicationLaunchOptionsLocalNotificationKey];
//    if(notificationDict1)
//    {
//        //有推送消息，处理推送的消息
//        UILocalNotification *notification = [[UILocalNotification alloc] init];
//        notification.userInfo= notificationDict1;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self application:application didReceiveLocalNotification:notificationDict1];
//        });
//        //         [UMFeedback didReceiveRemoteNotification:notificationDict];
//        
//    }
    //    [UMessage setLogEnabled:YES];
    self.regNotifi = NO;
    return YES;
}


-(void)startLocation:(TLocaticonBlock)block1
{
    [[DLLocationManager sharedInstance] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
        
        self.viewController.myLat = [NSString fromFoalt:locationCorrrdinate.latitude];
        self.viewController.myLng = [NSString fromFoalt:locationCorrrdinate.longitude];
        
        if (block1!=nil) {
            block1();
        }
    }];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [WeiboSDK handleOpenURL:url delegate:self ];
    
    [WXApi handleOpenURL:url delegate:self];
    
    return  YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result = %@",resultDic);
//        
//        if (self.myPayController!=nil) {
//            [self.myPayController handlerAliPay:resultDic];
//        }
    }];
    
    [WeiboSDK handleOpenURL:url delegate:self];
    
    [WXApi handleOpenURL:url delegate:self];
    
    return  YES;
}


- (void)onReq:(BaseReq *)req
{
    
}

- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]]) {
        
        if (self.myPayController!=nil) {
            [self.myPayController handlerWxPay:[NSString fromInt:resp.errCode]];
        }
        
    }else if([resp isKindOfClass:[SendAuthResp class]]){
        SendAuthResp* tempResp = (SendAuthResp*)resp;
        if (self.viewController.loginController!=nil) {
            [self.viewController.loginController handlerWxLogin:tempResp.errCode withCode:tempResp.code];
        }
    }else if ([resp isKindOfClass:[SendMessageToWXResp class]]){
        SendMessageToWXResp* tempResp = (SendMessageToWXResp*)resp;
        if (tempResp.errCode == 0) {
            [SVProgressHUD showSuccessWithStatus:@"分享成功！"];
        }else if (tempResp.errCode == -2){
            [SVProgressHUD showErrorWithStatus:@"取消分享！"];
        }else if (tempResp.errCode == -4){
            [SVProgressHUD showErrorWithStatus:@"拒绝分享！"];
        }
    }
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        if (response.statusCode == 0) {
            //成功
            [SVProgressHUD showSuccessWithStatus:@"分享成功！"];
        }else if (response.statusCode == -1) {
            //用户取消发送
            [SVProgressHUD showErrorWithStatus:@"用户取消发送"];
        }else if (response.statusCode == -2) {
            //发送失败
            [SVProgressHUD showErrorWithStatus:@"发送失败"];
        }else if (response.statusCode == -3) {
            //授权失败
            [SVProgressHUD showErrorWithStatus:@"授权失败"];
        }else if (response.statusCode == -4) {
            //用户取消安装微博客户端
            [SVProgressHUD showErrorWithStatus:@"用户取消安装微博客户端"];
        }
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken)
        {
            self.viewController.myWbModel.access_token = accessToken;
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            self.viewController.myWbModel.currentUserID = userID;
        }
        NSString* refreshToken = [sendMessageToWeiboResponse.authResponse refreshToken];
        if (refreshToken)
        {
            self.viewController.myWbModel.refresh_token = refreshToken;
        }
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        self.viewController.myWbModel.access_token = [(WBAuthorizeResponse *)response accessToken];
        self.viewController.myWbModel.currentUserID = [(WBAuthorizeResponse *)response userID];
        self.viewController.myWbModel.refresh_token = [(WBAuthorizeResponse *)response refreshToken];
        
        if (self.viewController.loginController!=nil) {
            [self.viewController.loginController handlerWbLogin:(int)response.statusCode];
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //取消徽章
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark Umessage
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken
{
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    if (!self.regNotifi) {
        [JPUSHService registerDeviceToken:deviceToken];
        self.regNotifi = YES;
    }
    //推送
//    [UMessage registerDeviceToken:deviceToken];
    //反馈添加的代码
//    NSLog(@"umeng message alias is: %@", [UMFeedback uuid]);
//    [UMessage addAlias:[UMFeedback uuid] type:[UMFeedback messageType] response:^(id responseObject, NSError *error) {
//        if (error != nil) {
//            NSLog(@"%@", error);
//            NSLog(@"%@", responseObject);
//            LL_FeedBackViewController *view = [[LL_FeedBackViewController alloc]init];
//            [[UMFeedback sharedInstance] setFeedbackViewController:view shouldPush:YES];
//        }
//    }];
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"sssssssss11111%@",error);
    
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    LL_FeedBackViewController *view = [[LL_FeedBackViewController alloc]init];
    [[UMFeedback sharedInstance] setFeedbackViewController:view shouldPush:YES];
    
    if (userInfo !=nil) {
          [APPDELEGATE.viewController handleJPushData:userInfo];
    }

}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    if (application.applicationState == UIApplicationStateActive) {

        NSString *messageAlert = [[userInfo objectForKey:@"aps"]objectForKey:@"alert"];

        [APPDELEGATE registerLocalNotification:1 withDic:userInfo withBody:messageAlert];

    }
    else if(application.applicationState == UIApplicationStateInactive)
    {
        if (APPDELEGATE.viewController.JPushData == nil) {

            [APPDELEGATE.viewController handleJPushData:userInfo];
        }
        
    }
    
    [JPUSHService handleRemoteNotification:userInfo];
    
//    [UMessage didR18311242595eceiveRemoteNotification:userInfo];
    //处理push打开进入页面

    completionHandler(UIBackgroundFetchResultNewData);
    
}


// 本地通知回调函数，当应用程序在前台时调用
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {

    if(application.applicationState == UIApplicationStateInactive)
    {
        NSLog(@"%@",APPDELEGATE.viewController.JPushData);
        if (APPDELEGATE.viewController.JPushData == nil) {
            [APPDELEGATE.viewController handleJPushData:notification.userInfo];
        }
        
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
    }
}
// 设置本地通知
- (void)registerLocalNotification:(NSInteger)alertTime
                          withDic:(NSDictionary*)userInfo
                         withBody:(NSString*)body{
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];

    notification.fireDate = fireDate;
    notification.repeatCalendar=[NSCalendar currentCalendar];
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔

    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSCalendarUnitDay;
    } else {
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSDayCalendarUnit;
    }

    
    // 通知参数
    
    [notification setUserInfo: userInfo];
    
    notification.alertBody = body;

    notification.soundName = @"msg.caf";

       // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];

}

// 取消某个本地推送通知
+ (void)cancelLocalNotificationWithKey:(NSString *)key {
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    for (UILocalNotification *notification in localNotifications) {
        
//        [[UIApplication sharedApplication] cancelLocalNotification:notification];
        
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo) {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[key];
            
            // 如果找到需要取消的通知，则取消
            if (info != nil) {

                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;
            }
        }
    }
}

- (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    return topVC;
}

@end
