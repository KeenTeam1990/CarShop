
//
//  D_LLDetailOrderHeadView.m
//  DHCarForSales
//
//  Created by leiyu on 15/11/15.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_LLDetailOrderHeadView.h"

#import "M_CarDistributorItemView.h"


@interface D_LLDetailOrderHeadView()

AS_MODEL_STRONG(M_MyOrderTtemModel, myItemModel);

AS_MODEL_STRONG(UIView, myCarView);
AS_MODEL_STRONG(UIView, myCodeView);
AS_MODEL_STRONG(UIView, myDealerView);
AS_MODEL_STRONG(UIView, myCertificateView);
AS_MODEL_STRONG(UIView, myOrderView);

AS_MODEL_STRONG(UILabel, myOrderNO);

AS_MODEL_STRONG(UIView, myOrderStatusView);

AS_MODEL_STRONG(UIImageView, myImageView);
AS_MODEL_STRONG(UILabel, myNameLabel);

AS_MODEL_STRONG(UIImageView, myLine1View);
AS_MODEL_STRONG(UIImageView, myLine2View);
AS_MODEL_STRONG(UIImageView, myLine3View);
AS_MODEL_STRONG(UIImageView, myLine4View);
AS_MODEL_STRONG(UIImageView, myLine5View);
AS_MODEL_STRONG(UIImageView, myLine6View);
AS_MODEL_STRONG(UIImageView, myLine7View);
AS_MODEL_STRONG(UIImageView, myLine8View);

AS_MODEL_STRONG(UILabel, myPriceLabel);
AS_MODEL_STRONG(UILabel, myOrderPrice);

AS_MODEL_STRONG(UILabel, myCodeLabel);
AS_MODEL_STRONG(UIButton, myCodeBtn);

AS_MODEL_STRONG(M_CarDistributorItemView, myDealerItemView);

AS_MODEL_STRONG(UILabel, myLastPriceLabel);
AS_MODEL_STRONG(UILabel, myInfoClewLabel);
AS_MODEL_STRONG(UILabel, myInfoLabel);

AS_MODEL_STRONG(UILabel, myCertificateLabel);
AS_MODEL_STRONG(UIImageView, myCertificateImageView);

AS_MODEL_STRONG(UILabel, myOrderMsgLabel);
AS_MODEL_STRONG(UILabel, myOrderCreateLabel);
AS_MODEL_STRONG(UILabel, myOrderUpdateLabel);
AS_MODEL_STRONG(UILabel, myOrderFinishLabel);

AS_MODEL_STRONG(UILabel, myComboLabel);
AS_MODEL_STRONG(UIView, myComboView);

AS_MODEL_STRONG(UIButton, myOpenCallBtn);
@end


@implementation D_LLDetailOrderHeadView

DEF_MODEL(block);

DEF_FACTORY(D_LLDetailOrderHeadView);

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    if (self){
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self initCarView:CGRectMake(0, 0, frame.size.width, 250)];
        
        [self initCodeView:CGRectMake(0, 250, frame.size.width, 50)];
        
        [self initDealerView:CGRectMake(0, 300, frame.size.width, 263)];
        
        [self initCertificateView:CGRectMake(0, 563, frame.size.width, 180)];
        
        [self initOrderMsgView:CGRectMake(0, 692, frame.size.width, 150)];

        [self initStatusView];
    }
    return self;
}

-(void)initCarView:(CGRect)frame
{
    self.myCarView = [[UIView alloc]initWithFrame:frame];
    [self addSubview:self.myCarView];
    
    self.myOrderNO = [self getLabel:CGRectMake(10, 0, self.myCarView.frame.size.width-20, 30) withView:self.myCarView];
    [self.myOrderNO setText:@"订单号:"];
    [self.myOrderNO setTextColor:[UIColor redColor]];
    
    self.myLine1View = [self getLineView:CGRectMake(0, 30, self.myCarView.frame.size.width, 1) withView:self.myCarView];
    
    self.myOrderStatusView = [[UIView alloc]initWithFrame:CGRectMake(0, 31, self.myCarView.frame.size.width, 70)];
    [self.myCarView addSubview:self.myOrderStatusView];
    
    self.myLine2View = [self getLineView:CGRectMake(0, 100, self.myCarView.frame.size.width, 1) withView:self.myCarView];
    
    self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 105, 100, 100)];
    self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.myImageView.image = [UIImage imageNamed:@"tempcar.jpg"];
    [self.myCarView addSubview:self.myImageView];
    
    self.myNameLabel = [self getLabel:CGRectMake(120, 105, self.myCarView.frame.size.width-130, 110) withView:self.myCarView];
    self.myNameLabel.numberOfLines = 3;
    
    self.myPriceLabel = [self getLabel:CGRectMake(self.myCarView.frame.size.width/2, 210, self.myCarView.frame.size.width/2-10, 30) withView:self.myCarView];
    [self.myPriceLabel setTextAlignment:UITextAlignmentRight];
     self.myPriceLabel.textColor = RGBCOLOR(166 , 166, 167);
    
    self.myOrderPrice = [self getLabel:CGRectMake(10, 210, self.myCarView.frame.size.width/2-10, 30) withView:self.myCarView];
    
    self.myLine3View = [self getLineView:CGRectMake(0, 240, self.myCarView.frame.size.width, 10) withView:self.myCarView];
}

-(void)initDealerView:(CGRect)frame
{
    self.myDealerView = [[UIView alloc]initWithFrame:frame];
    [self addSubview:self.myDealerView];
    
    self.myDealerItemView = [M_CarDistributorItemView allocInstanceFrame:CGRectMake(0, 0, self.myDealerView.frame.size.width, 110)];
    self.myDealerItemView.showPrice = NO;
    [self.myDealerView addSubview:self.myDealerItemView];
    
    self.myOpenCallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myOpenCallBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor]; style.borderWidth = 1;
                                                 style.borderColor = [UIColor blackColor];
                                                 style.cornerRedius = 5;);
    self.myOpenCallBtn.tintColor = [UIColor blackColor];
    [self.myOpenCallBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.myOpenCallBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    self.myOpenCallBtn.frame = CGRectMake(self.myDealerItemView.frame.size.width-110, 110-35, 80, 30);
    [self.myOpenCallBtn addTarget:self action:@selector(openCallBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.myOpenCallBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
    self.myOpenCallBtn.userInteractionEnabled = YES;
    [self.myDealerItemView addSubview:self.myOpenCallBtn];
    
    
    
    self.myLine4View = [self getLineView:CGRectMake(0, 110, self.myDealerView.frame.size.width, 1) withView:self.myDealerView];
    
    self.myLastPriceLabel = [self getLabel:CGRectMake(10, 111, self.myDealerView.frame.size.width-20, 40) withView:self.myDealerView];
    self.myLastPriceLabel.textColor = [UIColor redColor];
    
    self.myLine5View = [self getLineView:CGRectMake(0, 151, self.myDealerView.frame.size.width, 1) withView:self.myDealerView];
    
    self.myInfoClewLabel = [self getLabel:CGRectMake(10, 152, self.myDealerView.frame.size.width-20, 30) withView:self.myDealerView];
    
    self.myInfoLabel = [self getLabel:CGRectMake(10, 182, self.myDealerView.frame.size.width-20, 30) withView:self.myDealerView];
    self.myInfoLabel.numberOfLines = 0;
    self.myInfoLabel.lineBreakMode = UILineBreakModeWordWrap;
    
    self.myLine6View = [self getLineView:CGRectMake(0, 212, self.myDealerView.frame.size.width, 1) withView:self.myDealerView];
    
    self.myComboLabel = [self getLabel:CGRectMake(10, 213, self.myDealerView.frame.size.width-20, 30) withView:self.myDealerView];
    
    self.myComboView = [[UIView alloc]initWithFrame:CGRectMake(10, 233, self.myDealerView.frame.size.width, 30)];
    
    [self.myDealerView addSubview:self.myComboView];
    
    self.myLine8View = [self getLineView:CGRectMake(0, 263, self.myDealerView.frame.size.width, 1) withView:self.myDealerView];
}

-(void)initCodeView:(CGRect)frame
{
    self.myCodeView = [[UIView alloc]initWithFrame:frame];
    [self addSubview:self.myCodeView];
    
    self.myCodeLabel = [self getLabel:CGRectMake(10, 0, self.myCodeView.frame.size.width/2, 40) withView:self.myCodeView];
    self.myCodeLabel.textColor = [UIColor blackColor];
    
    self.myCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myCodeBtn.style =DLButtonStyleMake(style.borderColor = [UIColor redColor];
                                            style.borderWidth = 1;
                                            style.cornerRedius = 2;);
    [self.myCodeBtn setTitle:@"重新发码" forState:UIControlStateNormal];
    [self.myCodeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.myCodeBtn addTarget:self action:@selector(codeBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.myCodeBtn.frame = CGRectMake(self.myCodeView.frame.size.width-110, (self.myCodeView.frame.size.height-10-30)/2, 100, 30);
    self.myCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.myCodeView addSubview:self.myCodeBtn];
    
    self.myLine6View = [self getLineView:CGRectMake(0, 40, self.myCodeView.frame.size.width, 10) withView:self.myCodeView];
}

-(void)initCertificateView:(CGRect)frame
{
    self.myCertificateView = [[UIView alloc]initWithFrame:frame];
    [self addSubview:self.myCertificateView];
    
    self.myCertificateLabel = [self getLabel:CGRectMake(10, 0, 100, 30) withView:self.myCertificateView];
    
    self.myCertificateImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 30, self.myCertificateView.frame.size.width-20, 150)];
    self.myCertificateImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.myCertificateView addSubview:self.myCertificateImageView];
    
    self.myLine7View = [self getLineView:CGRectMake(0, 180, self.myCodeView.frame.size.width, 10) withView:self.myCertificateView];
}

-(void)initOrderMsgView:(CGRect)frame
{
    self.myOrderView = [[UIView alloc]initWithFrame:frame];
    [self addSubview:self.myOrderView];
    
    self.myOrderMsgLabel = [self getLabel:CGRectMake(10, 0, self.myOrderView.frame.size.width, 30) withView:self.myOrderView];
    
    self.myOrderCreateLabel = [self getLabel:CGRectMake(10, 30, self.myOrderView.frame.size.width, 30) withView:self.myOrderView];
    self.myOrderCreateLabel.textColor = [UIColor lightGrayColor];
    
    self.myOrderUpdateLabel = [self getLabel:CGRectMake(10, 60, self.myOrderView.frame.size.width, 30) withView:self.myOrderView];
    self.myOrderUpdateLabel.textColor = [UIColor lightGrayColor];
    
    self.myOrderFinishLabel = [self getLabel:CGRectMake(10, 90, self.myOrderView.frame.size.width, 30) withView:self.myOrderView];
    self.myOrderFinishLabel.textColor = [UIColor lightGrayColor];
}

-(UILabel*)getLabel:(CGRect)frame withView:(UIView*)view
{
    UILabel* tempLabel = [[UILabel alloc]initWithFrame:frame];
    tempLabel.font = [UIFont systemFontOfSize:14];
    tempLabel.textColor = [UIColor blackColor];
    [view addSubview:tempLabel];
    return tempLabel;
}

-(UIImageView*)getLineView:(CGRect)frame withView:(UIView*)view
{
    UIImageView* tempView = [[UIImageView alloc]initWithFrame:frame];
    tempView.backgroundColor = RGBCOLOR(232, 232, 232);
    [view addSubview:tempView];
    return tempView;
}

-(void)codeBtnPressed:(id)sender
{
    if (self.block!=nil) {
        self.block(1,self.myItemModel);
    }
}

-(void)initStatusView
{
    UIImage* tempIconarrwo = [UIImage imageNamed:@"status_arrow.png"];
    
    NSInteger w = self.myCarView.frame.size.width/5;
    CGFloat x = 0;
    
    UIButton* tempbtn1 = [self getStatusBtn:CGRectMake(x, 10, w, 50) withView:self.myOrderStatusView withTitle:@"待支付"];
    tempbtn1.tag = 1001;
    
    UIImageView* tempImage = [[UIImageView alloc]initWithFrame:CGRectMake(x+w/2+10, 25, w-20, tempIconarrwo.size.height)];
    tempImage.tag = 2001;
    tempImage.image = [tempIconarrwo resizableImageWithCapInsets:UIEdgeInsetsMake(5, 10, 5, 50)];
    [self.myOrderStatusView addSubview:tempImage];
    
    tempbtn1 = [self getStatusBtn:CGRectMake(x+w, 10, w, 50) withView:self.myOrderStatusView withTitle:@"敬请提车"];
    tempbtn1.tag = 1002;
    
    tempImage = [[UIImageView alloc]initWithFrame:CGRectMake(x+w+w/2+10, 25, w-20, tempIconarrwo.size.height)];
    tempImage.tag = 2002;
    tempImage.image = [tempIconarrwo resizableImageWithCapInsets:UIEdgeInsetsMake(5, 10, 5, 50)];
    [self.myOrderStatusView addSubview:tempImage];
    
    tempbtn1 = [self getStatusBtn:CGRectMake(x+w*2, 10, w, 50) withView:self.myOrderStatusView withTitle:@"等待上传凭证"];
    tempbtn1.tag = 1003;
    
    tempImage = [[UIImageView alloc]initWithFrame:CGRectMake(x+w*2+w/2+10, 25, w-20, tempIconarrwo.size.height)];
    tempImage.tag = 2003;
    tempImage.image = [tempIconarrwo resizableImageWithCapInsets:UIEdgeInsetsMake(5, 10, 5, 50)];
    [self.myOrderStatusView addSubview:tempImage];
    
    tempbtn1 = [self getStatusBtn:CGRectMake(x+w*3, 10, w, 50) withView:self.myOrderStatusView withTitle:@"凭证待审"];
    tempbtn1.tag = 1004;
    
    tempImage = [[UIImageView alloc]initWithFrame:CGRectMake(x+w*3+w/2+10, 25, w-20, tempIconarrwo.size.height)];
    tempImage.tag = 2004;
    tempImage.image = [tempIconarrwo resizableImageWithCapInsets:UIEdgeInsetsMake(5, 10, 5, 50)];
    [self.myOrderStatusView addSubview:tempImage];
    
    tempbtn1 = [self getStatusBtn:CGRectMake(x+w*4, 10, w, 50) withView:self.myOrderStatusView withTitle:@"交易完成"];
    tempbtn1.tag = 1005;
}


-(UIButton*)getStatusBtn:(CGRect)frame withView:(UIView*)view withTitle:(NSString*)text
{
    UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage* tempIcon = [UIImage imageNamed:@"status_grey.png"];
    UIImage* tempIcon_h = [UIImage imageNamed:@"status_red.png"];
    
    [tempBtn setImage:tempIcon forState:UIControlStateNormal];
    [tempBtn setImage:tempIcon_h forState:UIControlStateSelected];
    
    [tempBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [tempBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
    tempBtn.userInteractionEnabled = NO;
    
    [tempBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    tempBtn.frame = frame;
    
    [tempBtn setImageEdgeInsets:UIEdgeInsetsMake(3, (frame.size.width-tempIcon.size.width)/2, 20, 0)];
    
    [tempBtn setTitle:text forState:UIControlStateNormal];
    
    CGSize tempTextW = [text sizeWithFont:[UIFont systemFontOfSize:12] byWidth:frame.size.width];
    
    [tempBtn setTitleEdgeInsets:UIEdgeInsetsMake(frame.size.height-20, (0-tempIcon.size.width)+(frame.size.width-tempTextW.width)/2, 0, 0)];
    
    [tempBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    [view addSubview:tempBtn];
    
    return tempBtn;
}

-(void)updataData:(M_MyOrderTtemModel*)data
{
    M_MyOrderTtemModel* tempModel = data;
    
    if (tempModel!=nil) {
        self.myItemModel = tempModel;
    
        self.myOrderNO.text = @"订单号：";
        
        self.myOrderPrice.text = @"预付订金：";
        self.myPriceLabel.text = @"指导价：";
        self.myOrderMsgLabel.text = @"订单信息";
        self.myCertificateLabel.text = @"凭证信息";
        self.myInfoClewLabel.text = @"报价说明";
        self.myCodeLabel.text = @"校验码：";
        
        self.myLastPriceLabel.text = @"最终报价：";
        self.myComboLabel.text = @"购车大礼包";
    
        self.myComboLabel.hidden = YES;
        self.myComboView.hidden = YES;
        self.myLine8View.hidden = YES;
        self.myLine6View.hidden = YES;
        
        if ([tempModel.order_no notEmpty]) {
            self.myOrderNO.text = [NSString stringWithFormat:@"订单号：%@",tempModel.order_no];
            self.myOrderNO.textColor = [UIColor blackColor];
            NSMutableAttributedString* tempAttr = [[NSMutableAttributedString alloc]initWithString:self.myOrderNO.text];
            
            [tempAttr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 4)];
            
            self.myOrderNO.attributedText = tempAttr;
        }
        
        if (tempModel.car!=nil) {
            
            if ([tempModel.car.myCar_Deposit notEmpty]) {
                self.myOrderPrice.text = [NSString stringWithFormat:@"预付订金：%@元",tempModel.car.myCar_Deposit];
            }
            
            if ([tempModel.car.myCar_Price notEmpty]) {
                self.myPriceLabel.text = [NSString stringWithFormat:@"指导价：%@万",tempModel.car.myCar_Price];
            }
            
            if ([tempModel.car.myCar_Img notEmpty]) {
                [self.myImageView setImageWithURL:[NSURL URLWithString:tempModel.car.myCar_Img] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
            }
            
            if ([tempModel.car.myBrand_Name notEmpty]&& [tempModel.car.mySubbrand_Name notEmpty] && [tempModel.car.myCar_Year notEmpty] && [tempModel.car.myCar_Name notEmpty]) {
                self.myNameLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",tempModel.car.myBrand_Name,tempModel.car.mySubbrand_Name,tempModel.car.myCar_Year,tempModel.car.myCar_Name];
            }
        }
        
        if (tempModel.myDealerModel!=nil) {
            [self.myDealerItemView updateData:tempModel.myDealerModel];
        }
        
        if (tempModel.myCodeModel!=nil && [tempModel.myCodeModel.myCodeStr notEmpty]) {
            self.myCodeLabel.text = [NSString stringWithFormat:@"校验码：%@",tempModel.myCodeModel.myCodeStr];
        }
        
        if (self.myItemModel!=nil) {
            if (self.myItemModel.car!=nil) {
                if (self.myItemModel.car.myCar_New) {
                    
                    self.myInfoClewLabel.hidden = NO;
                    self.myInfoLabel.hidden = NO;
                    self.myLine6View.hidden = NO;
                    
                    if (self.myItemModel.myQuoteModel!=nil) {
                        if ([self.myItemModel.myQuoteModel.myLastPrice notEmpty] && ![self.myItemModel.myQuoteModel.myLastPrice isEqualToString:@"0"]) {
                            
                            self.myLastPriceLabel.text = [NSString stringWithFormat:@"最终报价：%@万元",self.myItemModel.myQuoteModel.myLastPrice];
                            if ([self.myItemModel.myQuoteModel.myLastInfo notEmpty]) {
                                self.myInfoLabel.text = self.myItemModel.myQuoteModel.myLastInfo;
                                
                                NSInteger tempH = [self.myInfoLabel.text sizeWithFont:SYSTEMFONT(14) byWidth:self.myInfoLabel.frame.size.width].height+10;
                                
                                if (tempH < 20) {
                                    tempH = 20;
                                }
                                
                                CGRect tempFrame = self.myInfoLabel.frame;
                                tempFrame.size.height = tempH;
                                self.myInfoLabel.frame = tempFrame;
                                
                                tempFrame = self.myLine6View.frame;
                                tempFrame.origin.y = MaxY(self.myInfoLabel);
                                self.myLine6View.frame = tempFrame;
                                
                            }
                            
                            if ([self.myItemModel.myQuoteModel.myLastComboArray count]>0) {
                                
                                self.myComboLabel.hidden  = NO;
                                self.myComboView.hidden = NO;
                                self.myLine8View.hidden = NO;
                                
                                CGRect tempFrame = self.myComboLabel.frame;
                                tempFrame.origin.y = MaxY(self.myLine6View);;
                                self.myComboLabel.frame = tempFrame;
                                
                                for (int i=0; i<[self.myComboView.subviews count]; i++) {
                                    UIView* tempView=  [self.myComboView.subviews objectAtIndex:i];
                                    if (tempView!=nil) {
                                        [tempView removeFromSuperview];
                                    }
                                }
                                
                                UIImage* tempIcon = [UIImage imageNamed:@"礼包.png"];
                                UIImage* tempIcon2 = [UIImage imageNamed:@"icon_more.png"];
                                
                                NSInteger x = 0;
                                NSInteger y = 0;
                                NSInteger h = 0;
                                NSInteger w = self.myComboView.frame.size.width-tempIcon.size.width-tempIcon2.size.width;
                                
                                NSInteger t_H = 0;
                                
                                
                                for (int i=0; i<[self.myItemModel.myQuoteModel.myLastComboArray count]; i++) {
                                    M_QuoteComboItemModel* tempComboItem = [self.myItemModel.myQuoteModel.myLastComboArray objectAtIndex:i];
                                    if (tempComboItem!=nil) {
                                        
                                        UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                                        
                                        tempBtn.titleLabel.font = SYSTEMFONT(12);
                                        tempBtn.titleLabel.numberOfLines = 0;
                                        tempBtn.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
                                        
                                        [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                        [tempBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                                        [tempBtn setImage:tempIcon forState:UIControlStateNormal];
                                        
                                        [tempBtn addTarget:self action:@selector(libaoBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
                                        
                                        NSString* tempStr = [NSString stringWithFormat:@"%@:%@",tempComboItem.myComboTitle,tempComboItem.myComboContent];
                                        
                                        [tempBtn setTitle:tempStr forState:UIControlStateNormal];
                                        
                                        NSInteger tempH = [tempStr sizeWithFont:SYSTEMFONT(12) byWidth:w].height+20;
                                        
                                        if (tempH < 30) {
                                            tempH = 30;
                                        }
                                        
                                        h = tempH;
                                        
                                        tempBtn.tag = 8000+i;
                                        
                                        tempBtn.frame = CGRectMake(x, y, w, h);
                                        
                                        UIImageView* tempArrow = [[UIImageView alloc]initWithFrame:CGRectMake(tempBtn.frame.size.width-tempIcon2.size.width-10, (tempBtn.frame.size.height-tempIcon2.size.height)/2, tempIcon2.size.width, tempIcon2.size.height)];
                                        tempArrow.image = tempIcon2;
                                        [tempBtn addSubview:tempArrow];
                                        
                                        [self.myComboView addSubview:tempBtn];
                                        
                                        t_H+=h;
                                        
                                        y+=h;
                                    }
                                }
                                
                                tempFrame = self.myComboView.frame;
                                tempFrame.origin.y = MaxY(self.myComboLabel);
                                tempFrame.size.height = t_H+10;
                                self.myComboView.frame = tempFrame;
                                
                                tempFrame = self.myLine8View.frame;
                                tempFrame.origin.y = MaxY(self.myComboView);
                                self.myLine8View.frame = tempFrame;
                            }
                            
                        }else if ([self.myItemModel.myQuoteModel.myFirstPrice notEmpty] && ![self.myItemModel.myQuoteModel.myFirstPrice isEqualToString:@"0"]) {
                            self.myLastPriceLabel.text = [NSString stringWithFormat:@"首次报价：%@万元",self.myItemModel.myQuoteModel.myFirstPrice];
                            if ([self.myItemModel.myQuoteModel.myFirstInfo notEmpty]) {
                                self.myInfoLabel.text = self.myItemModel.myQuoteModel.myFirstInfo;
                                
                                NSInteger tempH = [self.myInfoLabel.text sizeWithFont:SYSTEMFONT(14) byWidth:self.myInfoLabel.frame.size.width].height+10;
                                
                                if (tempH<20) {
                                    tempH = 20;
                                }
                                
                                CGRect tempFrame = self.myInfoLabel.frame;
                                tempFrame.size.height = tempH;
                                self.myInfoLabel.frame = tempFrame;
                                
                                tempFrame = self.myLine6View.frame;
                                tempFrame.origin.y = MaxY(self.myInfoLabel);
                                self.myLine6View.frame = tempFrame;
                            }
                            
                            if ([self.myItemModel.myQuoteModel.myFirstComboArray count]>0) {
                                
                                self.myComboLabel.hidden  = NO;
                                self.myComboView.hidden = NO;
                                self.myLine8View.hidden = NO;
                                
                                CGRect tempFrame = self.myComboLabel.frame;
                                tempFrame.origin.y = MaxY(self.myLine6View);;
                                self.myComboLabel.frame = tempFrame;
                                
                                for (int i=0; i<[self.myComboView.subviews count]; i++) {
                                    UIView* tempView=  [self.myComboView.subviews objectAtIndex:i];
                                    if (tempView!=nil) {
                                        [tempView removeFromSuperview];
                                    }
                                }
                       
                                UIImage* tempIcon = [UIImage imageNamed:@"礼包.png"];
                                UIImage* tempIcon2 = [UIImage imageNamed:@"icon_more.png"];
                                
                                NSInteger x = 0;
                                NSInteger y = 0;
                                NSInteger h = 0;
                                NSInteger w = self.myComboView.frame.size.width-tempIcon.size.width-tempIcon2.size.width;
                                
                                NSInteger t_H = 0;
                                
                                
                                for (int i=0; i<[self.myItemModel.myQuoteModel.myFirstComboArray count]; i++) {
                                    M_QuoteComboItemModel* tempComboItem = [self.myItemModel.myQuoteModel.myFirstComboArray objectAtIndex:i];
                                    if (tempComboItem!=nil) {
                                        
                                        UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                                        
                                        tempBtn.titleLabel.font = SYSTEMFONT(12);
                                        tempBtn.titleLabel.numberOfLines = 0;
                                        tempBtn.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
                                        
                                        [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                        [tempBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                                        [tempBtn setImage:tempIcon forState:UIControlStateNormal];
                                        
                                        NSString* tempStr = [NSString stringWithFormat:@"%@:%@",tempComboItem.myComboTitle,tempComboItem.myComboContent];
                                        
                                        [tempBtn setTitle:tempStr forState:UIControlStateNormal];
                                        
                                        [tempBtn addTarget:self action:@selector(libaoBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
                                        
                                        NSInteger tempH = [tempStr sizeWithFont:SYSTEMFONT(12) byWidth:w].height+20;
                                        
                                        if (tempH < 30) {
                                            tempH = 30;
                                        }
                                        
                                        h = tempH;
                                        
                                        tempBtn.tag = 8000+i;
                                        
                                        tempBtn.frame = CGRectMake(x, y, w, h);
                                        
                                        UIImageView* tempArrow = [[UIImageView alloc]initWithFrame:CGRectMake(tempBtn.frame.size.width-tempIcon2.size.width, (tempBtn.frame.size.height-tempIcon2.size.height)/2, tempIcon2.size.width, tempIcon2.size.height)];
                                        tempArrow.image = tempIcon2;
                                        [tempBtn addSubview:tempArrow];
                                        
                                        [self.myComboView addSubview:tempBtn];
                                        
                                        t_H+=h;
                                        
                                        y+=h;
                                    }
                                }
                                
                                tempFrame = self.myComboView.frame;
                                tempFrame.origin.y = MaxY(self.myComboLabel);
                                tempFrame.size.height = t_H+10;
                                self.myComboView.frame = tempFrame;
                                
                                tempFrame = self.myLine8View.frame;
                                tempFrame.origin.y = MaxY(self.myComboView);
                                self.myLine8View.frame = tempFrame;
                            }
                        }
                    }
                    
                    CGRect tempFrame = self.myDealerView.frame;
                    if (self.myItemModel.myQuoteModel!=nil) {
                        if ([self.myItemModel.myQuoteModel.myLastComboArray count]>0) {
                            tempFrame.size.height = MaxY(self.myLine8View)+1;
                        }else if ([self.myItemModel.myQuoteModel.myFirstComboArray count]>0) {
                            tempFrame.size.height = MaxY(self.myLine8View)+1;
                        }else{
                            tempFrame.size.height = MaxY(self.myLine6View)+1;
                        }
                    }else{
                        self.myInfoClewLabel.hidden = YES;
                        self.myInfoLabel.hidden = YES;
                        self.myLine6View.hidden = YES;
                        self.myLastPriceLabel.hidden = YES;
                        self.myLine5View.hidden = YES;
                        tempFrame.size.height = 112;
                    }
                    
                    self.myDealerView.frame = tempFrame;
                    
                }else if (self.myItemModel.car.myCar_Lease){
                    
                    self.myLastPriceLabel.hidden = YES;
                    self.myInfoLabel.hidden = YES;
                    self.myInfoClewLabel.hidden = YES;
                    self.myLine5View.hidden = YES;
                    
                    CGRect tempFrame = self.myDealerView.frame;
                    tempFrame.size.height = 112;
                    self.myDealerView.frame = tempFrame;
                    
                }else if (self.myItemModel.car.myCar_Sales){
                    
                    self.myLastPriceLabel.hidden = YES;
                    self.myInfoLabel.hidden = YES;
                    self.myInfoClewLabel.hidden = YES;
                    self.myLine5View.hidden = YES;
                    
                    CGRect tempFrame = self.myDealerView.frame;
                    tempFrame.size.height = 112;
                    self.myDealerView.frame = tempFrame;
                }else{
                    self.myLastPriceLabel.hidden = YES;
                    self.myInfoLabel.hidden = YES;
                    self.myInfoClewLabel.hidden = YES;
                    self.myLine5View.hidden = YES;
                    
                    CGRect tempFrame = self.myDealerView.frame;
                    tempFrame.size.height = 112;
                    self.myDealerView.frame = tempFrame;
                }
            }
        }
        
        if ([tempModel.order_create_time notEmpty]) {
            NSString* tempStr = [[NSDate dateWithTimeIntervalSince1970:[tempModel.order_create_time doubleValue]] timeToString];
            self.myOrderCreateLabel.text = [NSString stringWithFormat:@"订单创建时间：%@",tempStr];
        }
        if ([tempModel.order_update_time notEmpty]) {
            NSString* tempStr = [[NSDate dateWithTimeIntervalSince1970:[tempModel.order_update_time doubleValue]] timeToString];
            self.myOrderUpdateLabel.text = [NSString stringWithFormat:@"订单支付时间：%@",tempStr];
        }
        if ([tempModel.order_finish_time notEmpty]) {
            NSString* tempStr = [[NSDate dateWithTimeIntervalSince1970:[tempModel.order_finish_time doubleValue]] timeToString];
            self.myOrderFinishLabel.text = [NSString stringWithFormat:@"奖励时间：%@",tempStr];
        }
        
        if ([tempModel.myCertificateArray count]>0) {
            NSString* tempIamgess = [tempModel.myCertificateArray objectAtIndex:0];
            if ([tempIamgess notEmpty]) {
                [self.myCertificateImageView setImageWithURL:[NSURL URLWithString:tempIamgess] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
            }
        }
        
        if ([tempModel.order_step notEmpty]) {
            //0未支付 1未发码 2未核销 3未上传凭证 4凭证待审核 5订单完成 -1订单关闭未退款 -2订单关闭已退款 -3凭证未通过审核 -4订单过期关闭
            
            UIButton* tempBtn1 = [self.myOrderStatusView viewWithTag:1001];
            UIButton* tempBtn2 = [self.myOrderStatusView viewWithTag:1002];
            UIButton* tempBtn3 = [self.myOrderStatusView viewWithTag:1003];
            UIButton* tempBtn4 = [self.myOrderStatusView viewWithTag:1004];
            UIButton* tempBtn5 = [self.myOrderStatusView viewWithTag:1005];
            
            UIImageView* tempArrow1 = [self.myOrderStatusView viewWithTag:2001];
            UIImageView* tempArrow2 = [self.myOrderStatusView viewWithTag:2002];
            UIImageView* tempArrow3 = [self.myOrderStatusView viewWithTag:2003];
            UIImageView* tempArrow4 = [self.myOrderStatusView viewWithTag:2004];
            
            [tempBtn1 setSelected:NO];
            [tempBtn2 setSelected:NO];
            [tempBtn3 setSelected:NO];
            [tempBtn4 setSelected:NO];
            [tempBtn5 setSelected:NO];
            
            tempBtn3.hidden = NO;
            tempBtn4.hidden = NO;
            tempBtn5.hidden = NO;
            
            tempArrow1.hidden = NO;
            tempArrow2.hidden = NO;
            tempArrow3.hidden = NO;
            tempArrow4.hidden = NO;
            
            [tempBtn2 setTitle:@"敬请提车" forState:UIControlStateNormal];
            
            if ([tempModel.order_step isEqualToString:@"0"]) {
                [tempBtn1 setSelected:YES];
                [self updateStep0Frame];
            }else if ([tempModel.order_step isEqualToString:@"1"]) {
                [tempBtn2 setSelected:YES];
                [self updateStep1Frame];
            }else if ([tempModel.order_step isEqualToString:@"2"]) {
                [tempBtn2 setSelected:YES];
                [self updateStep2Frame];
            }else if ([tempModel.order_step isEqualToString:@"3"]) {
                [tempBtn3 setSelected:YES];
                [self updateStep3Frame];
            }else if ([tempModel.order_step isEqualToString:@"4"]) {
                [tempBtn4 setSelected:YES];
                [self updateStep4Frame];
            }else if ([tempModel.order_step isEqualToString:@"5"]) {
                [tempBtn5 setSelected:YES];
                [self updateStep5Frame];
            }else if ([tempModel.order_step isEqualToString:@"-1"]) {
                [tempBtn2 setSelected:YES];
                [tempBtn2 setTitle:@"已关闭" forState:UIControlStateNormal];
                tempBtn3.hidden = YES;
                tempBtn4.hidden = YES;
                tempBtn5.hidden = YES;
                
                tempArrow2.hidden = YES;
                tempArrow3.hidden = YES;
                tempArrow4.hidden = YES;
                
                [self updateStep0Frame];
            }else if ([tempModel.order_step isEqualToString:@"-2"]) {
                [tempBtn2 setSelected:YES];
                [tempBtn2 setTitle:@"已关闭" forState:UIControlStateNormal];
                tempBtn3.hidden = YES;
                tempBtn4.hidden = YES;
                tempBtn5.hidden = YES;
                
                tempArrow2.hidden = YES;
                tempArrow3.hidden = YES;
                tempArrow4.hidden = YES;
                [self updateStep0Frame];
            }else if ([tempModel.order_step isEqualToString:@"-3"]) {
                [tempBtn2 setSelected:YES];
                [tempBtn2 setTitle:@"凭证未通过审核" forState:UIControlStateNormal];
                tempBtn3.hidden = YES;
                tempBtn4.hidden = YES;
                tempBtn5.hidden = YES;
                
                tempArrow2.hidden = YES;
                tempArrow3.hidden = YES;
                tempArrow4.hidden = YES;
                [self updateStep3Frame];
            }else if ([tempModel.order_step isEqualToString:@"-4"]) {
                [tempBtn2 setSelected:YES];
                [tempBtn2 setTitle:@"已关闭" forState:UIControlStateNormal];
                tempBtn3.hidden = YES;
                tempBtn4.hidden = YES;
                tempBtn5.hidden = YES;
                
                tempArrow2.hidden = YES;
                tempArrow3.hidden = YES;
                tempArrow4.hidden = YES;
                [self updateStep0Frame];
            }else if ([tempModel.order_step isEqualToString:@"-5"]) {
                [tempBtn2 setSelected:YES];
                [tempBtn2 setTitle:@"已关闭" forState:UIControlStateNormal];
                tempBtn3.hidden = YES;
                tempBtn4.hidden = YES;
                tempBtn5.hidden = YES;
                
                tempArrow2.hidden = YES;
                tempArrow3.hidden = YES;
                tempArrow4.hidden = YES;
                [self updateStep0Frame];
            }else if ([tempModel.order_step isEqualToString:@"-6"]) {
                [tempBtn2 setSelected:YES];
                [tempBtn2 setTitle:@"已关闭" forState:UIControlStateNormal];
                tempBtn3.hidden = YES;
                tempBtn4.hidden = YES;
                tempBtn5.hidden = YES;
                
                tempArrow2.hidden = YES;
                tempArrow3.hidden = YES;
                tempArrow4.hidden = YES;
                [self updateStep0Frame];
            }
        }
    }
    
    CGRect tempFrame = self.frame;
    tempFrame.size.height = MaxY(self.myOrderView);
    self.frame = tempFrame;
}

//点击礼包按钮
-(void)libaoBtnPressed:(UIButton *)sender
{
    M_QuoteComboItemModel* tempComboItem = nil;
    
    if ([self.myItemModel.myQuoteModel.myLastComboArray count]>0) {
        
        tempComboItem = [self.myItemModel.myQuoteModel.myLastComboArray objectAtIndex:sender.tag-8000];
    }else if ([self.myItemModel.myQuoteModel.myFirstComboArray count]>0) {
        
        tempComboItem = [self.myItemModel.myQuoteModel.myFirstComboArray objectAtIndex:sender.tag-8000];
    }
    
    if (tempComboItem!=nil) {
        if (self.block!=nil) {
            self.block(0,tempComboItem);
        }
    }
}

-(void)updateStep0Frame
{
    self.myCodeView.hidden = YES;
    self.myCertificateView.hidden =YES;
    self.myOrderUpdateLabel.hidden = YES;
    self.myOrderFinishLabel.hidden = YES;
    
    CGRect tempFrame = self.myDealerView.frame;
    tempFrame.origin.y = MaxY(self.myCarView);
    self.myDealerView.frame = tempFrame;
    
    tempFrame = self.myOrderView.frame;
    tempFrame.origin.y = MaxY(self.myDealerView);
    self.myOrderView.frame = tempFrame;
}

-(void)updateStep1Frame
{
    self.myCodeView.hidden = YES;
    self.myCertificateView.hidden =YES;
    self.myOrderUpdateLabel.hidden = NO;
    self.myOrderFinishLabel.hidden = YES;
    
    CGRect tempFrame = self.myDealerView.frame;
    tempFrame.origin.y = CGRectGetMaxY(self.myCarView.frame);
    self.myDealerView.frame = tempFrame;
    
    tempFrame = self.myOrderView.frame;
    tempFrame.origin.y = CGRectGetMaxY(self.myDealerView.frame);
    self.myOrderView.frame = tempFrame;
}

-(void)updateStep2Frame
{
    self.myCodeView.hidden = NO;
    self.myCertificateView.hidden =YES;
    self.myOrderUpdateLabel.hidden = NO;
    self.myOrderFinishLabel.hidden = YES;
    
    CGRect tempFrame = self.myDealerView.frame;
    tempFrame.origin.y = CGRectGetMaxY(self.myCodeView.frame);
    self.myDealerView.frame = tempFrame;
    
    tempFrame = self.myOrderView.frame;
    tempFrame.origin.y = CGRectGetMaxY(self.myDealerView.frame);
    self.myOrderView.frame = tempFrame;
}

-(void)updateStep3Frame
{
    self.myCodeView.hidden = NO;
    self.myCertificateView.hidden =YES;
    self.myOrderUpdateLabel.hidden = NO;
    self.myOrderFinishLabel.hidden = YES;
    
    CGRect tempFrame = self.myDealerView.frame;
    tempFrame.origin.y = CGRectGetMaxY(self.myCodeView.frame);
    self.myDealerView.frame = tempFrame;
    
    tempFrame = self.myOrderView.frame;
    tempFrame.origin.y = CGRectGetMaxY(self.myDealerView.frame);
    self.myOrderView.frame = tempFrame;
}

-(void)updateStep4Frame
{
    self.myCodeView.hidden = NO;
    self.myCertificateView.hidden =NO;
    self.myOrderUpdateLabel.hidden = NO;
    self.myOrderFinishLabel.hidden = YES;
    
    CGRect tempFrame = self.myDealerView.frame;
    tempFrame.origin.y = CGRectGetMaxY(self.myCodeView.frame);
    self.myDealerView.frame = tempFrame;
    
    tempFrame = self.myCertificateView.frame;
    tempFrame.origin.y = CGRectGetMaxY(self.myDealerView.frame);
    self.myCertificateView.frame = tempFrame;
    
    tempFrame = self.myOrderView.frame;
    tempFrame.origin.y = CGRectGetMaxY(self.myCertificateView.frame)+10;
    self.myOrderView.frame = tempFrame;
}

-(void)updateStep5Frame
{
    self.myCodeView.hidden = NO;
    self.myCertificateView.hidden =NO;
    self.myOrderUpdateLabel.hidden = NO;
    self.myOrderFinishLabel.hidden = NO;
    
    CGRect tempFrame = self.myDealerView.frame;
    tempFrame.origin.y = CGRectGetMaxY(self.myCodeView.frame);
    self.myDealerView.frame = tempFrame;
    
    tempFrame = self.myCertificateView.frame;
    tempFrame.origin.y = CGRectGetMaxY(self.myDealerView.frame);
    self.myCertificateView.frame = tempFrame;
    
    tempFrame = self.myOrderView.frame;
    tempFrame.origin.y = CGRectGetMaxY(self.myCertificateView.frame)+10;
    self.myOrderView.frame = tempFrame;
}
-(void)openCallBtnPressed:(UIButton *)button
{
    if (self.block != nil) {
        self.block(2,self.myItemModel);
    }
}


@end
