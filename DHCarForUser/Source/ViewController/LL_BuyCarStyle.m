
//
//  LL_BuyCarStyle.m
//  DHCarForUser
//
//  Created by leiyu on 16/4/1.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "LL_BuyCarStyle.h"
@interface LL_BuyCarStyle()
AS_MODEL_STRONG(UIView, myView);
@end
@implementation LL_BuyCarStyle
DEF_MODEL(myView);
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.myView = [[UIView alloc]init];
    }
    return self;
}
-(void)upDataWithType:(NSString *)type
{
    self.myView = [[UIView alloc]init];
    [self.myView addSubview:self.myView];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 50)];
    lable.text = @"请选择购车方式";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor redColor];
    lable.font = [UIFont systemFontOfSize:14];
    [self.myView addSubview:lable];
    
    switch ([type integerValue]) {
        case 3:
        {
            self.myView.frame = CGRectMake((self.frame.size.width-160)/2, (self.frame.size.height-60-50*2)/2, 160, 60+50*2);
            for (int i=0; i<2; i++) {
                LL_ButtonView *tempView = [[LL_ButtonView alloc]initWithFrame:CGRectMake(0, 50+i*50, self.frame.size.width, 50)];
                if (i ==0) {
                    
                    [tempView upButtonTitle:@"优选"];
                }
                if (i==2) {
                    [tempView upButtonTitle:@"优选"];
                }
                tempView.myAction = ^(NSInteger tag){
                    NSLog(@"点击选中不同button的响应事件");
                };
                [self.myView addSubview:tempView];
            }
        }
            break;
        case 5:
        {
             self.myView.frame = CGRectMake((self.frame.size.width-160)/2, (self.frame.size.height-60-50*2)/2, 160, 60+50*2);
            //1+4
            for (int i=0; i<2; i++) {
                LL_ButtonView *tempView = [[LL_ButtonView alloc]initWithFrame:CGRectMake(0, 50+i*50, self.frame.size.width, 50)];
                if (i ==0) {
                    
                    [tempView upButtonTitle:@"优选"];
                }
                if (i==2) {
                    [tempView upButtonTitle:@"租购"];
                }
                tempView.myAction = ^(NSInteger tag){
                    NSLog(@"点击选中不同button的响应事件");
                };
                [self.myView addSubview:tempView];
            }
        }
            break;
        case 6:
        {
             self.myView.frame = CGRectMake((self.frame.size.width-160)/2, (self.frame.size.height-60-50*2)/2, 160, 60+50*2);
            //2+4
            for (int i=0; i<2; i++) {
                LL_ButtonView *tempView = [[LL_ButtonView alloc]initWithFrame:CGRectMake(0, 50+i*50, self.frame.size.width, 50)];
                if (i ==0) {
                    
                    [tempView upButtonTitle:@"优选"];
                }
                if (i==2) {
                    [tempView upButtonTitle:@"租购"];
                }
                tempView.myAction = ^(NSInteger tag){
                    NSLog(@"点击选中不同button的响应事件");
                };
                [self.myView addSubview:tempView];
            }

        }
            break;
        case 7:
        {
             self.myView.frame = CGRectMake((self.frame.size.width-160)/2, (self.frame.size.height-60-50*3)/2, 160, 60+50*3);
            //2+4+1
            for (int i=0; i<3; i++) {
                LL_ButtonView *tempView = [[LL_ButtonView alloc]initWithFrame:CGRectMake(0, 50+i*50, self.frame.size.width, 50)];
                if (i ==0) {
                    
                    [tempView upButtonTitle:@"优选"];
                }
                if (i==2) {
                    [tempView upButtonTitle:@"优选"];
                }
                if (i==3) {
                    [tempView upButtonTitle:@"租购"];
                }
                tempView.myAction = ^(NSInteger tag){
                    NSLog(@"点击选中不同button的响应事件");
                };
                [self.myView addSubview:tempView];
            }
        }
            break;
        default:
            break;
    }
    
}
-(void)updataWithArr:(NSArray *)arr
{
    self.myView = [[UIView alloc]initWithFrame:CGRectMake((self.frame.size.width-160)/2, (self.frame.size.height -60-arr.count*50)/2, 160, 60+arr.count*50)];
    [self.myView addSubview:self.myView];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 50)];
    lable.text = @"请选择购车方式";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor redColor];
    lable.font = [UIFont systemFontOfSize:14];
    [self.myView addSubview:lable];
    
    for (int i=0; i<arr.count; i++) {
        LL_ButtonView *tempView = [[LL_ButtonView alloc]initWithFrame:CGRectMake(0, 50+i*50, self.frame.size.width, 50)];
        tempView.myAction = ^(NSInteger tag){
            NSLog(@"点击选中不同button的响应事件");
        };
        [self.myView addSubview:tempView];
    }
}
-(void)drawRect:(CGRect)rect1
{
    [super drawRect:rect1];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = self.myView.frame;
    
    CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 0.5);
    CGContextSetRGBStrokeColor(context, 0.8, 0.8, 0.8, 0.8);
    
    CGFloat lengths[2];
    lengths[0] = 0.0;
    lengths[1]= 0.0;
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 3.0);
    CGContextSetLineDash(context, 0.0f, lengths, 2);
    float w = self.bounds.size.width;
    float h = self.bounds.size.height;
    
    CGRect clips2[] =
    {
        CGRectMake(0, 0, w, rect.origin.y),
        CGRectMake(0, rect.origin.y,rect.origin.x, rect.size.height),
        CGRectMake(0, rect.origin.y + rect.size.height, w, h-(rect.origin.y+rect.size.height)),
        CGRectMake(rect.origin.x + rect.size.width, rect.origin.y, w-(rect.origin.x + rect.size.width), rect.size.height),
    };
    CGContextClipToRects(context, clips2, sizeof(clips2) / sizeof(clips2[0]));
    
    CGContextFillRect(context, self.bounds);
    CGContextStrokeRect(context, rect);
    UIGraphicsEndImageContext();
}
@end



@interface LL_ButtonView ()
AS_MODEL_STRONG(UIButton, myButton)
@end
@implementation LL_ButtonView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}
-(void)initView
{
    self.myButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, self.frame.size.width-20, self.frame.size.height-10)];
    [self addSubview:self.myButton];
    self.myButton.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor];style.cornerRedius = 5;style.borderWidth =1;style.borderColor = [UIColor grayColor];)
    [self.myButton addTarget:self action:@selector(myButtonClockAction:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.myButton];
}
-(void)upButtonTitle:(NSString *)title
{
    [self.myButton setTitle:title forState:UIControlStateNormal];
    [self.myButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
-(void)myButtonClockAction:(UIButton *)button
{
    if (self.myAction != nil) {
        self.myAction(button.tag);
    }
}
@end