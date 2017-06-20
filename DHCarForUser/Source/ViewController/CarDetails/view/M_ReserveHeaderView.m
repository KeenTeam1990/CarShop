//
//  M_ReserveHeaderView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_ReserveHeaderView.h"

#import "M_FieldOrButtonView.h"
#import "M_CarDistributorItemView.h"

#define KLeftOffset 10
#define KLabelWidth 80

#define KLineHeight 60

@interface M_ReserveHeaderView ()

AS_MODEL_STRONG(UIImageView, myImageView);
AS_MODEL_STRONG(UILabel, myNameLabel);
AS_MODEL_STRONG(UILabel, myPriceLabel);
AS_MODEL_STRONG(UILabel, myPrice2Label);

AS_MODEL_STRONG(UILabel, myPolicyLabel);
AS_MODEL_STRONG(UILabel, myPolicyContentLabel);

AS_MODEL_STRONG(UIImageView, myLine1View);
AS_MODEL_STRONG(UIImageView, myLine2View);

AS_MODEL(TCarBottomType, carType);

AS_MODEL_STRONG(UIView, myRow1View);
AS_MODEL_STRONG(UIView, myRow2View);

AS_MODEL_STRONG(UIImageView, myRightIconView);
AS_MODEL_STRONG(UIButton, mySeleteBtn);

AS_MODEL_STRONG(M_CarItemModel, myItemModel);

@end

@implementation M_ReserveHeaderView

DEF_FACTORY_FRAME(M_ReserveHeaderView);

DEF_MODEL(myImageView);
DEF_MODEL(myNameLabel);

DEF_MODEL(myLine1View);
DEF_MODEL(myLine2View);

DEF_MODEL(myPrice2Label);
DEF_MODEL(myPriceLabel);
DEF_MODEL(carType);
DEF_MODEL(myPolicyLabel);
DEF_MODEL(myPolicyContentLabel);

DEF_MODEL(myRow1View);
DEF_MODEL(myRow2View);

DEF_MODEL(myRightIconView);

DEF_MODEL(mySeleteBtn);

DEF_MODEL(myItemModel);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self initRow1View:CGRectMake(0, 10, frame.size.width, 110)];
        
        //[self initRow2View:CGRectMake(0, 120, frame.size.width, 50)];

    }
    
    return self;
}

-(void)initRow1View:(CGRect)frame
{
    self.myRow1View = [[UIView alloc]initWithFrame:frame];
    [self addSubview:self.myRow1View];
    
    NSInteger im_W = self.bounds.size.width/2-KLeftOffset*2;
    
    self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(KLeftOffset, (frame.size.height-100)/2,im_W ,100)];
    self.myImageView.image = [UIImage imageNamed:@"tempcar.jpg"];
    self.myImageView.contentMode  =UIViewContentModeScaleAspectFit;
    
    self.myImageView.backgroundColor = [UIColor clearColor];
    [self.myRow1View addSubview:self.myImageView];
    
    self.myNameLabel = [self getLabel:CGRectMake(KLeftOffset+im_W+10, 0, frame.size.width-KLeftOffset*2-im_W-10, 60)];
    self.myNameLabel.numberOfLines = 3;
    self.myNameLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.myNameLabel.textColor = [UIColor blackColor];
    [self.myRow1View addSubview:self.myNameLabel];
    
    self.myPriceLabel = [self getLabel:CGRectMake(KLeftOffset+im_W+10, 60, frame.size.width-KLeftOffset*2-im_W, 30)];
    self.myPriceLabel.text = @"指导价：";
    self.myPriceLabel.textColor = RGBCOLOR(202, 202, 202);
    self.myPriceLabel.font = [UIFont systemFontOfSize:14];
    [self.myRow1View addSubview:self.myPriceLabel];
    
    self.myPrice2Label = [self getLabel:CGRectMake(KLeftOffset+im_W+70, 60, frame.size.width-KLeftOffset*2-im_W-10, 30)];
    self.myPrice2Label.textColor = [UIColor redColor];
//    [self.myRow1View addSubview:self.myPrice2Label];
    
    self.myLine1View = [self getLineView:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
//    [self.myRow1View addSubview:self.myLine1View];
}

-(void)initRow2View:(CGRect)frame
{
    self.myRow2View = [[UIView alloc]initWithFrame:frame];
    [self addSubview:self.myRow2View];
    
    self.myPolicyLabel = [self getLabel:CGRectMake(KLeftOffset, (frame.size.height-30)/2, 150, 30)];
    self.myPolicyLabel.text = @"选择租购政策";
    [self.myRow2View addSubview:self.myPolicyLabel];
    
    self.myPolicyContentLabel = [self getLabel:CGRectMake(KLeftOffset+150+10, (frame.size.height-30)/2, frame.size.width-KLeftOffset*2-150-20, 30)];
    self.myPolicyContentLabel.textColor = RGBCOLOR(202, 202, 202);
    self.myPolicyContentLabel.textAlignment = UITextAlignmentRight;
    [self.myRow2View addSubview:self.myPolicyContentLabel];
    
    UIImage* tempIcon = [UIImage imageNamed:@"详情右.png"];
    self.myRightIconView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-KLeftOffset-tempIcon.size.width, (frame.size.height-tempIcon.size.height)/2, tempIcon.size.width, tempIcon.size.height)];
    self.myRightIconView.image = tempIcon;
    [self.myRow2View addSubview:self.myRightIconView];
    
    self.myLine2View = [self getLineView:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
    [self.myRow2View addSubview:self.myLine2View];
    
    self.mySeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mySeleteBtn addTarget:self action:@selector(seletePolicyBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.mySeleteBtn.frame = frame;
    [self.myRow2View addSubview:self.mySeleteBtn];
}

-(UILabel*)getLabel:(CGRect)frame
{
    UILabel* tempLabel = [[UILabel alloc]initWithFrame:frame];
    [tempLabel setBackgroundColor:[UIColor clearColor]];
    [tempLabel setFont:[UIFont systemFontOfSize:14]];
    [tempLabel setTextColor:RGBCOLOR(102, 102, 102)];
    return tempLabel;
}

-(UIImageView*)getLineView:(CGRect)frame
{
    UIImageView* tempLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, frame.origin.y+frame.size.height-1, frame.size.width, 1)];
    [tempLine setBackgroundColor:RGBCOLOR(186, 186, 187)];
    return tempLine;
}

-(void)updateData:(M_CarItemModel*)model withCarType:(TCarBottomType)type
{
    self.carType = type;
    
    if (model!=nil) {
        
        self.myItemModel = model;
        
        if ([model.myCar_Img notEmpty]) {
            [self.myImageView setImageWithURL:[NSURL URLWithString:model.myCar_Img] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
        }
        
        if ([model.myBrand_Name notEmpty] && [model.mySubbrand_Name notEmpty] && [model.myCar_Year notEmpty] && [model.myCar_Name notEmpty]) {
            self.myNameLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",model.myBrand_Name,model.mySubbrand_Name,model.myCar_Year,model.myCar_Name];
        }
        
        if([model.myCar_Price notEmpty]){
            self.myPriceLabel.text = [NSString stringWithFormat:@"指导价%@万元",model.myCar_Price];
        }
        
        if (carType == EB_RentaiCar) {
            self.myRow2View.hidden = NO;
        }else{
            self.myRow2View.hidden = YES;
        }
    }
}

-(void)seletePolicyBtnPressed:(id)sender
{
    if (self.block!=nil) {
        self.block(7,nil);
    }
}

-(void)updateContent:(id)data withTag:(NSInteger)tag
{
    switch (tag) {
        case 7://portiy
            
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
