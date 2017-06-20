//
//  D_ConfigHeadView.m
//  DHCarForSales
//
//  Created by leiyu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_ConfigHeadView.h"
#import "LLLable.h"
//#import "M_SalesInfoModel.h"
#import "M_UserInfoModel.h"

#define headImageViewWidth  80
#define userNameLableSize   20
#define userSexImageViewWidth 30

@interface D_ConfigHeadView()
AS_MODEL_STRONG(UIImageView, headImageView);
AS_MODEL_STRONG(LLLable, userNameLable);
AS_MODEL_STRONG(UIImageView, userSexImageView);
@end
@implementation D_ConfigHeadView

DEF_FACTORY_FRAME(D_ConfigHeadView);
DEF_MODEL(headImageView);
DEF_MODEL(userNameLable);
DEF_MODEL(userSexImageView);
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.headImageView=[[UIImageView alloc]init];
        ViewRadius(self.headImageView, headImageViewWidth/2);
        [self addSubview:self.headImageView];
        
        self.userNameLable=[LLLable labelWithBoldColor:RGBCOLOR(0, 0, 0) andTextFont:userNameLableSize];
        [self addSubview:self.userNameLable];
        self.userSexImageView=[[UIImageView alloc]init];
        [self addSubview:self.userSexImageView];
    }
    return self;
}

-(void)setModel:(M_UserInfoModel *)model
{
    if (model!=nil) {
        _model=model;
        
        CGFloat userNameLableWidth=[Unity getLableWidthWithString:_model.user_name  andFontSize:userNameLableSize];
        CGFloat userNameLableHeight=[Unity getLabelHeightWithWidth:userNameLableWidth andDefaultHeight:userSexImageViewWidth andFontSize:userNameLableSize andText:_model.user_name];
        CGFloat totalNameAndSexImageViewWidth=userNameLableWidth+20+30;
        
        self.headImageView.frame=CGRectMake(SCREEN_WIDTH/2-headImageViewWidth/2, 20, headImageViewWidth, headImageViewWidth);
        if ([_model.user_photo notEmpty]) {
            [self.headImageView setImageWithURL:[NSURL URLWithString:_model.user_photo] placeholderImage:[UIImage imageNamed:@"icon_head"]];
        }else{
            self.headImageView.image = [UIImage imageNamed:@"icon_head"];
        }
        
        self.userNameLable.frame=CGRectMake(SCREEN_WIDTH/2-totalNameAndSexImageViewWidth/2, CGRectGetMaxY(self.headImageView.frame)+10, userNameLableWidth+20, userNameLableHeight);
        if ([_model.user_name notEmpty]) {
            self.userNameLable.text=_model.user_name;
        }
        self.userSexImageView.frame=CGRectMake(CGRectGetMaxX(self.userNameLable.frame), CGRectGetMinY(self.userNameLable.frame), userSexImageViewWidth, userSexImageViewWidth);
        
        if ([_model.user_sex notEmpty]) {
            if ([_model.user_sex isEqualToString:@"1"]||[_model.user_sex isEqualToString:@"男"]) {//表示男生
                self.userSexImageView.image=[UIImage imageNamed:@"男"];
            }
            else if([_model.user_sex isEqualToString:@"2"]||[_model.user_sex isEqualToString:@"女"])
            {
                self.userSexImageView.image=[UIImage imageNamed:@"女"];
            }
        }
    }
}
@end

