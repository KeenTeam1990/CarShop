//
//  M_BuyShaixuanView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/22.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_BuyShaixuanView.h"

@interface M_BuyShaixuanView ()

AS_MODEL_STRONG(UIButton, myLeftBtn);
AS_MODEL_STRONG(UIButton, myCenterBtn);
AS_MODEL_STRONG(UIButton, myRightBtn);

@end

@implementation M_BuyShaixuanView

DEF_FACTORY_FRAME(M_BuyShaixuanView);

DEF_MODEL(myLeftBtn);
DEF_MODEL(myCenterBtn);
DEF_MODEL(myRightBtn);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.myLeftBtn = [self getSeleteButton:CGRectMake(10, 10, self.frame.size.width/3-20, self.frame.size.height-20)];
        self.myLeftBtn.tag = 9990;
        
        self.myCenterBtn = [self getSeleteButton:CGRectMake(self.frame.size.width/3+10, 10, self.frame.size.width/3-20, self.frame.size.height-20)];
        self.myCenterBtn.tag = 9991;
        
        self.myRightBtn = [self getSeleteButton:CGRectMake((self.frame.size.width/3)*2+10, 10, self.frame.size.width/3-20, self.frame.size.height-20)];
        self.myRightBtn.tag = 9992;
        
        [self updateLeftText:@"全部品牌"];
        [self updateCenterText:@"全部价格"];
        [self updateRightText:@"全部车型"];
        
    }
    return self;
}

-(void)setLeftText:(NSString *)text
{
    _leftText = text;
    
    if (text.length==0) {
        [self updateState:NO withTag:0];
        [self updateLeftText:@"全部品牌"];
    }else{
        [self updateLeftText:text];
    }
}

-(void)setCenterText:(NSString *)text
{
    _centerText = text;
    if (text.length == 0) {
        [self updateState:NO withTag:1];
        [self updateCenterText:@"全部价格"];
    }else{
        [self updateCenterText:text];
    }
}

-(void)setRightText:(NSString *)text
{
    _rightText = text;
    
    if (text.length==0) {
        [self updateState:NO withTag:2];
        [self updateRightText:@"全部车型"];
    }else{
        [self updateRightText:text];
    }
}

-(void)updateLeftText:(NSString*)text
{
    [self.myLeftBtn setTitle:text forState:UIControlStateNormal];
}

-(void)updateCenterText:(NSString*)text
{
    [self.myCenterBtn setTitle:text forState:UIControlStateNormal];
}

-(void)updateRightText:(NSString*)text
{
    [self.myRightBtn setTitle:text forState:UIControlStateNormal];
}

-(void)updateState:(BOOL)selete withTag:(NSInteger)tag
{
    UIButton* templeftBtn = [self.myLeftBtn viewWithTag:1001];
    UIButton* tempcenterBtn = [self.myCenterBtn viewWithTag:1001];
    UIButton* temprightBtn = [self.myRightBtn viewWithTag:1001];
    
    if (tag == 0) {
        [self.myLeftBtn setSelected:selete];
        [templeftBtn setSelected:selete];
    }else if (tag == 1){
        [self.myCenterBtn setSelected:selete];
        [tempcenterBtn setSelected:selete];

    }else if(tag == 2){
        [self.myRightBtn setSelected:selete];
        [temprightBtn setSelected:selete];
    }
}

-(UIButton*)getSeleteButton:(CGRect)frame
{
    UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tempBtn.frame = frame;
    
    [tempBtn addTarget:self action:@selector(seleteBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [tempBtn setBackgroundColor:[UIColor whiteColor]];
    [tempBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, frame.size.height)];
    [tempBtn setTitleColor:RGBCOLOR(202, 202, 202) forState:UIControlStateNormal];
    [tempBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [tempBtn.layer setMasksToBounds:YES];
    [tempBtn.layer setCornerRadius:4];
    [tempBtn.layer setBorderWidth:1];
    [tempBtn.layer setBorderColor:[UIColor blackColor].CGColor];
    [tempBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [tempBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    UIButton* tempRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tempRightBtn.frame = CGRectMake(frame.size.width-frame.size.height, -1, frame.size.height+2, frame.size.height+2);
    tempRightBtn.backgroundColor = [UIColor whiteColor];
    [tempRightBtn setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
    [tempRightBtn setImage:[UIImage imageNamed:@"arrow_red.png"] forState:UIControlStateSelected];
    tempRightBtn.userInteractionEnabled = NO;
    [tempRightBtn.layer setMasksToBounds:YES];
    [tempRightBtn.layer setBorderWidth:1];
    tempRightBtn.tag = 1001;
    [tempRightBtn.layer setBorderColor:[UIColor blackColor].CGColor];
    [tempBtn addSubview:tempRightBtn];
    
    [self addSubview:tempBtn];
    
    return tempBtn;
}

-(void)seleteBtnPressed:(id)sender
{
    UIButton* tempBtn = (UIButton*)sender;
    
    [self updateBtnData];
    
    if (tempBtn.tag == 9990) {
        
        [self updateState:YES withTag:0];
        [self updateLeftText:@"选择品牌"];
        
        if (self.block!=nil) {
            self.block(0,nil);
        }
    }else if (tempBtn.tag == 9991){
        
        [self updateState:YES withTag:1];
        [self updateCenterText:@"选择价格"];
        
        if (self.block!=nil) {
            self.block(1,nil);
        }
    }else if (tempBtn.tag == 9992){
        
        [self updateState:YES withTag:2];
        [self updateRightText:@"选择车型"];
        
        if (self.block!=nil) {
            self.block(2,nil);
        }
    }
}

-(void)resetData
{
    self.leftText = @"";
    self.centerText = @"";
    self.rightText = @"";
}

-(void)updateBtnData
{
    if ([self.leftText length] == 0) {
        [self updateState:NO withTag:0];
        [self updateLeftText:@"全部品牌"];
    }else{
        [self updateLeftText:self.leftText];
    }
    if ([self.centerText length] == 0) {
        [self updateState:NO withTag:1];
        [self updateCenterText:@"全部价格"];
    }else{
        [self updateCenterText:self.centerText];
    }
    if ([self.rightText length] == 0) {
        [self updateState:NO withTag:2];
        [self updateRightText:@"全部车型"];
    }else{
        [self updateRightText:self.rightText];
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
