//
//  M_NameView.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_NameView.h"
#define titleButtonSize 14
@implementation M_NameView
@synthesize cb_Btn;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initNameView:CGRectMake(30, 100, SCREEN_WIDTH-60, 40)];
        [self initWihtCommitButtomWithFrame:CGRectMake(CGRectGetMinX(self.nameTF.frame), CGRectGetMaxY(self.nameTF.frame)+30, SCREEN_WIDTH-60, 40)];
    }
    return self;
}

-(void)initNameView:(CGRect)frame
{
    //UIImage* tempPhoneIcon = [UIImage imageNamed:@"输入图标手机号.png"];
    
    self.nameTF = [self getTextFiled:frame];
    self.nameTF.placeholder = @"请输入姓名"; //默认显示的字
    [self addSubview:self.nameTF];
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
//    tempField.returnKeyType = UIReturnKeyDone;
    tempField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    tempField.enablesReturnKeyAutomatically = YES;
    //tempField.keyboardType = UIKeyboardTypeNumberPad;
    tempField.background = [tempBg stretchableImageWithLeftCapWidth:tempBg.size.width/2 topCapHeight:tempBg.size.height/2];
    
    //    [self addSubview:tempField];
    
    return tempField;
}
-(void)initWihtCommitButtomWithFrame:(CGRect)frame
{
    __weak M_NameView* tempSelf= self;
       self.cb_Btn =[CB_Button buttonWithFram:frame backgroundImages:@"登录.png" title:@"提交" andBlock:^{
        NSLog(@"提交按钮");
        if (_block!=nil) {

            _block(tempSelf.nameTF.text);
        };
    }];
    self.cb_Btn.titleLabel.font=[UIFont systemFontOfSize:titleButtonSize];
    [self addSubview:self.cb_Btn];
}
#pragma mark textfileDelegate
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.nameTF resignFirstResponder];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
