//
//  M_CommuniteUserCell.m
//  DHCarForSales
//
//  Created by leiyu on 15/11/3.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CommuniteUserCell.h"
#import "M_CommunicateModel.h"

#define  messageTextSize 18
#define timeDateSize 14
@interface M_CommuniteUserCell()
@property(nonatomic,strong)UIImageView *communiteUserHeadView;
@property(nonatomic,strong)UIImageView *messageView;
@property(nonatomic,strong)UILabel *messageTextLable;
@property(nonatomic,strong)UIButton *timesButton;

@end
@implementation M_CommuniteUserCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        _timesButton=[[UIButton alloc]init];
        _timesButton.titleLabel.font=[UIFont systemFontOfSize:timeDateSize];
        UIEdgeInsets insets;
        insets.top=10; insets.bottom=10;insets.left=10;insets.right=10;
        [_timesButton setBackgroundImage:[[UIImage imageNamed:@"气泡时间"]resizableImageWithCapInsets:insets] forState:UIControlStateNormal];
        [_timesButton setTitleColor:RGBCOLOR(255, 255, 255) forState:UIControlStateNormal];
        [self.contentView addSubview:_timesButton];
        
        _communiteUserHeadView=[[UIImageView alloc]init];
        _communiteUserHeadView.contentMode=UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_communiteUserHeadView];
        
        _messageView=[[UIImageView alloc]init];
        [self.contentView addSubview:_messageView];
        
        _messageTextLable=[[UILabel alloc]init];
        [_messageTextLable setTextColor:RGBCOLOR(0, 0, 0)];
        _messageTextLable.font=[UIFont systemFontOfSize:messageTextSize];
        [_messageView addSubview:_messageTextLable];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
}
-(BOOL)boolAddTimeLable
{
    NSDate *budgDate=[[NSUserDefaults standardUserDefaults] valueForKey:@"budgDate"];
    if ([budgDate timeIntervalSinceDate:_model.messageDate]==0) {
        return YES;
    }
    if ([budgDate timeIntervalSinceDate:_model.messageDate]<3600) {
        return NO;
    }
    budgDate=_model.messageDate;
    [[NSUserDefaults standardUserDefaults] setValue:budgDate forKey:@"budgDate"];
    return YES;
}

-(CGFloat)getLbaleWidthWithString:(NSString *)string andFontSize:(CGFloat )fontSize
{
    return [string sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}].width;
}
-(void)updateData:(M_CommunicateModel *)data
{
    _model=data;
    if (_model.messagePosterHeadImageView!=nil) {
        _communiteUserHeadView.image=[UIImage imageNamed:_model.messagePosterHeadImageView];
    }
    _messageTextLable.text=_model.messageText;
    if ([self boolAddTimeLable]) {
        _timesButton.hidden=YES;
    }
    else
    {
        _timesButton.hidden=NO;
    }
    
    

    
}
@end
