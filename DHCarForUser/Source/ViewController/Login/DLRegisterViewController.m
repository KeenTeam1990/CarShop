//
//  DLRegisterViewController.m
//  DHCarForUser
//
//  Created by 张海亮 on 16/3/23.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLRegisterViewController.h"
#import "TTReqEngine.h"
#define KMAX_TIMER 60

@interface DLRegisterViewController ()<UITextFieldDelegate>

AS_MODEL_STRONG(UIButton, myGetCodeBtn);
AS_MODEL_STRONG(UIButton, mySendBtn);
AS_MODEL_STRONG(NSTimer, myTimer);
AS_INT(currIndex);

@end

@implementation DLRegisterViewController

DEF_MODEL(myGetCodeBtn);
DEF_MODEL(mySendBtn);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    
    self.currIndex = KMAX_TIMER;
    
    [self initTimer];
    
    [self addTapToBaseView];
    
    [self addKeywordNotify];
    
    self.currIndex = KMAX_TIMER;
}

-(void)initView
{
    [self addCustomNavBar:@"注册"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    self.baseView.backgroundColor = [UIColor colorWithRed:0.93725 green:0.93725 blue:0.93725 alpha:1.0];
    
    [self initTableGroupView:CGRectMake(0, NavigationBarHeight, self.baseView.bounds.size.width, self.baseView.bounds.size.height) withSeparatoStyle:UITableViewCellSeparatorStyleSingleLine];
    self.myTableView.rowHeight = 50;
    //self.myTableView.scrollEnabled = NO;
    self.myTableView.backgroundColor = [UIColor colorWithRed:0.93725 green:0.93725 blue:0.93725 alpha:1.0];
    
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
    
    self.mySendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mySendBtn.style = DLButtonStyleMake(style.backgroundColor =[UIColor redColor];
                                             style.cornerRedius = 6;);
    [self.mySendBtn addTarget:self action:@selector(sendBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.mySendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.mySendBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.mySendBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    self.mySendBtn.frame = CGRectMake(10, NavigationBarHeight + 270, ScreenWidth-20, 45);
    //self.mySendBtn.layer.cornerRadius = 6.0;
    [self.baseView addSubview:self.mySendBtn];
    
}

-(void)sendBtnPressed:(UIButton *)sender
{
    NSString* tempPhone = nil;
    NSString* tempCode = nil;
    NSString* tempPwd = nil;
    NSString* tempPwd2 = nil;
    
    UITableViewCell* tempcell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (tempcell!=nil) {
        UITextField *cellTextField = (UITextField *)[tempcell viewWithTag:101];
        if (cellTextField!=nil) {
            tempPhone = cellTextField.text;
        }
    }
    
    tempcell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (tempcell!=nil) {
        UITextField *cellTextField = (UITextField *)[tempcell viewWithTag:101];
        if (cellTextField!=nil) {
            tempCode = cellTextField.text;
        }
    }
    tempcell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    if (tempcell!=nil) {
        UITextField *cellTextField = (UITextField *)[tempcell viewWithTag:101];
        if (cellTextField!=nil) {
            tempPwd = cellTextField.text;
        }
    }
    tempcell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    if (tempcell!=nil) {
        UITextField *cellTextField = (UITextField *)[tempcell viewWithTag:101];
        if (cellTextField!=nil) {
            tempPwd2 = cellTextField.text;
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
    
    if ([tempCode empty]) {
        [SVProgressHUD showErrorWithStatus:@"请输入短信验证码"];
        return;
    }
    
    if ([tempPwd empty]) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
//    if ([tempPwd isPassword]) {
//        [SVProgressHUD showErrorWithStatus:@"请输入6-18位密码"];
//        return;
//    }
    
    if (![tempPwd isEqualToString:tempPwd2]) {
        [SVProgressHUD showErrorWithStatus:@"两次密码输入不一致"];
        return;
    }
    
    [self reg:tempPhone withCode:tempCode withPwd:tempPwd];
}
-(void)reg:(NSString*)phone withCode:(NSString*)code withPwd:(NSString*)pwd
{
    [TTReqEngine C_PostUser_RegisterPhone:phone
                              andWithCode:code
                          andWithPassword:pwd
                                withBlock:^(BOOL success, id dataModel) {
                                    if (success) {
                                        M_UserInfoModel* tempModel = (M_UserInfoModel*)dataModel;
                                        if (tempModel!=nil) {
                                            
                                            APPDELEGATE.viewController.myUserModel = tempModel;
                                            
                                            [DLAppData sharedInstance].myUserName = phone;
                                            [[DLUserDefaults sharedInstance] setObject:phone forKey:@"username"];
                                            [[NSUserDefaults standardUserDefaults] synchronize];
                                            [self dismissViewControllerAnimated:NO completion:nil];
                                            [SVProgressHUD showSuccessWithStatus:@"注册成功!"];
                                        }
                                    }
                                }];
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
                             if (success) {
                                 [self getCodeFinish];
                                 [SVProgressHUD showSuccessWithStatus:@"验证码发送成功!"];
                             }
                         }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 15;
    }
    
    return 10;
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
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cellTextField.secureTextEntry = NO;
            cellTextField.keyboardType = UIKeyboardTypeNumberPad;
            cellTextField.placeholder = @"请输入手机号";
            cell.textLabel.text = @"手机号";
        } else {
            cellTextField.placeholder = @"请输入验证码";
            cell.textLabel.text = @"验证码";
            cellTextField.keyboardType = UIKeyboardTypeNumberPad;
            [cell addSubview:self.myGetCodeBtn];
        }

    } else {
        cellTextField.secureTextEntry = YES;
        if (indexPath.row == 0) {
            cellTextField.placeholder = @"请输入密码";
            cell.textLabel.text = @"密  码";
        } else {
            cellTextField.placeholder = @"请再次输入密码";
            cell.textLabel.text = @"确认密码";
        }

    }
    
    return cell;
}

-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
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
    
    [self.myGetCodeBtn setTitle:[NSString stringWithFormat:@"已发送%ld",(long)self.currIndex] forState:UIControlStateNormal];
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

@end
