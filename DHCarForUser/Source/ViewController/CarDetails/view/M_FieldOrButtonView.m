//
//  M_FieldOrButtonView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_FieldOrButtonView.h"

#define KLeftOffset 20
#define KLabelWidth 80

#define KMAX_TIMER 60

@interface M_FieldOrButtonView ()<UITextViewDelegate,UITextViewDelegate>

AS_MODEL_STRONG(UITextView, messageView);
AS_MODEL_STRONG(UILabel, myLabel);
AS_MODEL_STRONG(UIButton, myButtonView);
AS_MODEL_STRONG(UITextField, myFieldView);
AS_MODEL_STRONG(UIButton, myBtn);
AS_MODEL_STRONG(UIImageView, myLineView);
AS_MODEL_STRONG(NSTimer, myTimer);
AS_INT(currIndex);

@end

@implementation M_FieldOrButtonView

DEF_FACTORY_FRAME(M_FieldOrButtonView);

DEF_MODEL(myBtn);
DEF_MODEL(myButtonView);
DEF_MODEL(myFieldView);
DEF_MODEL(myLabel);
DEF_MODEL(myLineView);
DEF_MODEL(myTimer);
DEF_MODEL(currIndex);
DEF_MODEL(messageView);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.currIndex = KMAX_TIMER;
        
        self.myLabel = [self getLabel:CGRectMake(KLeftOffset, 10, KLabelWidth, 30)];
        //self.myLabel.numberOfLines = 0;
        
        self.myButtonView = [self getSeleteButton:CGRectMake(KLeftOffset+KLabelWidth, 10, frame.size.width-KLabelWidth-KLeftOffset*2, frame.size.height-20) withBgImage:@"灰色输入框.png"];
        self.myButtonView.hidden = YES;
        
//        self.messageView = [self getTextView:CGRectMake(KLeftOffset+KLabelWidth, 10, frame.size.width-KLabelWidth-KLeftOffset*2, frame.size.height-20) withImage:@"灰色输入框.png" withPlaceholder:@""];

        
        self.myFieldView = [self getTextFiled:CGRectMake(KLeftOffset+KLabelWidth, 10, frame.size.width-KLabelWidth-KLeftOffset*2, frame.size.height-20) withImage:@"灰色输入框.png" withPlaceholder:@""];
        self.myFieldView.hidden = YES;
        
        self.myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.myBtn.frame = CGRectMake(frame.size.width-KLeftOffset-70, 10, 70, frame.size.height-20);
        [self.myBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.myBtn.backgroundColor = [UIColor redColor];
        [self.myBtn.layer setMasksToBounds:YES];
        [self.myBtn.layer setCornerRadius:5];
        [self.myBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [self.myBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self.myBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.myBtn];
        self.myBtn.hidden = YES;
        
        //self.myLineView = [self getLineView:frame];
        
        [self initTimer];
    }
    return self;
}



-(void)initTimer
{
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
    [self stop];
}

-(void)scrollTimer
{
    self.currIndex--;
    
    if (self.currIndex < 0) {
        self.currIndex = KMAX_TIMER;
        self.myBtn.userInteractionEnabled = YES;
        [self.myBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [self stop];
        return;
    }
    
    [self.myBtn setTitle:[NSString stringWithFormat:@"已发送%ld",(long)self.currIndex] forState:UIControlStateNormal];
    self.myBtn.userInteractionEnabled = NO;
}

-(void)start
{
    //开启定时器
    [self.myTimer setFireDate:[NSDate distantPast]];
}
-(void)stop
{
    //关闭定时器
    [self.myTimer setFireDate:[NSDate distantFuture]];
}

-(void)afterInterval:(float)interval
{
    [self.myTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
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
    UIImageView* tempLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
    [tempLine setBackgroundColor:RGBCOLOR(186, 186, 187)];
    [self addSubview:tempLine];
    return tempLine;
}

-(NSString*)getTextViewText;
{
    return self.messageView.text;
}

-(void)getTextView:(CGRect)frame withImage:(NSString *)image withPlaceholder:(NSString *)placeholder
{
    UITextView *tempMessageView = [[UITextView alloc] initWithFrame:CGRectMake(KLeftOffset+KLabelWidth, 10, self.frame.size.width-KLabelWidth-KLeftOffset*2, self.frame.size.height-20)];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[tempMessageView bounds]];
//    
//    imageView.image = [UIImage imageNamed:image];
//    
//    [tempMessageView addSubview:imageView];
//    
//    [tempMessageView sendSubviewToBack:imageView];
    
    //初始化
    tempMessageView.tag = 101;
    tempMessageView.textColor = [UIColor blackColor];
    tempMessageView.font = [UIFont fontWithName:@"Arial" size:13.0];
    [tempMessageView.layer setCornerRadius:5];
    tempMessageView.delegate = self;
//    tempMessageView. = @"请输入专场的介绍内容!";
    tempMessageView.backgroundColor = [UIColor colorWithRed:0.945 green:0.945 blue:0.945 alpha:1.0];
    tempMessageView.returnKeyType = UIReturnKeyDefault;
    tempMessageView.scrollEnabled = YES;
    tempMessageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.messageView = tempMessageView;
    tempMessageView.delegate = self;
   
    
    UILabel *textLable =[[UILabel alloc]init];
    textLable.frame = CGRectMake(0, 0,frame.size.width, 20);
    textLable.text = @"备注说明";
    textLable.font =[UIFont fontWithName:@"Arial" size:13.0];
    textLable.textColor = [UIColor grayColor];
    textLable.textAlignment = NSTextAlignmentLeft;
    textLable.tag =1011;
    [self.messageView addSubview:textLable];
    [self addSubview: self.messageView];
}

-(UITextField*)getTextFiled:(CGRect)frame withImage:(NSString *)image withPlaceholder:(NSString *)placeholder
{
    UIImage* tempBg = [UIImage imageNamed:image];
    
    UITextField* tempField = [[UITextField alloc]initWithFrame:frame];
    [tempField setFont:[UIFont systemFontOfSize:14]];
    [tempField setTextColor:[UIColor blackColor]];
    tempField.delegate = self;
    [tempField setBorderStyle:UITextBorderStyleNone]; //外框类型
    tempField.placeholder = placeholder; //默认显示的字
    tempField.autocorrectionType = UITextAutocorrectionTypeNo;
    tempField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tempField.returnKeyType = UIReturnKeyDone;
    tempField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    tempField.enablesReturnKeyAutomatically = YES;
    tempField.keyboardType = UIKeyboardTypeDefault;
    tempField.background = [tempBg stretchableImageWithLeftCapWidth:tempBg.size.width/2 topCapHeight:tempBg.size.height/2];
    
    UIView* tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, frame.size.height)];
    
    tempField.leftView = tempView;
    tempField.leftViewMode = UITextFieldViewModeAlways;
    
    [self addSubview:tempField];
    
    return tempField;
}

-(UIButton*)getSeleteButton:(CGRect)frame withBgImage:(NSString*)image
{
    UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tempBtn.frame = frame;
    
    [tempBtn addTarget:self action:@selector(seleteBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage* tempImage = [UIImage imageNamed:image];
    
    [tempBtn setBackgroundImage:[tempImage stretchableImageWithLeftCapWidth:tempImage.size.width/2 topCapHeight:tempImage.size.height/2] forState:UIControlStateNormal];
    
    [tempBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [tempBtn setTitleColor:RGBCOLOR(202, 202, 202) forState:UIControlStateNormal];
    [tempBtn.layer setMasksToBounds:YES];
    [tempBtn.layer setCornerRadius:5];
    
    [tempBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [tempBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    UIButton* tempRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tempRightBtn.frame = CGRectMake(frame.size.width-frame.size.height, 2, frame.size.height-2, frame.size.height-4);
    tempRightBtn.backgroundColor = [UIColor whiteColor];
    UIImage* tempDronImage = [UIImage imageNamed:@"下拉.png"];
    [tempRightBtn setImage:tempDronImage forState:UIControlStateNormal];
    tempRightBtn.userInteractionEnabled = NO;
    tempRightBtn.tag = 1001;
    [tempBtn addSubview:tempRightBtn];
    
    [self addSubview:tempBtn];
    return tempBtn;
}

-(void)seleteBtnPressed:(id)sender
{
    if (self.block!=nil) {
        self.block(0,self.myButtonView.titleLabel.text);
    }
}

-(void)btnPressed:(id)sender
{
    if (self.block!=nil) {
        self.block(1,self.myFieldView.text);
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.block!=nil) {
        self.block(2,nil);
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.block!=nil) {
        self.block(3,nil);
    }
}

-(void)showDrowButton:(BOOL)showDrow
{
    self.myButtonView.hidden = !showDrow;
    self.myFieldView.hidden = showDrow;
    self.myFieldView.userInteractionEnabled = NO;
    self.myButtonView.userInteractionEnabled = showDrow;
}

-(void)showCodeButton
{
    UIButton* tempDrow = [self.myButtonView viewWithTag:1001];
    if (tempDrow!=nil) {
        tempDrow.hidden = YES;
    }
    
    CGRect tempFrame = self.myFieldView.frame;
    tempFrame.size.width = self.frame.size.width-KLabelWidth-KLeftOffset*2-80;
    self.myFieldView.frame = tempFrame;
    
    self.myBtn.hidden = NO;
    self.myButtonView.hidden = YES;
    self.myFieldView.hidden = NO;
    self.myFieldView.userInteractionEnabled = YES;
}

-(void)updateSetting:(BOOL)showField withShowBtn:(BOOL)showBtn withShowDrowBtn:(BOOL)showDrow withLabel:(NSString*)label withPlaceholder:(NSString*)placeholder
{
//    self.myBtn.hidden = !showBtn;
    self.myButtonView.hidden = !showDrow;
    self.myFieldView.hidden = !showField;
    
    if ([label notEmpty]) {
        self.myLabel.text = label;
        
        NSRange tempPos = [label rangeOfString:@"*"];
        
        if (tempPos.length >0) {
            if (tempPos.location == 0) {
                NSMutableAttributedString* tempAttr = [[NSMutableAttributedString alloc]initWithString:label];
                [tempAttr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:tempPos];
                self.myLabel.attributedText = tempAttr;
            }
        }
    }
    
    if ([placeholder notEmpty]) {
        
        if (showField) {
            self.myFieldView.placeholder = placeholder;
        }
        if (showDrow) {
            [self.myButtonView setTitle:placeholder forState:UIControlStateNormal];
        }
    }
    
//    if (showBtn) {
//        CGRect tempFrame = self.myFieldView.frame;
//        tempFrame.size.width = self.frame.size.width-KLabelWidth-KLeftOffset*2-80;
//        self.myFieldView.frame = tempFrame;
//        
//    }else{
        CGRect tempFrame = self.myFieldView.frame;
        tempFrame.size.width = self.frame.size.width-KLabelWidth-KLeftOffset*2;
        self.myFieldView.frame = tempFrame;
//    }
    
    if (showBtn && showDrow) {
        UIButton* tempDrow = [self.myButtonView viewWithTag:1001];
        if (tempDrow!=nil) {
            tempDrow.hidden = YES;
        }
    }else{
        if (showDrow && showField) {
            self.myFieldView.userInteractionEnabled = NO;
            self.myButtonView.hidden = YES;
        }else{
            self.myFieldView.userInteractionEnabled = YES;
        }
    }
}

-(void)updateFiledContent:(NSString *)content
{
    self.myFieldView.text = content;
}

-(void)updateContent:(NSString*)content
{
    if (!self.myFieldView.hidden) {
        self.myFieldView.text = content;
    }
    
    if (!self.myButtonView.hidden) {
        [self.myButtonView setTitle:content forState:UIControlStateNormal];
        
        if ([content length]>0) {
            [self.myButtonView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else{
            [self.myButtonView setTitleColor:RGBCOLOR(202, 202, 202) forState:UIControlStateNormal];
        }
    }
}

-(NSString*)getText
{
    NSString* tempResult = @"";
    if (!self.myFieldView.hidden) {
        tempResult = self.myFieldView.text;
    }
    
    if (!self.myButtonView.hidden) {
        tempResult =  self.myButtonView.titleLabel.text;
    }
    return tempResult;
}

-(void)getCodeFinish
{
    [self start];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.tag == 101) {
        UILabel *lable = [textView viewWithTag:1011];
        lable.hidden = YES;
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.tag ==101 && [textView.text isEqualToString:@""]) {
        UILabel *lable = [textView viewWithTag:1011];
        lable.hidden = NO;
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
