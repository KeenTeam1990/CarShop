//
//  RentalCarView.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/7.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "RentalCarView.h"


#define KLeftOffset 10

@interface RentalCarView ()

AS_MODEL_STRONG(UIImageView, myImageView);
AS_MODEL_STRONG(UIImageView, myIconView);
AS_MODEL_STRONG(UILabel, myNameLabel);
AS_MODEL_STRONG(UILabel, myPriceLabel);
AS_MODEL_STRONG(UIView, myLeaseView);
AS_MODEL_STRONG(UIButton, myButtonBtn);
AS_MODEL_STRONG(M_CarItemModel, myItemModel);

@end

@implementation RentalCarView

DEF_FACTORY_FRAME(RentalCarView);

DEF_MODEL(myPriceLabel);
DEF_MODEL(myNameLabel);
DEF_MODEL(myButtonBtn);
DEF_MODEL(myIconView);
DEF_MODEL(myImageView);
DEF_MODEL(myItemModel);
DEF_MODEL(myLeaseView);

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage* tempIcon = [UIImage imageNamed:@"优惠.png"];
        
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(KLeftOffset, 0, frame.size.width-KLeftOffset*2, 100)];
        self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.myImageView];
        
        self.myIconView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-tempIcon.size.width, self.frame.origin.y, tempIcon.size.width, tempIcon.size.height)];
        [self addSubview:self.myIconView];
        
        NSInteger w = self.bounds.size.width;
        
        self.myNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(KLeftOffset, 100, w-KLeftOffset*2, 25)];
        [self.myNameLabel setBackgroundColor:[UIColor clearColor]];
        [self.myNameLabel setFont:[UIFont systemFontOfSize:14]];
        [self.myNameLabel setTextColor:[UIColor blackColor]];
        [self.myNameLabel setTextAlignment:UITextAlignmentCenter];
        [self addSubview:self.myNameLabel];
        
        self.myPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(KLeftOffset, 125, w-KLeftOffset*2, 25)];
        [self.myPriceLabel setBackgroundColor:[UIColor clearColor]];
        [self.myPriceLabel setFont:[UIFont systemFontOfSize:14]];
        [self.myPriceLabel setTextColor:[UIColor redColor]];
        [self.myPriceLabel setTextAlignment:UITextAlignmentCenter];
        [self addSubview:self.myPriceLabel];
        
        self.myLeaseView = [[UIView alloc]initWithFrame:CGRectMake(KLeftOffset, 150, w,40)];
        [self addSubview:self.myLeaseView];
        
        UIImage* tempBtnBg = [UIImage imageNamed:@"登录.png"];
        UIImage* tempBtn_HBg = [UIImage imageNamed:@"登录按下.png"];
        
        self.myButtonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.myButtonBtn addTarget:self action:@selector(buttonBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.myButtonBtn setBackgroundImage:[tempBtnBg stretchableImageWithLeftCapWidth:tempBtnBg.size.width/2 topCapHeight:tempBtnBg.size.height/2] forState:UIControlStateNormal];
        [self.myButtonBtn setBackgroundImage:[tempBtn_HBg stretchableImageWithLeftCapWidth:tempBtn_HBg.size.width/2 topCapHeight:tempBtn_HBg.size.height/2] forState:UIControlStateHighlighted];
        [self.myButtonBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.myButtonBtn setTitle:@"微首付" forState:UIControlStateNormal];
        self.myButtonBtn.frame = CGRectMake(KLeftOffset, 190, frame.size.width-KLeftOffset*2, 30);
        self.myButtonBtn.userInteractionEnabled = NO;
        [self addSubview:self.myButtonBtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempFrame = self.myImageView.frame;
    tempFrame.size.width = self.frame.size.width-KLeftOffset*2;
    self.myImageView.frame = tempFrame;
    
    tempFrame = self.myNameLabel.frame;
    tempFrame.size.width = self.frame.size.width-KLeftOffset*2;
    self.myNameLabel.frame = tempFrame;
    
    tempFrame = self.myPriceLabel.frame;
    tempFrame.size.width = self.frame.size.width-KLeftOffset*2;
    self.myPriceLabel.frame = tempFrame;
    
    tempFrame = self.myButtonBtn.frame;
    tempFrame.size.width = self.frame.size.width-KLeftOffset*2;
    self.myButtonBtn.frame = tempFrame;
    
    tempFrame = self.myLeaseView.frame;
    tempFrame.size.width = self.frame.size.width-KLeftOffset*2;
    self.myLeaseView.frame = tempFrame;
    
    
}

-(void)buttonBtnPressed:(id)sender
{
    
}

-(void)updateData:(M_CarItemModel*)model
{
    self.myImageView.image = [UIImage imageNamed:@"tempcar.jpg"];
    self.myIconView.hidden = YES;
    self.myNameLabel.text  = @"";
    self.myPriceLabel.text = @"";
    self.myLeaseView.hidden = YES;
    self.myButtonBtn.hidden = YES;
    
    if (model!=nil) {
        
        self.myItemModel = model;
        
        if ([model.myCar_Img notEmpty]) {
            [self.myImageView setImageWithURL:[NSURL URLWithString:model.myCar_Img] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
        }
        
        if ([model.myBrand_Name notEmpty] && [model.mySubbrand_Name notEmpty]) {
            self.myNameLabel.text = [NSString stringWithFormat:@"%@%@",model.myBrand_Name,model.mySubbrand_Name];
        }
        if ([model.myLease_Price notEmpty]) {
            self.myPriceLabel.text = [NSString stringWithFormat:@"首付最低至%@万",model.myLease_Price];
        }
        
        if ([model.myLeaseArray count]>0) {

        }
        
        self.myLeaseView.hidden = NO;
        self.myButtonBtn.hidden = NO;
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
