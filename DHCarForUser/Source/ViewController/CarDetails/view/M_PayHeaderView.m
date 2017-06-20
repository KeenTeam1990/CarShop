//
//  M_PayHeaderView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/16.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_PayHeaderView.h"

@interface M_PayHeaderView ()

AS_MODEL_STRONG(UILabel, myOrderLabel);
AS_MODEL_STRONG(UILabel, myOrderNumLabel);

AS_MODEL_STRONG(UILabel, myOrderPriceLabel);
AS_MODEL_STRONG(UILabel, myOrderPrice2Label);

AS_MODEL_STRONG(UILabel, myNameLabel);

AS_MODEL_STRONG(UIImageView, myLine1View);

@end

@implementation M_PayHeaderView

DEF_FACTORY_FRAME(M_PayHeaderView);

DEF_MODEL(myNameLabel);
DEF_MODEL(myOrderLabel);
DEF_MODEL(myOrderNumLabel);
DEF_MODEL(myOrderPrice2Label);
DEF_MODEL(myOrderPriceLabel);
DEF_MODEL(myLine1View);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView* tempBackView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, frame.size.width, frame.size.height)];
        tempBackView.image = [UIImage imageNamed:@"order_bg.png"];
        [self addSubview:tempBackView];
        
        self.myOrderLabel  = [self getLabel:CGRectMake(10, 15, 60, 30)];
        self.myOrderLabel.text = @"订单号：";
        self.myOrderLabel.textColor = [UIColor blackColor];
        
        self.myOrderNumLabel  = [self getLabel:CGRectMake(70, 15, frame.size.width-100, 30)];
        self.myOrderNumLabel.textColor = [UIColor blueColor];
        
        self.myNameLabel  = [self getLabel:CGRectMake(10, 40, frame.size.width-20, 40)];
        self.myNameLabel.numberOfLines = 2;
        
        self.myOrderPriceLabel = [self getLabel:CGRectMake(10, 80, 70, 30)];
        self.myOrderPriceLabel.text = @"订单金额：";
        self.myOrderPriceLabel.textColor = [UIColor blackColor];
        
        self.myOrderPrice2Label = [self getLabel:CGRectMake(80, 80, 100, 30)];
        self.myOrderPrice2Label.textColor = [UIColor redColor];
        
//        self.myLine1View = [self getLineView:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
    }
    return self;
}

-(UILabel*)getLabel:(CGRect)frame
{
    UILabel* tempLabel = [[UILabel alloc]initWithFrame:frame];
    [tempLabel setBackgroundColor:[UIColor clearColor]];
    [tempLabel setFont:[UIFont systemFontOfSize:14]];
    [tempLabel setTextColor:RGBCOLOR(102, 102, 102)];
    [self addSubview:tempLabel];
    return tempLabel;
}

-(UIImageView*)getLineView:(CGRect)frame
{
    UIImageView* tempLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, frame.origin.y+frame.size.height-1, frame.size.width, 1)];
    [tempLine setBackgroundColor:RGBCOLOR(186, 186, 187)];
    [self addSubview:tempLine];
    return tempLine;
}

-(void)updateData:(NSString*)orderId
        withPrice:(NSString*)price
        withModel:(M_CarItemModel*)model
{
    if (model!=nil) {
        if ([model.myBrand_Name notEmpty] && [model.myCar_Name notEmpty] && [model.myCar_Year notEmpty] && [model.mySubbrand_Name notEmpty]) {
            NSString* etmpS = @"车    型：";
            self.myNameLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",etmpS,model.myBrand_Name,model.mySubbrand_Name,model.myCar_Year,model.myCar_Name];
            
            NSMutableAttributedString* tempAttr = [[NSMutableAttributedString alloc]initWithString:self.myNameLabel.text];
            
            [tempAttr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, etmpS.length)];
            
            self.myNameLabel.attributedText = tempAttr;
        }
        
        if ([model.myCar_Deposit notEmpty]) {
            self.myOrderPrice2Label.text = [NSString stringWithFormat:@"%@元",model.myCar_Deposit];
        }
    }
    
    if ([orderId notEmpty]) {
        self.myOrderNumLabel.text = orderId;
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
