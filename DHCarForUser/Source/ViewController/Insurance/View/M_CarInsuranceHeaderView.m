//
//  M_CarInsuranceHeaderView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarInsuranceHeaderView.h"

#define KLeftOffset 20
#define KLabelWidth 70

@interface M_CarInsuranceHeaderView ()

AS_MODEL_STRONG(UITextField, myCarPlateLabel);
AS_MODEL_STRONG(UITextField, myCarFrameLabel);
AS_MODEL_STRONG(UIButton, myCompanyBtn);
AS_MODEL_STRONG(UIButton, mySumbitBtn);

@end

@implementation M_CarInsuranceHeaderView

DEF_FACTORY_FRAME(M_CarInsuranceHeaderView);

DEF_MODEL(myCarFrameLabel);
DEF_MODEL(myCarPlateLabel);
DEF_MODEL(myCompanyBtn);
DEF_MODEL(mySumbitBtn);
DEF_MODEL(block);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.myCarPlateLabel = [self row2View:CGRectMake(0, 20, frame.size.width, 50)
                                    withLabel:@"车牌号"
                                      withTag:1000
                              withPlaceholder:@"请输入车牌号"];
        
        self.myCarFrameLabel = [self row2View:CGRectMake(0, 70, frame.size.width, 50)
                                    withLabel:@"车架号"
                                      withTag:1001
                              withPlaceholder:@"请输入车架号"];
        
        self.myCompanyBtn = [self row1View:CGRectMake(0, 120, frame.size.width, 50)
                                 withLabel:@"保险公司"
                                   withTag:1002];
        
        UIImage* tempBtnBg = [UIImage imageNamed:@"登录.png"];
        UIImage* tempBtn_HBg = [UIImage imageNamed:@"登录按下.png"];
        
        self.mySumbitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.mySumbitBtn addTarget:self action:@selector(sumbitBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.mySumbitBtn setBackgroundImage:[tempBtnBg stretchableImageWithLeftCapWidth:tempBtnBg.size.width/2 topCapHeight:tempBtnBg.size.height/2] forState:UIControlStateNormal];
        [self.mySumbitBtn setBackgroundImage:[tempBtn_HBg stretchableImageWithLeftCapWidth:tempBtn_HBg.size.width/2 topCapHeight:tempBtn_HBg.size.height/2] forState:UIControlStateHighlighted];
        [self.mySumbitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [self.mySumbitBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        self.mySumbitBtn.frame = CGRectMake(KLeftOffset, 250, frame.size.width-KLeftOffset*2, 40);
        [self addSubview:self.mySumbitBtn];
        
    }
    return self;
}

-(UITextField*)row2View:(CGRect)frame withLabel:(NSString*)label withTag:(NSInteger)tag withPlaceholder:(NSString*)placeholder
{
    UILabel* tempLabel = [self getLabel:CGRectMake(KLeftOffset, frame.origin.y+(frame.size.height-30)/2, KLabelWidth, 30)];
    tempLabel.text = label;
    
    UITextField* tempBtn = [self getTextFiled:CGRectMake(KLeftOffset+KLabelWidth+KLeftOffset/2, frame.origin.y+(frame.size.height-40)/2, frame.size.width-KLeftOffset*2-KLabelWidth-KLeftOffset/2, 40)];
    tempBtn.placeholder = placeholder; //默认显示的字
    tempBtn.returnKeyType = UIReturnKeyDone;
    tempBtn.tag = tag;
    
    UIImageView* tempLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, frame.origin.y+frame.size.height-1, frame.size.width, 1)];
    tempLine.backgroundColor = RGBCOLOR(157, 157, 158);
    [self addSubview:tempLine];
    
    return tempBtn;
}

-(UIButton*)row1View:(CGRect)frame  withLabel:(NSString*)label withTag:(NSInteger)tag
{
    UILabel* tempLabel = [self getLabel:CGRectMake(KLeftOffset, frame.origin.y+(frame.size.height-30)/2, KLabelWidth, 30)];
    tempLabel.text = label;
    
    UIButton* tempBtn = [self getDropView:CGRectMake(KLeftOffset+KLabelWidth+KLeftOffset/2, frame.origin.y+(frame.size.height-40)/2, frame.size.width-KLeftOffset*2-KLabelWidth-KLeftOffset/2, 40)];
    tempBtn.tag = tag;
    
    UIImageView* tempLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, frame.origin.y+frame.size.height-1, frame.size.width, 1)];
    tempLine.backgroundColor = RGBCOLOR(157, 157, 158);
    [self addSubview:tempLine];
    
    return tempBtn;
}


-(UITextField*)getTextFiled:(CGRect)frame
{
    UIImage* tempBg = [UIImage imageNamed:@"灰色输入框.png"];
    
    UITextField* tempField = [[UITextField alloc]initWithFrame:frame];
    [tempField setFont:[UIFont systemFontOfSize:14]];
    [tempField setTextColor:[UIColor blackColor]];
    tempField.delegate = self;
    [tempField setBorderStyle:UITextBorderStyleNone]; //外框类型
    
    tempField.autocorrectionType = UITextAutocorrectionTypeNo;
    tempField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tempField.returnKeyType = UIReturnKeyDone;
    tempField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    tempField.enablesReturnKeyAutomatically = YES;
    tempField.keyboardType = UIKeyboardTypeNumberPad;
    tempField.background = [tempBg stretchableImageWithLeftCapWidth:tempBg.size.width/2 topCapHeight:tempBg.size.height/2];
    
    UIView* tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    tempField.leftView = tempView;
    tempField.leftViewMode = UITextFieldViewModeAlways;
    
    [self addSubview:tempField];
    
    return tempField;
}


-(UIButton*)getDropView:(CGRect)frame
{
    UIImage* tempBackBg = [UIImage imageNamed:@"灰色输入框.png"];
    UIImage* tempArrowIcon = [UIImage imageNamed:@"下拉.png"];
    
    UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tempBtn setBackgroundImage:[tempBackBg stretchableImageWithLeftCapWidth:tempBackBg.size.width/2 topCapHeight:tempBackBg.size.height/2] forState:UIControlStateNormal];
    [tempBtn addTarget:self action:@selector(itemBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    tempBtn.frame = frame;
    [tempBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    tempBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10+frame.size.height);
    [tempBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    UIButton* tempArrowbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tempArrowbtn.frame = CGRectMake(frame.size.width-frame.size.height, 1, frame.size.height-2, frame.size.height-2);
    tempArrowbtn.backgroundColor = [UIColor whiteColor];
    [tempArrowbtn setImage:tempArrowIcon forState:UIControlStateNormal];
    tempArrowbtn.userInteractionEnabled = NO;
    [tempBtn addSubview:tempArrowbtn];
    [self addSubview:tempBtn];
    return tempBtn;
}

-(UILabel*)getLabel:(CGRect)frame
{
    UILabel* tempLabel = [[UILabel alloc]initWithFrame:frame];
    [tempLabel setBackgroundColor:[UIColor clearColor]];
    [tempLabel setFont:[UIFont systemFontOfSize:14]];
    [tempLabel setTextColor:[UIColor blackColor]];
    [self addSubview:tempLabel];
    return tempLabel;
}

-(void)sumbitBtnPressed:(id)sender
{
    NSString* tempLabel1 = self.myCarPlateLabel.text ;
    NSString* tempLabel2 = self.myCarFrameLabel.text ;
    
    if ([tempLabel1 empty]) {
        [SVProgressHUD showErrorWithStatus:@"请输入车牌号"];
        return;
    }
    
    if ([tempLabel2 empty]) {
        [SVProgressHUD showErrorWithStatus:@"请输入车架号"];
        return;
    }
    
    NSMutableDictionary* tempDic = [NSMutableDictionary dictionary];
    
    [tempDic setObject:tempLabel1 forKey:@"label1"];
    [tempDic setObject:tempLabel2 forKey:@"label2"];
    
    if (self.block!=nil) {
        self.block(0,tempDic);
    }
}

-(void)itemBtnPressed:(id)sender
{
    UIButton* tempbtn = (UIButton*)sender;
    
    if (self.block!=nil) {
        self.block(1,tempbtn.titleLabel.text);
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.currFieldRect = textField.frame;
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.currFieldRect = CGRectZero;
}

-(void)updateData:(NSString*)data
{
    if ([data notEmpty]) {
        [self.myCompanyBtn setTitle:data forState:UIControlStateNormal];
    }}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
