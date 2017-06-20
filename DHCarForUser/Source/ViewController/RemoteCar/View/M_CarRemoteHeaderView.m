//
//  M_CarRemoteHeaderView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarRemoteHeaderView.h"

#define KLeftOffset 20
#define KLabelWidth 70

@interface M_CarRemoteHeaderView ()

AS_MODEL_STRONG(UIButton, mySeleteCityBtn);
AS_MODEL_STRONG(UIButton, mySeleteDateBtn);
AS_MODEL_STRONG(UIButton, myCarTypeBtn);
AS_MODEL_STRONG(UIButton, myCarNumBtn);
AS_MODEL_STRONG(UIButton, mySumbitBtn);

@end

@implementation M_CarRemoteHeaderView

DEF_FACTORY_FRAME(M_CarRemoteHeaderView);
DEF_MODEL(myCarNumBtn);
DEF_MODEL(myCarTypeBtn);
DEF_MODEL(mySeleteCityBtn);
DEF_MODEL(mySeleteDateBtn);
DEF_MODEL(mySumbitBtn);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        
        self.mySeleteCityBtn = [self row1View:CGRectMake(0, 20, frame.size.width, 50) withLabel:@"选择城市" withTag:1000];
        
        self.mySeleteDateBtn = [self row1View:CGRectMake(0, 70, frame.size.width, 50) withLabel:@"选择日期" withTag:1001];
        
        self.myCarTypeBtn = [self row1View:CGRectMake(0, 120, frame.size.width, 50) withLabel:@"车辆类型" withTag:1002];
        
        self.myCarNumBtn = [self row1View:CGRectMake(0, 170, frame.size.width, 50) withLabel:@"用车人数" withTag:1003];
        
        UIImage* tempBtnBg = [UIImage imageNamed:@"登录.png"];
        UIImage* tempBtn_HBg = [UIImage imageNamed:@"登录按下.png"];
        
        self.mySumbitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.mySumbitBtn addTarget:self action:@selector(sumbitBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.mySumbitBtn setBackgroundImage:[tempBtnBg stretchableImageWithLeftCapWidth:tempBtnBg.size.width/2 topCapHeight:tempBtnBg.size.height/2] forState:UIControlStateNormal];
        [self.mySumbitBtn setBackgroundImage:[tempBtn_HBg stretchableImageWithLeftCapWidth:tempBtn_HBg.size.width/2 topCapHeight:tempBtn_HBg.size.height/2] forState:UIControlStateHighlighted];
        [self.mySumbitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [self.mySumbitBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        self.mySumbitBtn.frame = CGRectMake(KLeftOffset, 250, frame.size.width-KLeftOffset*2, 40);
        [self addSubview:self.mySumbitBtn];
    }
    return self;
}

-(UIButton*)row1View:(CGRect)frame  withLabel:(NSString*)label withTag:(NSInteger)tag
{
    UILabel* tempLabel = [self getLabel:CGRectMake(KLeftOffset, frame.origin.y+(frame.size.height-30)/2, KLabelWidth, 30)];
    tempLabel.text = label;
    
    UIButton* tempBtn = [self getDropView:CGRectMake(KLeftOffset+KLabelWidth+KLeftOffset/2, frame.origin.y+(frame.size.height-40)/2, frame.size.width-KLeftOffset*2-KLabelWidth-KLeftOffset/2, 40)];
    tempBtn.tag = tag;
    
    UIImageView* tempLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, frame.origin.y+frame.size.height-1, frame.size.width, 1)];
    tempLine.backgroundColor = RGBCOLOR(157, 157, 158);
    [self addSubview:tempLine];
    
    return tempBtn;
}

-(UIButton*)getDropView:(CGRect)frame
{
    UIImage* tempBackBg = [UIImage imageNamed:@"灰色输入框.png"];
    UIImage* tempArrowIcon = [UIImage imageNamed:@"下拉.png"];
    
    UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tempBtn setBackgroundImage:[tempBackBg stretchableImageWithLeftCapWidth:tempBackBg.size.width/2 topCapHeight:tempBackBg.size.height/2] forState:UIControlStateNormal];
    [tempBtn addTarget:self action:@selector(itemBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    tempBtn.frame = frame;
    [tempBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    tempBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10+frame.size.height);
    [tempBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    UIButton* tempArrowbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tempArrowbtn.frame = CGRectMake(frame.size.width-frame.size.height, 1, frame.size.height-2, frame.size.height-2);
    tempArrowbtn.backgroundColor = [UIColor whiteColor];
    [tempArrowbtn setImage:tempArrowIcon forState:UIControlStateNormal];
    tempArrowbtn.userInteractionEnabled = NO;
    [tempBtn addSubview:tempArrowbtn];
    [self addSubview:tempBtn];
    return tempBtn;
}

-(UILabel*)getLabel:(CGRect)frame
{
    UILabel* tempLabel = [[UILabel alloc]initWithFrame:frame];
    [tempLabel setBackgroundColor:[UIColor clearColor]];
    [tempLabel setFont:[UIFont systemFontOfSize:14]];
    [tempLabel setTextColor:[UIColor blackColor]];
    [self addSubview:tempLabel];
    return tempLabel;
}

-(void)sumbitBtnPressed:(id)sender
{
    if (self.block!=nil) {
        self.block(4,nil);
    }
}

-(void)itemBtnPressed:(id)sender
{
    UIButton* tempbtn = (UIButton*)sender;
    
    if (self.block!=nil) {
        self.block(tempbtn.tag-1000,tempbtn.titleLabel.text);
    }
}

-(void)updateData:(NSString*)data withTag:(NSInteger)tag
{
    switch (tag) {
        case 0:
            [self.mySeleteCityBtn setTitle:data forState:UIControlStateNormal];
            break;
        case 1:
            [self.mySeleteDateBtn setTitle:data forState:UIControlStateNormal];
            break;
        case 2:
            [self.myCarTypeBtn setTitle:data forState:UIControlStateNormal];
            break;
        case 3:
            [self.myCarNumBtn setTitle:data forState:UIControlStateNormal];
            break;
        default:
            break;
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
