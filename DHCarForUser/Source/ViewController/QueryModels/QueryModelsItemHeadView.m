//
//  QueryModelsItemHeadView.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/16.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "QueryModelsItemHeadView.h"

#define cellLableTextSize 14
#define KLeftOffset 10

@interface QueryModelsItemHeadView()

AS_MODEL_STRONG(UIImageView, carLogoImageView);

AS_MODEL_STRONG(UILabel, carNameLable);

AS_MODEL_STRONG(UILabel, carColorLabel);

AS_MODEL_STRONG(UILabel, dateLabel);

@end

@implementation QueryModelsItemHeadView

-(id)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self initView];
    }
    return self;
}

-(void)initView
{
    NSInteger tempImageW = self.frame.size.width/2-KLeftOffset*2;
    
    if (IS_SCREEN_35_INCH||IS_SCREEN_4_INCH) {
        tempImageW = 100;
    }
    
    self.carLogoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(KLeftOffset, 5, tempImageW,100)];
    self.carLogoImageView.image = [UIImage imageNamed:@"tempcar.jpg"];
    self.carLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.carLogoImageView];

    self.carNameLable = [[UILabel alloc]initWithFrame:CGRectMake(tempImageW+KLeftOffset*2, 5, self.frame.size.width-tempImageW-KLeftOffset*3, 60)];
    [self.carNameLable setBackgroundColor:[UIColor clearColor]];
    self.carNameLable.font = [UIFont systemFontOfSize:14];
    self.carNameLable.textColor = [UIColor blackColor];
    self.carNameLable.numberOfLines = 2;
    [self addSubview:self.carNameLable];
    
    self.carColorLabel = [[UILabel alloc]initWithFrame:CGRectMake(tempImageW+KLeftOffset*2, 65, 150, 30)];
    [self.carColorLabel setBackgroundColor:[UIColor clearColor]];
    self.carColorLabel.font = [UIFont systemFontOfSize:14];
    self.carColorLabel.textColor = [UIColor redColor];
    [self addSubview:self.carColorLabel];
    
    //时间
    self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width-110), 65, 100, 30)];
    [self.dateLabel setBackgroundColor:[UIColor clearColor]];
    self.dateLabel.font = [UIFont systemFontOfSize:12];
    self.dateLabel.textColor = RGBCOLOR(202, 202, 202);
    self.dateLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.dateLabel];
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    CGRect tempFrame = self.frame;
//    
//    tempFrame.size.width = self.bounds.size.width;
//    self.frame = tempFrame;
    
   // self.dateLabel.frame =tempFrame;
    
}
-(void)updataMOdel:(M_MyOrderTtemModel *)model
{
    if (model!=nil) {
        if (model.car!=nil) {
            if ([model.car.myCar_Img notEmpty]) {
                [self.carLogoImageView setImageWithURL:[NSURL URLWithString:model.car.myCar_Img] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
            }
            
            if ([model.car.myBrand_Name notEmpty] && [model.car.mySubbrand_Name notEmpty]
                && [model.car.myCar_Year notEmpty] && [model.car.myCar_Name notEmpty]) {
              
                self.carNameLable.text =[NSString stringWithFormat:@"%@ %@ %@款 %@",model.car.myBrand_Name,model.car.mySubbrand_Name,model.car.myCar_Year,model.car.myCar_Name] ;
            }
            
            if (model.car.myItemColorModel!=nil) {
                self.carColorLabel.text = model.car.myItemColorModel.myCar_Color_Name;
            }
            
            if ([model.myQuoted_at notEmpty]) {
                self.dateLabel.text = [Unity getTimeFromTimerLong:model.myQuoted_at];
            }
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
