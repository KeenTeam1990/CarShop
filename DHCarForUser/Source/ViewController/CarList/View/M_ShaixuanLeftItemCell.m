//
//  M_ShaixuanLeftItemCell.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_ShaixuanLeftItemCell.h"

@implementation M_ShaiXuanLeftItemModel

DEF_FACTORY(M_ShaiXuanLeftItemModel);

DEF_MODEL(myTitle);
DEF_MODEL(currSeleted);

@end

@interface M_ShaixuanLeftItemCell ()

AS_MODEL_STRONG(UILabel, myTitleLabel);
AS_MODEL_STRONG(UIImageView, myLineView);

@end

@implementation M_ShaixuanLeftItemCell

DEF_MODEL(myLineView);
DEF_MODEL(myTitleLabel);

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        self.myTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 44)];
        [self.myTitleLabel setBackgroundColor:[UIColor clearColor]];
        [self.myTitleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.myTitleLabel setTextColor:[UIColor blackColor]];
        [self.myTitleLabel setTextAlignment:UITextAlignmentCenter];
        [self.contentView addSubview:self.myTitleLabel];
        
        self.myLineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1)];
        self.myLineView.backgroundColor = RGBCOLOR(202, 202, 202);
        [self.contentView addSubview:self.myLineView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempFrame = self.myTitleLabel.frame;
    tempFrame.size.width = self.bounds.size.width;
    self.myTitleLabel.frame = tempFrame;
    
    tempFrame = self.myLineView.frame;
    tempFrame.size.width = self.bounds.size.width;
    self.myLineView.frame = tempFrame;
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    M_ShaiXuanLeftItemModel* tempItem = [array objectAtIndex:indexPath.row];
    if (tempItem!=nil) {
        
        if (tempItem.currSeleted) {
            self.contentView.backgroundColor= RGBCOLOR(202, 202, 202);
        }else{
            self.contentView.backgroundColor= RGBCOLOR(238, 238, 238);
        }
        
        if ([tempItem.myTitle notEmpty]) {
            self.myTitleLabel.text = tempItem.myTitle;
        }
        
        CGRect tempFrame = self.myLineView.frame;
        tempFrame.size.width = self.bounds.size.width;
        tempFrame.origin.y = self.bounds.size.height-1;
        self.myLineView.frame = tempFrame;
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
