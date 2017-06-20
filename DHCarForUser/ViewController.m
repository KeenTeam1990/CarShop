//
//  ViewController.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/18.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "ViewController.h"
#import "BootstrapViewController.h"
#import "LogoViewController.h"
#import "TTReqEngine.h"
#import "JPUSHService.h"
#import "D_WebViewController.h"
#import "D_LLDetailOrderViewController.h"
#import "LL_SysteMessageDetailViewController.h"
@interface ViewController ()

AS_MODEL_STRONG(UIViewController, myCurrController);

@end

@implementation ViewController

DEF_FACTORY(ViewController);

DEF_MODEL(myCurrController);

DEF_MODEL(myUserModel);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
     [self initData];
    
    [self initLogoController];
    
}

-(void)initData
{
    [DLAppData sharedInstance].httpTimerOut = KHttpTimerOut;
    
    self.myCityModel = [M_CityItemModel allocInstance];
    
    NSString* cityid = [[DLUserDefaults sharedInstance] objectForKey:@"city_id"];
    NSString* cityname = [[DLUserDefaults sharedInstance] objectForKey:@"city_name"];
    
    if ([cityid notEmpty]) {
        self.myCityModel.myCity_Id = cityid;
    }else{
        self.myCityModel.myCity_Id = @"320100";
    }
    if ([cityname notEmpty]) {
        self.myCityModel.myCity_Name = cityname;
    }else{
        self.myCityModel.myCity_Name = @"南京市";
    }
    
    self.myWbModel = [M_WbAuth2Model allocInstance];
    self.myWxModel = [M_WxAuth2Model allocInstance];
}

-(void)initLogoController
{
    [self.navigationController pushViewController:[LogoViewController allocInstance] animated:NO];
}

-(void)toHome
{
    //调用的时候判断是否为第一次
    if (![[NSUserDefaults standardUserDefaults] boolForKey:[[DLUserDefaults sharedInstance] getAppKey:@"first"]])
    {
        [self initBootstrapController];
        
    }else{
        
        [self getCacheUserData];
        
        [self initHomeController];
    }
}

-(BOOL)getCacheUserData
{
    NSString* tmpStr  = [[DLUserDefaults sharedInstance] objectForKey:@"uid"];
    
    if ([tmpStr notEmpty]) {
        [DLAppData sharedInstance].myUserKey = tmpStr;
        
        [JPUSHService setAlias:tmpStr callbackSelector:nil object:nil];
        
        NSString* tempPath = [NSString stringWithFormat:@"%@%@",[DLCache libCachesToTemp],@"info"];
        
        if ([DLCache isFileExists:tempPath]) {
            
            NSString* tempStr=  [DLCache getStringFromDocumentPath:tempPath];
            
            self.myUserModel = [M_UserInfoModel allocInstance];
            
            [self.myUserModel parseData:tempStr];
            
            if ([self.myUserModel.user_phone notEmpty]) {
                [DLAppData sharedInstance].myUserName = self.myUserModel.user_phone;
            }
            [self getUserData:nil];
        }else{
            [self getUserData:nil];
        }
        
        return YES;
    }
    return NO;
}

-(void)initHomeController
{
    self.homeController = [HomeViewController allocInstance];
    
    DLBaseNavigationController* tempNav = [DLBaseNavigationController sharedInstanceRoot:self.homeController];
    tempNav.navigationBarHidden = YES;
    [self presentViewController:tempNav animated:NO completion:nil];
}

-(void)initBootstrapController
{
    [self presentViewController:[BootstrapViewController allocInstance] animated:NO completion:nil];
}

-(void)initLoginController:(UIViewController*)controller withIsLogin:(BOOL)login
{
    self.loginController = [D_LoginViewController allocInstance];
    self.loginController.isLogin = login;
    DLBaseNavigationController* tempNav = [DLBaseNavigationController sharedInstanceRoot:self.loginController];
    tempNav.navigationBarHidden = YES;
    
    [controller presentViewController:tempNav animated:YES completion:nil];
}

-(void)openLogin:(UIViewController*)controller
{
    self.myCurrController = controller;
    UIAlertView* tempView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没有登录，是否立即登录？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    tempView.tag = 9999;
    [tempView show];
}

-(void)openBingPhone:(UIViewController*)controller withBlock:(TBingPhoneBlock)block
{
    self.myCurrController = controller;
    
    self.bindBlock = block;
    
    UIAlertView* tempView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没有绑定手机号码，是否立即绑定？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    tempView.tag = 9990;
    [tempView show];
}

-(void)bindPhone:(UIViewController*)controller withBlock:(TBingPhoneBlock)block
{
    self.myCurrController = controller;
    
    [self initLoginController:self.myCurrController withIsLogin:NO];
    
    self.loginController.block = ^(NSInteger tag){
        if (tag == 0) {
            if (block!=nil) {
                block(YES);
            }
        }
    };
}

-(void)logout:(UIViewController*)controller
{
    self.myCurrController = controller;
    UIAlertView* tempView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定退出账户？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    tempView.tag = 9998;
    [tempView show];
}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 9999) {
        if (buttonIndex == 1) {
            [self initLoginController:self.myCurrController withIsLogin:YES];
        }
    }else if (alertView.tag == 9998){
        
        if (buttonIndex ==1) {
            
            [DLAppData sharedInstance].myUserKey = @"";
            [DLAppData sharedInstance].myUserName = @"";
            
            [[DLUserDefaults sharedInstance] setObject:@"" forKey:@"uid"];
            [[DLUserDefaults sharedInstance] setObject:@"" forKey:@"username"];
            APPDELEGATE.viewController.myUserModel.user_has_sign= @"0";
            self.myUserModel = nil;
            
            [self.myCurrController.navigationController popViewControllerAnimated:NO];
            
            [self initLoginController:self.homeController withIsLogin:YES];
        }
    }else if (alertView.tag == 9990){
        if(buttonIndex == 1)
        {
            [self bindPhone:self.myCurrController withBlock:self.bindBlock];
        }
        
    }
}

-(void)cityLocation:(TCarDataBlock)block
{
    if ([self.myLng notEmpty] && [self.myLat notEmpty]) {
   
        [TTReqEngine C_GetCity_locationLng:self.myLng
                                   withLat:self.myLat
                                 withBlock:^(BOOL success, id dataModel) {
                                     if(success){
                                         
                                         M_CityItemModel* tempModel = (M_CityItemModel*)dataModel;
                                         
                                         [DLAppData sharedInstance].myCurrCityId = tempModel.myCity_Id;
                                         [DLAppData sharedInstance].myCurrCityName = tempModel.myCity_Name;
                                         [DLAppData sharedInstance].myCurrCityCode = tempModel.myCity_Code;
                                         
                                         if (block!=nil) {
                                             block(tempModel);
                                             
                                         }
                                     }
                                 }];
    }else{
        [DLAppData sharedInstance].myCurrCityId = @"";
        [DLAppData sharedInstance].myCurrCityName = @"";
        [DLAppData sharedInstance].myCurrCityCode = @"";
    }
}

-(void)getUserData:(TCarDataBlock)block
{
    [TTReqEngine C_GetUser_GetSetUid:[DLAppData sharedInstance].myUserKey
                           withBlock:^(BOOL success, id dataModel) {
                               if (success) {
                                   
                                   self.myUserModel = (M_UserInfoModel*)dataModel;
                                   
                                   if ([self.myUserModel.user_phone notEmpty]) {
                                       [DLAppData sharedInstance].myUserName = self.myUserModel.user_phone;
                                   }
                                   
                                   if (block!=nil) {
                                       block(self.myUserModel);
                                   }
                               }else{
                                   if (block!=nil) {
                                       block(nil);
                                   }
                               }
                           }];
}

-(void)handleJPushData:(NSDictionary*)data
{
    if (data!=nil) {
        
        self.JPushData = data;
       
        [self toJpushDetail];
    }
}

-(void)toJpushDetail
{
    id curViewController;
    if (self.homeController!=nil) {
        switch (self.homeController.tabBarController.selectedIndex) {
            case 0:
                curViewController = [self.homeController.homeVC.navigationController.viewControllers lastObject];
                
                break;
            case 1:
                curViewController = [self.homeController.findMessageVC.navigationController.viewControllers lastObject];
                break;
            case 2:
                curViewController = [self.homeController.myCenterVC.navigationController.viewControllers lastObject];
                break;
            default:
                break;
        }
    }
    
    if (curViewController!=nil) {
        [self performSelector:@selector(toDetails:) withObject:curViewController afterDelay:0.5];
    }
}

-(void)toDetails:(UIViewController*)controller
{
    if (self.JPushData!= nil) {
        if (controller==nil) {
            return;
        }
        NSNumber* tempType = [self.JPushData hasItemAndBack:@"type"];
        if (tempType !=nil) {
            NSInteger numberType = [tempType integerValue];
            if (numberType == 1) {
                //订单
                if ([self getCacheUserData]) {
                    NSNumber * tempId = [self.JPushData hasItemAndBack:@"id"];
                    if (tempId == nil) {
                        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"" message:@"账单ID为空,账单生成失败!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                        [alter show];
                        return;
                    }
                    D_LLDetailOrderViewController* tempController = [D_LLDetailOrderViewController allocInstance];
                    
                    tempController.orderID = [tempId stringValue];
                    tempController.showPush = YES;
                    
                    DLBaseNavigationController* tempNav = [DLBaseNavigationController sharedInstanceRoot:tempController];
                    tempNav.navigationBarHidden = YES;
                    [controller presentViewController:tempNav animated:YES completion:nil];
                }else{
                    [self openLogin:controller];
                }
                
            }else if (numberType == 2){
                //2 文章
                
                NSString* tempurl = [self.JPushData hasItemAndBack:@"url"];
                [self toWebController:@"文章" withUrl:tempurl withController:controller];
                
            }else if (numberType == 3){
                //3 系统消息
//                NSString* tempurl = [self.JPushData hasItemAndBack:@"url"];
//                
//                [self toWebController:@"系统消息" withUrl:tempurl withController:controller];
                NSString* tempId = [self.JPushData hasItemAndBack:@"id"];

                LL_SysteMessageDetailViewController * tempController = [[LL_SysteMessageDetailViewController alloc]init];
            
                tempController.showPush = YES;
                
                DLBaseNavigationController* tempNav = [DLBaseNavigationController sharedInstanceRoot:tempController];
                tempNav.navigationBarHidden = YES;
                [controller presentViewController:tempNav animated:YES completion:nil];
            }
        }
        
        self.JPushData = nil;
    }
}

-(void)toWebController:(NSString*)title withUrl:(NSString*)url withController:(UIViewController*)controller
{
    D_WebViewController* tempController = [D_WebViewController allocInstance];
    tempController.myTitle  =title;
    tempController.myUrl = url;
    tempController.showPush = YES;
    
    DLBaseNavigationController* tempNav = [DLBaseNavigationController sharedInstanceRoot:tempController];
    tempNav.navigationBarHidden = YES;
    [controller presentViewController:tempNav animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
