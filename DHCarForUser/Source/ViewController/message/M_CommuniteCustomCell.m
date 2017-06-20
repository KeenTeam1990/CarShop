
//
//  M_CommuniteCustomCell.m
//  DHCarForSales
//
//  Created by leiyu on 15/11/3.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CommuniteCustomCell.h"
#import "M_CommunicateModel.h"
#define  messageTextSize 18
#define timeDateSize 14
@interface M_CommuniteCustomCell()
@property(nonatomic,strong)UIImageView *communiteCustomHeadView;
@property(nonatomic,strong)UIImageView *messageView;
@property(nonatomic,strong)UILabel *messageTextLable;
@property(nonatomic,strong)UIButton *timesButton;



@end
@implementation M_CommuniteCustomCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        _communiteCustomHeadView=[[UIImageView alloc]init];
        _communiteCustomHeadView.contentMode=UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_communiteCustomHeadView];
        
        _messageView=[[UIImageView alloc]init];
        _messageView.contentMode=UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_messageView];
        
        _messageTextLable=[[UILabel alloc]init];
        [_messageTextLable setTextColor:RGBCOLOR(0, 0, 0)];
        _messageTextLable.font=[UIFont systemFontOfSize:messageTextSize];
        [_messageView addSubview:_messageTextLable];
        
        _timesButton=[[UIButton alloc]init];
        _timesButton .titleLabel.font=[UIFont systemFontOfSize:timeDateSize];
        UIEdgeInsets insets;
        insets.top=10; insets.bottom=10;insets.left=10;insets.right=10;
        [_timesButton setBackgroundImage:[[UIImage imageNamed:@"气泡时间"]resizableImageWithCapInsets:insets] forState:UIControlStateNormal];
        [_timesButton setTitleColor:RGBCOLOR(255, 255, 255) forState:UIControlStateNormal];
        [self.contentView addSubview:_timesButton];
    }
    CGRect frame=[self frame];
    frame.size.height=CGRectGetMaxY(_messageView.frame);
    self.frame=frame;

    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat screenWidth= self.bounds.size.width;
    
   
    //加时间的Lable那部分
    if ([self boolAddTimeLable]) {
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy年MM月dd日  HH:mm"];
        NSString *dateString=[dateFormatter stringFromDate:[[NSUserDefaults standardUserDefaults] valueForKey:@"budgDate"]];
        CGFloat buttonWidth=[self getLbaleWidthWithString:dateString andFontSize:timeDateSize];
        _timesButton.frame=CGRectMake(screenWidth/2-buttonWidth/2+10, 10, buttonWidth+20, 30);
        [_timesButton setTitle:dateString forState:UIControlStateNormal];
        _timesButton.hidden = NO;
    }
    else
    {
        _timesButton.hidden = YES;
    }
    if (_timesButton.hidden) {
        _communiteCustomHeadView.frame=CGRectMake(20, 10, 70, 70);
    }
    else
    {
        _communiteCustomHeadView.frame=CGRectMake(20, 10+CGRectGetMaxY(_timesButton.frame), 70, 70);
    }
    
    CGFloat messageLableWidth=[self getLbaleWidthWithString:_model.messageText andFontSize:messageTextSize];
    UIEdgeInsets insets;
    insets.top=30; insets.bottom=4;insets.right=5 ;insets.left=20;
    CGFloat maxLableWidth=screenWidth-70-20-10-20-70-10-20-10;
    if (messageLableWidth>maxLableWidth) {
        _messageTextLable.numberOfLines=0;
        _messageTextLable.frame=CGRectMake(20, 10, maxLableWidth, [Unity getLabelHeightWithWidth:maxLableWidth andDefaultHeight:60 andFontSize:messageTextSize andText:_model.messageText]);
        _messageView.frame=CGRectMake(70+20+10,CGRectGetMinY(_communiteCustomHeadView.frame),maxLableWidth+30 , [Unity getLabelHeightWithWidth:maxLableWidth andDefaultHeight:60 andFontSize:messageTextSize andText:_model.messageText]+30);
        
    }
    else
    {
        _messageTextLable.frame=CGRectMake(20, 20, messageLableWidth, 30);
        _messageView.frame=CGRectMake(CGRectGetMaxX(_messageView.frame)+10, 10, 20+30+messageLableWidth, 70);
    }
    _messageView.image=[[UIImage imageNamed:@"气泡框左"]resizableImageWithCapInsets:insets];
    
}
-(BOOL)boolAddTimeLable
{
    NSDate *budgDate=[[NSUserDefaults standardUserDefaults] valueForKey:@"budgDate"];
    if ([budgDate timeIntervalSinceDate:_model.messageDate]==0) {
        return YES;
    }
    if ([budgDate timeIntervalSinceDate:_model.messageDate]<=3600) {
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
    if ([data.messagePosterHeadImageView isBlankObject]) {
        _communiteCustomHeadView.image=[UIImage imageNamed:_model.messagePosterHeadImageView];
    }
    _messageTextLable.text=_model.messageText;

    
    
    
}


@end
