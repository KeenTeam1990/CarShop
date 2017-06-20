//
//  DLPageErrorView.m
//  DHCarForUser
//
//  Created by lucaslu on 16/1/2.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLPageErrorView.h"

@interface DLPageErrorView ()

AS_MODEL_STRONG(UIImageView, myIconView);
AS_MODEL_STRONG(UIButton, myResetBtn);

@end

@implementation DLPageErrorView

DEF_FACTORY_FRAME(DLPageErrorView);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIView* tempView = [[UIView alloc]initWithFrame:CGRectMake(10, (self.frame.size.height-300)/2, 300, 300)];
        tempView.tag = 1001;
        [self addSubview:tempView];
        
        self.myIconView = [[UIImageView alloc]initWithFrame:CGRectMake((tempView.frame.size.width-(tempView.frame.size.width-50))/2, 0, tempView.frame.size.width-50, tempView.frame.size.height-50)];
        [tempView addSubview:self.myIconView];
        
        self.myTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.myIconView.frame), CGRectGetMaxY(self.myIconView.frame), tempView.frame.size.width-50, 25)];
        self.myTitleLable.font = [UIFont systemFontOfSize:12];
        self.myTitleLable.textColor = [UIColor grayColor];
        self.myTitleLable.textAlignment = NSTextAlignmentCenter;
        [tempView addSubview:self.myTitleLable];
        self.myTitleLable.hidden = YES;
        
        self.myMessLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 350, self.frame.size.width, 20)];
        self.myMessLable.font = [UIFont systemFontOfSize:13];
        self.myMessLable.textColor = [UIColor grayColor];
        self.myMessLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.myMessLable];
        self.myMessLable.hidden = YES;
        self.myMessLable.text = @"很抱歉,网络请求可能遭受攻击";
        
        
        self.myResetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.myResetBtn.frame = CGRectMake(0, CGRectGetMaxY(self.myMessLable.frame), self.frame.size.width, 40);
        [self.myResetBtn.layer setMasksToBounds:YES];
        self.myResetBtn.backgroundColor = [UIColor whiteColor];
        [self.myResetBtn addTarget:self action:@selector(resetBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.myResetBtn setTitle:@"请刷新或者重试" forState:UIControlStateNormal];

        [self.myResetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.myResetBtn.hidden = YES;
        [self addSubview:self.myResetBtn];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resetBtnPressed:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    UIView* tempView = [self viewWithTag:1001];
    
    CGRect tempFrame = tempView.frame;
    tempFrame.origin.x = (self.frame.size.width - tempFrame.size.width)/2;
    tempFrame.origin.y = (self.frame.size.height-tempFrame.size.height)/2;
    tempView.frame = tempFrame;
    
    tempFrame = self.myTitleLable.frame;
    tempFrame.size.width = tempView.frame.size.width-50;
    tempFrame.origin.y = CGRectGetMaxY(self.myIconView.frame);
    self.myTitleLable.frame = tempFrame;
    
    tempFrame = self.myMessLable.frame;
    tempFrame.size.width = self.frame.size.width;
    tempFrame.origin.y = CGRectGetMaxY(tempView.frame)+10;
    self.myMessLable.frame = tempFrame;
    
    tempFrame = self.myResetBtn.frame;
    tempFrame.size.width = self.frame.size.width;
    tempFrame .origin.y = CGRectGetMaxY(self.myMessLable.frame);
    self.myResetBtn.frame = tempFrame;
    
    
}

-(void)resetBtnPressed:(id)sender
{
    if (self.block!=nil) {
        self.block(0);
    }
}

-(void)setMyIcon:(UIImage *)icon
{
    _myIcon = icon;
    self.myIconView.image = icon;
}
-(void)setIsError:(BOOL)isError
{
    if (isError) {
        self.myTitleLable.text = @"您的访问出错了";
        self.myTitleLable.hidden = NO;
        self.myMessLable.hidden = NO;
        self.myResetBtn.hidden = NO;
    }
    else
    {
        self.myTitleLable.text = @"暂无数据";
        self.myTitleLable.hidden = NO;
        self.myMessLable.hidden = YES;
        self.myResetBtn.hidden = YES;
        
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
