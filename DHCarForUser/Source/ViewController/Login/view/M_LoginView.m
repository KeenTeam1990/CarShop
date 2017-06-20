//
//  M_LoginView.m
//  DHCarForSales
//
//  Created by lucaslu on 15/10/31.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_LoginView.h"
#import "Unity.h"
#import "M_IconView.h"

#define KMAX_TIMER 60

@interface M_LoginView ()

AS_MODEL_STRONG(UITextField, myPhoneField);
AS_MODEL_STRONG(UITextField, myCodeField);
AS_MODEL_STRONG(UIButton, myGetCodeBtn);
AS_MODEL_STRONG(UIButton, myLoginBtn);

AS_MODEL_STRONG(NSTimer, myTimer);
AS_INT(currIndex);

AS_MODEL_STRONG(UILabel, myPhoneLabel);
AS_MODEL_STRONG(UILabel, myCodeLabel);

AS_MODEL_STRONG(UIView, myPhoneView);
AS_MODEL_STRONG(UIView, myCodeView);

AS_MODEL_STRONG(UIImageView, myLineView);

AS_MODEL_STRONG(M_IconView, myWxIconView);
AS_MODEL_STRONG(M_IconView, myWbIconView);

@end

@implementation M_LoginView

DEF_FACTORY_FRAME(M_LoginView);
DEF_MODEL(block);

DEF_MODEL(myCodeField);
DEF_MODEL(myGetCodeBtn);
DEF_MODEL(myLoginBtn);
DEF_MODEL(myPhoneField);
DEF_MODEL(myTimer);
DEF_MODEL(currIndex);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.currIndex = KMAX_TIMER;
        
        [self initPhoneView:CGRectMake(0, 20, frame.size.width, 44)];
        
        [self initCodeView:CGRectMake(0, 64, frame.size.width, 44)];
        
        [self initLoginBtn:CGRectMake(0, 128, frame.size.width, 40)];
        
        //[self initThreeLoginView:(CGRectMake(0, 228, frame.size.width, 100))];
        
        [self initTimer];
        
        self.myPhoneField.text = @"18311242595";
        self.myCodeField.text = @"1234";
    }
    return self;
}

-(void)setIsLogin:(BOOL)login
{
    _isLogin = login;
    
    if (login) {
        [self initThreeLoginView:(CGRectMake(0, 228, self.frame.size.width, 100))];
    }
}

-(UITextField*)getTextFiled:(CGRect)frame
{
    UITextField* tempField = [[UITextField alloc]initWithFrame:frame];
    [tempField setFont:[UIFont systemFontOfSize:14]];
    [tempField setTextColor:[UIColor blackColor]];
    tempField.delegate = self;
    [tempField setBorderStyle:UITextBorderStyleNone]; //外框类型
    tempField.placeholder = @"请输入手机号"; //默认显示的字
    tempField.autocorrectionType = UITextAutocorrectionTypeNo;
    tempField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tempField.returnKeyType = UIReturnKeyDone;
    tempField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    tempField.enablesReturnKeyAutomatically = YES;
    tempField.keyboardType = UIKeyboardTypeNumberPad;
    tempField.backgroundColor = [UIColor clearColor];
    
    return tempField;
}

-(void)initPhoneView:(CGRect)frame
{
    self.myPhoneView = [[UIView alloc]initWithFrame:frame];
    [self.myPhoneView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.myPhoneView];
    
    self.myPhoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, frame.size.height)];
    [self.myPhoneLabel setBackgroundColor:[UIColor clearColor]];
    self.myPhoneLabel.text = @"手机号";
    self.myPhoneLabel.font = [UIFont systemFontOfSize:14];
    self.myPhoneLabel.textColor = [UIColor blackColor];
    self.myPhoneLabel.textAlignment = UITextAlignmentCenter;
    [self.myPhoneView addSubview:self.myPhoneLabel];
    
    self.myPhoneField = [self getTextFiled:CGRectMake(100, 0, frame.size.width-110, frame.size.height)];
    self.myPhoneField.placeholder = @"请输入手机号"; //默认显示的字
    self.myPhoneField.returnKeyType = UIReturnKeyNext;
    self.myPhoneField.tag = 1001;
    [self.myPhoneView addSubview:self.myPhoneField];
    
    self.myLineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
    [self.myLineView setBackgroundColor:RGBCOLOR(202, 202, 202)];
    [self.myPhoneView addSubview:self.myLineView];
}

-(void)initCodeView:(CGRect)frame
{
    self.myCodeView = [[UIView alloc]initWithFrame:frame];
    [self.myCodeView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.myCodeView];
    
    self.myCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, frame.size.height)];
    [self.myCodeLabel setBackgroundColor:[UIColor clearColor]];
    self.myCodeLabel.text = @"验证码";
    self.myCodeLabel.font = [UIFont systemFontOfSize:14];
    self.myCodeLabel.textColor = [UIColor blackColor];
    self.myCodeLabel.textAlignment = UITextAlignmentCenter;
    [self.myCodeView addSubview:self.myCodeLabel];
    
    self.myCodeField = [self getTextFiled:CGRectMake(100, 0, frame.size.width-210, frame.size.height)];
    self.myCodeField.placeholder = @"请输入验证码"; //默认显示的字
    self.myCodeField.tag = 1002;
    [self.myCodeView addSubview:self.myCodeField];
    
    self.myGetCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myGetCodeBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor];
                                                style.borderWidth = 1;
                                                style.cornerRedius = 2;
                                                style.borderColor = [UIColor redColor];);
    
    [self.myGetCodeBtn addTarget:self action:@selector(getCodeBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.myGetCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [self.myGetCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.myGetCodeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.myGetCodeBtn.frame = CGRectMake(frame.size.width-110, (frame.size.height-30)/2, 100, 30);
    
    [self.myCodeView addSubview:self.myGetCodeBtn];
}

-(void)initLoginBtn:(CGRect)frame
{
    self.myLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myLoginBtn.style = DLButtonStyleMake(style.backgroundColor =[UIColor redColor];
                                              style.cornerRedius = 2;);
    [self.myLoginBtn addTarget:self action:@selector(loginBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.myLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.myLoginBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.myLoginBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    self.myLoginBtn.frame = CGRectMake(10, frame.origin.y, frame.size.width-20, frame.size.height);
    
    [self addSubview:self.myLoginBtn];
}

-(void)initThreeLoginView:(CGRect)frame
{
    UILabel* tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.origin.y, frame.size.width, 30)];
    tempLabel.textAlignment = UITextAlignmentCenter;
    tempLabel.font = SYSTEMFONT(14);
    tempLabel.textColor = RGBCOLOR(201, 202, 202);
    tempLabel.text = @"其它方式登录";
    [self addSubview:tempLabel];
    
    self.myWxIconView = [M_IconView allocInstanceFrame:CGRectMake(frame.size.width/2-80, frame.origin.y+60, 80, 80)];
    [self.myWxIconView updateModel:@"share_weixin.png" withText:@"微信登录"];
    [self addSubview:self.myWxIconView];
    
    self.myWbIconView = [M_IconView allocInstanceFrame:CGRectMake(frame.size.width/2+10, frame.origin.y+60, 80, 80)];
    [self.myWbIconView updateModel:@"share_weibo.png" withText:@"微博登录"];
    [self addSubview:self.myWbIconView];
    
    __weak M_LoginView* tempSelf = self;
    self.myWxIconView.block = ^(NSInteger tag){
        if (tempSelf.block!=nil) {
            tempSelf.block(2,nil,nil);
        }
    };
    
    self.myWbIconView.block = ^(NSInteger tag){
        if (tempSelf.block!=nil) {
            tempSelf.block(3,nil,nil);
        }
    };
}

-(void)getCodeBtnPressed:(id)sender
{
    NSString* tempPhone = self.myPhoneField.text;
    
    if ([tempPhone empty]) {
        [SVProgressHUD showErrorWithStatus:@"请输入11位的手机号码"];
        return;
    }
    
    if (![Unity isTelephone:tempPhone]) {
        [SVProgressHUD showErrorWithStatus:@"请输入11位的手机号码"];
        return;
    }
    
    if (self.block!=nil) {
        self.block(0,tempPhone,nil);
    }
}

-(void)loginBtnPressed:(id)sender
{
    NSString* tempPhone = self.myPhoneField.text;
    NSString* tempCode = self.myCodeField.text;
    
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
    
    if (self.block!=nil) {
        self.block(1,tempPhone,tempCode);
    }   
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.currFieldRect = textField.frame;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.currFieldRect = CGRectZero;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 1001) {
        [self.myCodeField becomeFirstResponder];
    }else if (textField.tag == 1002){
        [self loginBtnPressed:nil];
    }
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
