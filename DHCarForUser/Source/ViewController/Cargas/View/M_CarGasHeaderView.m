//
//  M_CarGasHeaderView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarGasHeaderView.h"

@interface M_CarGasHeaderView ()

AS_MODEL_STRONG(UILabel, myNumLabel);
AS_MODEL_STRONG(UIButton, myGasBtn);

@end

@implementation M_CarGasHeaderView

DEF_FACTORY_FRAME(M_CarGasHeaderView);

DEF_MODEL(myGasBtn);
DEF_MODEL(myNumLabel);
DEF_MODEL(block);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        
        self.myNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, frame.size.width-40, 30)];
        [self.myNumLabel setBackgroundColor:[UIColor clearColor]];
        [self.myNumLabel setTextColor:RGBCOLOR(102, 102, 102)];
        [self.myNumLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:self.myNumLabel];
        
        UIImageView* tempLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 90, frame.size.width, 1)];
        tempLine.backgroundColor = RGBCOLOR(157, 157, 158);
        [self addSubview:tempLine];
        
        UIImage* tempBtnBg = [UIImage imageNamed:@"登录.png"];
        UIImage* tempBtn_HBg = [UIImage imageNamed:@"登录按下.png"];
        
        self.myGasBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.myGasBtn addTarget:self action:@selector(gasBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.myGasBtn setBackgroundImage:[tempBtnBg stretchableImageWithLeftCapWidth:tempBtnBg.size.width/2 topCapHeight:tempBtnBg.size.height/2] forState:UIControlStateNormal];
        [self.myGasBtn setBackgroundImage:[tempBtn_HBg stretchableImageWithLeftCapWidth:tempBtn_HBg.size.width/2 topCapHeight:tempBtn_HBg.size.height/2] forState:UIControlStateHighlighted];
        [self.myGasBtn setTitle:@"加油卡充值" forState:UIControlStateNormal];
        [self.myGasBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        self.myGasBtn.frame = CGRectMake(20, 100, frame.size.width-40, 40);

        [self addSubview:self.myGasBtn];
    }
    return self;
}

-(void)gasBtnPressed:(id)sender
{
    if (self.block!=nil) {
        self.block();
    }
}

-(void)updateData
{
    self.myNumLabel.text = @"您本月获得0次加油卡充值机会";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
