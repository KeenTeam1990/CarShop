//
//  LL_MessageSystemCell.m
//  DHCarForUser
//
//  Created by leiyu on 15/12/24.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "LL_MessageSystemCell.h"

#define edge 10
#define CellBloadSize 14
#define MessageSize 12

@interface LL_MessageSystemCell ()
AS_MODEL_STRONG(LL_SystemModel, myTestModel);
AS_MODEL_STRONG(UIView, myTagView);
AS_MODEL_STRONG(UILabel, myTitleLable);
AS_MODEL_STRONG(UILabel, myMessageLable);
AS_MODEL_STRONG(UILabel, myDatelable);

@end

@implementation LL_MessageSystemCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self ) {
    
        [self initMyTageViewWithFrame:CGRectMake(edge, 13, 4, 4)];
        [self initMyTitleLableWithFrame:CGRectMake(CGRectGetMaxX(self.myTagView.frame)+10, 0, 200, 30)];
        [self initMyDateLableWithFrame:CGRectMake(self.bounds.size.width-edge-100, 0, 100, 30)];
        [self initMyMessageLableWithFrame:CGRectMake(CGRectGetMinX(self.myTitleLable.frame), CGRectGetMaxY(self.myTitleLable.frame), self.bounds.size.width-edge-4-edge-edge, 25)];
    }
    return  self;
}
-(void)initMyTageViewWithFrame:(CGRect)frame
{
    self.myTagView = [[UIView alloc]initWithFrame:frame];
    self.myTagView.backgroundColor = [Unity getColor:@"#f61e26"];
    self.myTagView.layer.masksToBounds = YES;
    self.layer.cornerRadius = 2;
    [self.contentView addSubview:self.myTagView];
}
-(void)initMyTitleLableWithFrame:(CGRect)frame
{
    self.myTitleLable = [[UILabel alloc]initWithFrame:frame];
    self.myTitleLable.font = [UIFont boldSystemFontOfSize:CellBloadSize];
    self.myTitleLable.textColor = [Unity getColor:@"#333333"];
    [self.contentView addSubview:self.myTitleLable];
}
-(void)initMyDateLableWithFrame:(CGRect)frame
{
    self.myDatelable = [[UILabel alloc]initWithFrame:frame];
    self.myDatelable.textColor = [Unity getColor:@"#bbbbbb"];
    self.myDatelable.font = [UIFont systemFontOfSize:MessageSize];
    self.myDatelable.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.myDatelable];
}
-(void)initMyMessageLableWithFrame:(CGRect)frame
{
    self.myMessageLable = [[UILabel alloc]initWithFrame:frame];
    self.myMessageLable.textColor = [Unity getColor:@"#666666"];
    self.myMessageLable.font = [UIFont systemFontOfSize:MessageSize];
    self.myMessageLable.numberOfLines = 0;
    [self.contentView addSubview:self.myMessageLable];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat boundWidth = self.bounds.size.width;
    
    CGRect tempFrame = self.myDatelable.frame;
    tempFrame.origin.x = boundWidth-edge-100;
    self.myDatelable.frame =tempFrame;
    
    //对于MessageLable需要重新计算高度
    if ([self.myTestModel.myType isEqualToString:@"0"]) {
        tempFrame = self.myMessageLable.frame;
        tempFrame.origin.x = edge;
        CGFloat textHeight = [Unity getLabelHeightWithWidth:self.bounds.size.width -edge-edge andDefaultHeight:25 andFontSize:MessageSize andText:self.myTestModel.myContent];
        tempFrame.size.height =textHeight;
        tempFrame.size.width =self.bounds.size.width -edge-edge;
        self.myMessageLable.frame = tempFrame;
    }
    else
    {
        CGFloat textHeight = [Unity getLabelHeightWithWidth:self.bounds.size.width -edge-4-edge-edge andDefaultHeight:25 andFontSize:MessageSize andText:self.myTestModel.myContent];
        CGRect tempFrame = self.myMessageLable.frame;
        tempFrame.size.height =textHeight;
        self.myMessageLable.frame = tempFrame;
    }

    
    tempFrame = [self frame];
    tempFrame.size.height = CGRectGetMaxY(self.myMessageLable.frame);
    self.frame = tempFrame;
    
}
-(void)updataTestModel:(LL_SystemModel *)model
{
    self.myTestModel = model;
    if ([self.myTestModel.myType isEqualToString:@"0"]) {
        //表示已读
        self.myTagView.hidden = YES;
        
        CGRect tempFrame = self.myTitleLable.frame;
        tempFrame.origin.x = edge;
        self.myTitleLable.frame = tempFrame;
        
        self.myTitleLable.textColor = [Unity getColor:@"#666666"];
        self.myTitleLable.text = model.myTitle;
        
        tempFrame = self.myMessageLable.frame;
        tempFrame.origin.x = edge;
        CGFloat textHeight = [Unity getLabelHeightWithWidth:self.bounds.size.width -edge-edge andDefaultHeight:25 andFontSize:MessageSize andText:self.myTestModel.myContent];
        tempFrame.size.height =textHeight;
        tempFrame.size.width =self.bounds.size.width -edge-edge;
        self.myMessageLable.frame = tempFrame;
        self.myMessageLable.text = self.myTestModel.myContent;
    }
   else
   {
       self.myTitleLable.text = self.myTestModel.myTitle;
       self.myMessageLable.text = self.myTestModel.myContent;
       
       CGFloat textHeight = [Unity getLabelHeightWithWidth:self.bounds.size.width -edge-4-edge-edge andDefaultHeight:25 andFontSize:MessageSize andText:self.myTestModel.myContent];
       CGRect tempFrame = self.myMessageLable.frame;
       tempFrame.size.height =textHeight;
       self.myMessageLable.frame = tempFrame;
       
   }
    self.myDatelable.text = [Unity getTimeFromTimerLong:model.myCreateAt];
}
@end
