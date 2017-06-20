//
//  CB_Button.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CB_BaseButtonDelegate <NSObject>

-(void)presentViewController;
//通过点击实现界面的跳转
@end

typedef void(^buttonClickBlock)();

@interface CB_Button : UIButton

@property(nonatomic,copy)buttonClickBlock myBlock;

//通过类方法得到一个按钮
+(CB_Button *)buttonWithFram:(CGRect )frame  title:(NSString *)title  action:(SEL )sel andtarget:(id)target;
//实现代理使用的方法
+(CB_Button *)buttonWithFram:(CGRect)frame title:(NSString *)title andDelegate:(id<CB_BaseButtonDelegate>)deleage;
//实现Block方法
+(CB_Button *)buttonWithFram:(CGRect)frame title:(NSString *)title andBlock:(buttonClickBlock)myBlock;
+(CB_Button *)buttonWithFram:(CGRect)frame images:(NSString *)imageName andBlock:(buttonClickBlock)myBlock;
+(CB_Button *)buttonWithFram:(CGRect)frame backgroundImages:(NSString *)imageName title:(NSString *)titleText andBlock:(buttonClickBlock)myBlock;

@end
