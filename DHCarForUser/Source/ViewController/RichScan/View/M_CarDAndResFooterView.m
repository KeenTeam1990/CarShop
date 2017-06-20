//
//  M_CarDAndResFooterView.m
//  DHCarForUser
//
//  Created by lucaslu on 16/4/6.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "M_CarDAndResFooterView.h"
#import "M_FieldOrButtonView.h"

#define KLeftOffset 20
#define KLabelWidth 80

#define KLineHeight 50

@interface M_CarDAndResFooterView ()

AS_MODEL_STRONG(M_FieldOrButtonView, myNameFBView);
AS_MODEL_STRONG(M_FieldOrButtonView, myPhoneFBView);
AS_MODEL_STRONG(M_FieldOrButtonView, myDealerFBView);
AS_MODEL_STRONG(M_FieldOrButtonView, myMemoFBView);
AS_MODEL_STRONG(M_FieldOrButtonView, myCodeFBView);
AS_MODEL_STRONG(M_FieldOrButtonView, myCityFBView);
AS_MODEL_STRONG(UIButton, myPayBtn);
AS_MODEL_STRONG(UILabel, myDepostLabel);
AS_MODEL_STRONG(UILabel, myDepostPriceLabel);
AS_MODEL_STRONG(UIImageView, myLine4View);
AS_MODEL_STRONG(UIView, myRow4View);

@end

@implementation M_CarDAndResFooterView


DEF_FACTORY_FRAME(M_CarDAndResFooterView);

DEF_MODEL(myDealerFBView);
DEF_MODEL(myMemoFBView);
DEF_MODEL(myNameFBView);
DEF_MODEL(myPayBtn);
DEF_MODEL(myPhoneFBView);
DEF_MODEL(myDepostLabel);
DEF_MODEL(myDepostPriceLabel);
DEF_MODEL(myRow4View);
DEF_MODEL(myLine4View);
DEF_MODEL(myCodeFBView);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self initRow4View:CGRectMake(0, 0, frame.size.width, KLineHeight)];
        
        NSInteger tempHeight = KLineHeight;
        
        self.myNameFBView = [M_FieldOrButtonView allocInstanceFrame:CGRectMake(0, tempHeight, frame.size.width, KLineHeight)];
        [self.myNameFBView updateSetting:YES withShowBtn:NO withShowDrowBtn:NO withLabel:@"*姓名称呼:" withPlaceholder:@"请输入姓名"];
        [self addSubview:self.myNameFBView];
        
        self.myPhoneFBView = [M_FieldOrButtonView allocInstanceFrame:CGRectMake(0, tempHeight+KLineHeight, frame.size.width, KLineHeight)];
        [self.myPhoneFBView updateSetting:YES withShowBtn:NO withShowDrowBtn:NO withLabel:@"*手机号码:" withPlaceholder:@"请输入您的手机号码"];
        [self addSubview:self.myPhoneFBView];
        
//        self.myCodeFBView = [M_FieldOrButtonView allocInstanceFrame:CGRectMake(0, tempHeight+KLineHeight*2, frame.size.width, KLineHeight)];
//        [self.myCodeFBView updateSetting:YES withShowBtn:YES withShowDrowBtn:NO withLabel:@"*验证码:" withPlaceholder:@"请输入验证码"];
//        [self.myCodeFBView showCodeButton];
//        [self addSubview:self.myCodeFBView];
        
        self.myCityFBView = [M_FieldOrButtonView allocInstanceFrame:CGRectMake(0, tempHeight+KLineHeight*2, frame.size.width, KLineHeight)];
        [self.myCityFBView updateSetting:YES withShowBtn:NO withShowDrowBtn:YES withLabel:@"所在城市:" withPlaceholder:@"请输入您的城市"];
        [self addSubview:self.myCityFBView];
        
        self.myMemoFBView = [M_FieldOrButtonView allocInstanceFrame:CGRectMake(0, tempHeight+KLineHeight*3, frame.size.width, 150)];
        [self.myMemoFBView updateSetting:NO withShowBtn:NO withShowDrowBtn:NO withLabel:@"补充说明：" withPlaceholder:@"备注说明"];
        [self.myMemoFBView getTextView:CGRectMake(KLeftOffset+KLabelWidth, 10, frame.size.width-KLabelWidth-KLeftOffset*2, frame.size.height-20) withImage:@"灰色输入框.png" withPlaceholder:@"备注说明"];
       
        [self addSubview:self.myMemoFBView];
        
        self.myPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.myPayBtn addTarget:self action:@selector(payBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.myPayBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor redColor];
                                                style.cornerRedius = 2;
                                                );
        [self.myPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.myPayBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self.myPayBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        self.myPayBtn.frame = CGRectMake(20, tempHeight+KLineHeight*3+150+20, frame.size.width-40, 40);
        [self addSubview:self.myPayBtn];
        
        [self initData];
        
    }
    return self;
}

-(void)initData
{
    __weak M_CarDAndResFooterView* tempSelf = self;
    
    self.myNameFBView.block = ^(NSInteger tag,id data){
        // 0 seleteBtn
        // 1 btn
        switch (tag) {
            case 2:
            {
                tempSelf.currFieldRect = tempSelf.frame;
            }
                break;
            case 3:
            {
                tempSelf.currFieldRect= CGRectZero;
            }
                break;
            default:
                break;
        }
    };
    
    self.myPhoneFBView.block = ^(NSInteger tag,id data){
        // 0 seleteBtn
        // 1 btn
        switch (tag) {
            case 2:
            {
                tempSelf.currFieldRect = tempSelf.myPhoneFBView.frame;
            }
                break;
            case 3:
            {
                tempSelf.currFieldRect= CGRectZero;
            }
                break;
            default:
                break;
        }
    };
    
    self.myMemoFBView.block = ^(NSInteger tag,id data){
        // 0 seleteBtn
        // 1 btn
        switch (tag) {
            case 2:
            {
                tempSelf.currFieldRect = tempSelf.myMemoFBView.frame;
            }
                break;
            case 3:
            {
                tempSelf.currFieldRect= CGRectZero;
            }
                break;
            default:
                break;
        }
    };
    
    self.myCodeFBView.block = ^(NSInteger tag,id data){
        // 0 seleteBtn
        // 1 btn
        switch (tag) {
            case 1:
            {
                if (tempSelf.block!=nil) {
                    tempSelf.block(5,[tempSelf.myPhoneFBView getText]);
                }
            }
                break;
            case 2:
                {
                    tempSelf.currFieldRect = tempSelf.myCodeFBView.frame;
                }
                break;
            case 3:
                {
                    tempSelf.currFieldRect= CGRectZero;
                }
                break;
            default:
                break;
        }
    };
}


-(void)initRow4View:(CGRect)frame
{
    self.myRow4View = [[UIView alloc]initWithFrame:frame];
    [self addSubview:self.myRow4View];
    
    self.myDepostLabel = [self getLabel:CGRectMake(KLeftOffset, (frame.size.height-30)/2, KLabelWidth, 30)];
    self.myDepostLabel.text = @"预付订金：";
    [self.myRow4View addSubview:self.myDepostLabel];
    
    self.myDepostPriceLabel = [self getLabel:CGRectMake(KLeftOffset+KLabelWidth, (frame.size.height-30)/2, frame.size.width-KLeftOffset*2-KLabelWidth, 30)];
    self.myDepostPriceLabel.textColor = [UIColor redColor];
    [self.myRow4View addSubview:self.myDepostPriceLabel];
    
    self.myLine4View = [self getLineView:CGRectMake(20, frame.size.height-1, frame.size.width-40, 1)];
    self.myLine4View.backgroundColor = [UIColor clearColor];
    self.myLine4View.image = [UIImage imageNamed:@"dashedLine.png"];
    [self.myRow4View addSubview:self.myLine4View];
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
    UIImageView* tempLine = [[UIImageView alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    [tempLine setBackgroundColor:RGBCOLOR(186, 186, 187)];
    return tempLine;
}

-(void)updateData:(M_CarItemModel*)model withCarType:(TCarBottomType)type
{
    if (model!=nil) {
        if ([model.myCar_Deposit notEmpty]) {
            self.myDepostPriceLabel.text = [NSString stringWithFormat:@"%@元",model.myCar_Deposit];
        }
        
        if ([[DLAppData sharedInstance].myUserName notEmpty]) {
            NSString* tempPhone = [DLAppData sharedInstance].myUserName;
            [self.myPhoneFBView updateFiledContent:tempPhone];
        }
        
        if ([APPDELEGATE.viewController.myUserModel.user_nick notEmpty]) {
            [self.myNameFBView updateContent:APPDELEGATE.viewController.myUserModel.user_nick];
        }
        
        if (APPDELEGATE.viewController.myCityModel!=nil) {
            [self.myCityFBView updateContent:APPDELEGATE.viewController.myCityModel.myCity_Name];
        }
    }
}

-(void)seletePolicyBtnPressed:(id)sender
{
    if (self.block!=nil) {
        self.block(7,nil);
    }
}

-(void)payBtnPressed:(id)sender
{
    NSString* tempName = [self.myNameFBView getText];
    NSString* tempMemo = [self.myMemoFBView getTextViewText];
    NSString* tempPhone = [self.myPhoneFBView getText];
//    NSString* tempCode = [self.myCodeFBView getText];

    if ([tempName empty]) {
        [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
     
        return;
    }
    if ([tempPhone empty]) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (![tempPhone isTelephone]) {
        [SVProgressHUD showErrorWithStatus:@"请输入11位的手机号"];
        return;
    }
    
//    if ([tempCode empty]) {
//        [SVProgressHUD showErrorWithStatus:@"请输入短信验证码"];
//        return;
//    }
    
    NSMutableDictionary* tempDic = [NSMutableDictionary dictionary];
    
    [tempDic setObject:tempName forKey:@"name"];
    [tempDic setObject:tempPhone forKey:@"phone"];
//    [tempDic setObject:tempCode forKey:@"code"];
    
    if ([tempMemo notEmpty]) {
        [tempDic setObject:tempMemo forKey:@"memo"];
    }
    if (self.block!=nil) {
        self.block(8,tempDic);
    }
}

-(void)updateContent:(id)data withTag:(NSInteger)tag
{
    if (tag == 9) {
        [self.myPhoneFBView updateContent:data];
        [self.myPhoneFBView updateSetting:YES withShowBtn:NO withShowDrowBtn:NO withLabel:@"*手机号码:" withPlaceholder:@"请输入您的手机号码"];
    }
}

-(void)getCodeFinish
{
    [self.myCodeFBView getCodeFinish];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
