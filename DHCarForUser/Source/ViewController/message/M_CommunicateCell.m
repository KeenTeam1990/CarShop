//
//  M_CommunicateCell.m
//  DHCarForSales
//
//  Created by leiyu on 15/11/5.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CommunicateCell.h"
#import "M_CarMessageDetailModel.h"
#define  messageTextSize 14
#define timeDateSize 14
#define posterHeadViewWidth 50
#define posterHeadViewHeight 50

@interface M_CommunicateCell()
@property(nonatomic,strong)UIImageView *communitePosterHeadView;
@property(nonatomic,strong)UIImageView *messageView;
@property(nonatomic,strong)UILabel *messageTextLable;
@property(nonatomic,strong)UIButton *timesButton;

@end

@implementation M_CommunicateCell
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
   
    if ([_model.user_type isEqualToString:@"1"]) {
        //表示顾客的  1 销售人员  0 顾客
        //加时间的Lable那部分
        if (_model.timeButtonShowOrNot) {
            CGFloat buttonWidth=[self getLbaleWidthWithString:_timesButton.titleLabel.text andFontSize:timeDateSize];
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
        
        CGFloat messageLableWidth=[self getLbaleWidthWithString:_messageTextLable.text andFontSize:messageTextSize];
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
    else if([_model.user_type isEqualToString:@"0"])
    {
        //表示用户的
        if (_model.timeButtonShowOrNot) {

            CGFloat buttonWidth=[self getLbaleWidthWithString:_timesButton.titleLabel.text andFontSize:timeDateSize];
            _timesButton.frame=CGRectMake(screenWidth/2-buttonWidth/2+10, 10, buttonWidth+20, 30);
            _timesButton.hidden = NO;
        }
        else
        {
            _timesButton.hidden=YES;
        }
        if (_timesButton.hidden) {
            _communitePosterHeadView.frame=CGRectMake(screenWidth-20-posterHeadViewWidth, 10, posterHeadViewWidth, posterHeadViewHeight);;
        }
        else
        {
            _communitePosterHeadView.frame=CGRectMake(screenWidth-20-posterHeadViewWidth, 10+CGRectGetMaxY(_timesButton.frame), posterHeadViewWidth, posterHeadViewHeight);
        }
        CGFloat messageLableWidth=[self getLbaleWidthWithString:_model.consult_txt andFontSize:messageTextSize];
        UIEdgeInsets insets;
        insets.top=30;insets.left=2;insets.right=20;insets.bottom=2;
       CGFloat maxLableWidth=screenWidth-20-posterHeadViewWidth-10-20-20-30;
        if (messageLableWidth>maxLableWidth) {
            _messageTextLable.numberOfLines=0;
            _messageTextLable.frame=CGRectMake(20, 10, maxLableWidth, [Unity getLabelHeightWithWidth:maxLableWidth andDefaultHeight:0 andFontSize:messageTextSize andText:_model.consult_txt]);
            _messageView.frame=CGRectMake(screenWidth-20-posterHeadViewWidth-10-20-maxLableWidth-20, CGRectGetMinY(_communitePosterHeadView.frame),20+maxLableWidth+20 , [Unity getLabelHeightWithWidth:maxLableWidth andDefaultHeight:0 andFontSize:messageTextSize andText:_model.consult_txt]+20);
        }
        else
        {
            _messageTextLable.frame=CGRectMake(20, 10, messageLableWidth, [Unity getLabelHeightWithWidth:maxLableWidth andDefaultHeight:0 andFontSize:messageTextSize andText:_model.consult_txt]);
            _messageView.frame=CGRectMake(screenWidth-20-posterHeadViewWidth-10-20-messageLableWidth-20, CGRectGetMinY(_communitePosterHeadView.frame), 20+messageLableWidth+20, [Unity getLabelHeightWithWidth:messageLableWidth andDefaultHeight:0 andFontSize:messageTextSize andText:_model.consult_txt]+20);
        }
        _messageView.image=[[UIImage imageNamed:@"气泡框右"]resizableImageWithCapInsets:insets];
        
    }
    
    
}

-(CGFloat)getLbaleWidthWithString:(NSString *)string andFontSize:(CGFloat )fontSize
{
    return [string sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}].width;
}
-(void)updateData:(M_MyMessageItemModel *)data
{
    _model=data;
    
    NSString *tempPleaceHoldImageName;
    if ([_model.user_type isEqualToString:@"0"]) {
        //1 销售 0 用户
        tempPleaceHoldImageName=@"customHead";
    }
    else if ([_model.user_type isEqualToString:@"1"])
    {
        tempPleaceHoldImageName=@"userHead";
    }
    
    [_communitePosterHeadView setImageWithURL:[NSURL URLWithString:_model.user_photo] placeholderImage:[UIImage imageNamed:tempPleaceHoldImageName]];
    
    [_timesButton setTitle:_model.consult_time forState:UIControlStateNormal];
    
    _messageTextLable.text=_model.consult_txt;
    
    _timesButton.hidden=NO;
}
@end
