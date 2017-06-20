//
//  M_DealerCarItemView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/10.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_DealerCarItemView.h"

#import "LL_LableHaveLine.h"

#define KLeftOffset 20
#define KImageWidth 80
#define KImageHeight 60

@interface M_DealerCarItemView ()

AS_MODEL_STRONG(UIImageView, myImageView);
AS_MODEL_STRONG(UILabel, myName1Label);
AS_MODEL_STRONG(UILabel, myName2Label);
AS_MODEL_STRONG(UILabel, myPriceLabel);
AS_MODEL_STRONG(UILabel, myClewLabel);
AS_MODEL_STRONG(UIImageView, myLineView);
AS_MODEL_STRONG(LL_LableHaveLine, myPriceLineLabel);

@end

@implementation M_DealerCarItemView

DEF_FACTORY_FRAME(M_DealerCarItemView);

DEF_MODEL(carType);
DEF_MODEL(myClewLabel);
DEF_MODEL(myImageView);
DEF_MODEL(myName1Label);
DEF_MODEL(myName2Label);
DEF_MODEL(myPriceLabel);
DEF_MODEL(myLineView);
DEF_MODEL(myPriceLineLabel);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(KLeftOffset, (frame.size.height-KImageHeight)/2, KImageWidth, KImageHeight)];
        self.myImageView.image = [UIImage imageNamed:@"tempcar.jpg"];
        [self addSubview:self.myImageView];
        
        self.myName1Label = [self getLabel:CGRectMake(KLeftOffset+KImageWidth+5, 10, frame.size.width-KLeftOffset*2-KImageWidth-5, 30)];
        
        self.myName2Label = [self getLabel:CGRectMake(KLeftOffset+KImageWidth+5, 40, frame.size.width-KLeftOffset*2-KImageWidth-5, 30)];
        
        self.myPriceLabel = [self getLabel:CGRectMake(KLeftOffset+KImageWidth+5, 70, 150, 30)];
        self.myPriceLabel.font = [UIFont systemFontOfSize:12];
        
        self.myPriceLineLabel = [[LL_LableHaveLine alloc]initWithFrame:CGRectMake(KLeftOffset+KImageWidth+5+160, 70, 80, 30)];
        [self addSubview:self.myPriceLineLabel];
        
        self.myClewLabel  = [self getLabel:CGRectMake(KLeftOffset+KImageWidth+5, 70, frame.size.width-KLeftOffset*2-KImageWidth-5, 30)];
   
        self.myLineView = [[UIImageView alloc]initWithFrame:CGRectMake(10, frame.size.height-1, frame.size.width-20, 1)];
        self.myLineView.image = [UIImage imageNamed:@"dashedLine.png"];
        [self addSubview:self.myLineView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempFrame = self.myLineView.frame;
    tempFrame.size.width = self.bounds.size.width-20;
    self.myLineView.frame = tempFrame;
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

-(void)updateData:(M_CarItemModel*)model
{
    if (model!=nil) {
        
    
        
        if (model.myIndexPath !=nil) {
            
        }
        
        if ([model.myCar_Img notEmpty]) {
            [self.myImageView setImageWithURL:[NSURL URLWithString:model.myCar_Img] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
        }
        
        if ([model.myBrand_Name notEmpty] && [model.mySubbrand_Name notEmpty] && [model.myCar_Year notEmpty]) {
            self.myName1Label.text = [NSString stringWithFormat:@"%@ %@ %@",model.myCar_Year,model.myBrand_Name,model.mySubbrand_Name];
        }
        
        if ([model.myCar_Name notEmpty]) {
            self.myName2Label.text = model.myCar_Name;
        }
        
        if (self.carType == EB_NewCar) {
            if ([model.myDealer_Car_Price notEmpty]) {
                self.myPriceLabel.text = [NSString stringWithFormat:@"%@万元",model.myDealer_Car_Price];
            }
        }else if (self.carType == EB_RentaiCar) {
            if ([model.myLease_Price notEmpty]) {
                self.myPriceLabel.text = [NSString stringWithFormat:@"最低首付至：%@万元",model.myLease_Price];
            }
        }else if (self.carType == EB_SpeciaiCar) {
            if ([model.myDealer_Car_Price notEmpty]) {
                self.myPriceLabel.text = [NSString stringWithFormat:@"%@万元",model.myDealer_Car_Price];
            }
        }
        
        if ([model.myCar_Price notEmpty]) {
            self.myPriceLineLabel.myText = [NSString stringWithFormat:@"%@万元",model.myCar_Price];
        }
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
