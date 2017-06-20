//
//  D_LoginViewController.m
//  DHCarForSales
//
//  Created by lucaslu on 15/10/31.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_LoginViewController.h"
#import "M_LoginView.h"
#import "TTReqEngine.h"
#import "Dh_LoginModel.h"
#import "M_UserInfoModel.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "WeiboSDK.h"
#import "DHForgetPassword.h"
#import "DLRegisterViewController.h"
#import "DLSetPasswordViewController.h"
#import "JPUSHService.h"

#define KMAX_TIMER 60

@interface D_LoginViewController ()

//AS_MODEL_STRONG(M_LoginView, myLoginView);
AS_MODEL_STRONG(UISegmentedControl, loginType);
AS_MODEL_STRONG(UIButton, myGetCodeBtn);
AS_MODEL_STRONG(UIButton, myLoginBtn);
AS_MODEL_STRONG(UIButton, myforgetBtn);
AS_MODEL_STRONG(UIButton, registerBtn);

AS_MODEL_STRONG(NSTimer, myTimer);
AS_INT(currIndex);

@end

@implementation D_LoginViewController

DEF_FACTORY(D_LoginViewController);
//DEF_MODEL(myLoginView);
DEF_MODEL(loginType);
DEF_MODEL(myGetCodeBtn);
DEF_MODEL(myLoginBtn);
DEF_MODEL(myforgetBtn);
DEF_MODEL(registerBtn);
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    
    [self initData];
    
    [self initTimer];
    
    [self addTapToBaseView];
    
    [self addKeywordNotify];
    
    self.currIndex = KMAX_TIMER;

}

-(void)notifyshowKeyword:(CGRect)keyRect
{
    CGRect tempFrame = self.myTableView.frame;
    tempFrame.size.height = self.baseView.frame.size.height-keyRect.size.height;
    self.myTableView.frame = tempFrame;
    
//    [self.myTableView scrollRectToVisible:[self.myLoginView getCurrFieldRect:self.myTableView] animated:YES];
}

-(void)notifyhideKeyword
{
    CGRect tempFrame = self.myTableView.frame;
    tempFrame.size.height = self.baseView.frame.size.height;
    self.myTableView.frame = tempFrame;
}

-(void)initView
{
    NSString* tempStr = @"";
    NSInteger tempHeaderHeight = 0;
    if (self.isLogin) {
        tempStr = @"帐号登录";

        tempHeaderHeight = 420;
    }else{
        tempStr = @"绑定手机号码";
        tempHeaderHeight = 320;
    }
    
    [self addCustomNavBar:tempStr
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    self.baseView.backgroundColor = [UIColor colorWithRed:0.93725 green:0.93725 blue:0.93725 alpha:1.0];
    self.loginType = [[UISegmentedControl alloc]initWithItems:@[@"验证码登录",@"新密码登录"]];
    
    self.loginType.frame=CGRectMake(30, NavigationBarHeight+20, SCREEN_WIDTH-60, 40);
    
    self.loginType.selectedSegmentIndex=0;
    
    self.loginType.tintColor=[UIColor redColor];
    
    self.loginType.momentary=NO;
    
    self.loginType.backgroundColor=[Unity   getColor:@"#ffffff"];
    
    [self.loginType addTarget:self action:@selector(loginTypeChange:) forControlEvents:UIControlEventValueChanged];
    [self.baseView addSubview:self.loginType];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight + 80, self.baseView.bounds.size.width, self.baseView.bounds.size.height-80) withSeparatoStyle:UITableViewCellSeparatorStyleSingleLine];
    self.myTableView.rowHeight = 50;
    self.myTableView.scrollEnabled = NO;
    self.myTableView.backgroundColor = [UIColor colorWithRed:0.93725 green:0.93725 blue:0.93725 alpha:1.0];
//    self.myTableView.backgroundColor = [UIColor redColor];

    
//    self.myLoginView = [M_LoginView allocInstanceFrame:CGRectMake(0, 0, self.baseView.frame.size.width, tempHeaderHeight)];
//    self.myLoginView.isLogin = self.isLogin;
//    self.myTableView.tableHeaderView = self.myLoginView;
    
    self.myGetCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myGetCodeBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor];
                                                style.borderWidth = 1;
                                                style.cornerRedius = 4;
                                                style.borderColor = [UIColor redColor];);
    
    [self.myGetCodeBtn addTarget:self action:@selector(getCodeBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.myGetCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.myGetCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.myGetCodeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //self.myGetCodeBtn.layer.cornerRadius = 4.0;
    self.myGetCodeBtn.frame = CGRectMake(ScreenWidth-110, 10, 100, 30);
    
    self.myLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myLoginBtn.style = DLButtonStyleMake(style.backgroundColor =[UIColor redColor];
                                              style.cornerRedius = 6;);
    [self.myLoginBtn addTarget:self action:@selector(loginBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.myLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.myLoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.myLoginBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    self.myLoginBtn.frame = CGRectMake(10, NavigationBarHeight + 240, ScreenWidth-20, 45);
    //self.myLoginBtn.layer.cornerRadius = 6.0;
    [self.baseView addSubview:self.myLoginBtn];

    self.myforgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.myforgetBtn addTarget:self action:@selector(forgetBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.myforgetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.myforgetBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 0, 0, -70);
    [self.myforgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [self.myforgetBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    self.myforgetBtn.frame = CGRectMake(ScreenWidth-150, NavigationBarHeight + 190, 140, 25);
    self.myforgetBtn.enabled = NO;
    self.myforgetBtn.hidden = YES;
    [self.baseView addSubview:self.myforgetBtn];
    
    UIButton *temprightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn = temprightBtn;
    [temprightBtn setFrame:CGRectMake(ScreenWidth-80, 0, 70, 44)];
    [temprightBtn setBackgroundColor:[UIColor clearColor]];
    [temprightBtn setTitle:@"快速注册" forState:UIControlStateNormal];
    temprightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [temprightBtn addTarget:self action:@selector(registerBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [temprightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.registerBtn.hidden = YES;
    self.registerBtn.enabled = NO;
    [self.customNavBar addSubview:temprightBtn];
}

-(void)registerBtnPressed
{
    [self.navigationController pushViewController:[[DLRegisterViewController alloc] init] animated:YES];
}

-(void)forgetBtnPressed:(UIButton *)sender
{
    [self.navigationController pushViewController:[[DHForgetPassword alloc] init] animated:YES];
}

-(void)loginBtnPressed:(UIButton *)sender
{
    NSString* tempPhone = nil;
    NSString* tempCode = nil;
    NSString* tempPwd = nil;
    
    UITableViewCell* tempcell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (tempcell!=nil) {
        UITextField *cellTextField = (UITextField *)[tempcell viewWithTag:101];
        if (cellTextField!=nil) {
            tempPhone = cellTextField.text;
        }
    }
    
    if (self.loginType.selectedSegmentIndex == 0) {
        //验证码登录
        NSLog(@"验证码登录");
        
        tempcell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        if (tempcell!=nil) {
            UITextField *cellTextField = (UITextField *)[tempcell viewWithTag:101];
            if (cellTextField!=nil) {
                tempCode = cellTextField.text;
            }
            //[self login:@"18311242595" withCode:@"1234"];
        }
    }else if (self.loginType.selectedSegmentIndex == 1){
        //新密码登录
        //[self login:@"18311242595" withPassword:@"1234"];
        tempcell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        if (tempcell!=nil) {
            UITextField *cellTextField = (UITextField *)[tempcell viewWithTag:101];
            if (cellTextField!=nil) {
                tempPwd = cellTextField.text;
            }
        }
    }
    
    if (![Unity isNetworkReachable]) {
        return;
    }
    
    if ([tempPhone empty]) {
        [SVProgressHUD showErrorWithStatus:@"请输入11位的手机号码"];
        return;
    }
    
    if (![Unity isTelephone:tempPhone]) {
        [SVProgressHUD showErrorWithStatus:@"请输入11位的手机号码"];
        return;
    }
    
    if (self.loginType.selectedSegmentIndex == 0) {
        
        if ([tempCode empty]) {
            [SVProgressHUD showErrorWithStatus:@"请输入短信验证码"];
            return;
        }
        
        [self login:tempPhone withCode:tempCode withIsPwd:NO];
    }else if (self.loginType.selectedSegmentIndex == 1){
        if ([tempPwd empty]) {
            [SVProgressHUD showErrorWithStatus:@"请输入密码"];
            return;
        }
        [self login:tempPhone withPassword:tempPwd];

        //[self login:@"18311242595" withPassword:@"1234"];
        //[self login:tempPhone withCode:tempPwd withIsPwd:YES];
    }
    else{

    }
}

-(void)getCodeBtnPressed:(UIButton *)sender
{
    NSString* tempPhone = nil;
    
    UITableViewCell* tempcell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (tempcell!=nil) {
        UITextField *cellTextField = (UITextField *)[tempcell viewWithTag:101];
        if (cellTextField!=nil) {
            tempPhone = cellTextField.text;
        }
    }
    
    if ([tempPhone empty]) {
        [SVProgressHUD showErrorWithStatus:@"请输入11位的手机号码"];
        return;
    }
    
    if (![Unity isTelephone:tempPhone]) {
        [SVProgressHUD showErrorWithStatus:@"请输入11位的手机号码"];
        return;
    }
    
    [self getCode:tempPhone];
   
}

-(void)getCode:(NSString*)phone
{
    [TTReqEngine C_GetCodeSetPhone:phone
                          withType:@"ordinary"
                         withBlock:^(BOOL success, id dataModel) {
                             DLBaseModel *model = (DLBaseModel *)dataModel;
                             if (success) {
                                 [self getCodeFinish];
                                 [SVProgressHUD showSuccessWithStatus:@"验证码发送成功!"];
                             }
                         }];
}

-(void)loginTypeChange:(UISegmentedControl *)sender
{
    [self.myTableView reloadData];
    UITableViewCell* tempcell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (sender.selectedSegmentIndex == 0) {
        self.myforgetBtn.enabled = NO;
        self.myforgetBtn.hidden = YES;
        if (tempcell!=nil) {
            UITextField *cellTextField = (UITextField *)[tempcell viewWithTag:101];
            cellTextField.secureTextEntry = NO;
            self.registerBtn.hidden = YES;
            self.registerBtn.enabled = NO;
        }
    }
    else{
        self.myforgetBtn.enabled = YES;
        self.myforgetBtn.hidden = NO;
        if (tempcell!=nil) {
            UITextField *cellTextField = (UITextField *)[tempcell viewWithTag:101];
            cellTextField.secureTextEntry = YES;
        }
        self.registerBtn.hidden = NO;
        self.registerBtn.enabled = YES;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"identify";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        UITextField *contentText = [[UITextField alloc] initWithFrame:CGRectMake(90, 10, ScreenWidth - 100, 30)];
        contentText.font = [UIFont systemFontOfSize:15];
        contentText.delegate = self;
        contentText.tag = 101;
        contentText.autocorrectionType = UITextAutocorrectionTypeNo;
        contentText.autocapitalizationType = UITextAutocapitalizationTypeNone;
        contentText.returnKeyType = UIReturnKeyDone;
        contentText.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        contentText.enablesReturnKeyAutomatically = YES;
        [cell addSubview:contentText];
    }
    
    UITextField *cellTextField = (UITextField *)[cell viewWithTag:101];
    if (indexPath.row == 0) {
        cellTextField.placeholder = @"请输入手机号";
        cell.textLabel.text = @"手机号";
        cellTextField.keyboardType = UIKeyboardTypeNumberPad;
        cellTextField.text = @"";
    } else {
        if (self.loginType.selectedSegmentIndex == 0) {
            cellTextField.placeholder = @"请输入验证码";
            cell.textLabel.text = @"验证码";
            cellTextField.text = @"";
            cellTextField.keyboardType = UIKeyboardTypeNumberPad;
            [cell addSubview:self.myGetCodeBtn];
        } else {
            cellTextField.placeholder = @"请输入密码";
            cell.textLabel.text = @"密码";
            cellTextField.text = @"";
            cellTextField.keyboardType = UIKeyboardTypeDefault;
            [self.myGetCodeBtn removeFromSuperview];
        }
    }
    
    return cell;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(void)initData
{
//    __weak D_LoginViewController* tempSelf = self;
//    self.myLoginView.block = ^(NSInteger tag,NSString* phone,NSString* code){
//    
//        switch (tag) {
//            case 0://get code
//                [tempSelf getCode:phone];
//                break;
//            case 1://login
//                [tempSelf login:phone withCode:code];
//                break;
//            case 2:
//                [tempSelf wxLogin];
//                break;
//            case 3:
//                [tempSelf wbLogin];
//                break;
//            default:
//                break;
//        }
//    };
}

-(void)wxLogin
{
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc ] init ];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"123" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}

-(void)wbLogin
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"D_LoginViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}


-(void)login:(NSString*)phone withPassword:(NSString*)password
{
    [TTReqEngine C_PostUser_LoginPhone:phone withPassword:password withBlock:^(BOOL success, id dataModel) {
        M_UserInfoModel* tempModel = (M_UserInfoModel*)dataModel;
        if (success) {
            if (tempModel!=nil) {
                APPDELEGATE.viewController.myUserModel = tempModel;
                [DLAppData sharedInstance].myUserName = phone;
                [[DLUserDefaults sharedInstance] setObject:phone forKey:@"username"];
                [[DLUserDefaults sharedInstance] setObject:tempModel.user_id forKey:@"user_id"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self dismissViewControllerAnimated:NO completion:nil];
                [SVProgressHUD showSuccessWithStatus:@"登录成功!"];
                APPDELEGATE.viewController.updateSpike = YES;
                //设置别名推送
                [JPUSHService setTags:[NSSet set] alias:tempModel.user_id fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags , iAlias);
                }];
                //后台模式下设置别名
                [JPUSHService setTags:[NSSet set] aliasInbackground:tempModel.user_id];
                
            }
        }
    }];
}



-(void)login:(NSString*)phone withCode:(NSString*)code withIsPwd:(BOOL)isPwd
{
//    if (self.isLogin) {
    
        if (isPwd) {
            [TTReqEngine C_PostUser_LoginPhone:phone withPassword:code withBlock:^(BOOL success, id dataModel) {
                M_UserInfoModel* tempModel = (M_UserInfoModel*)dataModel;

                if (success) {
                    if (tempModel!=nil) {
                        
                        APPDELEGATE.viewController.myUserModel = tempModel;
                        
                        [DLAppData sharedInstance].myUserName = phone;
                        [[DLUserDefaults sharedInstance] setObject:phone forKey:@"username"];
                        [[DLUserDefaults sharedInstance] setObject:tempModel.user_id forKey:@"user_id"];
                        [self dismissViewControllerAnimated:NO completion:nil];
                        [SVProgressHUD showSuccessWithStatus:@"登录成功!"];
                        APPDELEGATE.viewController.updateSpike = YES;
                        //设置别名推送
                        [JPUSHService setTags:[NSSet set] alias:tempModel.user_id fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                            NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags , iAlias);
                        }];
                        //后台模式下设置别名
                        [JPUSHService setTags:[NSSet set] aliasInbackground:tempModel.user_id];
                    }
                }
            }];
        }else{
            [TTReqEngine C_PostUser_LoginPhone:phone withCode:code withBlock:^(BOOL success, id dataModel) {
                M_UserInfoModel* tempModel = (M_UserInfoModel*)dataModel;
                if (success) {
                    if (tempModel!=nil) {
                        
                        APPDELEGATE.viewController.myUserModel = tempModel;
                        
                        [DLAppData sharedInstance].myUserName = phone;
                        [[DLUserDefaults sharedInstance] setObject:phone forKey:@"username"];
                        [[DLUserDefaults sharedInstance] setObject:tempModel.user_id forKey:@"user_id"];
                        [self dismissViewControllerAnimated:NO completion:nil];
                        [SVProgressHUD showSuccessWithStatus:@"登录成功!"];
                        APPDELEGATE.viewController.updateSpike = YES;
                        //设置别名推送
                        [JPUSHService setTags:[NSSet set] alias:tempModel.user_id fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                            NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags , iAlias);
                        }];
                        //后台模式下设置别名
                        [JPUSHService setTags:[NSSet set] aliasInbackground:tempModel.user_id];
                    }
                }
            }];
        }
//    }else{
//        [TTReqEngine C_PostUser_BindphoneSetUid:[DLAppData sharedInstance].myUserKey
//                                      withPhone:phone
//                                       withCode:code
//                                      withBlock:^(BOOL success, id dataModel) {
//                                          if (success) {
//                                              M_UserInfoModel* tempModel = (M_UserInfoModel*)dataModel;
//                                              if (tempModel!=nil) {
//                                                  
//                                                  APPDELEGATE.viewController.myUserModel = tempModel;
//                                                  
//                                                  [DLAppData sharedInstance].myUserName = phone;
//                                                  [[DLUserDefaults sharedInstance] setObject:phone forKey:@"username"];
//                                                  
//                                                  if (self.block!=nil) {
//                                                      self.block(0);
//                                                  }
//                                                  
//                                                  [self dismissViewControllerAnimated:NO completion:nil];
//                                                  [SVProgressHUD showSuccessWithStatus:@"绑定成功！"];
//                                              }
//                                          }
//                                      }];
//    }

}
// 微信登陆
-(void)handlerWbLogin:(int)errorcode
{
    if (errorcode == 0) {
        //成功
        
        if (APPDELEGATE.viewController.myWbModel!=nil) {
            if ([APPDELEGATE.viewController.myWbModel.access_token notEmpty] &&
                [APPDELEGATE.viewController.myWbModel.refresh_token notEmpty] &&
                [APPDELEGATE.viewController.myWbModel.currentUserID notEmpty]) {
                [self autoLogin:APPDELEGATE.viewController.myWbModel.access_token
                     withUserId:APPDELEGATE.viewController.myWbModel.currentUserID
               withRefreshToken:APPDELEGATE.viewController.myWbModel.refresh_token
                       withFrom:@"weibo"];
            }
        }
        
    }else if (errorcode == -1) {
        //用户取消发送
        [SVProgressHUD showErrorWithStatus:@"用户取消发送"];
    }else if (errorcode == -2) {
        //发送失败
        [SVProgressHUD showErrorWithStatus:@"发送失败"];
    }else if (errorcode == -3) {
        //授权失败
        [SVProgressHUD showErrorWithStatus:@"授权失败"];
    }else if (errorcode == -4) {
        //用户取消安装微博客户端
        [SVProgressHUD showErrorWithStatus:@"用户取消安装微博客户端"];
    }
}

// 微信登陆
-(void)handlerWxLogin:(int)errorcode withCode:(NSString*)code
{
    if (errorcode == 0) {
        //成功
        NSString* tempurl = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=wxdcbe9ff16e5533e8&secret=410241b097107646516afb06b12319b2&code=%@&grant_type=authorization_code",code];
        [SVProgressHUD showWithStatus:@"请等待..."];
        [DLHttpHelper GetData:tempurl
               withParameters:nil
                      success:^(id responseObject) {
                          [SVProgressHUD dismiss];
                          NSDictionary* tempDic = [responseObject JSONValue];
                          if (tempDic != nil) {
                              NSLog(@"授权：%@",tempDic);
                              
                              APPDELEGATE.viewController.myWxModel.access_token = [tempDic hasItemAndBack:@"access_token"];
                              APPDELEGATE.viewController.myWxModel.openid = [tempDic hasItemAndBack:@"openid"];
                              APPDELEGATE.viewController.myWxModel.refresh_token = [tempDic hasItemAndBack:@"refresh_token"];
                              APPDELEGATE.viewController.myWxModel.unionid = [tempDic hasItemAndBack:@"unionid"];
                              
                              if (APPDELEGATE.viewController.myWxModel!=nil) {
                                  if ([APPDELEGATE.viewController.myWxModel.access_token notEmpty] &&
                                      [APPDELEGATE.viewController.myWxModel.refresh_token notEmpty] &&
                                      [APPDELEGATE.viewController.myWxModel.openid notEmpty]) {
                                      [self autoLogin:APPDELEGATE.viewController.myWxModel.access_token
                                           withUserId:APPDELEGATE.viewController.myWxModel.openid
                                     withRefreshToken:APPDELEGATE.viewController.myWxModel.refresh_token
                                             withFrom:@"weixin"];
                                  }
                              }
                          }
                    } failure:^(NSString *error) {
                        [SVProgressHUD dismissWithError:@"联网失败，请重试"];
                    }];
        
    }else if (errorcode == -2){
        //用户取消
        [SVProgressHUD showErrorWithStatus:@"用户取消微信登录"];
    }else if (errorcode == -4){
        //用户拒绝授权
        [SVProgressHUD showErrorWithStatus:@"用户拒绝微信登录"];
    }
}

// auto2d 授权登陆
-(void)autoLogin:(NSString*)token
      withUserId:(NSString*)uid
withRefreshToken:(NSString*)refreshtoken
        withFrom:(NSString*)from
{
    [TTReqEngine C_PostUser_ThirdloginSetSource_from:from
                                      withSource_uid:uid
                                    withAccess_token:token
                                   wtihRefresh_token:refreshtoken
                                       witHunique_id:nil
                                           withBlock:^(BOOL success, id dataModel) {
                                               M_UserInfoModel* tempModel = (M_UserInfoModel*)dataModel;
                                               if (success) {
                                                   if (tempModel!=nil) {
                                                       
                                                       APPDELEGATE.viewController.myUserModel = tempModel;
                                                       
//                                                       [DLAppData sharedInstance].myUserName = phone;
//                                                       [[DLUserDefaults sharedInstance] setObject:phone forKey:@"username"];
                                                       
                                                       [self dismissViewControllerAnimated:NO completion:nil];
                                                       [SVProgressHUD showSuccessWithStatus:@"登录成功!"];
                                                       APPDELEGATE.viewController.updateSpike = YES;
                                                       //设置别名推送
                                                       [JPUSHService setTags:[NSSet set] alias:tempModel.user_id fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                                                           NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags , iAlias);
                                                       }];
                                                       //后台模式下设置别名
                                                       [JPUSHService setTags:[NSSet set] aliasInbackground:tempModel.user_id];
                                                   }
                                               }
                                           }];
}

-(void)leftBtnPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)rightBtnPressed:(id)sender
{
    //快速注册
}


-(void)initTimer
{
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
    [self stop];
}

-(void)scrollTimer
{
    self.currIndex--;
    
    if (self.currIndex < 0) {
        self.currIndex = KMAX_TIMER;
        self.myGetCodeBtn.userInteractionEnabled = YES;
        [self.myGetCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        [self stop];
        return;
    }
    
    [self.myGetCodeBtn setTitle:[NSString stringWithFormat:@"已发送%ldS",(long)self.currIndex] forState:UIControlStateNormal];
    self.myGetCodeBtn.userInteractionEnabled = NO;
}

-(void)start
{
    //开启定时器
    [self.myTimer setFireDate:[NSDate distantPast]];
}
-(void)stop
{
    //关闭定时器
    [self.myTimer setFireDate:[NSDate distantFuture]];
}

-(void)afterInterval:(float)interval
{
    [self.myTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

-(void)getCodeFinish
{
    [self start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
