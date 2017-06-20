//
//  M_SearchView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_SearchView.h"

@interface M_SearchView  ()

AS_MODEL_STRONG(UIImageView, myView);
AS_MODEL_STRONG(UITextField, mySearchField);
AS_MODEL_STRONG(UIImageView, mySearchIconView);

@end

@implementation M_SearchView

DEF_FACTORY_FRAME(M_SearchView);

DEF_MODEL(mySearchField);
DEF_MODEL(mySearchIconView);
DEF_MODEL(myView);

DEF_MODEL(block);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        UIImage* tempBg = [UIImage imageNamed:@"搜索框.png"];
        self.myView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (frame.size.height-35)/2, frame.size.width-20, 35)];
        self.myView.image = [tempBg stretchableImageWithLeftCapWidth:tempBg.size.width/2 topCapHeight:tempBg.size.height/2];
//        [self addSubview:self.myView];
        
        self.mySearchField = [self getTextFiled:CGRectMake(10, (self.frame.size.height-30)/2, self.frame.size.width-20, 30)];
        [self addSubview:self.mySearchField];
        self.mySearchField.placeholder = @"搜索车型";
        
        UIImage* tempIcon = [UIImage imageNamed:@"search.png"];
        
        self.mySearchIconView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tempIcon.size.width, tempIcon.size.height)];
        self.mySearchIconView.image = tempIcon;
        self.mySearchIconView.contentMode = UIViewContentModeScaleAspectFit;
        self.mySearchField.leftView = self.mySearchIconView;
        self.mySearchField.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

-(UITextField*)getTextFiled:(CGRect)frame
{
    UITextField* tempField = [[UITextField alloc]initWithFrame:frame];
    [tempField setFont:[UIFont systemFontOfSize:12]];
    [tempField setTextColor:[UIColor blackColor]];
    tempField.delegate = self;
    [tempField setBorderStyle:UITextBorderStyleNone]; //外框类型
    [tempField setBackgroundColor:RGBCOLOR(234,234,234)];
    tempField.autocorrectionType = UITextAutocorrectionTypeNo;
    tempField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tempField.returnKeyType = UIReturnKeySearch;
    tempField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    tempField.enablesReturnKeyAutomatically = YES;
    tempField.keyboardType = UIKeyboardTypeDefault;
    [tempField setTextAlignment:UITextAlignmentCenter];
    return tempField;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self hidekeyword];
    [self search];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.currFieldRect = textField.frame;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.currFieldRect = CGRectZero;
}

-(void)search
{
    self.keyword = self.mySearchField.text;
    if (self.block!=nil) {
        self.block(self.mySearchField.text);
    }
}

-(void)setKeyword:(NSString *)key
{
    _keyword = key;
    
    self.mySearchField.text = _keyword;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
