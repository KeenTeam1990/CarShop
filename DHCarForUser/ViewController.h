//
//  ViewController.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/18.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "D_LoginViewController.h"
#import "M_UserInfoModel.h"
#import "M_CityListModel.h"
#import "M_WxAuth2Model.h"

typedef void (^TCarDataBlock)(id data);
typedef void (^TBingPhoneBlock)(bool result);

@interface ViewController : UIViewController<UIAlertViewDelegate>

AS_FACTORY(ViewController);

AS_MODEL_STRONG(M_UserInfoModel, myUserModel);
AS_MODEL_STRONG(M_CityItemModel, myCityModel);
AS_MODEL_STRONG(NSString, myLat);
AS_MODEL_STRONG(NSString, myLng);
AS_BOOL(updateSpike);
AS_MODEL_STRONG(HomeViewController, homeController);
AS_MODEL_STRONG(D_LoginViewController, loginController);

AS_MODEL_STRONG(M_WbAuth2Model, myWbModel);
AS_MODEL_STRONG(M_WxAuth2Model, myWxModel);

AS_BLOCK(TBingPhoneBlock, bindBlock);

AS_MODEL_STRONG(NSDictionary, JPushData);

-(void)handleJPushData:(NSDictionary*)data;
-(void)toJpushDetail;
-(void)toDetails:(UIViewController*)controller;

-(void)initLogoController;
-(void)initHomeController;
-(void)initLoginController:(UIViewController*)controller  withIsLogin:(BOOL)login;
-(void)toHome;
-(void)logout:(UIViewController*)controller;
-(void)openLogin:(UIViewController*)controller;
-(void)openBingPhone:(UIViewController*)controller withBlock:(TBingPhoneBlock)block;
-(void)bindPhone:(UIViewController*)controller withBlock:(TBingPhoneBlock)block;

-(void)cityLocation:(TCarDataBlock)block;
-(void)getUserData:(TCarDataBlock)block;

@end

