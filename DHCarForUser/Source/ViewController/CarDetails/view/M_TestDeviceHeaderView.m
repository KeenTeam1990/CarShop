//
//  M_TestDeviceHeaderView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_TestDeviceHeaderView.h"
#import "M_FieldOrButtonView.h"
#import "M_CarDistributorItemView.h"
#import "M_DealerItemModel.h"

#define KLeftOffset 10
#define KLineHeight 50

@interface M_TestDeviceHeaderView  ()

AS_MODEL_STRONG(UIImageView, myImageView);
AS_MODEL_STRONG(UILabel, myNameLabel);

AS_MODEL_STRONG(UIImageView, myLineView1);
AS_MODEL_STRONG(UIImageView, myLineView2);

AS_MODEL_STRONG(M_FieldOrButtonView, myNameView);
AS_MODEL_STRONG(M_FieldOrButtonView, myPhoneView);
AS_MODEL_STRONG(M_FieldOrButtonView, myTimeView);
AS_MODEL_STRONG(M_FieldOrButtonView, myMemoView);
AS_MODEL_STRONG(M_CarDistributorItemView, myDealerItemView);
AS_MODEL_STRONG(M_DealerItemModel, myDealerItemModel);

AS_MODEL_STRONG(UIButton, mySureBtn);

@end

@implementation M_TestDeviceHeaderView

DEF_FACTORY_FRAME(M_TestDeviceHeaderView);

DEF_MODEL(myMemoView);
DEF_MODEL(myNameView);
DEF_MODEL(myTimeView);
DEF_MODEL(myPhoneView);
DEF_MODEL(mySureBtn);
DEF_MODEL(myDealerItemView);
DEF_MODEL(myDealerItemModel);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        UILabel* tempClew = [self getLabel:CGRectMake(KLeftOffset, 5, frame.size.width-KLeftOffset*2, 20)];
        tempClew.tag = 9001;
        tempClew.backgroundColor = RGBCOLOR(166, 166, 167);
        [tempClew.layer setMasksToBounds:YES];
        tempClew.layer.cornerRadius = 5;
        [tempClew setTextColor:[UIColor whiteColor]];
        [tempClew setNumberOfLines:1];
        tempClew.font = [UIFont systemFontOfSize:10];
        [tempClew setTextAlignment:UITextAlignmentCenter];
        [tempClew setText:@"想试乘试驾，请填写如下信息给经销商（信息保密，不对外公开）"];
        
        NSInteger im_W = self.bounds.size.width/2-KLeftOffset*2;
        
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(KLeftOffset, 35, im_W, 100)];
        self.myImageView.image = [UIImage imageNamed:@"tempcar.jpg"];
        self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.myImageView];
        
        self.myNameLabel = [self getLabel:CGRectMake(KLeftOffset*2+im_W, 35, self.frame.size.width-KLeftOffset*3-im_W, 100)];
        [self.myNameLabel setFont:[UIFont systemFontOfSize:14]];
        [self.myNameLabel setTextColor:[UIColor blackColor]];
        [self.myNameLabel setNumberOfLines:3];
        
        [self getLineView:CGRectMake(0, 140, frame.size.width, 10)];
        
        self.myDealerItemView = [M_CarDistributorItemView allocInstanceFrame:CGRectMake(0, 150, frame.size.width, 120)];
        [self addSubview:self.myDealerItemView];
        
        UIButton * myOpenCallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        myOpenCallBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor]; style.borderWidth = 1;
                                                style.borderColor = [UIColor grayColor];
                                                style.cornerRedius = 5;);
        myOpenCallBtn.tintColor = [UIColor blackColor];
        [myOpenCallBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [myOpenCallBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        myOpenCallBtn.frame = CGRectMake(frame.size.width-110, 120-35, 80, 30);
        [myOpenCallBtn addTarget:self action:@selector(openCallBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [myOpenCallBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
        myOpenCallBtn.userInteractionEnabled = YES;
        [self.myDealerItemView addSubview:myOpenCallBtn];
        
        
        [self getLineView:CGRectMake(0, 270, frame.size.width, 10)];
        
        NSInteger tempH = 280;
        
        self.myNameView = [M_FieldOrButtonView allocInstanceFrame:CGRectMake(0, tempH, frame.size.width, KLineHeight)];
        [self.myNameView updateSetting:YES withShowBtn:NO withShowDrowBtn:NO withLabel:@"*姓名称呼:" withPlaceholder:@"请输入姓名"];
        [self addSubview:self.myNameView];
        
        self.myPhoneView = [M_FieldOrButtonView allocInstanceFrame:CGRectMake(0, tempH+KLineHeight, frame.size.width, KLineHeight)];
        [self.myPhoneView updateSetting:YES withShowBtn:NO withShowDrowBtn:YES withLabel:@"*手机号码:" withPlaceholder:@"请输入手机"];
        [self addSubview:self.myPhoneView];
        
        self.myTimeView = [M_FieldOrButtonView allocInstanceFrame:CGRectMake(0, tempH+KLineHeight*2, frame.size.width, KLineHeight)];
        [self.myTimeView updateSetting:NO withShowBtn:NO withShowDrowBtn:YES withLabel:@"*预约时间:" withPlaceholder:@"请选择预约时间"];
        [self addSubview:self.myTimeView];
        
        self.myMemoView = [M_FieldOrButtonView allocInstanceFrame:CGRectMake(0, tempH+KLineHeight*3, frame.size.width, 150)];
        [self.myMemoView updateSetting:NO withShowBtn:NO withShowDrowBtn:NO withLabel:@"补充说明：" withPlaceholder:@"备注说明"];
        [self.myMemoView getTextView:CGRectMake(0, tempH+KLineHeight*3, frame.size.width, 150) withImage:@"灰色输入框.png" withPlaceholder:nil];
        [self addSubview:self.myMemoView];
        
        self.mySureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.mySureBtn addTarget:self action:@selector(sureBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.mySureBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor redColor];
                                                 style.cornerRedius = 2;);
        [self.mySureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.mySureBtn setTitle:@"提交" forState:UIControlStateNormal];
        [self.mySureBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        self.mySureBtn.frame = CGRectMake(20, tempH+KLineHeight*3+150+20, frame.size.width-40, 40);
        [self addSubview:self.mySureBtn];
        
        [self initData];
    }
    
    return self;
}
-(void)openCallBtnPressed:(UIButton *)btn
{
    if(self.block != nil){
        self.block(10,self.myDealerItemModel);
    }
}
-(void)initData
{
    __weak M_TestDeviceHeaderView* tempSelf = self;
    
    self.myNameView.block = ^(NSInteger tag,id data){
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
    
    self.myPhoneView.block = ^(NSInteger tag,id data){
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
    
    self.myMemoView.block = ^(NSInteger tag,id data){
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
    self.myTimeView.block = ^(NSInteger tag,id data){
        // 0 seleteBtn
        // 1 btn
        switch (tag) {
            case 0:
            {
                if (tempSelf.block!=nil) {
                    tempSelf.block(6,data);
                }
            }
                break;
            default:
                break;
        }
    };

}

-(void)updateDealerData:(M_DealerItemModel*)data
{
    if (data!=nil) {
        
        self.myDealerItemModel = data;
        
        [self.myDealerItemView updateData:self.myDealerItemModel];
    }
}

-(void)sureBtnPressed:(id)sender
{
    NSString* tempName = [self.myNameView getText];
    NSString* tempPhone = [self.myPhoneView getText];
    NSString* tempTime = [self.myTimeView getText];
    NSString* tempMemo = [self.myMemoView getTextViewText];
    
    if ([tempName length] == 0||tempName==nil) {
        [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
        return;
    }
    
    if ([tempPhone length] == 0||tempPhone == nil) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    
    if (tempTime == nil || tempTime.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择预约时间"];
        return;
    }
    
    NSMutableDictionary* tempDic = [NSMutableDictionary dictionary];
    
    [tempDic setObject:tempName forKey:@"name"];
    [tempDic setObject:tempPhone forKey:@"phone"];
     [tempDic setObject:tempTime forKey:@"time"];
    
    if ([tempMemo notEmpty]) {
        [tempDic setObject:tempMemo forKey:@"memo"];
    }
    if (self.block!=nil) {
        self.block(8,tempDic);
    }
}


-(UILabel*)getLabel:(CGRect)frame
{
    UILabel* tempLabel = [[UILabel alloc]initWithFrame:frame];
    [tempLabel setBackgroundColor:[UIColor clearColor]];
    [tempLabel setFont:[UIFont systemFontOfSize:14]];
    [tempLabel setTextColor:RGBCOLOR(102, 102, 102)];
    [self addSubview:tempLabel];
    return tempLabel;
}

-(UIImageView*)getLineView:(CGRect)frame
{
    UIImageView* tempLine = [[UIImageView alloc]initWithFrame:frame];
    [tempLine setBackgroundColor:[Unity getGrayBackColor]];
    [self addSubview:tempLine];
    return tempLine;
}

-(void)updateData:(M_CarItemModel*)model
{
    if (model!=nil) {
        
        if ([model.myCar_Img notEmpty]) {
            [self.myImageView setImageWithURL:[NSURL URLWithString:model.myCar_Img] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
        }
        
        if ( [model.myBrand_Name notEmpty] && [model.myCar_Year notEmpty] &&
            [model.mySubbrand_Name notEmpty] && [model.myCar_Name notEmpty]) {
            self.myNameLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",model.myBrand_Name ,model.mySubbrand_Name,model.myCar_Year,model.myCar_Name];
        }
        
        if ([[DLAppData sharedInstance].myUserName notEmpty]) {
            NSString* tempPhone = [DLAppData sharedInstance].myUserName;
            [self.myPhoneView updateFiledContent:tempPhone];
        }
        
        if ([APPDELEGATE.viewController.myUserModel.user_nick notEmpty]) {
            [self.myNameView updateContent:APPDELEGATE.viewController.myUserModel.user_nick];
        }
    }
}

-(void)updateContent:(id)data withTag:(NSInteger)tag
{
    switch (tag) {
        case 6://time
            [self.myTimeView updateContent:data];
            break;
        case 9:
            [self.myPhoneView updateContent:data];
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
