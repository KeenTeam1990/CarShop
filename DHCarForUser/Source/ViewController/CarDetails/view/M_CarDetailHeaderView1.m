//
//  M_CarDetailHeaderView1.m
//  DHCarForUser
//
//  Created by 陈斌 on 16/1/14.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "M_CarDetailHeaderView1.h"
#import "M_SpikeListModel.h"
#import "M_CarImagesView.h"


#define KLeftOffset 20

@interface M_CarDetailHeaderView1 ()

AS_MODEL_STRONG(M_CarImagesView, myImagesView);
AS_MODEL_STRONG(UILabel, myNameLabel);
AS_MODEL_STRONG(UIImageView, myLine1View);
AS_MODEL_STRONG(UIImageView, myLine2View);
AS_MODEL_STRONG(UIImageView, myLine3View);
AS_MODEL_STRONG(UILabel, myPriceLabel);
AS_MODEL_STRONG(UILabel, myGuidePriceLabel);

AS_MODEL_STRONG(UILabel, myDepositLabel);

AS_MODEL_STRONG(UIView, myParameterView);

AS_MODEL_STRONG(UIButton, myDiscasdPrice);

@end

@implementation M_CarDetailHeaderView1

DEF_FACTORY_FRAME(M_CarDetailHeaderView1);

DEF_MODEL(myDepositLabel);
DEF_MODEL(myGuidePriceLabel);
DEF_MODEL(myImagesView);
DEF_MODEL(myLine1View);
DEF_MODEL(myLine2View);
DEF_MODEL(myNameLabel);
DEF_MODEL(myPriceLabel);
DEF_MODEL(myParameterView);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setClipsToBounds:YES];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        NSInteger imageheight = 220;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            imageheight = 440;
        }
        
        [self initImagesView:CGRectMake(0, 0, frame.size.width, imageheight)];
        
        [self initNameView:CGRectMake(0, imageheight, frame.size.width, 40)];
        
        [self initDepositView:CGRectMake(0, imageheight+40, frame.size.width, 50)];
        
        [self initParameterView:CGRectMake(0, imageheight+90, frame.size.width, 30)];
        
        self.myLine3View = [[UIImageView alloc]initWithFrame:CGRectMake(0, imageheight+120, frame.size.width, 1)];
        [self.myLine3View setBackgroundColor:RGBCOLOR(186, 186, 187)];
        [self addSubview:self.myLine3View];
        
        self.myLine2View = [[UIImageView alloc]initWithFrame:CGRectMake(0, imageheight+121, frame.size.width, 10)];
        [self.myLine2View setBackgroundColor:RGBCOLOR(202, 202, 202)];//
        [self addSubview:self.myLine2View];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

-(UILabel*)getParameter:(CGRect)frame withView:(UIView*)view
{
    UILabel* tempLabel = [[UILabel alloc]initWithFrame:frame];
    [tempLabel setBackgroundColor:[UIColor clearColor]];
    [tempLabel setTextColor:RGBCOLOR(103, 102, 102)];
    [tempLabel setFont:[UIFont systemFontOfSize:14]];
    
    [view addSubview:tempLabel];
    return tempLabel;
}

-(void)initImagesView:(CGRect)frame
{
    self.myImagesView = [M_CarImagesView allocInstanceFrame:frame];
    [self.myImagesView setClipsToBounds:YES];
    [self addSubview:self.myImagesView];
}

-(void)initNameView:(CGRect)frame
{
    self.myNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(KLeftOffset, frame.origin.y, frame.size.width-KLeftOffset*2, frame.size.height)];
    [self.myNameLabel setBackgroundColor:[UIColor clearColor]];
    [self.myNameLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [self.myNameLabel setTextColor:[UIColor blackColor]];
    self.myNameLabel.numberOfLines = 3;
    [self addSubview:self.myNameLabel];
}

-(void)initParameterView:(CGRect)frame
{
    self.myParameterView = [[UIView alloc]initWithFrame:frame];
    [self.myParameterView setBackgroundColor:RGBCOLOR(234, 234, 234)];
    [self addSubview:self.myParameterView];
    
    self.myDiscasdPrice = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myDiscasdPrice.frame = CGRectMake(10, 0, self.myParameterView.frame.size.width, 30);
    self.myDiscasdPrice.userInteractionEnabled = NO;
    [self.myDiscasdPrice setImage:[UIImage imageNamed:@"icon_sound2.png"] forState:UIControlStateNormal];
    [self.myDiscasdPrice.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.myDiscasdPrice setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.myDiscasdPrice setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.myParameterView addSubview:self.myDiscasdPrice];
}

-(void)initDepositView:(CGRect)frame
{
    self.myDepositLabel = [self getParameter:CGRectMake(KLeftOffset, frame.origin.y, 50, frame.size.height) withView:self];
    [self.myDepositLabel setTextColor:[UIColor redColor]];
    
    self.myPriceLabel = [self getParameter:CGRectMake(KLeftOffset+70, frame.origin.y, ScreenWidth-KLeftOffset-70, frame.size.height) withView:self];
    [self.myPriceLabel setTextColor:[UIColor redColor]];
    [self.myPriceLabel setFont:[UIFont boldSystemFontOfSize:15]];
    self.myPriceLabel.textAlignment = NSTextAlignmentLeft;
    
    self.myLine1View = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2, frame.origin.y+10, 1, 30)];
    [self.myLine1View setBackgroundColor:RGBCOLOR(186, 186, 187)];
    [self addSubview:self.myLine1View];
    
    self.myGuidePriceLabel = [self getParameter:CGRectMake(self.myLine1View.frame.origin.x+20, frame.origin.y, frame.size.width/2-KLeftOffset, frame.size.height) withView:self];
}

-(void)updateData:(M_SpikeItemModel *)data
{
    if (data!=nil) {
        
        if ([data.myBrand_Name notEmpty] && [data.mySubbrand_Name notEmpty] && [data.myCar_Year notEmpty] &&[data.myCar_Name notEmpty]) {
            
                self.myNameLabel.text =[NSString stringWithFormat:@"%@ %@ %@款 %@",data.myBrand_Name,data.mySubbrand_Name,data.myCar_Year,data.myCar_Name] ;
        }
      
        NSMutableArray *imageCarArray = [[NSMutableArray alloc]init];
        [imageCarArray addObject:data.myCar_Img];
        if ([imageCarArray count]>0) {
            [self.myImagesView upDateData:imageCarArray];
        }else{
            [self.myImagesView upDateData:[NSMutableArray arrayWithObjects:@"1", nil]];
        }
        
        if ([data.spike_price notEmpty]) {
            self.myPriceLabel.text = [NSString stringWithFormat:@"%@万元",data.spike_price];;
        }

        self.myDepositLabel.text = @"秒拍价";
        
        if ([data.myCar_Price notEmpty]) {
            
            float downPrice = [data.myCar_Price floatValue] - [data.spike_price floatValue];
            
            self.myGuidePriceLabel.text = [NSString stringWithFormat:@"指导价%@万元",data.myCar_Price];
        }
        
        if ([data.myCar_Deposit notEmpty]) {
            [self.myDiscasdPrice setTitle:[NSString stringWithFormat:@"订金：%@元",data.myCar_Deposit] forState:UIControlStateNormal];
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
