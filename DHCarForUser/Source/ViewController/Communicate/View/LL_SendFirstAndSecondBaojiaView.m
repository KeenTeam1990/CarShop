//
//  LL_SendFirstAndSecondBaojiaView.m
//  DHCarForSales
//
//  Created by leiyu on 15/12/20.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "LL_SendFirstAndSecondBaojiaView.h"
//#import "UIImageView+AFNetworking.h"
#define edgt 10
#define CarImageViewWidth 70
#define CarImageViewHeight 60
#define MyPriceLableSize 14
#define MyPriceDemoLableSize 12


@interface LL_SendFirstAndSecondBaojiaView()
AS_FACTORY(LL_SendFirstAndSecondBaojiaView);
AS_MODEL_STRONG(UIView, myUpView);
AS_MODEL_STRONG(UIImageView, myCarImageView);
AS_MODEL_STRONG(UILabel, myPriceLable);//报价价格
AS_MODEL_STRONG(UILabel, myPriceDemoLable);//报价说明

AS_MODEL_STRONG(UIView, myFootView);
AS_MODEL_STRONG(UILabel, myLookDetailLable);
AS_MODEL_STRONG(UIButton,myLookDetailButton);

@end
@implementation LL_SendFirstAndSecondBaojiaView
DEF_FACTORY(LL_SendFirstAndSecondBaojiaView)
DEF_MODEL(myUpView);
DEF_MODEL(myCarImageView);
DEF_MODEL(myPriceLable);
DEF_MODEL(myPriceDemoLable);

DEF_MODEL(myFootView);
DEF_MODEL(myLookDetailLable);
DEF_MODEL(myLookDetailButton);

DEF_MODEL(myModel);

DEF_MODEL(myLookDetailBlock);
-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        [self initWithMyUpViewWithFrame:CGRectMake(0, 0, self.bounds.size.width, CarImageViewHeight+20)];
        [self initWithFootViewWithFrame:CGRectMake(0, MAX(CGRectGetMaxY(self.myCarImageView.frame)+10, CGRectGetMaxY(self.myPriceDemoLable.frame)), self.bounds.size.width, 30)];
    }
    return self;
}
-(void)initWithMyUpViewWithFrame:(CGRect)frame
{
    self.myUpView = [[UIView alloc]initWithFrame:frame];
    self.myUpView.userInteractionEnabled = NO;
    [self addSubview:self.myUpView];
    
    self.myCarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(edgt, 0,CarImageViewWidth,CarImageViewHeight)];
    self.myCarImageView.image = [UIImage imageNamed:@"tempcar.jpg"];
    [self.myUpView addSubview:self.myCarImageView];
    
    self.myPriceLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.myCarImageView.frame)+edgt, CGRectGetMinY(self.myCarImageView.frame), frame.size.width-edgt -CarImageViewWidth-edgt-edgt, 20)];
    self.myPriceLable.textColor = [UIColor redColor];
    self.myPriceLable.textAlignment = NSTextAlignmentLeft;
    self.myPriceLable.font = [UIFont systemFontOfSize:MyPriceLableSize];
    [self.myUpView addSubview:self.myPriceLable];
    
    self.myPriceDemoLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.myPriceLable.frame), CGRectGetMaxY(self.myPriceLable.frame), frame.size.width-edgt -CarImageViewWidth-edgt-edgt, 40)];
    self.myPriceDemoLable.font = [UIFont systemFontOfSize:MyPriceDemoLableSize];
    self.myPriceDemoLable.textColor = [UIColor blackColor];
    self.myPriceDemoLable.numberOfLines = 2 ;
    [self.myUpView addSubview:self.myPriceDemoLable];
}

-(void)initWithFootViewWithFrame:(CGRect)frame
{
    self.myFootView = [[UIView alloc]initWithFrame:frame];
    self.myFootView.userInteractionEnabled = NO;
    [self addSubview:self.myFootView];
    
    self.myLookDetailLable = [[UILabel alloc]initWithFrame:CGRectMake(edgt, 0, 100, frame.size.height)];
    self.myLookDetailLable.textColor = [UIColor blackColor];
    self.myLookDetailLable.text = @"查看详情";
    self.myLookDetailLable.font = [UIFont systemFontOfSize:12];
    [self.myFootView addSubview:self.myLookDetailLable];
    
    UIImage *tempImage = [UIImage imageNamed:@"详情右"];
    
    self.myLookDetailButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width-edgt-tempImage.size.width, 7, tempImage.size.width, tempImage.size.height)];
    [self.myLookDetailButton setBackgroundImage:tempImage forState:UIControlStateNormal];
    self.myLookDetailButton.selected = NO;
    [self.myFootView addSubview:self.myLookDetailButton];
    self.myFootView .backgroundColor = [Unity getColor:@"#e0e0e0"];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat bounsWidth = self.frame.size.width;
    CGRect tempFrame = self.frame;
    tempFrame.size.width = bounsWidth;
    self.frame = tempFrame;
    
    tempFrame = self.myUpView.frame;
    tempFrame.size.width = bounsWidth;
    self.myUpView.frame = tempFrame;
    
    tempFrame = self.myFootView.frame ;
    tempFrame.size.width = bounsWidth ;
    self.myFootView.frame = tempFrame;
    
    tempFrame = self.myPriceLable.frame ;
    tempFrame.size.width = bounsWidth-edgt -CarImageViewWidth-edgt-edgt;
    self.myPriceLable.frame = tempFrame;
    
    tempFrame = self.myPriceDemoLable.frame ;
    tempFrame.size.width = bounsWidth-edgt -CarImageViewWidth-edgt-edgt;
    self.myPriceDemoLable.frame = tempFrame;
    
     UIImage *tempImage = [UIImage imageNamed:@"详情右"];
    tempFrame = self.myLookDetailButton .frame;
    tempFrame.origin.x = bounsWidth-tempImage.size.width;
    self.myLookDetailButton.frame = tempFrame;
    
    tempFrame = [self frame];
    tempFrame.size.height = CGRectGetMaxY(self.myLookDetailLable.frame);
    self.frame = tempFrame;
}
-(void)updataModel:(M_MyMessageItemModel *)model1
{
    self.myModel = model1;
    
    self.myPriceLable.text = @"";
    self.myPriceDemoLable.text = @"";
    self.myCarImageView.image = [UIImage imageNamed:@"tempcar.jpg"];
    
    if ([model1.myType notEmpty]) {
        if ([model1.myType isEqualToString:@"80"]) {
            self.myPriceLable.text = model1.myCardDesc;//[NSString stringWithFormat:@"首次报价%@万",model1.myCardDesc];
            [ self.myCarImageView setImageWithURL:[NSURL URLWithString:self.myModel.myCardCarImg] placeholderImage:[UIImage imageNamed:@"carPleaceHoldImage"]];
//            self.myPriceDemoLable.text = model1.myCardInfo;
            self.myPriceLable.text = [NSString stringWithFormat:@"%@万元",model1.myCardInfo];//[NSString stringWithFormat:@"报价说明:%@",self.myModel.carFirstPriceDemo];
        }else if ([model1.myType isEqualToString:@"81"]){
//            self.myPriceLable.text = model1.myCardDesc;
            self.myPriceLable.text = [NSString stringWithFormat:@"%@万元",model1.myCardDesc];;//[NSString stringWithFormat:@"最终报价%@万",model1.carLastPrice];
            [ self.myCarImageView setImageWithURL:[NSURL URLWithString:self.myModel.myCardCarImg] placeholderImage:[UIImage imageNamed:@"carPleaceHoldImage"]];
            self.myPriceDemoLable.text = model1.myCardInfo;//[NSString stringWithFormat:@"报价说明:%@",self.myModel.carLastPriceDemo];
        }
    }
}

@end
