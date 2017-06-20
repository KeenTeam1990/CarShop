//
//  LL_DeatailOrderHeadView.m
//  DHCarForSales
//
//  Created by leiyu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "LL_DeatailOrderHeadView.h"
#import "LL_CarHeadView.h"
#import "M_MyOrderModel.h"
#import "LL_LableHaveLine.h"
#import "M_CarDistributorItemView.h"
//#import "LL_PriceAndPriceDemoView.m"

#define KLeftOffset 10
#define cellLableTextSize 12

@interface LL_DeatailOrderHeadView()

AS_MODEL_STRONG(UIView, myCarView);
AS_MODEL_STRONG(UILabel, myOrderLabel);
AS_MODEL_STRONG(UILabel, myOrderStateLabel);
AS_MODEL_STRONG(UIImageView, myImageView);
AS_MODEL_STRONG(UILabel, myNameLabel);
AS_MODEL_STRONG(UILabel, myPriceLabel);

AS_MODEL_STRONG(UIView, myParameterView);

AS_MODEL_STRONG(UIImageView, myLineView1);
AS_MODEL_STRONG(UIImageView, myLineView2);

AS_MODEL_STRONG(M_CarDistributorItemView, myDealerView);

AS_MODEL_STRONG(UIView, myFirstPriceView);
AS_MODEL_STRONG(UIView, myLastPriceView);

AS_MODEL_STRONG(UIImageView, myFirstBackView);
AS_MODEL_STRONG(UIImageView, myLastBackView);

AS_MODEL_STRONG(UILabel, myFirstPriceLabel);
AS_MODEL_STRONG(UILabel, myFirstClewLabel);
AS_MODEL_STRONG(UILabel, myFirstInfoClewLabel);
AS_MODEL_STRONG(UILabel, myFirstInfoLabel);
AS_MODEL_STRONG(UIImageView, myFirstLineView);

AS_MODEL_STRONG(UIImageView, myLastToFirstBackView);
AS_MODEL_STRONG(LL_LableHaveLine, myLastToFristPriceLabel);
AS_MODEL_STRONG(UILabel, myLastToFristInfoLabel);
AS_MODEL_STRONG(UIImageView, myLastLine1View);
AS_MODEL_STRONG(UIImageView, myLastLine2View);
AS_MODEL_STRONG(UILabel, myLastPriceLabel);
AS_MODEL_STRONG(UILabel, myLastClewInfoLabel);
AS_MODEL_STRONG(UILabel, myLastInfoLabel);

AS_MODEL_STRONG(UIImageView, myFirstLine2View);
AS_MODEL_STRONG(UILabel, myFirstComboLabel);
AS_MODEL_STRONG(UIView, myFirstComboView);

AS_MODEL_STRONG(UIImageView, myLastToFirstLine3View);
AS_MODEL_STRONG(UILabel, myLastToFirstComboLabel);
AS_MODEL_STRONG(UIView, myLastToFirstComboView);
AS_MODEL_STRONG(UIImageView, myLastLine3View);
AS_MODEL_STRONG(UILabel, myLastComboLabel);
AS_MODEL_STRONG(UIView, myLastComboView);
AS_MODEL_STRONG(UIButton, myOpenCallBtn);

@end

@implementation LL_DeatailOrderHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.myCarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 140)];
        [self.myCarView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.myCarView];
        
        self.myOrderLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width-130, 30)];
        self.myOrderLabel.font  =[UIFont systemFontOfSize:14];
        self.myOrderLabel.textColor = [UIColor redColor];
        [self.myCarView addSubview:self.myOrderLabel];
        
        self.myOrderStateLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-120, 0, 110, 30)];
        self.myOrderStateLabel.font  =[UIFont systemFontOfSize:14];
        self.myOrderStateLabel.textColor = [UIColor redColor];
        self.myOrderStateLabel.textAlignment = UITextAlignmentRight;
        [self.myCarView addSubview:self.myOrderStateLabel];
        
        self.myLineView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, 1)];
        self.myLineView1.image = [UIImage imageNamed:@"dashedLine.png"];
        [self.myCarView addSubview:self.myLineView1];
        
        NSInteger tempIamgew = self.frame.size.width/2-20;
        
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, tempIamgew, 100)];
        self.myImageView.image = [UIImage imageNamed:@"tempcar.jpg"];
        self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.myCarView addSubview:self.myImageView];
        
        self.myNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(tempIamgew+20, 25, self.frame.size.width-tempIamgew-30, 60)];
        self.myNameLabel.font = [UIFont systemFontOfSize:14];
        self.myNameLabel.textColor = [UIColor blackColor];
        self.myNameLabel.numberOfLines = 3;
        [self.myCarView addSubview:self.myNameLabel];
        
        self.myPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(tempIamgew+20, 85, self.frame.size.width-190, 30)];
        [self.myPriceLabel setFont:[UIFont systemFontOfSize:14]];
        self.myPriceLabel.textColor = RGBCOLOR(202, 202, 202);
        [self.myCarView addSubview:self.myPriceLabel];
        
        self.myParameterView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.myCarView.frame), self.bounds.size.width, 0)];
        self.myParameterView.backgroundColor = RGBCOLOR(230, 230, 232);
        [self addSubview:self.myParameterView];
        
        self.myDealerView = [M_CarDistributorItemView allocInstanceFrame:CGRectMake(0, CGRectGetMaxY(self.myCarView.frame)+10, self.bounds.size.width, 110)];
        self.myDealerView.showDistance = YES;
        self.myDealerView.showPrice = NO;
        [self addSubview:self.myDealerView];
        self.myOpenCallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.myOpenCallBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor]; style.borderWidth = 1;
                                                     style.borderColor = [UIColor blackColor];
                                                     style.cornerRedius = 5;);
        self.myOpenCallBtn.tintColor = [UIColor blackColor];
        [self.myOpenCallBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.myOpenCallBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        self.myOpenCallBtn.frame = CGRectMake(self.myDealerView.frame.size.width-110, 110-35, 80, 30);
        [self.myOpenCallBtn addTarget:self action:@selector(openCallBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.myOpenCallBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
        self.myOpenCallBtn.userInteractionEnabled = YES;
        [self.myDealerView addSubview:self.myOpenCallBtn];
        
        
        self.myFirstPriceView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.myDealerView.frame)+10, self.bounds.size.width, 140)];
        self.myFirstPriceView.hidden = YES;
        [self addSubview:self.myFirstPriceView];
        
        self.myLastPriceView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.myDealerView.frame)+10, self.bounds.size.width, 180)];
        self.myLastPriceView.hidden = YES;
        [self addSubview:self.myLastPriceView];
        
        [self initFirstView];
        
        [self initLastView];
    }
    return self;
}

-(void)initFirstView
{
    UIImage* tempImage = [UIImage imageNamed:@"order_bg.png"];
    self.myFirstBackView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.myFirstPriceView.frame.size.height)];
    self.myFirstBackView.image = [tempImage resizableImageWithCapInsets:UIEdgeInsetsMake(20, 0, 20, 0)];
    [self.myFirstPriceView addSubview:self.myFirstBackView];
    
    self.myFirstPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, self.myFirstPriceView.frame.size.width-20, 30)];
    self.myFirstPriceLabel.font = [UIFont systemFontOfSize:18];
    self.myFirstPriceLabel.textColor = [UIColor redColor];
    [self.myFirstPriceView addSubview:self.myFirstPriceLabel];
    
    self.myFirstClewLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, self.myFirstPriceView.frame.size.width-20, 20)];
    self.myFirstClewLabel.textColor = RGBCOLOR(202, 202, 202);
    self.myFirstClewLabel.font = [UIFont systemFontOfSize:12];
    self.myFirstClewLabel.text = @"销售顾问还有机会给您最终报价";
    [self.myFirstPriceView addSubview:self.myFirstClewLabel];
    
    self.myFirstLineView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 70, self.myFirstPriceView.frame.size.width-20, 1)];
    self.myFirstLineView.image = [UIImage imageNamed:@"dashedLine.png"];
    [self.myFirstPriceView addSubview:self.myFirstLineView];
    
    self.myFirstInfoClewLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 71, self.myFirstPriceView.frame.size.width-20, 30)];
    self.myFirstInfoClewLabel.textColor = [UIColor blackColor];
    self.myFirstInfoClewLabel.font = [UIFont systemFontOfSize:14];
    self.myFirstInfoClewLabel.text = @"报价说明";
    [self.myFirstPriceView addSubview:self.myFirstInfoClewLabel];
    
    self.myFirstInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 101, self.myFirstPriceView.frame.size.width-20, 30)];
    self.myFirstInfoLabel.textColor = RGBCOLOR(202, 202, 202);
    self.myFirstInfoLabel.font = [UIFont systemFontOfSize:14];
    self.myFirstInfoLabel.numberOfLines = 0;
    self.myFirstInfoLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    [self.myFirstPriceView addSubview:self.myFirstInfoLabel];
    
    self.myFirstLine2View = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.myFirstInfoLabel.frame), self.myFirstPriceView.frame.size.width-20, 1)];
    self.myFirstLine2View.backgroundColor = RGBCOLOR(202, 202, 202);
    self.myFirstLine2View.hidden = YES;
    [self.myFirstPriceView addSubview:self.myFirstLine2View];
    
    self.myFirstComboLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, MaxY(self.myFirstLine2View), self.myFirstPriceView.frame.size.width-20, 30)];
    self.myFirstComboLabel.textColor = [UIColor blackColor];
    self.myFirstComboLabel.font = [UIFont systemFontOfSize:14];
    self.myFirstComboLabel.text = @"购车大礼包";
    self.myFirstComboLabel.hidden = YES;
    [self.myFirstPriceView addSubview:self.myFirstComboLabel];

    self.myFirstComboView = [[UIView alloc]initWithFrame:CGRectMake(10, MaxY(self.myFirstComboLabel), self.myFirstPriceView.frame.size.width, 30)];
    self.myFirstComboView.hidden = YES;
    [self.myFirstPriceView addSubview:self.myFirstComboView];
}
-(void)openCallBtnPressed:(UIButton *)button
{
    if (self.block != nil) {
        self.block(3,self.model);
    }
}
-(void)initLastView
{
    UIImage* tempImage = [UIImage imageNamed:@"order_bg.png"];
    self.myLastBackView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.myLastPriceView.frame.size.height)];
    self.myLastBackView.image = [tempImage resizableImageWithCapInsets:UIEdgeInsetsMake(20, 0, 20, 0)];
    [self.myLastPriceView addSubview:self.myLastBackView];
    
    self.myLastToFirstBackView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, self.myLastPriceView.frame.size.width, 60)];
    self.myLastToFirstBackView.backgroundColor = RGBCOLOR(230, 230, 230);
    self.myLastToFirstBackView.userInteractionEnabled  = YES;
    [self.myLastPriceView addSubview:self.myLastToFirstBackView];
    
    self.myLastToFristPriceLabel = [[LL_LableHaveLine alloc]initWithFrame:CGRectMake(10, 2, (self.myLastPriceView.frame.size.width-20)/2, 30)];
    [self.myLastToFirstBackView addSubview:self.myLastToFristPriceLabel];
    
    self.myLastToFristInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, self.myLastPriceView.frame.size.width-20, 30)];
    self.myLastToFristInfoLabel.textColor = RGBCOLOR(202, 202, 202);
    self.myLastToFristInfoLabel.font = [UIFont systemFontOfSize:14];
    self.myLastToFristInfoLabel.numberOfLines = 0;
    self.myLastToFristInfoLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    [self.myLastToFirstBackView addSubview:self.myLastToFristInfoLabel];
    
    self.myLastToFirstLine3View = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.myLastToFristInfoLabel.frame), self.myLastToFirstBackView.frame.size.width-20, 1)];
    self.myLastToFirstLine3View.backgroundColor = RGBCOLOR(202, 202, 202);
    self.myLastToFirstLine3View.hidden = YES;
    [self.myLastToFirstBackView addSubview:self.myLastToFirstLine3View];
    
    self.myLastToFirstComboLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, MaxY(self.myLastToFirstLine3View), self.myLastToFirstBackView.frame.size.width-20, 30)];
    self.myLastToFirstComboLabel.textColor = [UIColor blackColor];
    self.myLastToFirstComboLabel.font = [UIFont systemFontOfSize:14];
    self.myLastToFirstComboLabel.text = @"购车大礼包";
    self.myLastToFirstComboLabel.hidden = YES;
    [self.myLastToFirstBackView addSubview:self.myLastToFirstComboLabel];
    
    self.myLastToFirstComboView = [[UIView alloc]initWithFrame:CGRectMake(10, MaxY(self.myLastToFirstComboLabel), self.myLastToFirstBackView.frame.size.width, 30)];
    self.myLastToFirstComboView.hidden = YES;
    self.myLastToFirstComboView.userInteractionEnabled  = YES;
    [self.myLastToFirstBackView addSubview:self.myLastToFirstComboView];
    
    self.myLastLine1View = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.myLastToFirstBackView.frame), self.myLastPriceView.frame.size.width, 1)];
    self.myLastLine1View.backgroundColor = RGBCOLOR(202, 202, 202);
    [self.myLastPriceView addSubview:self.myLastLine1View];
    
    self.myLastPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.myLastLine1View.frame), self.myLastPriceView.frame.size.width-20, 40)];
    self.myLastPriceLabel.font = [UIFont systemFontOfSize:18];
    self.myLastPriceLabel.textColor = [UIColor redColor];
    [self.myLastPriceView addSubview:self.myLastPriceLabel];
    
    self.myLastLine2View = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.myLastPriceLabel.frame), self.myLastPriceView.frame.size.width-20, 1)];
    self.myLastLine2View.image = [UIImage imageNamed:@"dashedLine.png"];
    [self.myLastPriceView addSubview:self.myLastLine2View];
    
    self.myLastClewInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.myLastLine2View.frame), self.myLastPriceView.frame.size.width-20, 30)];
    self.myLastClewInfoLabel.font = [UIFont systemFontOfSize:14];
    self.myLastClewInfoLabel.textColor = [UIColor blackColor];
    self.myLastClewInfoLabel.text =@"报价说明";
    [self.myLastPriceView addSubview:self.myLastClewInfoLabel];
    
    self.myLastInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.myLastClewInfoLabel.frame), self.myLastPriceView.frame.size.width-20, 30)];
    self.myLastInfoLabel.textColor = RGBCOLOR(202, 202, 202);
    self.myLastInfoLabel.font = [UIFont systemFontOfSize:14];
    self.myLastInfoLabel.numberOfLines = 0;
    self.myLastInfoLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    [self.myLastPriceView addSubview:self.myLastInfoLabel];
    
    self.myLastLine3View = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.myLastInfoLabel.frame), self.myLastPriceView.frame.size.width-20, 1)];
    self.myLastLine3View.backgroundColor = RGBCOLOR(202, 202, 202);
    self.myLastLine3View.hidden = YES;
    [self.myLastPriceView addSubview:self.myLastLine3View];
    
    self.myLastComboLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, MaxY(self.myLastLine3View), self.myLastPriceView.frame.size.width-20, 30)];
    self.myLastComboLabel.textColor = [UIColor blackColor];
    self.myLastComboLabel.font = [UIFont systemFontOfSize:14];
    self.myLastComboLabel.text = @"购车大礼包";
    self.myLastComboLabel.hidden = YES;
    [self.myLastPriceView addSubview:self.myLastComboLabel];
    
    self.myLastComboView = [[UIView alloc]initWithFrame:CGRectMake(10, MaxY(self.myLastComboLabel), self.myLastPriceView.frame.size.width, 30)];
    self.myLastComboView.hidden = YES;
    [self.myLastPriceView addSubview:self.myLastComboView];
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

-(void)upDateWithMyOrdelDeatailModel:(M_QuoteItemModel *)model
{
    self.model = model;
    
    if (model!=nil) {
        
        self.myOrderLabel.hidden = YES;
        self.myLineView1.hidden=  YES;
        
        if (model.myOrderModel!=nil) {
            
            if ([model.myOrderModel.order_no notEmpty]) {
                
                self.myOrderLabel.hidden = NO;
                self.myLineView1.hidden = NO;
                
                CGRect tempFrame = self.myImageView.frame;
                tempFrame.origin.y = 35;
                self.myImageView.frame = tempFrame;
                
                tempFrame = self.myNameLabel.frame;
                tempFrame.origin.y = 45;
                self.myNameLabel.frame = tempFrame;
                
                tempFrame = self.myPriceLabel.frame;
                tempFrame.origin.y = 105;
                self.myPriceLabel.frame = tempFrame;
                
                self.myOrderLabel.text = [NSString stringWithFormat:@"订单号:%@",model.myOrderModel.order_no];
                
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:self.myOrderLabel.text];
                [attStr addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"#fa1e25"] range:NSMakeRange(0, 4)];
                self.myOrderLabel.attributedText = attStr;
                
                if ([model.myOrderModel.order_step notEmpty]) {
                    if ([model.myOrderModel.order_step isEqualToString:@"0"]||
                        [model.myOrderModel.order_step isEqualToString:@"1"]) {
                        self.myOrderStateLabel.text = @"待支付";
                    }else if ([model.myOrderModel.order_step isEqualToString:@"2"]) {
                        self.myOrderStateLabel.text = @"敬请提车";
                    }else if ([model.myOrderModel.order_step isEqualToString:@"3"]) {
                        self.myOrderStateLabel.text = @"等待上传凭证";
                    }else if ([model.myOrderModel.order_step isEqualToString:@"4"]) {
                        self.myOrderStateLabel.text = @"凭证待审";
                    }else if ([model.myOrderModel.order_step isEqualToString:@"5"]) {
                        self.myOrderStateLabel.text = @"交易完成";
                    }else if ([model.myOrderModel.order_step isEqualToString:@"-1"]) {
                        self.myOrderStateLabel.text = @"等待退款";
                    }else if ([model.myOrderModel.order_step isEqualToString:@"-2"]) {
                        self.myOrderStateLabel.text = @"退款已完成";
                    }else if ([model.myOrderModel.order_step isEqualToString:@"-3"]) {
                        self.myOrderStateLabel.text = @"凭证未通过审核";
                    }else if ([model.myOrderModel.order_step isEqualToString:@"-4"]) {
                        self.myOrderStateLabel.text = @"订单关闭";
                    }else if ([model.myOrderModel.order_step isEqualToString:@"-5"]) {
                        self.myOrderStateLabel.text = @"支付失败";
                    }else if ([model.myOrderModel.order_step isEqualToString:@"-6"]) {
                        self.myOrderStateLabel.text = @"支付成功";
                    }
                }
            }
        }
        
        if (model.myDealerModel != nil) {
            [self.myDealerView updateData:model.myDealerModel];
        }
        
        if (model.myInquiryModel!=nil) {
            
            if (model.myInquiryModel.car!=nil) {
                
                if ([model.myInquiryModel.car.myCar_Img notEmpty]) {
                    [self.myImageView setImageWithURL:[NSURL URLWithString:model.myInquiryModel.car.myCar_Img] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
                }
                if ([model.myInquiryModel.car.myBrand_Name notEmpty] &&
                    [model.myInquiryModel.car.mySubbrand_Name notEmpty] &&
                    [model.myInquiryModel.car.myCar_Year notEmpty] &&
                    [model.myInquiryModel.car.myCar_Name notEmpty]) {
                    self.myNameLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",model.myInquiryModel.car.myBrand_Name,model.myInquiryModel.car.mySubbrand_Name,model.myInquiryModel.car.myCar_Year,model.myInquiryModel.car.myCar_Name];
                }
                
                if ([model.myInquiryModel.car.myCar_Price notEmpty]) {
                    self.myPriceLabel.text = [NSString stringWithFormat:@"指导价：%@万元",model.myInquiryModel.car.myCar_Price];
                }
                
                if ([model.myInquiryModel.car.myParameterArray count]>0) {
                    
                    CGRect tempFrame = self.myParameterView.frame;
                    tempFrame.size.height = 30*([model.myInquiryModel.car.myParameterArray count]%2==0?[model.myInquiryModel.car.myParameterArray count]/2:([model.myInquiryModel.car.myParameterArray count]/2)+1);
                    self.myParameterView.frame = tempFrame;
                    
                    tempFrame = self.myDealerView.frame;
                    tempFrame.origin.y = CGRectGetMaxY(self.myParameterView.frame)+10;
                    self.myDealerView.frame = tempFrame;
                    
                    tempFrame = self.myFirstPriceView.frame;
                    tempFrame.origin.y = CGRectGetMaxY(self.myDealerView.frame)+10;
                    self.myFirstPriceView.frame = tempFrame;
                    
                    tempFrame = self.myLastPriceView.frame;
                    tempFrame.origin.y = CGRectGetMaxY(self.myDealerView.frame)+10;
                    self.myLastPriceView.frame = tempFrame;
                    
                    for (int i=0; i<[self.myParameterView.subviews count]; i++) {
                        UIView* tempView = [self.myParameterView.subviews objectAtIndex:i];
                        if (tempView!=nil) {
                            [tempView removeFromSuperview];
                        }
                    }
                    
                    NSInteger x = KLeftOffset;
                    NSInteger y = 0;
                    NSInteger w = (self.myParameterView.frame.size.width-KLeftOffset*2)/2;
                    NSInteger h = 30;
                    
                    for (int i=0; i<[model.myInquiryModel.car.myParameterArray count]; i++) {
                        M_CarParameterItemModel* tempItem = [model.myInquiryModel.car.myParameterArray objectAtIndex:i];
                        if (tempItem!=nil) {
                            
                            UILabel* tempLabel = [self getParameter:CGRectMake(x, y, w, h) withView:self.myParameterView];
                            
                            tempLabel.text = [NSString stringWithFormat:@"%@:%@",tempItem.myParameter_Name,tempItem.myParameter_Value];
                            
                            if (i!=0 && (i+1)%2==0) {
                                x = KLeftOffset;
                                y += h;
                            }else{
                                x+=w;
                            }
                        }
                    }
                }
            }
        }
        
        if ([model.myLastPrice notEmpty] && ![model.myLastPrice isEqualToString:@"0"]) {
            self.myLastPriceView.hidden = NO;
            
            NSInteger tempHeight1 = 0;
            NSInteger tempHeight2 = 0;
            
            if ([model.myFirstPrice notEmpty]) {
                
                self.myLastToFristPriceLabel.myText = [NSString stringWithFormat:@"首次报价：%@万元",model.myFirstPrice];
                
                if ([model.myFirstInfo notEmpty]) {
                    
                    self.myLastToFristInfoLabel.text = model.myFirstInfo;
                    
                    tempHeight1 = [Unity getLabelHeightWithWidth:self.myLastToFristInfoLabel.frame.size.width andDefaultHeight:20 andFontSize:14 andText:self.myLastToFristInfoLabel.text]+10;
                    
                    CGRect tempFrame = self.myLastToFristInfoLabel.frame;
                    tempFrame.size.height = tempHeight1;
                    self.myLastToFristInfoLabel.frame = tempFrame;
                    
                    tempFrame = self.myLastToFirstBackView.frame;
                    tempFrame.size.height = 30+tempHeight1;
                    self.myLastToFirstBackView.frame = tempFrame;
                    
                }
                
                if ([model.myFirstComboArray count]>0) {
                    
                    self.myLastToFirstLine3View.hidden = NO;
                    self.myLastToFirstComboView.hidden = NO;
                    self.myLastToFirstComboLabel.hidden = NO;
                    
                    CGRect tempFrame = self.myLastToFirstLine3View.frame;
                    tempFrame.origin.y = MaxY(self.myLastToFristInfoLabel);;
                    self.myLastToFirstLine3View.frame = tempFrame;
                    
                    tempFrame = self.myLastToFirstComboLabel.frame;
                    tempFrame.origin.y = MaxY(self.myLastToFirstLine3View);;
                    self.myLastToFirstComboLabel.frame = tempFrame;
                    
                    for (int i=0; i<[self.myLastToFirstComboView.subviews count]; i++) {
                        UIView* tempView=  [self.myLastToFirstComboView.subviews objectAtIndex:i];
                        if (tempView!=nil) {
                            [tempView removeFromSuperview];
                        }
                    }
                    
                    UIImage* tempIcon = [UIImage imageNamed:@"礼包.png"];
                    UIImage* tempIcon2 = [UIImage imageNamed:@"icon_more.png"];
                    
                    NSInteger x = 0;
                    NSInteger y = 0;
                    NSInteger h = 0;
                    NSInteger w = self.myLastToFirstComboView.frame.size.width-tempIcon.size.width-tempIcon2.size.width;
                    
                    NSInteger t_H = 0;
                    
                    
                    for (int i=0; i<[model.myFirstComboArray count]; i++) {
                        M_QuoteComboItemModel* tempComboItem = [model.myFirstComboArray objectAtIndex:i];
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
                            
                            [tempBtn addTarget:self action:@selector(libao2BtnPressed:) forControlEvents:UIControlEventTouchUpInside];
                            
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
                            
                            [self.myLastToFirstComboView addSubview:tempBtn];
                            
                            t_H+=h;
                            
                            y+=h;
                        }
                    }
                    
                    tempFrame = self.myLastToFirstComboView.frame;
                    tempFrame.origin.y = MaxY(self.myLastToFirstComboLabel);
                    tempFrame.size.height = t_H+10;
                    self.myLastToFirstComboView.frame = tempFrame;
                    
                    tempFrame = self.myLastToFirstBackView.frame;
                    tempFrame.size.height = MaxY(self.myLastToFirstComboView);
                    self.myLastToFirstBackView.frame = tempFrame;
                }
                
                CGRect tempFrame = self.myLastLine1View.frame;
                tempFrame.origin.y = CGRectGetMaxY(self.myLastToFirstBackView.frame);
                self.myLastLine1View.frame = tempFrame;
            }
            
            self.myLastPriceLabel.text = [NSString stringWithFormat:@"最终报价：%@万元",model.myLastPrice];
            
            NSMutableAttributedString* tempArrt = [[NSMutableAttributedString alloc]initWithString:self.myLastPriceLabel.text];
            
            [tempArrt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, 5)];
            
            self.myLastPriceLabel.attributedText = tempArrt;
            
            if ([model.myLastInfo notEmpty]) {
                
                self.myLastInfoLabel.text = model.myLastInfo;
                
                tempHeight2 = [Unity getLabelHeightWithWidth:self.myLastInfoLabel.frame.size.width andDefaultHeight:20 andFontSize:14 andText:self.myLastInfoLabel.text]+10;
                
                CGRect tempFrame = self.myLastPriceView.frame;
                tempFrame.size.height = 180+tempHeight2+tempHeight1-60;
                self.myLastPriceView.frame = tempFrame;
                
                tempFrame = self.myLastBackView.frame;
                tempFrame.size.height = 180+tempHeight2+tempHeight1-60;
                self.myLastBackView.frame = tempFrame;
                
                tempFrame = self.myLastPriceLabel.frame;
                tempFrame.origin.y = CGRectGetMaxY(self.myLastToFirstBackView.frame);
                self.myLastPriceLabel.frame = tempFrame;
                
                tempFrame = self.myLastLine2View.frame;
                tempFrame.origin.y = CGRectGetMaxY(self.myLastPriceLabel.frame);
                self.myLastLine2View.frame = tempFrame;
                
                tempFrame = self.myLastClewInfoLabel.frame;
                tempFrame.origin.y = CGRectGetMaxY(self.myLastLine2View.frame);
                self.myLastClewInfoLabel.frame = tempFrame;
                
                tempFrame = self.myLastInfoLabel.frame;
                tempFrame.origin.y = CGRectGetMaxY(self.myLastClewInfoLabel.frame);
                tempFrame.size.height = tempHeight2;
                self.myLastInfoLabel.frame = tempFrame;
                
            }else{
                
                CGRect tempFrame = self.myLastPriceView.frame;
                tempFrame.size.height = 180+tempHeight2+self.myLastToFirstBackView.frame.size.height;
                self.myLastPriceView.frame = tempFrame;
                
                tempFrame = self.myLastBackView.frame;
                tempFrame.size.height = 180+tempHeight2+self.myLastToFirstBackView.frame.size.height;
                self.myLastBackView.frame = tempFrame;
                
                tempFrame = self.myLastPriceLabel.frame;
                tempFrame.origin.y = CGRectGetMaxY(self.myLastToFirstBackView.frame);
                self.myLastPriceLabel.frame = tempFrame;
                
                tempFrame = self.myLastLine2View.frame;
                tempFrame.origin.y = CGRectGetMaxY(self.myLastPriceLabel.frame);
                self.myLastLine2View.frame = tempFrame;
                
                tempFrame = self.myLastClewInfoLabel.frame;
                tempFrame.origin.y = CGRectGetMaxY(self.myLastLine2View.frame);
                self.myLastClewInfoLabel.frame = tempFrame;
                
                tempFrame = self.myLastInfoLabel.frame;
                tempFrame.origin.y = CGRectGetMaxY(self.myLastClewInfoLabel.frame);
                tempFrame.size.height = tempHeight2;
                self.myLastInfoLabel.frame = tempFrame;
            }
            
            if ([model.myLastComboArray count]>0) {

                self.myLastComboLabel.hidden = NO;
                self.myLastComboView.hidden = NO;
                self.myLastLine3View.hidden = NO;
                
                CGRect tempFrame = self.myLastLine3View.frame;
                tempFrame.origin.y = MaxY(self.myLastInfoLabel);
                self.myLastLine3View.frame = tempFrame;
                
                tempFrame = self.myLastComboLabel.frame;
                tempFrame.origin.y = MaxY(self.myLastLine3View);
                self.myLastComboLabel.frame = tempFrame;
                
                for (int i=0; i<[self.myLastComboView.subviews count]; i++) {
                    UIView* tempView=  [self.myLastComboView.subviews objectAtIndex:i];
                    if (tempView!=nil) {
                        [tempView removeFromSuperview];
                    }
                }
                
                UIImage* tempIcon = [UIImage imageNamed:@"礼包.png"];
                UIImage* tempIcon2 = [UIImage imageNamed:@"icon_more.png"];
                
                NSInteger x = 0;
                NSInteger y = 0;
                NSInteger h = 0;
                NSInteger w = self.myLastComboView.frame.size.width-tempIcon.size.width-tempIcon2.size.width;
                NSInteger t_H = 0;
                
                
                for (int i=0; i<[model.myLastComboArray count]; i++) {
                    M_QuoteComboItemModel* tempComboItem = [model.myLastComboArray objectAtIndex:i];
                    if (tempComboItem!=nil) {
                        
                        UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                        //                                        tempBtn.userInteractionEnabled = NO;
                        
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
                        
                        tempBtn.tag = 9000+i;
                        
                        tempBtn.frame = CGRectMake(x, y, w, h);
                        
                        UIImageView* tempArrow = [[UIImageView alloc]initWithFrame:CGRectMake(tempBtn.frame.size.width-tempIcon2.size.width, (tempBtn.frame.size.height-tempIcon2.size.height)/2, tempIcon2.size.width, tempIcon2.size.height)];
                        tempArrow.image = tempIcon2;
                        [tempBtn addSubview:tempArrow];
                        
                        [self.myLastComboView addSubview:tempBtn];
                        
                        t_H+=h;
                        
                        y+=h;
                    }
                }
                
                tempFrame = self.myLastComboView.frame;
                tempFrame.origin.y = MaxY(self.myLastComboLabel);
                tempFrame.size.height = t_H+10;
                self.myLastComboView.frame = tempFrame;
                
                tempFrame = self.myLastBackView.frame;
                tempFrame.size.height = MaxY(self.myLastComboView);
                self.myLastBackView.frame = tempFrame;
                
                tempFrame = self.myLastPriceView.frame;
                tempFrame.size.height = MaxY(self.myLastBackView)+20;
                self.myLastPriceView.frame = tempFrame;
            }
            
            CGRect tempFrame = self.frame;
            tempFrame.size.height = MaxY(self.myLastPriceView)+50;
            self.frame = tempFrame;
            
        }else if ([model.myFirstPrice notEmpty] && ![model.myFirstPrice isEqualToString:@"0"]){
            self.myFirstPriceView.hidden = NO;
            
            self.myFirstPriceLabel.text = [NSString stringWithFormat:@"首次报价：%@万元",model.myFirstPrice];
            
            NSMutableAttributedString* tempArrt = [[NSMutableAttributedString alloc]initWithString:self.myFirstPriceLabel.text];
            
            [tempArrt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, 5)];
            
            self.myFirstPriceLabel.attributedText = tempArrt;
            
            if ([model.myFirstInfo notEmpty]) {
                
                self.myFirstInfoLabel.text = model.myFirstInfo;
                
                NSInteger tempHeight = [Unity getLabelHeightWithWidth:self.frame.size.width-20 andDefaultHeight:20 andFontSize:14 andText:model.myFirstInfo]+10;
                
                CGRect tempFrame = self.myFirstInfoLabel.frame;
                tempFrame.size.height = tempHeight;
                self.myFirstInfoLabel.frame = tempFrame;
                
                tempFrame = self.myFirstPriceView.frame;
                tempFrame.size.height = 110+tempHeight;
                self.myFirstPriceView.frame = tempFrame;
                
                tempFrame = self.myFirstBackView.frame;
                tempFrame.size.height = 110+tempHeight;
                self.myFirstBackView.frame = tempFrame;
            }
            
            if ([model.myFirstComboArray count]>0) {
                
                self.myFirstComboLabel.hidden  = NO;
                self.myFirstComboView.hidden = NO;
                self.myFirstLine2View.hidden = NO;
                
                CGRect tempFrame = self.myFirstLine2View.frame;
                tempFrame.origin.y = MaxY(self.myFirstInfoLabel);
                self.myFirstLine2View.frame = tempFrame;
                
                tempFrame = self.myFirstComboLabel.frame;
                tempFrame.origin.y = MaxY(self.myFirstLine2View);
                self.myFirstComboLabel.frame = tempFrame;
                
                for (int i=0; i<[self.myFirstComboView.subviews count]; i++) {
                    UIView* tempView=  [self.myFirstComboView.subviews objectAtIndex:i];
                    if (tempView!=nil) {
                        [tempView removeFromSuperview];
                    }
                }
                
                UIImage* tempIcon = [UIImage imageNamed:@"礼包.png"];
                UIImage* tempIcon2 = [UIImage imageNamed:@"icon_more.png"];
                
                NSInteger x = 0;
                NSInteger y = 0;
                NSInteger h = 0;
                NSInteger w = self.myFirstComboView.frame.size.width-tempIcon.size.width-tempIcon2.size.width;
                NSInteger t_H = 0;
                
                
                for (int i=0; i<[model.myFirstComboArray count]; i++) {
                    M_QuoteComboItemModel* tempComboItem = [model.myFirstComboArray objectAtIndex:i];
                    if (tempComboItem!=nil) {
                        
                        UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                        //                                        tempBtn.userInteractionEnabled = NO;
                        
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
                        
                        [self.myFirstComboView addSubview:tempBtn];
                        
                        t_H+=h;
                        
                        y+=h;
                    }
                }
                
                tempFrame = self.myFirstComboView.frame;
                tempFrame.origin.y = MaxY(self.myFirstComboLabel);
                tempFrame.size.height = t_H+10;
                self.myFirstComboView.frame = tempFrame;
                
                tempFrame = self.myFirstBackView.frame;
                tempFrame.size.height = MaxY(self.myFirstComboView);
                self.myFirstBackView.frame = tempFrame;
                
                tempFrame = self.myFirstPriceView.frame;
                tempFrame.size.height = MaxY(self.myFirstBackView)+20;
                self.myFirstPriceView.frame = tempFrame;
            }
            
            CGRect tempFrame = self.frame;
            tempFrame.size.height = MaxY(self.myFirstPriceView)+50;
            self.frame = tempFrame;
            
        }else{
            
            CGRect tempFrame = self.frame;
            tempFrame.size.height = MaxY(self.myDealerView)+50;
            self.frame = tempFrame;
        }
    }
}

-(void)libao2BtnPressed:(id)sender
{
    UIButton* tempbtn = (UIButton*)sender;
    if (tempbtn!=nil) {
        if (self.model!=nil) {
            if ([self.model.myLastPrice notEmpty] && ![self.model.myLastPrice isEqualToString:@"0"]) {
                
                if ([self.model.myFirstPrice notEmpty]) {
                    if ([self.model.myFirstComboArray count]>0) {
                        M_QuoteComboItemModel* tempitem = [self.model.myFirstComboArray objectAtIndex:tempbtn.tag - 8000];
                        if (tempitem!=nil) {
                            if (self.block!=nil) {
                                self.block(0,tempitem);
                            }
                        }
                    }
                }
            }
        }
    }
}

-(void)libaoBtnPressed:(id)sender
{
    UIButton* tempbtn = (UIButton*)sender;
    if (tempbtn!=nil) {
        if (self.model!=nil) {
            if ([self.model.myLastPrice notEmpty] && ![self.model.myLastPrice isEqualToString:@"0"]) {
                
                if ([self.model.myLastComboArray count]>0) {
                    M_QuoteComboItemModel* tempitem = [self.model.myLastComboArray objectAtIndex:tempbtn.tag - 9000];
                    if (tempitem!=nil) {
                        if (self.block!=nil) {
                            self.block(0,tempitem);
                        }
                    }
                }
                
            }else if ([self.model.myFirstPrice notEmpty] && ![self.model.myFirstPrice isEqualToString:@"0"]) {
                if ([self.model.myFirstComboArray count]>0) {
                    M_QuoteComboItemModel* tempitem = [self.model.myFirstComboArray objectAtIndex:tempbtn.tag - 8000];
                    if (tempitem!=nil) {
                        if (self.block!=nil) {
                            self.block(0,tempitem);
                        }
                    }
                }
            }
        }
    }
}

@end
