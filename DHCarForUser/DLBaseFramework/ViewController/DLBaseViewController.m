
//
//  DLBaseViewController.m
//  TickTock
//
//  Created by 卢迎志 on 14-11-26.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import "DLBaseViewController.h"

@implementation DLBaseViewController

DEF_MODEL(baseView);
DEF_MODEL(stateView);
DEF_MODEL(customNavBar);
DEF_MODEL(needHideTabBar);

-(void)dealloc
{
    [self removeAllNotify];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[Unity getBackColor]];
    
    self.needHideTabBar = YES;
    
    self.baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.baseView];
    [self.view sendSubviewToBack:self.baseView];
    
    if (DeviceVersion >= 7.0f) {
        
        UIView* tempstartview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
        //[tempstartview setBackgroundColor:[Unity getNavBarBackColor]];
        [tempstartview setBackgroundColor:[Unity getBackColor]];
        self.stateView = tempstartview;
        [self.view addSubview:tempstartview];
        
        self.baseView.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20);
    }else{
        self.baseView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    if (APPDELEGATE.viewController != nil && self.needHideTabBar) {
//        if (APPDELEGATE.viewController.homeController!=nil) {
//            [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
//        }
//    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)addTapToBaseView
{
    self.baseView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tempsingleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(baseViewSingleTap:)];
    tempsingleTap.numberOfTapsRequired=1;
    [self.baseView addGestureRecognizer:tempsingleTap];
}

-(void)baseViewSingleTap:(UITapGestureRecognizer*)gesture
{
    [self baseSingleTap];
}

-(void)baseSingleTap
{
    [APPDELEGATE.window endEditing:YES];
}

-(void)addCustomNavBar:(NSString*)title
           withLeftBtn:(NSString*)leftImage
          withRightBtn:(NSString*)rightImage
         withLeftLabel:(NSString*)leftLabel
        withRightLabel:(NSString*)rightLabel
{
    self.customNavBar = [[DLCustomNavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.baseView.frame.size.width, NavigationBarHeight)
                                                        withBgImage:nil
                                                          withTitle:title
                                                        withLeftBtn:leftImage
                                                       withRightBtn:rightImage
                                                      withLeftLabel:leftLabel
                                                     withRightLabel:rightLabel];
    self.customNavBar.delegate = self;
    [self.baseView addSubview:self.customNavBar];
}

#pragma DLCustomNavigationBarDelegate

-(void)leftBtnPressed:(id)sender
{
}
-(void)rightBtnPressed:(id)sender
{
    
}

#pragma  keyword

-(void)addKeywordNotify
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)removeAllNotify
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)notifyshowKeyword:(CGRect)keyRect
{
    
}
-(void)notifyhideKeyword
{
    
}

#pragma mark -
#pragma mark Responding to keyboard events
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    keyboardBounds = [self.baseView convertRect:keyboardBounds toView:nil];
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
	
    [self notifyshowKeyword:keyboardBounds];
    
	[UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
	// animations settings
  
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];

    int top = 0;
    if (DeviceVersion>=7.0) {
        top = 20;
    }
    self.baseView.frame = CGRectMake(0, top, self.baseView.frame.size.width, self.baseView.frame.size.height);
    
    [self notifyhideKeyword];
    
    //    self.myTouchBtn.top = self.animationHeight;
    [UIView commitAnimations];
}

-(UITextField*)getTextFiled:(CGRect)frame
{
    UIImage* tempBg = [UIImage imageNamed:@"fieldbg.png"];
    
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
    tempField.background = [tempBg stretchableImageWithLeftCapWidth:tempBg.size.width/2 topCapHeight:tempBg.size.height/2];
    
    //    [self addSubview:tempField];
    
    return tempField;
}


@end
