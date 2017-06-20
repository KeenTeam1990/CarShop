//
//  M_CarItem2View.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/20.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarItem2View.h"

#import "LL_LableHaveLine.h"

#define KLeftOffset 10

#define KImageHeight 100

AS_SHARE_LABEL_STYLE(Content);

DEF_SHARE_LABEL_STYLE(Content,
                      style.backgroundColor = [UIColor clearColor];
                      style.textStyle.font = [UIFont systemFontOfSize:14];
                      style.textStyle.textColor = [UIColor blackColor];);

@interface M_CarItem2View ()

AS_MODEL_STRONG(UIImageView, myImageView);
AS_MODEL_STRONG(UIImageView, myIconView);
AS_MODEL_STRONG(UILabel, myNameLabel);
AS_MODEL_STRONG(UIView, myRetalView);
AS_MODEL_STRONG(UILabel, myPriceLabel);
AS_MODEL_STRONG(UILabel, myClewLabel);
AS_MODEL_STRONG(LL_LableHaveLine, myPriceLineLabel);

@end

@implementation M_CarItem2View

DEF_FACTORY_FRAME(M_CarItem2View);

DEF_MODEL(carType);
DEF_MODEL(myClewLabel);
DEF_MODEL(myImageView);
DEF_MODEL(myNameLabel);
DEF_MODEL(myRetalView);
DEF_MODEL(myPriceLabel);
DEF_MODEL(myPriceLineLabel);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        NSInteger tempImageW = self.frame.size.width/2-KLeftOffset*2;
        
        if (IS_SCREEN_35_INCH||IS_SCREEN_4_INCH) {
            tempImageW = 100;
        }
        
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(KLeftOffset, (frame.size.height-KImageHeight)/2, tempImageW, KImageHeight)];
        self.myImageView.image = [UIImage imageNamed:@"tempcar.jpg"];
        self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.myImageView];
        
        self.myNameLabel = [self getLabel:CGRectMake(KLeftOffset*2+tempImageW, 5, frame.size.width-KLeftOffset*3-tempImageW, 40)];
        self.myNameLabel.numberOfLines = 2;
        
        self.myClewLabel  = [self getLabel:CGRectMake(KLeftOffset*2+tempImageW, 40, frame.size.width-KLeftOffset*3-tempImageW, 30)];
        self.myClewLabel.textColor = [UIColor redColor];
        
        self.myPriceLabel = [self getLabel:CGRectMake(KLeftOffset*2+tempImageW, 70, 80, 30)];
        self.myPriceLabel.font = [UIFont systemFontOfSize:12];
        self.myPriceLabel.textColor = [UIColor redColor];
        
        self.myPriceLineLabel = [[LL_LableHaveLine alloc]initWithFrame:CGRectMake(KLeftOffset*2+tempImageW+90, 70, 80, 30)];
        [self addSubview:self.myPriceLineLabel];
        
        self.myRetalView = [[UIView alloc]initWithFrame:CGRectMake(KLeftOffset*2+tempImageW, 70, frame.size.width-KLeftOffset*3-tempImageW, 35)];
        [self addSubview:self.myRetalView];
        
        UIImage* tempIcon = [UIImage imageNamed:@"特惠.png"];
        self.myIconView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width-tempIcon.size.width, 0, tempIcon.size.width, tempIcon.size.height)];
        self.myIconView.image = tempIcon;
        self.myIconView.hidden = YES;
        [self addSubview:self.myIconView];

    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger tempImageW = self.frame.size.width/2-KLeftOffset*2;
    
    if (IS_SCREEN_35_INCH||IS_SCREEN_4_INCH) {
        tempImageW = 100;
    }
    
    CGRect tempFrame = self.myNameLabel.frame;
    tempFrame.size.width = self.bounds.size.width-KLeftOffset*3-tempImageW;
    self.myNameLabel.frame = tempFrame;
    
    tempFrame = self.myClewLabel.frame;
    tempFrame.size.width = self.bounds.size.width-KLeftOffset*3-tempImageW;
    self.myClewLabel.frame = tempFrame;
    
    tempFrame = self.myRetalView.frame;
    tempFrame.size.width = self.bounds.size.width-KLeftOffset*3-tempImageW;
    self.myRetalView.frame = tempFrame;
    
    UIImage* tempIcon = [UIImage imageNamed:@"特惠.png"];
    tempFrame = self.myIconView.frame;
    tempFrame.origin.x = self.frame.size.width-tempIcon.size.width;
    self.myIconView.frame = tempFrame;
    
    [self updateRetalView];
}

-(UILabel*)getLabel:(CGRect)frame
{
    UILabel* tempLabel = [[UILabel alloc]initWithFrame:frame];
    tempLabel.style = DLStyleContent();
    [self addSubview:tempLabel];
    return tempLabel;
}

-(void)updateData:(M_CarItemModel*)model
{
    if (model!=nil) {
        
        self.myNameLabel.text = @"";
        self.myClewLabel.text = @"";
        self.myImageView.image = [UIImage imageNamed:@"tempcar.jpg"];
        self.myPriceLabel.text = @"";
        self.myPriceLineLabel.myText = @"";
        self.myPriceLineLabel.hidden = YES;
        self.myPriceLabel.hidden = YES;
        self.myRetalView.hidden = YES;
        self.myClewLabel.hidden = YES;
        self.myIconView.hidden = YES;
        
        if ([model.myCar_Img notEmpty]) {
            [self.myImageView setImageWithURL:[NSURL URLWithString:model.myCar_Img] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
        }
        
        if ([model.myBrand_Name notEmpty] && [model.mySubbrand_Name notEmpty] && [model.myCar_Year notEmpty] && [model.myCar_Name notEmpty]) {
            self.myNameLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",model.myBrand_Name,model.mySubbrand_Name ,model.myCar_Year,model.myCar_Name];
        }
        
        if (model.myCar_New||self.carType == EB_NewCar) {
            
            self.myPriceLabel.hidden = NO;
            self.myPriceLineLabel.hidden = NO;
            
            if ([model.myDealer_Car_Price notEmpty]) {
                self.myPriceLabel.text = [NSString stringWithFormat:@"%@万元",model.myDealer_Car_Price];
                CGRect tempFrame = self.myPriceLabel.frame;
                tempFrame.size.width = [Unity getLableWidthWithString:self.myPriceLabel.text andFontSize:14];
                self.myPriceLabel.frame = tempFrame;
            }
            
            if ([model.myCar_Price notEmpty]) {
                self.myPriceLineLabel.myText = [NSString stringWithFormat:@"指导价:%@万元",model.myCar_Price];
                
                CGRect tempFrame = self.myPriceLineLabel.frame;
                tempFrame.origin.x = MaxX(self.myPriceLabel)+10;
                tempFrame.size.width = [Unity getLableWidthWithString:self.myPriceLineLabel.myText andFontSize:12];
                self.myPriceLineLabel.frame = tempFrame;
            }
            
            CGRect tempFrame = self.myNameLabel.frame;
            tempFrame.origin.y = 20;
            self.myNameLabel.frame = tempFrame;
            
            tempFrame = self.myPriceLabel.frame;
            tempFrame.origin.y = 60;
            self.myPriceLabel.frame = tempFrame;
            
            tempFrame = self.myPriceLineLabel.frame;
            tempFrame.origin.y = 60;
            self.myPriceLineLabel.frame = tempFrame;
            
            UIImage* tempIcon = [UIImage imageNamed:@"新车.png"];
            self.myIconView.hidden = !self.showIcon;
            self.myIconView.image = tempIcon;
            
        }else if (model.myCar_Lease||self.carType == EB_RentaiCar) {
            
            self.myRetalView.hidden = NO;
            self.myClewLabel.hidden = NO;
            
            if ([model.myLease_Price notEmpty]) {
                self.myClewLabel.text = [NSString stringWithFormat:@"首付：%@万元",model.myLease_Price];
            }
            
            CGRect tempFrame = self.myNameLabel.frame;
            tempFrame.origin.y = 20;
            self.myNameLabel.frame = tempFrame;
            
            tempFrame = self.myClewLabel.frame;
            tempFrame.origin.y = 60;
            self.myClewLabel.frame = tempFrame;
            
//            for (int i=0; i<[self.myRetalView.subviews count]; i++) {
//                UIView* tempView = [self.myRetalView.subviews objectAtIndex:i];
//                if (tempView!=nil) {
//                    [tempView removeFromSuperview];
//                }
//            }
//            
//            if ([model.myLeaseArray count]>0) {
//                
//                NSInteger count = [model.myLeaseArray count];
//                NSInteger x = 0;
//                NSInteger y = 0;
//                
//                NSInteger w = (self.myRetalView.frame.size.width/4) - 3;
//                NSInteger h = 25;
//                
//                for (int i=0; i<count; i++) {
//                    
//                    NSString* tempStr = [model.myLeaseArray objectAtIndex:i];
//                    
//                    UIButton* tempbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//                    tempbtn.userInteractionEnabled = NO;
//                    tempbtn.style = DLButtonStyleMake(style.borderWidth = 1;
//                                                      style.borderColor = [UIColor lightGrayColor];
//                                                      style.cornerRedius = 3;);
//                    tempbtn.titleLabel.font = [UIFont systemFontOfSize:12];
//                    [tempbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//                    tempbtn.frame = CGRectMake(x, y, w, h);
//                    if ([tempStr notEmpty]) {
//                        [tempbtn setTitle:[NSString stringWithFormat:@"%@期",tempStr] forState:UIControlStateNormal];
//                    }
//                    tempbtn.tag = 1000+i;
//                    [self.myRetalView addSubview:tempbtn];
//                    
//                    if (i > 2) {
//                        break;
//                    }
//                    x+=w+3;
//                }
//            }
            
            UIImage* tempIcon = [UIImage imageNamed:@"租购1.png"];
            self.myIconView.hidden = !self.showIcon;
            self.myIconView.image = tempIcon;
            
        }else if (model.myCar_Sales||self.carType == EB_SpeciaiCar) {
            
            self.myPriceLabel.hidden = NO;
            self.myPriceLineLabel.hidden = NO;
//            self.myClewLabel.hidden = NO;
            
            if ([model.myDealer_Car_Price notEmpty]) {
                self.myPriceLabel.text = [NSString stringWithFormat:@"%@万元",model.myDealer_Car_Price];
                CGRect tempFrame = self.myPriceLabel.frame;
                tempFrame.size.width = [Unity getLableWidthWithString:self.myPriceLabel.text andFontSize:14];
                self.myPriceLabel.frame = tempFrame;
            }
            
            if ([model.myCar_Price notEmpty]) {
                self.myPriceLineLabel.myText = [NSString stringWithFormat:@"指导价:%@万元",model.myCar_Price];
                CGRect tempFrame = self.myPriceLineLabel.frame;
                tempFrame.origin.x = MaxX(self.myPriceLabel)+10;
                tempFrame.size.width = [Unity getLableWidthWithString:self.myPriceLineLabel.myText andFontSize:12];
                self.myPriceLineLabel.frame = tempFrame;
            }
            
            CGRect tempFrame = self.myNameLabel.frame;
            tempFrame.origin.y = 20;
            self.myNameLabel.frame = tempFrame;
            
            tempFrame = self.myPriceLabel.frame;
            tempFrame.origin.y = 60;
            self.myPriceLabel.frame = tempFrame;
            
            tempFrame = self.myPriceLineLabel.frame;
            tempFrame.origin.y = 60;
            self.myPriceLineLabel.frame = tempFrame;
            
//            if ([model.myDealer_Car_Price notEmpty] && [model.myCar_Price notEmpty]) {
//                CGFloat tempp = [model.myCar_Price floatValue]-[model.myDealer_Car_Price floatValue];
//                NSString* tempPrice = [NSString stringWithFormat:@"%.02f",tempp];
//                self.myClewLabel.text = [NSString stringWithFormat:@"东汇赠购礼包%@万元",tempPrice];
//            }
            
            UIImage* tempIcon = [UIImage imageNamed:@"特惠.png"];
            self.myIconView.hidden = !self.showIcon;
            self.myIconView.image = tempIcon;
        }
    }
}

-(void)updateRetalView
{
    NSInteger count = [self.myRetalView.subviews count];
    NSInteger x = 0;
    NSInteger y = 0;
    NSInteger w = (self.myRetalView.frame.size.width/4) - 3;
    NSInteger h = 25;
    
    for (int i=0; i<count; i++) {
        
        UIButton* tempbtn = [self.myRetalView.subviews objectAtIndex:i];

        tempbtn.frame = CGRectMake(x, y, w, h);
        
        if (i > 2) {
            break;
        }
        
        x+=w+3;
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
