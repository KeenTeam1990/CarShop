
//
//  LL_FeedBackCell.m
//  DHCarForUser
//
//  Created by leiyu on 15/12/27.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "LL_FeedBackCell.h"

#define messageTextSize 14
#define timeDateSize 14
#define posterHeadViewWidth 50
#define posterHeadViewHeight 50

@interface LL_FeedBackCell ()
@property(nonatomic,strong)UIImageView *communitePosterHeadView;
@property(nonatomic,strong)UIImageView *messageView;
@property(nonatomic,strong)UILabel *messageTextLable;
@property(nonatomic,strong)UIButton *timesButton;

AS_MODEL_STRONG(NSString, type);
AS_MODEL_STRONG(NSString, content);
AS_MODEL_STRONG(NSString, timeStr);
AS_BOOL(timeShowOrNot);
@end
@implementation LL_FeedBackCell
DEF_MODEL(type);
DEF_MODEL(content);
DEF_MODEL(timeShowOrNot);
DEF_MODEL(timeStr);

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        _communitePosterHeadView=[[UIImageView alloc]init];
        _communitePosterHeadView.contentMode=UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_communitePosterHeadView];
        
        _messageView=[[UIImageView alloc]init];
        
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
    
    if ([self.type isEqualToString:@"dev_reply"]) {
        //表示顾客的  1 销售人员  0 顾客
        //加时间的Lable那部分
        if (self.timeShowOrNot==YES) {
            CGFloat buttonWidth = [Unity getLableWidthWithString:timeStr andFontSize:timeDateSize];
            _timesButton.frame=CGRectMake(screenWidth/2-buttonWidth/2+10, 10, buttonWidth+20, 30);
            _timesButton.hidden = NO;
        }
        else
        {
            _timesButton.hidden = YES;
        }
        if (_timesButton.hidden) {
            _communitePosterHeadView.frame=CGRectMake(20, 10, posterHeadViewWidth, posterHeadViewHeight);
        }
        else
        {
            _communitePosterHeadView.frame=CGRectMake(20, 10+CGRectGetMaxY(_timesButton.frame), posterHeadViewWidth, posterHeadViewHeight);
        }
        

        CGFloat messageLableWidth = [Unity getLableWidthWithString:self.content andFontSize:messageTextSize];
        UIEdgeInsets insets;
        insets.top=30; insets.bottom=4;insets.right=5 ;insets.left=20;
        CGFloat maxLableWidth=screenWidth-20-posterHeadViewWidth-10-20-20-30;//聊天信息的
        if (messageLableWidth>maxLableWidth) {
            //表示有换行
            _messageTextLable.numberOfLines=0;
            _messageTextLable.frame=CGRectMake(20, 10, maxLableWidth, [Unity getLabelHeightWithWidth:maxLableWidth andDefaultHeight:0 andFontSize:messageTextSize andText:_messageTextLable.text]);
            _messageView.frame=CGRectMake(CGRectGetMaxX(_communitePosterHeadView.frame)+10,CGRectGetMinY(_communitePosterHeadView.frame),maxLableWidth+40 , _messageTextLable.frame.size.height+20);
        }
        else
        {
            _messageTextLable.frame=CGRectMake(20, 10, messageLableWidth, [Unity getLabelHeightWithWidth:maxLableWidth andDefaultHeight:0 andFontSize:messageTextSize andText:_messageTextLable.text]);
            _messageView.frame=CGRectMake(CGRectGetMaxX(_communitePosterHeadView.frame), CGRectGetMinY(_communitePosterHeadView.frame), 20+messageLableWidth+20, _messageTextLable.frame.size.height+20);
        }
        _messageView.image=[[UIImage imageNamed:@"气泡框左"]resizableImageWithCapInsets:insets];
        
        
    }
    else
    {
        //表示用户的
        if (self.timeShowOrNot == YES) {
            
            CGFloat buttonWidth = [Unity getLableWidthWithString:timeStr andFontSize:timeDateSize];
            _timesButton.frame=CGRectMake(screenWidth/2-buttonWidth/2+10, 10, buttonWidth+20, 30);
            _timesButton.hidden = NO;
        }
        else
        {
            _timesButton.hidden=YES;
        }
        if (_timesButton.hidden) {
            _communitePosterHeadView.frame=CGRectMake(screenWidth-20-posterHeadViewWidth, 10, posterHeadViewWidth, posterHeadViewHeight);
        }
        else
        {
            _communitePosterHeadView.frame=CGRectMake(screenWidth-20-posterHeadViewWidth, 10+CGRectGetMaxY(_timesButton.frame), posterHeadViewWidth, posterHeadViewHeight);
        }
         CGFloat messageLableWidth = [Unity getLableWidthWithString:self.content andFontSize:messageTextSize];
        UIEdgeInsets insets;
        insets.top=30;insets.left=2;insets.right=20;insets.bottom=2;
        CGFloat maxLableWidth=screenWidth-20-posterHeadViewWidth-10-20-20-30;
        if (messageLableWidth>maxLableWidth) {
            _messageTextLable.numberOfLines=0;
            _messageTextLable.frame=CGRectMake(20, 10, maxLableWidth, [Unity getLabelHeightWithWidth:maxLableWidth andDefaultHeight:0 andFontSize:messageTextSize andText:self.content]);
            _messageView.frame=CGRectMake(screenWidth-20-posterHeadViewWidth-10-20-maxLableWidth-20, CGRectGetMinY(_communitePosterHeadView.frame),20+maxLableWidth+20 , [Unity getLabelHeightWithWidth:maxLableWidth andDefaultHeight:0 andFontSize:messageTextSize andText:self.content]+20);
        }
        else
        {
            _messageTextLable.frame=CGRectMake(20, 10, messageLableWidth, [Unity getLabelHeightWithWidth:maxLableWidth andDefaultHeight:0 andFontSize:messageTextSize andText:self.content]);
            _messageView.frame=CGRectMake(screenWidth-20-posterHeadViewWidth-10-20-messageLableWidth-20, CGRectGetMinY(_communitePosterHeadView.frame), 20+messageLableWidth+20, [Unity getLabelHeightWithWidth:messageLableWidth andDefaultHeight:0 andFontSize:messageTextSize andText:self.content]+20);
        }
        _messageView.image=[[UIImage imageNamed:@"气泡框右"]resizableImageWithCapInsets:insets];
        
    }
    
    _communitePosterHeadView.layer.masksToBounds = YES;
    _communitePosterHeadView.layer.cornerRadius = posterHeadViewWidth/2;
    
}
-(void)upDataWithContent:(NSString *)contentText andType:(NSString *)typeMessage andTimeStr:(NSString *)myTimeStr andBoolTimeButtonShowOrNot:(BOOL)showOrNot andWithHeadImage:(NSString *)headImageUrl
{
    self.content = contentText;
    self.type = typeMessage;
    self.timeStr = myTimeStr;
    self.timeShowOrNot = showOrNot;
    _messageTextLable.text = contentText;
    [_timesButton setTitle:timeStr forState:UIControlStateNormal];
    if([self.type isEqualToString:@"dev_reply"])
    {
        _communitePosterHeadView.image = [UIImage imageNamed:@"icon_head@3x"];
    }
    else
    {
        [_communitePosterHeadView setImageWithURL:[NSURL URLWithString:headImageUrl] placeholderImage:[UIImage imageNamed:@"icon_head"]];
    }
    
}


@end
