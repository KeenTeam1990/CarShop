//
//  LL_PriceAndPriceDemoView.m
//  DHCarForSales
//
//  Created by leiyu on 15/12/23.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "LL_PriceAndPriceDemoView.h"
#import "LL_GiftView.h"
#define edge 10
#define cellLableTextChange 14
#define cellLableTextSize 12

@interface LL_PriceAndPriceDemoView ()
AS_MODEL_STRONG(UIImageView, myBackImageView);
AS_MODEL_STRONG(UILabel, myPriceLable)
AS_MODEL_STRONG(UILabel, myPriceDemoLable);
AS_MODEL_STRONG(UILabel, myPriceDemo);
AS_MODEL_STRONG(UILabel, myBoolCanGavePriceLable);
AS_MODEL_STRONG(NSString, myPriceLableDemoText);
AS_MODEL_STRONG(LL_GiftView, myGiftView);
@end
@implementation LL_PriceAndPriceDemoView
DEF_MODEL(myPriceLable);
DEF_MODEL(myPriceDemoLable);
DEF_MODEL(myBoolCanGavePriceLable);
DEF_MODEL(myPriceDemo)
DEF_MODEL(myPriceLableDemoText);
DEF_MODEL(myGiftView);

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initMyBackImageViewWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self initMyPriceLableWithFrame:CGRectMake(edge, edge, self.bounds.size.width, 25)];
        
        [self initMyBoolCanGavePriceLableWithFrame:CGRectMake(CGRectGetMinX(self.myPriceLable.frame), CGRectGetMaxY(self.myPriceLable.frame), 200, 20)];
        
        [self  initMyPriceDemoWithFrame:CGRectMake(CGRectGetMinX(self.myPriceLable.frame), CGRectGetMaxY(self.myBoolCanGavePriceLable.frame)+edge, self.bounds.size.width-edge*2, 20)];
        
        [self initMyPriceDemoLableWithFrame:CGRectMake(edge, CGRectGetMaxY(self.myPriceDemo.frame)+5, self.bounds.size.width-2*edge,30 )];
         [self initMyGiftViewWithFrame:CGRectMake(CGRectGetMinX(self.myPriceDemoLable.frame), CGRectGetMaxY(self.myPriceDemoLable.frame), self.bounds.size.width-2*edge, 0)];
    }
    return self;
}
-(void)initMyBackImageViewWithFrame:(CGRect)frame
{
    self.myBackImageView = [[UIImageView alloc]initWithFrame:frame];
    self.myBackImageView.image = [[UIImage imageNamed:@"order_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 10, 20, 10)];
    [self addSubview:self.myBackImageView];
}
-(void)initMyPriceLableWithFrame:(CGRect)frame
{
    self.myPriceLable = [[UILabel alloc]initWithFrame:frame];
    self.myPriceDemoLable.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.myPriceLable];
    
}
-(void)initMyBoolCanGavePriceLableWithFrame:(CGRect)frame
{
    self.myBoolCanGavePriceLable = [[UILabel alloc]initWithFrame:frame];
    self.myBoolCanGavePriceLable.textColor = [Unity getColor:@"#666666"];
    [self addSubview:self.myBoolCanGavePriceLable];
    self.myBoolCanGavePriceLable.font = [UIFont systemFontOfSize:12];
    self.myBoolCanGavePriceLable.textAlignment = NSTextAlignmentLeft;
    
}
-(void)initMyPriceDemoWithFrame:(CGRect)frame
{
    self.myPriceDemo = [[UILabel alloc]initWithFrame:frame];
    self.myPriceDemo.textColor = [Unity getColor:@"#2e2e2e"];
    self.myPriceDemo.font = [UIFont systemFontOfSize:12];
   
    self.myPriceDemoLable.textAlignment = NSTextAlignmentLeft;
    self.myPriceDemo.text = @"报价说明";
    [self addSubview:self.myPriceDemo];
}
-(void)initMyPriceDemoLableWithFrame:(CGRect)frame
{
    self.myPriceDemoLable = [[UILabel alloc]initWithFrame:frame];
    self.myPriceDemoLable.textColor = [Unity getColor:@"#777777"];
    self.myPriceDemoLable.numberOfLines = 0;
    self.myPriceDemoLable.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.myPriceDemoLable];
}
-(void)initMyGiftViewWithFrame:(CGRect)frame
{
    self.myGiftView = [[LL_GiftView alloc]initWithFrame:frame];
    [self addSubview:self.myGiftView];
}
-(void)layoutSubviews
{
//    [super layoutSubviews];
//    CGFloat boundWidth = self.bounds.size.width;
//    CGRect tempFrame = self.myPriceDemoLable.frame;
//    tempFrame.size.width = boundWidth - edge-edge;
//    self.myPriceDemoLable.frame = tempFrame;
//    
//   
//    
//    tempFrame = self.myBoolCanGavePriceLable.frame;
//    tempFrame.size.width = boundWidth -edge -edge;
//    self.myBoolCanGavePriceLable.frame = tempFrame;
    
    //还需计算高度
//    CGFloat LabelHeight = [Unity getLabelHeightWithWidth:boundWidth-edge-edge andDefaultHeight:30 andFontSize:cellLableTextSize andText:self.myPriceLableDemoText];
//    tempFrame = self.myPriceDemoLable.frame ;
//    tempFrame.size.width = boundWidth -edge -edge;
//    tempFrame.size.height =LabelHeight;
//    self.myPriceDemoLable.frame = tempFrame;
    
    
//    tempFrame = self.myBackImageView.frame;
//    tempFrame.size.width = boundWidth;
//    tempFrame.size.height =CGRectGetMaxY(self.myPriceDemoLable.frame);
//    self.myBackImageView.frame = tempFrame;
//    tempFrame = [self frame];
//    tempFrame.size.height = CGRectGetMaxY(self.myPriceDemoLable.frame);
//    self.frame = tempFrame;
}
-(void)updataWithPrice:(NSString *)price priceDemo:(NSString *)priceDemo andType:(BOOL)endPrice andWithGiftArr:(NSMutableArray *)arr
{
    self.myPriceLableDemoText = priceDemo;
    if(endPrice == NO){
        NSString *textStr = [NSString stringWithFormat:@"首次报价：%@万",price];
        NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc]initWithString:textStr];
        [attstr addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"#999999"] range:NSMakeRange(0, textStr.length)];
        self.myPriceLable.attributedText = attstr;
        [attstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:cellLableTextChange] range:NSMakeRange(0, 5)];
        [attstr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:cellLableTextChange] range:NSMakeRange(5, price.length+1)];
        
        self.myBoolCanGavePriceLable.text = @"销售顾问还有机会给你最总报价";
        self.myBoolCanGavePriceLable.hidden = NO;
        CGRect tempFrame = self.myPriceDemo.frame;
        tempFrame.origin.y = CGRectGetMaxY(self.myPriceLable.frame)+20;
        self.myPriceDemo.frame = tempFrame;
        self.myPriceDemo.text = @"报价说明:";
        
    }
    else
    {
        NSString *textStr = [NSString stringWithFormat:@"最终报价：%@万",price];
        NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc]initWithString:textStr];
        [attstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:cellLableTextChange] range:NSMakeRange(0, 5)];
        [attstr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:cellLableTextChange] range:NSMakeRange(5, price.length+1)];
        [attstr addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"#f81d25"] range:NSMakeRange(0, textStr.length)];
        self.myPriceLable.attributedText = attstr;
        
        self.myBoolCanGavePriceLable.hidden = YES;
        
        CGRect tempFrame = self.myPriceDemo.frame;
        tempFrame.origin.y = CGRectGetMaxY(self.myPriceLable.frame);
        self.myPriceDemo.frame = tempFrame;
        self.myPriceDemo.text = @"报价说明:";
    }
    
    [self.myGiftView upDataWithDataArray:arr];
    
    CGFloat labelHeight = [Unity getLabelHeightWithWidth:self.bounds.size.width-edge*2 andDefaultHeight:30 andFontSize:cellLableTextSize andText:priceDemo];
    
    CGRect tempFrame = self.myPriceDemoLable.frame;
    tempFrame.origin.y = CGRectGetMaxY(self.myPriceDemo.frame);
    tempFrame.size.height = labelHeight;
    self.myPriceDemoLable.frame = tempFrame;
    self.myPriceDemoLable.text = priceDemo;
    
    tempFrame = self.myGiftView.frame;
    tempFrame.origin.y = CGRectGetMaxY(self.myPriceDemoLable.frame)-10;
    tempFrame.size.height = (arr.count+1)*20;
    self.myGiftView.frame = tempFrame;
    
    tempFrame = self.myBackImageView.frame;
    tempFrame.size.height = CGRectGetMaxY(self.myGiftView.frame)+30;
    self.myBackImageView.frame = tempFrame;
}

@end
