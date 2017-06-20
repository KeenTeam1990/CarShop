
//
//  LL_ScanView.m
//  DHCarForUser
//
//  Created by leiyu on 16/4/1.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "LL_ScanView.h"
#import <QuartzCore/QuartzCore.h>
#define MyRimViewSizeWidth 250

#define MySmallViewSidth 20
@interface LL_ScanView()
@property(nonatomic,strong)UIView *rimView;
@end
@implementation LL_ScanView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.rimView = [[UIView alloc]initWithFrame:CGRectMake((frame.size.width-MyRimViewSizeWidth)/2, (frame.size.height -MyRimViewSizeWidth)/2, MyRimViewSizeWidth, MyRimViewSizeWidth)];
        [self addSubview:self.rimView];
        
        UIImageView *scanImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MyRimViewSizeWidth, 1)];
   
        [scanImageView setImage:[UIImage imageNamed:@"qrcode_scan_light_green"]];
        [self.rimView addSubview:scanImageView];
        [self scanAnimate:scanImageView];
        
        [self initViewAround];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.rimView.frame), frame.size.width, 20)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor whiteColor];
        lable.text = @"将二维码放入框内，即可自动扫描";
        lable.backgroundColor = [UIColor clearColor];
        lable.font = [UIFont systemFontOfSize:12];
        [self addSubview:lable];
        
        
    }
    return self;
}
-(void) drawRect:(CGRect)rect2
{
    [super drawRect:rect2];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = self.rimView.frame;
    
    
    
    CGContextSetRGBFillColor(context,   0.0, 0.0, 0.0, 0.5);
    CGContextSetRGBStrokeColor(context, 0.8, 0.8, 0.8, 0.5);
    
    
    CGFloat lengths[2];
    lengths[0] = 0.0;
    lengths[1] = 0.0;
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

/**
 *  初始化中间的四个边的图
 */
-(void)initViewAround
{
    for (int i=0; i<2; i++) {
        LL_UpAndDownView *upView = (LL_UpAndDownView *)[LL_UpAndDownView myAroundUpLinViewWidth:MyRimViewSizeWidth];
        LL_UpAndDownView *downView = (LL_UpAndDownView *)[LL_UpAndDownView myAroundRightLinViewWidth:MyRimViewSizeWidth];
        switch (i) {
            case 0:
            {
                upView.frame = CGRectMake(0, 0, MyRimViewSizeWidth, 1);
                downView.frame = CGRectMake(0, 0, 1, MyRimViewSizeWidth);
            }
                break;
            case 1:
            {
                upView.frame = CGRectMake(0, MyRimViewSizeWidth-1, MyRimViewSizeWidth, 1);
                downView.frame = CGRectMake(MyRimViewSizeWidth-1, 0, 1, MyRimViewSizeWidth);
            }
                break;

            default:
                break;
        }
        [self.rimView addSubview:upView];
        [self.rimView addSubview:downView];
    }
}
/**
 *  循环动画
 *
 *  @param view 扫描的动态imageView
 */
-(void)scanAnimate:(UIView *)view
{
    [UIView animateWithDuration:2 animations:^{
        CGRect tempFrame = view.frame;
        tempFrame.origin.y = self.rimView.frame.size.height;
        view.frame = tempFrame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            CGRect tempFrame  =view.frame;
            tempFrame.origin.y = 0;
            view.frame = tempFrame;
        } completion:^(BOOL finished) {
            [self scanAnimate:view];
        }];
    }];
}

@end

@implementation LL_UpAndDownView
+(UIView *)myAroundUpLinViewWidth:(CGFloat)width
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 1)];
    [view setBackgroundColor:[UIColor whiteColor]];
    UIView *greenViewLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MySmallViewSidth, 2)];
    [greenViewLeft setBackgroundColor:[UIColor greenColor]];
    [view addSubview:greenViewLeft];
    UIView *greenViewRight = [[UIView alloc]initWithFrame:CGRectMake(width-MySmallViewSidth, 0, MySmallViewSidth, 2)];
    [greenViewRight setBackgroundColor:[UIColor greenColor]];
    [view addSubview:greenViewRight];
    return view;
}
+(UIView *)myAroundRightLinViewWidth:(CGFloat)width
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, width)];
    [view setBackgroundColor:[UIColor whiteColor]];
    UIView *greenViewLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 2, MySmallViewSidth)];
    [greenViewLeft setBackgroundColor:[UIColor greenColor]];
    [view addSubview:greenViewLeft];
    UIView *greenViewRight = [[UIView alloc]initWithFrame:CGRectMake(0, width-MySmallViewSidth, 2,MySmallViewSidth)];
    [greenViewRight setBackgroundColor:[UIColor greenColor]];
    [view addSubview:greenViewRight];
    return view;
}

@end
