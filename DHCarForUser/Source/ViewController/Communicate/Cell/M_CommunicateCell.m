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
        _communitePosterHeadView.layer.masksToBounds = YES;
        _communitePosterHeadView.layer.cornerRadius = posterHeadViewWidth/2;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myClickAction:)];
        [_communitePosterHeadView addGestureRecognizer:tap];
        
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

    
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat screenWidth= self.bounds.size.width;
   
    if ([self.model.myUserType notEmpty]) {
        //0 左 1 右
        if ([self.model.myUserType isEqualToString:@"0"]) {
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
        }else if ([self.model.myUserType isEqualToString:@"1"]){
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
            CGFloat messageLableWidth=[self getLbaleWidthWithString:_model.myContent andFontSize:messageTextSize];
            UIEdgeInsets insets;
            insets.top=30;insets.left=2;insets.right=20;insets.bottom=2;
            CGFloat maxLableWidth=screenWidth-20-posterHeadViewWidth-10-20-20-30;
            if (messageLableWidth>maxLableWidth) {
                _messageTextLable.numberOfLines=0;
                _messageTextLable.frame=CGRectMake(20, 10, maxLableWidth, [Unity getLabelHeightWithWidth:maxLableWidth andDefaultHeight:0 andFontSize:messageTextSize andText:_model.myContent]);
                _messageView.frame=CGRectMake(screenWidth-20-posterHeadViewWidth-10-20-maxLableWidth-20, CGRectGetMinY(_communitePosterHeadView.frame),20+maxLableWidth+20 , [Unity getLabelHeightWithWidth:maxLableWidth andDefaultHeight:0 andFontSize:messageTextSize andText:_model.myContent]+20);
            }
            else
            {
                _messageTextLable.frame=CGRectMake(20, 10, messageLableWidth, [Unity getLabelHeightWithWidth:maxLableWidth andDefaultHeight:0 andFontSize:messageTextSize andText:_model.myContent]);
                _messageView.frame=CGRectMake(screenWidth-20-posterHeadViewWidth-10-20-messageLableWidth-20, CGRectGetMinY(_communitePosterHeadView.frame), 20+messageLableWidth+20, [Unity getLabelHeightWithWidth:messageLableWidth andDefaultHeight:0 andFontSize:messageTextSize andText:_model.myContent]+20);
            }
            _messageView.image=[[UIImage imageNamed:@"气泡框右"]resizableImageWithCapInsets:insets];
        }
    }
    
    
    
}

-(CGFloat)getLbaleWidthWithString:(NSString *)string andFontSize:(CGFloat )fontSize
{
    return [string sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}].width;
}
-(void)myClickAction:(UIGestureRecognizer *)tap
{
    if (self.myBlock != nil) {
        self.myBlock (0,self.model);
    }
}
-(void)updateData:(M_MyMessageItemModel *)data
{
    if (data!=nil) {
        self.model = data;
    
        self.messageTextLable.text = @"";
        [self.timesButton setTitle:@"" forState:UIControlStateNormal];
        
        if ([data.myContent notEmpty]) {
            self.messageTextLable.text = data.myContent;
        }
        
        if ([data.myTimer notEmpty]) {
            NSDate* tempDate = [NSDate dateWithTimeIntervalSince1970:[data.myTimer doubleValue]];
            [self.timesButton setTitle:[tempDate timeToString] forState:UIControlStateNormal];
        }
        
        if (data.myFromModel!=nil && [data.myFromModel.user_photo notEmpty]) {
            [_communitePosterHeadView setImageWithURL:[NSURL URLWithString:data.myFromModel.user_photo] placeholderImage:[UIImage imageNamed:@"customHead"]];
        }else{
            _communitePosterHeadView.image = [UIImage imageNamed:@"customHead"];
        }
    }
    
    _timesButton.hidden=NO;
}
@end
