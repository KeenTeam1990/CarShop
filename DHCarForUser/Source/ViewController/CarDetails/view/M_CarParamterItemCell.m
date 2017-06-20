//
//  M_CarParamterItemCell.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarParamterItemCell.h"
#import "M_CarListModel.h"

@interface M_CarParamterItemCell ()

AS_MODEL_STRONG(UILabel, myNameLabel);
AS_MODEL_STRONG(UILabel, myValueLabel);
AS_MODEL_STRONG(UIImageView, myLineView);

@end

@implementation M_CarParamterItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        self.myNameLabel = [self getLabel:CGRectMake(10, 0, self.bounds.size.width/2-20, 44)];
        
        self.myValueLabel = [self getLabel:CGRectMake(self.bounds.size.width/2+10, 0, self.bounds.size.width/2-20, 44)];
        
        self.myLineView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2, 0, 1, 44)];
        self.myLineView.backgroundColor = RGBCOLOR(102, 102, 102);
        [self.contentView addSubview:self.myLineView];
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

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempFrame = self.myNameLabel.frame;
    tempFrame.size.width = self.bounds.size.width/2-20;
    self.myNameLabel.frame = tempFrame;
    
    tempFrame = self.myValueLabel.frame;
    tempFrame.origin.x = self.bounds.size.width/2+10;
    tempFrame.size.width = self.bounds.size.width/2-20;
    self.myValueLabel.frame = tempFrame;
    
    tempFrame = self.myLineView.frame;
    tempFrame.origin.x = self.bounds.size.width/2;
    self.myLineView.frame = tempFrame;
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    M_CarParameterItemModel* tempItem = [array objectAtIndex:indexPath.row];
    if (tempItem!=nil) {
        
        self.myNameLabel.text = @"";
        self.myValueLabel.text = @"";
        
        if ([tempItem.myParameter_Name notEmpty]) {
            self.myNameLabel.text = tempItem.myParameter_Name;
        }
        
        if ([tempItem.myParameter_Value notEmpty]) {
            self.myValueLabel.text = tempItem.myParameter_Value;
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
