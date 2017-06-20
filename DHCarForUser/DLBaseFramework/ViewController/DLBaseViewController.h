//
//  DLBaseViewController.h
//  TickTock
//
//  Created by 卢迎志 on 14-11-26.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLCustomNavigationBar.h"

@interface DLBaseViewController : UIViewController<DLCustomNavigationBarDelegate,UITextFieldDelegate>

AS_MODEL_STRONG(UIView,baseView);
AS_MODEL_STRONG(UIView,stateView);
AS_MODEL_STRONG(DLCustomNavigationBar,customNavBar);

AS_BOOL(needHideTabBar);

-(void)addCustomNavBar:(NSString*)title
           withLeftBtn:(NSString*)leftImage
          withRightBtn:(NSString*)rightImage
         withLeftLabel:(NSString*)leftLabel
        withRightLabel:(NSString*)rightLabel;

-(void)addTapToBaseView;
-(void)baseSingleTap;

-(void)addKeywordNotify;
-(void)removeAllNotify;

-(void)notifyshowKeyword:(CGRect)keyRect;
-(void)notifyhideKeyword;

-(UITextField*)getTextFiled:(CGRect)frame;


@end
