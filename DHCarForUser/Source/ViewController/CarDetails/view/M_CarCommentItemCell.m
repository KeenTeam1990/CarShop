//
//  M_CarCommentItemCell.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarCommentItemCell.h"
#import "M_CarCommentListModel.h"

@interface M_CarCommentItemCell ()

AS_MODEL_STRONG(UILabel, myContentLabel);
AS_MODEL_STRONG(UILabel, myNameLabel);
AS_MODEL_STRONG(UILabel, myTimeLabel);

@end

@implementation M_CarCommentItemCell

DEF_MODEL(myNameLabel);
DEF_MODEL(myContentLabel);
DEF_MODEL(myTimeLabel);

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        self.myNameLabel = [self getLabel:CGRectMake(10, 0, self.bounds.size.width/2, 30)];
        
        self.myTimeLabel = [self getLabel:CGRectMake(self.bounds.size.width-110, 0, 100, 30)];
        
        self.myContentLabel = [self getLabel:CGRectMake(10, 30, self.bounds.size.width-20, 40)];
    }
    return self;
}

-(UILabel*)getLabel:(CGRect)frame
{
    UILabel* tempLabel = [[UILabel alloc]initWithFrame:frame];
    [tempLabel setBackgroundColor:[UIColor clearColor]];
    [tempLabel setFont:[UIFont systemFontOfSize:14]];
    [tempLabel setTextColor:RGBCOLOR(102, 102, 102)];
    [self.contentView addSubview:tempLabel];
    return tempLabel;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempFrame = self.myTimeLabel.frame;
    tempFrame.origin.x = self.bounds.size.width-110;
    self.myTimeLabel.frame = tempFrame;
    
    tempFrame = self.myContentLabel.frame;
    tempFrame.size.width = self.bounds.size.width-20;
    self.myContentLabel.frame = tempFrame;
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    M_CarCommentItemModel* tempItem = [array objectAtIndex:indexPath.row];
    
    if (tempItem!=nil) {
        self.myNameLabel.text = @"";
        self.myContentLabel.text = @"";
        self.myTimeLabel.text = @"";
        
        if ([tempItem.myEvaluate notEmpty]) {
            self.myContentLabel.text = tempItem.myEvaluate;
        }
        
        if ([tempItem.myEvaluateCreatime notEmpty]) {
            self.myTimeLabel.text = tempItem.myEvaluateCreatime;
        }
        
        if ([tempItem.myUser_Name notEmpty]) {
            self.myNameLabel.text = tempItem.myUser_Name;
        }
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
