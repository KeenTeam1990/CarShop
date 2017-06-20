//
//  M_CarItemView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarItemView.h"

#import "LL_LableHaveLine.h"

#define KLeftOffset 5

@interface M_CarItemView ()

AS_MODEL_STRONG(UIImageView, myImageView);
AS_MODEL_STRONG(UILabel, myNameLabel);
AS_MODEL_STRONG(UILabel, myClewLabel);
AS_MODEL_STRONG(UIImageView, myIconView);
AS_MODEL_STRONG(UIImageView, myLineView);
AS_MODEL_STRONG(UILabel, myPriceLabel);
AS_MODEL_STRONG(LL_LableHaveLine, myPriceLineLabel);

@end

@implementation M_CarItemView

DEF_FACTORY_FRAME(M_CarItemView);

DEF_MODEL(myIconView);
DEF_MODEL(myImageView);
DEF_MODEL(myNameLabel);
DEF_MODEL(myLineView);
DEF_MODEL(showLine);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(KLeftOffset, KLeftOffset, frame.size.width-KLeftOffset*2, 100)];
        [self.myImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:self.myImageView];
        
        self.myNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(KLeftOffset, 100+KLeftOffset, frame.size.width-KLeftOffset*2, 40)];
        [self.myNameLabel setBackgroundColor:[UIColor clearColor]];
        [self.myNameLabel setFont:[UIFont systemFontOfSize:14]];
        [self.myNameLabel setTextColor:[UIColor blackColor]];
        [self.myNameLabel setNumberOfLines:2];
        [self addSubview:self.myNameLabel];
        
        self.myClewLabel = [[UILabel alloc]initWithFrame:CGRectMake(KLeftOffset, 100+KLeftOffset+40, frame.size.width/2, 30)];
        [self.myClewLabel setBackgroundColor:[UIColor clearColor]];
        [self.myClewLabel setFont:[UIFont systemFontOfSize:14]];
        [self.myClewLabel setTextColor:[UIColor redColor]];
        [self addSubview:self.myClewLabel];
        
        UIImage* tempIcon = [UIImage imageNamed:@"特惠.png"];
        self.myIconView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width-tempIcon.size.width, 0, tempIcon.size.width, tempIcon.size.height)];
        self.myIconView.image = tempIcon;
        self.myIconView.hidden = YES;
        [self addSubview:self.myIconView];
        
        self.myPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(KLeftOffset, 100+KLeftOffset+40, frame.size.width/2, 30)];
        [self.myPriceLabel setBackgroundColor:[UIColor clearColor]];
        [self.myPriceLabel setFont:[UIFont systemFontOfSize:12]];
        self.myPriceLabel.textColor = [UIColor redColor];
        [self addSubview:self.myPriceLabel];
        
        self.myPriceLineLabel = [[LL_LableHaveLine alloc]initWithFrame:CGRectMake(frame.size.width/2, 100+KLeftOffset+40, 80, 30)];
        [self addSubview:self.myPriceLineLabel];
        
        self.myLineView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width, 0, 1, frame.size.height)];
        self.myLineView.backgroundColor = RGBCOLOR(157, 157, 158);
        [self addSubview:self.myLineView];
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
    
    tempFrame = self.myClewLabel.frame;
    tempFrame.size.width = self.frame.size.width-KLeftOffset*2;
    self.myClewLabel.frame = tempFrame;
    
    UIImage* tempIcon = [UIImage imageNamed:@"特惠.png"];
    tempFrame = self.myIconView.frame;
    tempFrame.origin.x = self.frame.size.width-tempIcon.size.width;
    self.myIconView.frame = tempFrame;
    
//    tempFrame = self.myPriceLabel.frame;
//    tempFrame.size.width = self.frame.size.width/2;
//    self.myPriceLabel.frame = tempFrame;
//    
//    tempFrame = self.myPriceLineLabel.frame;
//    tempFrame.origin.x = self.frame.size.width/2;
//    self.myPriceLineLabel.frame = tempFrame;
    
    tempFrame = self.myLineView.frame;
    tempFrame.origin.x = self.frame.size.width;
    self.myLineView.frame = tempFrame;
}

-(void)setShowLine:(BOOL)show
{
    showLine = show;
    self.myLineView.hidden = !show;
}

-(void)updateData:(M_CarItemModel*)model
{
    self.myImageView.image = [UIImage imageNamed:@"tempcar.jpg"];
    self.myNameLabel.text = @"";
    self.myClewLabel.text = @"";
    self.myIconView.hidden = YES;
    
    self.myPriceLabel.hidden = YES;
    self.myPriceLineLabel.hidden = YES;
    self.myPriceLineLabel.myText = @"";
    self.myPriceLabel.text = @"";
    self.myClewLabel.hidden = YES;
    
    if (model!=nil) {
        
        if ([model.myCar_Img notEmpty]) {
            [self.myImageView setImageWithURL:[NSURL URLWithString:model.myCar_Img] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
        }
        
        if ([model.myBrand_Name notEmpty] && [model.mySubbrand_Name notEmpty] && [model.myCar_Year notEmpty] && [model.myCar_Name notEmpty]) {
            self.myNameLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",model.myBrand_Name,model.mySubbrand_Name,model.myCar_Year,model.myCar_Name];
        }
        
        if (model.myCar_Sales) {
            
            self.myPriceLabel.hidden = NO;
            self.myPriceLineLabel.hidden = NO;
            
            if ([model.myDealer_Car_Price notEmpty]) {
                self.myPriceLabel.text = [NSString stringWithFormat:@"%@万元",model.myDealer_Car_Price];
                CGRect tempFrame = self.myPriceLabel.frame;
                tempFrame.size.width = [Unity getLableWidthWithString:self.myPriceLabel.text andFontSize:12];
                self.myPriceLabel.frame = tempFrame;
            }
            
            if ([model.myCar_Price notEmpty]) {
                self.myPriceLineLabel.myText = [NSString stringWithFormat:@"指导价:%@万元",model.myCar_Price];
                self.myPriceLabel.font = [UIFont systemFontOfSize:10];
                self.myPriceLabel.textAlignment = NSTextAlignmentLeft;
                CGRect tempFrame = self.myPriceLineLabel.frame;
                tempFrame.origin.x = MaxX(self.myPriceLabel)+3;
                tempFrame.size.width = [Unity getLableWidthWithString:self.myPriceLineLabel.myText andFontSize:12];
                self.myPriceLineLabel.frame = tempFrame;
            }
            
            UIImage* tempIcon = [UIImage imageNamed:@"特惠.png"];
            self.myIconView.hidden = NO;
            self.myIconView.image = tempIcon;
        }else if (model.myCar_Lease){
            
            self.myClewLabel.hidden = NO;
            
            if ([model.myLease_Price notEmpty]) {
                self.myClewLabel.text = [NSString stringWithFormat:@"首付：%@万元",model.myLease_Price];
            }
            
            UIImage* tempIcon = [UIImage imageNamed:@"租购1.png"];
            self.myIconView.hidden = NO;
            self.myIconView.image = tempIcon;
            
        }else if (model.myCar_New){
            
            self.myPriceLabel.hidden = NO;
            self.myPriceLineLabel.hidden = NO;
            
            if ([model.myDealer_Car_Price notEmpty]) {
                self.myPriceLabel.text = [NSString stringWithFormat:@"%@万元",model.myDealer_Car_Price];
                CGRect tempFrame = self.myPriceLabel.frame;
                tempFrame.size.width = [Unity getLableWidthWithString:self.myPriceLabel.text andFontSize:12];
                self.myPriceLabel.frame = tempFrame;
            }
            
            if ([model.myCar_Price notEmpty]) {
                self.myPriceLineLabel.myText = [NSString stringWithFormat:@"指导价:%@万元",model.myCar_Price];
                
                CGRect tempFrame = self.myPriceLineLabel.frame;
                tempFrame.origin.x = MaxX(self.myPriceLabel)+3;
                tempFrame.size.width = [Unity getLableWidthWithString:self.myPriceLineLabel.myText andFontSize:12];
                self.myPriceLineLabel.frame = tempFrame;
            }
            UIImage* tempIcon = [UIImage imageNamed:@"新车.png"];
            self.myIconView.hidden = NO;
            self.myIconView.image = tempIcon;
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
