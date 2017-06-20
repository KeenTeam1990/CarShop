//
//  M_MessageFirstCell.m
//  DHCarForSales
//
//  Created by leiyu on 15/11/2.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_MessageFirstCell.h"
#import "M_MessageMode.h"
#import "Unity.h"


#define userNameFontSize  14
#define messageBudgSize   10
#define messageTextSize   12


@interface M_MessageFirstCell()

AS_MODEL_STRONG(UIImageView, custom_HeadView);
AS_MODEL_STRONG(UILabel , custom_NameLable);
AS_MODEL_STRONG(UIButton , budg_Button);
AS_MODEL_STRONG(UILabel, message_TextLable);
AS_MODEL_STRONG(UILabel, time_MessageLable);
AS_MODEL_STRONG(UIImageView, myLineView);
AS_MODEL_STRONG(UIImageView, myLine2View);

@end
@implementation M_MessageFirstCell
DEF_MODEL(custom_HeadView);
DEF_MODEL(custom_NameLable);
DEF_MODEL(budg_Button);
DEF_MODEL(message_TextLable);
DEF_MODEL(time_MessageLable);

//DEF_MODEL(message_Model);
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];

        self.custom_HeadView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        self.custom_HeadView.contentMode=UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.custom_HeadView];
    
        self.custom_NameLable=[[UILabel alloc]initWithFrame:CGRectMake(80, 10, self.bounds.size.width-90, 30)];
        [self.custom_NameLable setFont:[UIFont systemFontOfSize:userNameFontSize]];
        [self.custom_NameLable setTextColor:RGBCOLOR(0, 0, 0)];
         [self.contentView addSubview:self.custom_NameLable];
        
        self.budg_Button=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.budg_Button setBackgroundImage:[UIImage imageNamed:@"redBudg"] forState:UIControlStateNormal];
        self.budg_Button.userInteractionEnabled=NO;
        [self.contentView addSubview:self.budg_Button];
        self.budg_Button.titleLabel.font=[UIFont systemFontOfSize:messageBudgSize];
        [self.budg_Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        self.message_TextLable=[[UILabel alloc]initWithFrame:CGRectMake(80, 30, self.bounds.size.width-90, 40)];
        [self.contentView addSubview:self.message_TextLable];
        [self.message_TextLable setFont:[UIFont systemFontOfSize:messageTextSize]];
        [self.message_TextLable setTextColor:RGBCOLOR(102, 102, 102)];
        self.message_TextLable.numberOfLines=2;
        
        self.myLineView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 80, self.bounds.size.width-10, 1)];
        self.myLineView.image = [UIImage imageNamed:@"dashedLine.png"];
        [self.contentView addSubview:self.myLineView];
        
        self.time_MessageLable=[[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width-100, 80, 100, 30)];
        [self.time_MessageLable setFont:[UIFont systemFontOfSize:messageTextSize]];
        [self.time_MessageLable setTextColor:RGBCOLOR(187, 187, 187)];
        self.time_MessageLable.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:self.time_MessageLable];

        self.myLine2View = [[UIImageView alloc]initWithFrame:CGRectMake(0, 110, self.bounds.size.width, 10)];
        self.myLine2View.backgroundColor = RGBCOLOR(202, 202, 202);
        [self.contentView addSubview:self.myLine2View];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat nameLableWidth=[self getLbaleWidthWithString:self.custom_NameLable.text andFontSize:userNameFontSize];
    
    CGRect tempframe = self.custom_NameLable.frame;
    tempframe.size.width = nameLableWidth;
    self.custom_NameLable.frame=tempframe;
    
    tempframe = self.budg_Button.frame;
    tempframe.origin.x = CGRectGetMaxX(self.custom_NameLable.frame)+5;
    self.budg_Button.frame=tempframe;

    tempframe = self.message_TextLable.frame;
    tempframe.size.width = self.bounds.size.width-110;
    self.message_TextLable.frame=tempframe;
    
    tempframe = self.time_MessageLable.frame;
    tempframe.origin.x = self.bounds.size.width-110;
    self.time_MessageLable.frame=tempframe;
    
    tempframe = self.myLineView.frame;
    tempframe.size.width = self.bounds.size.width-1;
    self.myLineView.frame=tempframe;
    
    tempframe = self.myLine2View.frame;
    tempframe.size.width = self.bounds.size.width;
    tempframe.origin.y = self.bounds.size.height-10;
    self.myLine2View.frame=tempframe;
}

-(CGFloat)getLbaleWidthWithString:(NSString *)string andFontSize:(CGFloat )fontSize
{
    return [string sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}].width;
}

-(void)updataItemModel:(M_MymessageListItemModel *)model
{
    self.message_ItemModel= model;

    self.custom_NameLable.text = @"";
    [self.budg_Button setTitle:@"" forState:UIControlStateNormal];
    self.message_TextLable.text=@"";
    self.time_MessageLable.text =@"";
    
    M_UserInfoModel *tempUser=self.message_ItemModel.user;
    
    M_MymessageLast_infoModel *tempLastInfo=self.message_ItemModel.last_info;
    
    if ([tempUser.user_photo notEmpty]) {
        [self.custom_HeadView setImageWithURL:[NSURL URLWithString:tempUser.user_photo] placeholderImage:[UIImage imageNamed:@"icon_head"]];
    }else{
        self.custom_HeadView.image=[UIImage imageNamed:@"icon_head"];
    }
    
    if ([tempUser.user_name notEmpty]) {
        self.custom_NameLable.text=tempUser.user_name;
    }
    
    if ([model.read_no_number notEmpty]) {
        [self.budg_Button setTitle:model.read_no_number forState:UIControlStateNormal];
    }
    if ([tempLastInfo.message_txt notEmpty]) {
        self.message_TextLable.text=tempLastInfo.message_txt;
    }
    
    if ([tempLastInfo.message_time notEmpty]) {
        NSDate* tempDate = [tempLastInfo.message_time stringToTime];
        self.time_MessageLable.text=[Unity countTimeLenght:tempDate];
    }
    
}

@end
