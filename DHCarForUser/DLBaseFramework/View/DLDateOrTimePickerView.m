//
//  DLDateOrTimePickerView.m
//  jintaitravel
//
//  Created by 卢迎志 on 15-4-21.
//  Copyright (c) 2015年 卢迎志. All rights reserved.
//

#import "DLDateOrTimePickerView.h"
#define KPickerViewHeight 260

@implementation DLDateOrTimePickerView

DEF_FACTORY_FRAME(DLDateOrTimePickerView);

DEF_MODEL(myCancelBtn);
DEF_MODEL(myPickerView);
DEF_MODEL(mySureBtn);
DEF_MODEL(myTitleBackView);
DEF_MODEL(myTitleLabel);
DEF_MODEL(myView);

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect tempRect = CGRectMake(0, frame.size.height - KPickerViewHeight, frame.size.width, KPickerViewHeight);
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        UIView* tempView = [[UIView alloc]initWithFrame:tempRect];
        [tempView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:tempView];
        
        self.myView = tempView;
        
        self.myTitleBackView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tempRect.size.width, 44)];
        [self.myTitleBackView setBackgroundColor:RGBCOLOR(211, 211, 211)];
        [tempView addSubview:self.myTitleBackView];
        
        self.myCancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.myCancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.myCancelBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.myCancelBtn setTitleColor:[Unity getNavBarBackColor] forState:UIControlStateNormal];
        [self.myCancelBtn addTarget:self action:@selector(cancelBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.myCancelBtn.frame = CGRectMake(0, 0, 60, 44);
        [tempView addSubview:self.myCancelBtn];
        
        self.mySureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.mySureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self.mySureBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.mySureBtn setTitleColor:[Unity getNavBarBackColor] forState:UIControlStateNormal];
        [self.mySureBtn addTarget:self action:@selector(sureBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.mySureBtn.frame = CGRectMake(tempRect.size.width-60, 0, 60, 44);
        [tempView addSubview:self.mySureBtn];
        
        self.myTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, tempRect.size.width-120, 44)];
        [self.myTitleLabel setBackgroundColor:[UIColor clearColor]];
        [self.myTitleLabel setFont:[UIFont systemFontOfSize:16]];
        [self.myTitleLabel setTextColor:[UIColor blackColor]];
        [self.myTitleLabel setTextAlignment:UITextAlignmentCenter];
        [tempView addSubview:self.myTitleLabel];
        
        self.myPickerView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 44, tempRect.size.width, tempRect.size.height-44)];
        // 设置时区
        //[datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];

        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中
        self.myPickerView.locale = locale;
        // 设置显示最大时间（此处为当前时间）
//        [self.myPickerView setMaximumDate:[NSDate date]];
        // 设置UIDatePicker的显示模式
        [self.myPickerView setDatePickerMode:UIDatePickerModeDate];
        [tempView addSubview:self.myPickerView];
    }
    return self;
}

-(void)updateViewData:(NSString*)title withData:(NSDate*)date withMode:(BOOL)showDate
{
    self.currDate = date;
    
    self.myTitleLabel.text= title;
    
    self.showIsDate = showDate;
    
    if (showDate) {
        // 设置UIDatePicker的显示模式
        [self.myPickerView setDatePickerMode:UIDatePickerModeDate];
    }else{
        // 设置UIDatePicker的显示模式
        [self.myPickerView setDatePickerMode:UIDatePickerModeDateAndTime];
    }
    
    [self.myPickerView setDate:self.currDate animated:YES];
}

-(void)setMaxTime:(NSDate*)maxDate withMinTime:(NSDate*)minDate
{
    // 设置显示最大时间
    if (maxDate!=nil) {
        [self.myPickerView setMaximumDate:maxDate];
    }
     // 设置显示最小时间
    if (minDate!=nil) {
        [self.myPickerView setMinimumDate:minDate];
    }
}

-(void)sureBtnPressed:(id)sender
{
    NSString* tempstr = @"";
    
    if (self.showIsDate) {
        tempstr = [self.myPickerView.date dateToString];
    }else{
        tempstr = [self.myPickerView.date timeToString];
    }
    
    if (tempstr.length > 0) {
        if (self.block!=nil) {
            self.block(1,tempstr);
        }
    }
    
    [self cancelBtnPressed:nil];
}
-(void)cancelBtnPressed:(id)sender
{
    [self stopAnimation];
    if (self.block!=nil) {
        self.block(0,nil);
    }
}

-(void)startAnimation
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect tempRect = self.myView.frame;
        tempRect.origin.y = self.frame.size.height-KPickerViewHeight;
        self.myView.frame = tempRect;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)stopAnimation
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect tempRect = self.myView.frame;
        tempRect.origin.y = self.frame.size.height;
        self.myView.frame = tempRect;
    } completion:^(BOOL finished) {
        
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
