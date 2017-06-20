//
//  LL_CarHeadView.m
//  DHCarForSales
//
//  Created by leiyu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "LL_CarHeadView.h"

@interface LL_CarHeadView()

AS_MODEL_STRONG(UIImageView, myImageView);
AS_MODEL_STRONG(UILabel, myNameLabel);
AS_MODEL_STRONG(UILabel, myPriceLable);
AS_MODEL_STRONG(UIButton, myButton);

@end

@implementation LL_CarHeadView
DEF_MODEL(myBlock);

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        
        NSInteger tempImageW = self.frame.size.width/2-20;
        
        if (IS_SCREEN_35_INCH||IS_SCREEN_4_INCH) {
            tempImageW = 100;
        }
        
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, tempImageW, 80)];
        self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.myImageView.image = [UIImage imageNamed:@"tempcar.jpg"];
        [self addSubview:self.myImageView];
        
        self.myNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(tempImageW+20, 5, self.bounds.size.width-tempImageW-30, 40)];
        self.myNameLabel.font = [UIFont systemFontOfSize:14];
        self.myNameLabel.textColor = [UIColor blackColor];
        self.myNameLabel.numberOfLines = 3;
        [self addSubview:self.myNameLabel];
        
        self.myPriceLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.myNameLabel.frame), CGRectGetMaxY(self.myNameLabel.frame), self.bounds.size.width-tempImageW-30, 40)];
        self.myPriceLable.font = [UIFont systemFontOfSize:14];
        self.myPriceLable.textColor = [UIColor blackColor];
        self.myPriceLable.numberOfLines = 3;
        [self addSubview:self.myPriceLable];
        
        self.myButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.myButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.myButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.myButton.style = DLButtonStyleMake(style.cornerRedius = 2;
                                                style.backgroundColor = [UIColor redColor];);
        self.myButton.frame = CGRectMake(0, 100, self.frame.size.width, 40);
        [self.myButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.myButton];
    }
    return self;
}

-(void)buttonPressed:(id)sender
{
    if (self.myItemModel!=nil) {
        if (self.myBlock!=nil) {
            self.myBlock(self.myItemModel);
        }
    }
}

-(void)updateData:(M_QuoteItemModel*)data
{
    if (data!=nil) {
        
        self.myItemModel = data;
        
        if (data.myInquiryModel!=nil) {
            if (data.myInquiryModel.car!=nil) {
                if ([data.myInquiryModel.car.myCar_Img notEmpty]) {
                    [self.myImageView setImageWithURL:[NSURL URLWithString:data.myInquiryModel.car.myCar_Img] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
                    
                }
                if ([data.myInquiryModel.car.myBrand_Name notEmpty] &&
                    [data.myInquiryModel.car.mySubbrand_Name notEmpty] &&
                    [data.myInquiryModel.car.myCar_Year notEmpty] &&
                    [data.myInquiryModel.car.myCar_Name notEmpty]) {
                    self.myNameLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",data.myInquiryModel.car.myBrand_Name,data.myInquiryModel.car.mySubbrand_Name,data.myInquiryModel.car.myCar_Year,data.myInquiryModel.car.myCar_Name];
                }
            }
        }
        
        self.myButton.hidden = YES;
        
        if ([data.myLastPrice notEmpty] && ![data.myLastPrice isEqualToString:@"0"]) {
            self.myButton.hidden = NO;
            [self.myButton setTitle:@"立即支付最终报价" forState:UIControlStateNormal];
            self.myPriceLable.text = [NSString stringWithFormat:@"最终报价:%@万元",data.myLastPrice];
        }else if ([data.myFirstPrice notEmpty] && ![data.myFirstPrice isEqualToString:@"0"]){
            self.myButton.hidden = NO;
            [self.myButton setTitle:@"立即支付首次报价" forState:UIControlStateNormal];
            self.myPriceLable.text = [NSString stringWithFormat:@"首次报价:%@万元",data.myFirstPrice];
        }else{
            self.myButton.hidden = NO;
            [self.myButton setTitle:@"立即预定" forState:UIControlStateNormal];
            self.myPriceLable.text = [NSString stringWithFormat:@"指导价格:%@万元",data.myInquiryModel.car.myCar_Price];
        }
        
        if (data.myOrderModel!=nil) {
            if ([data.myOrderModel.order_step notEmpty]) {
                if (![data.myOrderModel.order_step isEqualToString:@"0"]) {
                    self.myButton.hidden = NO;
                    [self.myButton setTitle:@"查看订单" forState:UIControlStateNormal];
                }
            }
        }
    }
}
-(void)upDataCarName:(NSString *)carname  andCarDescription:(NSString *)carDescription andCarFirstPrice:(NSString *)carFirstPrice andCarColor:(NSString *)carColor  andCarLogImageName:(NSString *)carLogeImageName
{
    if ([carLogeImageName isUrl]) {
        self.myImageView.hidden = NO;
        [self.myImageView setImageWithURL:[NSURL URLWithString:carLogeImageName] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
    }
    else
    {
        self.myImageView.hidden = NO;
        self.myImageView.image = [UIImage imageNamed:@"tempcar"];
    }
    if ([carname isEqualToString:@""]) {
        self.myNameLabel.hidden = YES;
    }
    else{
        self.myNameLabel.hidden = NO;
        self.myNameLabel.text = carname;
    }
    self.myButton.hidden = YES;

}
@end
