//
//  CB_Button.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "CB_Button.h"




/*有两个类A和B，关系：在导航里面先加载A后加载B在从A界面跳到B界面
需求：通过代理实现反向传值（将值从B类传到A类）
A类：被动类（实现需求的类）完成功能：遵守协议，实现协议的方法，将本类设置成代理类
B类：主动类（有需求的类）  完成功能：声明协议，生成代表任意类的属性（delegate），调用协议方法



通过block实现反向传值
主动类：LLbutton 完成功能：block变量的定义，block变量的调用；
被动类：LLApplist 代码块的生成，
*/
@interface CB_Button ()
@property(nonatomic,assign)id<CB_BaseButtonDelegate>delegate;

@end

@implementation CB_Button
-(id)init
{
    if (self=[super init]) {
        //会让代码的功能更加严谨，不容易出现问题
        if (_delegate!=nil) {//初始化时清空代理人，让其重新指向一个代理对象，
            _delegate=nil;
        }
    }
    return self;
}
+(CB_Button *)buttonWithFram:(CGRect )frame  title:(NSString *)title  action:(SEL )sel andtarget:(id)target
{
    CB_Button *button=[CB_Button buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"buttonbar_action"] forState:UIControlStateNormal];
    return button;
}


+(CB_Button *)buttonWithFram:(CGRect)frame title:(NSString *)title andDelegate:(id<CB_BaseButtonDelegate>)deleage
{
    CB_Button *button=[CB_Button buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:button action:@selector(myButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"buttonbar_action"] forState:UIControlStateNormal];
    //将delegate的值接过来
    button.delegate=deleage;
    return button;
    
}
+(CB_Button *)buttonWithFram:(CGRect)frame title:(NSString *)title andBlock:(buttonClickBlock)myBlock
{
    CB_Button *button=[CB_Button buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    button.layer.cornerRadius=10;
    button.clipsToBounds=YES;
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:button action:@selector(myButtonBlockClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"buttonbar_action"] forState:UIControlStateNormal];
    button.myBlock=myBlock;
    return button;
}
+(CB_Button *)buttonWithFram:(CGRect)frame images:(NSString *)imageName andBlock:(buttonClickBlock)myBlock
{
    CB_Button *button=[CB_Button buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    button.layer.cornerRadius=10;
    button.clipsToBounds=YES;
    [button setBackgroundColor:[UIColor whiteColor]];
    [button addTarget:button action:@selector(myButtonBlockClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.myBlock=myBlock;
    return button;
    
}
+(CB_Button *)buttonWithFram:(CGRect)frame backgroundImages:(NSString *)imageName title:(NSString *)titleText andBlock:(buttonClickBlock)myBlock
{
    CB_Button *button=[CB_Button buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    button.layer.cornerRadius=5;
    button.clipsToBounds=YES;
    UIEdgeInsets inset;
    inset.top=10;inset.bottom=10;inset.left=10;inset.right=10;
    [button setBackgroundImage:[[UIImage imageNamed:imageName] resizableImageWithCapInsets:inset]forState:UIControlStateNormal];
    [button addTarget:button action:@selector(myButtonBlockClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:titleText forState:UIControlStateNormal];
    button.myBlock=myBlock;
    return button;
    
}
-(void)myButtonBlockClick
{
    //调用block变量
    if (_myBlock!=nil) {
        _myBlock();
    }
}
-(void)myButtonClick
{
    //容错处理
    //respondsToSelector :判断前面的对象是否响应后面的方法
    //preformSelector:前面的对象执行后面的方法
    if ([_delegate respondsToSelector:@selector(presentViewController)]) {
        [_delegate performSelector:@selector(presentViewController)];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
