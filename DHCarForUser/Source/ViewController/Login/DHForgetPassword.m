//
//  DHForgetPassword.m
//  DHCarForUser
//
//  Created by 张海亮 on 16/3/23.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DHForgetPassword.h"
#import "TTReqEngine.h"
#import "DLSetPasswordViewController.h"
#define KMAX_TIMER 60

@interface DHForgetPassword ()<UITextFieldDelegate>
AS_MODEL_STRONG(UIButton, myGetCodeBtn);
AS_MODEL_STRONG(UIButton, mySendBtn);
AS_MODEL_STRONG(NSTimer, myTimer);
AS_INT(currIndex);

@end

@implementation DHForgetPassword

DEF_MODEL(myGetCodeBtn);
DEF_MODEL(mySendBtn);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    
    [self addTapToBaseView];
    
    [self addKeywordNotify];
    
    [self initTimer];
    
    self.currIndex = KMAX_TIMER;

}

-(void)initView
{
    [self addCustomNavBar:@"忘记密码"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    self.baseView.backgroundColor = [UIColor colorWithRed:0.93725 green:0.93725 blue:0.93725 alpha:1.0];

    [self initTablePlainView:CGRectMake(0, NavigationBarHeight+30, self.baseView.bounds.size.width, self.baseView.bounds.size.height-30) withSeparatoStyle:UITableViewCellSeparatorStyleSingleLine];
    self.myTableView.rowHeight = 50;
    self.myTableView.scrollEnabled = NO;
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
    [self.mySendBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.mySendBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    self.mySendBtn.frame = CGRectMake(10, NavigationBarHeight + 160, ScreenWidth-20, 45);
    //self.mySendBtn.layer.cornerRadius = 6.0;
    [self.baseView addSubview:self.mySendBtn];

}

-(void)sendBtnPressed:(UIButton *)sender
{
    NSString* tempPhone = nil;
    NSString* tempCode = nil;
    
    UITableViewCell* tempcell0 = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (tempcell0!=nil) {
        UITextField *cellTextField = (UITextField *)[tempcell0 viewWithTag:101];
        if (cellTextField!=nil) {
            tempPhone = cellTextField.text;
        }
    }
    
    UITableViewCell* tempcell1 = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (tempcell1!=nil) {
        UITextField *cellTextField = (UITextField *)[tempcell1 viewWithTag:101];
        if (cellTextField!=nil) {
            tempCode = cellTextField.text;
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
    [self login:tempPhone withCode:tempCode];
}
-(void)login:(NSString*)phone withCode:(NSString*)code
{
    [TTReqEngine C_PostUser_LoginPhone:phone withCode:code withBlock:^(BOOL success, id dataModel) {
        M_UserInfoModel* tempModel = (M_UserInfoModel*)dataModel;
        if (success) {
            if (tempModel!=nil) {
                
                APPDELEGATE.viewController.myUserModel = tempModel;
                [DLAppData sharedInstance].myUserName = phone;
                [[DLUserDefaults sharedInstance] setObject:phone forKey:@"username"];
                APPDELEGATE.viewController.myUserModel.myHas_Set_Password = @"0";
                [self.navigationController pushViewController:[[DLSetPasswordViewController alloc] init] animated:YES];
                //[self dismissViewControllerAnimated:NO completion:nil];
                //[SVProgressHUD showSuccessWithStatus:@"登录成功!"];
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
    NSLog(@"获取验证码");
    [TTReqEngine C_GetCodeSetPhone:tempPhone
                          withType:@"ordinary"
                         withBlock:^(BOOL success, id dataModel) {
                             if (success) {
                                 [self getCodeFinish];
                                 [SVProgressHUD showSuccessWithStatus:@"验证码发送成功!"];
                             }
                         }];
    
    [APPDELEGATE.window endEditing:YES];
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
        [cell addSubview:contentText];
    }
    
    UITextField *cellTextField = (UITextField *)[cell viewWithTag:101];
    if (indexPath.row == 0) {
        cellTextField.placeholder = @"请输入手机号";
        cell.textLabel.text = @"手机号";
    } else {
        cellTextField.placeholder = @"请输入验证码";
        cell.textLabel.text = @"验证码";
        [cell addSubview:self.myGetCodeBtn];
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
-(void)getCodeFinish
{
    [self start];
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

@end
