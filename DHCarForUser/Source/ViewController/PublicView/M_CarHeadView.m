//
//  LL_CarHeadView.m
//  DHCarForSales
//
//  Created by leiyu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarHeadView.h"
#import "LLLable.h"
//#import "M_UserModel.h"



#define carLogoImageViewHeight 70
#define carLogoImageViewWidth 80
#define edge 10


@interface M_CarHeadView()

@property(nonatomic,strong)UIImageView *carLogoImageView;

@property(nonatomic,strong)LLLable *carNameLable;

//@property(nonatomic,strong)LLLable *carDescriptionLable;

@property(nonatomic,strong)LLLable *carColorLable;

@property(nonatomic,strong)UILabel *myPriceLable;

AS_MODEL_STRONG(UIButton, mySendLastPriceButton);

@end

@implementation M_CarHeadView
DEF_MODEL(myBlock);

DEF_MODEL(mySendLastPriceButton);

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [Unity getColor:@"#ffffff"];
        [self initWithCarLogoImageView];
        [self initWithCarNalemLable];
        [self initWithCarDescription];
        [self initWithMyPriceLable];
        [self initWithCarColorLable];
        [self initWithMySendLastPriceButton];
    }
    return self;
}
-(void)initWithCarLogoImageView
{
    _carLogoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(edge, edge, carLogoImageViewWidth,carLogoImageViewHeight)];
    _carLogoImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self addSubview:_carLogoImageView];
}
-(void)initWithCarNalemLable
{
    _carNameLable=[LLLable  labelWithBoldColor:[Unity getColor:@"#000000"] andTextFont:14];
    _carNameLable.frame = CGRectMake(CGRectGetMaxX(_carLogoImageView.frame)+edge, 20, 200,40);
    _carNameLable.numberOfLines = 2;
    
    [self addSubview:_carNameLable];
}
-(void)initWithCarDescription
{
//    _carDescriptionLable=[LLLable labelWithColor:[Unity getColor:@"#000000"] andTextFont:cellLableTextSize];
//    _carDescriptionLable.frame = CGRectMake(CGRectGetMinX(_carNameLable.frame), 20+20, self.bounds.size.width -edge -carLogoImageViewWidth-edge-20, 20);
//    [self addSubview:_carDescriptionLable];
}
-(void)initWithCarColorLable
{
    _carColorLable=[LLLable labelWithBoldColor:[Unity getColor:@"f72b34"] andTextFont:12];
    _carColorLable .frame = CGRectMake(CGRectGetMinX(_carNameLable.frame), 20+20+20, self.bounds.size.width -edge -carLogoImageViewWidth-edge-20, 20);
    _carColorLable.attributedText = NSTextAlignmentLeft;
    [self addSubview:_carColorLable];
}
-(void)initWithMyPriceLable
{
    _myPriceLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_carNameLable.frame), CGRectGetMaxY(_carNameLable.frame), 150, 20)];
    _myPriceLable.font = [UIFont systemFontOfSize:12];
    _myPriceLable.attributedText = NSTextAlignmentLeft;
    [self addSubview:_myPriceLable];
}
-(void)initWithMySendLastPriceButton
{
    self.mySendLastPriceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mySendLastPriceButton setTitle: @"发送最终报价" forState:UIControlStateNormal];
    [self.mySendLastPriceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.mySendLastPriceButton.frame = CGRectMake(CGRectGetMinX(self.carLogoImageView.frame), CGRectGetMaxY(self.carLogoImageView.frame)+edge, self.bounds.size.width-10-10, 30);
    [self.mySendLastPriceButton setBackgroundImage:[[UIImage imageNamed:@"btn_login@2x"]resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    [self addSubview:self.mySendLastPriceButton];
    
    [self.mySendLastPriceButton addTarget:self action:@selector(goButtonCation) forControlEvents:UIControlEventTouchDown];
    
}
-(void)goButtonCation
{
    
    if (self.myBlock != nil) {
        self.myBlock();
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat boundWidth = self.bounds.size.width;
    CGRect tempFrame = _carNameLable.frame;
    tempFrame.size.width = boundWidth -10 -80-10-20;
    _carNameLable.frame = tempFrame;
    
//    tempFrame = _carDescriptionLable.frame;
//    tempFrame.size.width = boundWidth-10 -80-10-20 ;
//    _carDescriptionLable.frame = tempFrame;
    
    tempFrame = _carColorLable.frame ;
    tempFrame.size.width = boundWidth-10 -80-10-20;
    _carColorLable.frame = tempFrame;
    
    tempFrame = self.mySendLastPriceButton.frame ;
    tempFrame.size.width = boundWidth-10-10;
    self.mySendLastPriceButton.frame = tempFrame;
    
}

-(void)upDataCarName:(NSString *)carname  andCarDescription:(NSString *)carDescription andCarFirstPrice:(NSString *)carFirstPrice andCarColor:(NSString *)carColor  andCarLogImageName:(NSString *)carLogeImageName andWithHeadViewType:(MyCarHeadViewType )type
{
    self.carNameLable.hidden = YES;
    self.carLogoImageView.hidden = YES;
    self.carColorLable.hidden = YES;
//    self.carDescriptionLable.hidden = YES;
    self.myPriceLable.hidden = YES;
    self.mySendLastPriceButton.hidden = YES;
    if ([carLogeImageName isUrl]) {
        self.carLogoImageView.hidden = NO;
        [_carLogoImageView setImageWithURL:[NSURL URLWithString:carLogeImageName] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
    }
    else
    {
        self.carLogoImageView.hidden = NO;
        _carLogoImageView.image = [UIImage imageNamed:@"tempcar"];
    }
    if ([carname isEqualToString:@""]) {
        self.carNameLable.hidden = YES;
    }
    else{
         self.carNameLable.hidden = NO;
        self.carNameLable.text = carname;
    }
    if ([carDescription isEqualToString:@""]) {
//        self.carDescriptionLable.hidden = YES;
    }
    else
    {
//        self.carDescriptionLable.hidden = NO;
//        self.carDescriptionLable.text = carDescription;
    }
    if ([carColor isEqualToString:@""]) {
        _carColorLable.hidden = YES;
    }
    else
    {
        _carColorLable.hidden = NO;
        _carColorLable.text = carColor;
    }
   
    
    if (type == LL_MyCarHeadViewHaveColorType) {
        self.carLogoImageView.hidden = NO;
        self.carNameLable.hidden = NO;
//        self.carDescriptionLable.hidden = NO;
        self.myPriceLable.hidden = YES;
        self.carColorLable.hidden = NO;
        self.mySendLastPriceButton.hidden = YES;
    }
    if (type == LL_MyCarHeadViewHasPriceType) {
        self.carLogoImageView.hidden = NO;
        self.carNameLable.hidden = NO;
//        self.carDescriptionLable.hidden = NO;
        self.myPriceLable.hidden = NO;
        self.carColorLable.hidden = YES;
        self.mySendLastPriceButton.hidden = YES;
        
        NSString *priceStr = [NSString stringWithFormat:@"报价报价:%@万",carFirstPrice];
        NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc]initWithString: priceStr];
        [attstr addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"000000"] range:NSMakeRange(0, 5)];
        [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, priceStr.length-5)];
        self.myPriceLable.attributedText = attstr;
        
    }

    if (type == LL_MyCarHeadViewNomalViewType)
    {
        self.carLogoImageView.hidden = NO;
        self.carNameLable.hidden = NO;
//        self.carDescriptionLable.hidden = NO;
        self.myPriceLable.hidden = YES;
        self.carColorLable.hidden = YES;
        self.mySendLastPriceButton.hidden = YES;
    }
     if(type == LL_MyCarHeadViewSendFirstPriceType){
        NSString *priceStr = [NSString stringWithFormat:@"首次报价:%@万",carFirstPrice];
        NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc]initWithString: priceStr];
        [attstr addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"000000"] range:NSMakeRange(0, 5)];
        [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, priceStr.length-5)];
        self.myPriceLable.attributedText = attstr;
        
        
        self.carLogoImageView.hidden = NO;
        self.carNameLable.hidden = NO;
//        self.carDescriptionLable.hidden = NO;
        self.myPriceLable.hidden = NO;
        self.carColorLable.hidden = YES;
        self.mySendLastPriceButton.hidden = NO;
    }
  if(type == LL_MyCarHeadViewSendLastPriceType)
    {
        NSString *priceStr = [NSString stringWithFormat:@"最终报价:%@万",carFirstPrice];
        NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc]initWithString: priceStr];
        [attstr addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"000000"] range:NSMakeRange(0, 5)];
        [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, priceStr.length-5)];
        self.myPriceLable.attributedText = attstr;
        
        self.carLogoImageView.hidden = NO;
        self.carNameLable.hidden = NO;
//        self.carDescriptionLable.hidden = NO;
        self.myPriceLable.hidden = NO;
        self.carColorLable.hidden = YES;
        self.mySendLastPriceButton.hidden = YES;
    }

}

@end
