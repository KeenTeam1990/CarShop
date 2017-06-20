
//
//  LL_SendBaoJiaInfoCell.m
//  DHCarForSales
//
//  Created by leiyu on 15/12/20.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "LL_SendBaoJiaInfoCell.h"
#import "LL_SendFirstAndSecondBaojiaView.h"

#define edge 10
#define headViewWidth 50
#define headViewHeight 50

@interface LL_SendBaoJiaInfoCell()

AS_MODEL_STRONG(UILabel, mySendPriceLable);

AS_MODEL_STRONG(LL_SendFirstAndSecondBaojiaView, mySendPriceView);

AS_MODEL_STRONG(UIImageView, myMessageBackIamgeView);
AS_MODEL_STRONG(UIImageView, myTestPostHeadView);

AS_MODEL_STRONG(M_MyMessageItemModel, myModel);

AS_MODEL_STRONG(UIButton, myTouchBtn);

@end

@implementation LL_SendBaoJiaInfoCell

DEF_MODEL(myModel);
DEF_MODEL(myBlock);

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         self.backgroundColor = [UIColor clearColor];
        self.myTestPostHeadView = [[UIImageView alloc]initWithFrame:CGRectMake(edge*2, edge, headViewWidth, headViewHeight)];
         self.myTestPostHeadView .image = [UIImage imageNamed:@"userHead"] ;
        self.myTestPostHeadView.layer.masksToBounds = YES;
        self.myTestPostHeadView.layer.cornerRadius = headViewWidth/2;
        self.myTestPostHeadView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.myTestPostHeadView];
 
        self.myMessageBackIamgeView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.myTestPostHeadView.frame), CGRectGetMinY(self.myTestPostHeadView.frame), self.bounds.size.width -edge -headViewWidth -edge  -20, 110)];
        self.myMessageBackIamgeView.image = [[UIImage imageNamed:@"气泡框左"]resizableImageWithCapInsets:UIEdgeInsetsMake(30, 20, 4, 5)];
        [self.contentView addSubview:self.myMessageBackIamgeView];
        
        self.mySendPriceView = [[LL_SendFirstAndSecondBaojiaView alloc]initWithFrame:CGRectMake(6, 10, self.myMessageBackIamgeView.frame.size.width-6, 110)];
        [self.myMessageBackIamgeView addSubview:self.mySendPriceView];
        
        [self.myTestPostHeadView setUserInteractionEnabled:YES];
        UITapGestureRecognizer* tempsingleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap1:)];
        tempsingleTap.numberOfTapsRequired=1;
        [self.myTestPostHeadView addGestureRecognizer:tempsingleTap];
        
        self.myTouchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.myTouchBtn.frame = self.myMessageBackIamgeView.frame;
        [self.myTouchBtn addTarget:self action:@selector(touchBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.myTouchBtn];
    }
    return self;
}

-(void)touchBtnPressed:(id)sender
{
    if (self.myBlock!=nil) {
        self.myBlock(0,self.myModel);
    }
}

-(void)singleTap1:(UITapGestureRecognizer*)gesture
{
    if (self.myBlock!=nil) {
        self.myBlock(1,self.myModel);
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat boundWidth = self.bounds.size.width;
    CGRect tempFrame = self.myMessageBackIamgeView.frame;
    tempFrame.size.width = boundWidth - edge -headViewWidth -edge -edge -20;
    self.myMessageBackIamgeView.frame = tempFrame;
    
    tempFrame = self.mySendPriceView.frame;
    tempFrame.size.width =self.myMessageBackIamgeView.frame.size.width -7;
    self.mySendPriceView.frame = tempFrame;
    
    tempFrame = self.myMessageBackIamgeView.frame;
    self.myTouchBtn.frame = tempFrame;
    
 
}
-(void)updataItem:(M_MyMessageItemModel *)model
{
    self.myModel = model;
    [self upMySendPriceViewData];
}

-(void)upMySendPriceViewData
{
    [self.mySendPriceView updataModel:self.myModel];
    
    self.myTestPostHeadView.image = [UIImage imageNamed:@"userHead"];
    
    if (self.myModel!=nil) {
        if (self.myModel.myFromModel!=nil) {
            if ([self.myModel.myFromModel.user_photo notEmpty]) {
                [self.myTestPostHeadView setImageWithURL:[NSURL URLWithString:self.myModel.myFromModel.user_photo] placeholderImage:[UIImage imageNamed:@"userHead"]];
            }
        }
    }
}
@end
