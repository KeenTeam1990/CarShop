//
//  M_CarItem2Cell.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/20.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarItem2Cell.h"
#import "M_CarItem2View.h"
#import "M_CarListModel.h"

@interface M_CarItem2Cell ()

AS_MODEL_STRONG(M_CarItem2View, myItemView);
AS_MODEL_STRONG(UIImageView, myLineView);

@end

@implementation M_CarItem2Cell

DEF_MODEL(myItemView);
DEF_MODEL(carType);

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        self.myItemView = [M_CarItem2View allocInstanceFrame:CGRectMake(5, 0, self.bounds.size.width-10, 110)];
        [self.contentView addSubview:self.myItemView];
        
        self.myLineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 110, self.bounds.size.width, 5)];
        [self.myLineView setBackgroundColor:RGBCOLOR(222, 222, 222)];
        self.myLineView.hidden = YES;
//        [self.contentView addSubview:self.myLineView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempFrame =self.myItemView.frame;
    tempFrame.size.width = self.bounds.size.width-10;
    tempFrame.size.height = self.bounds.size.height-5;
    self.myItemView.frame = tempFrame;
    
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    M_CarItemModel* tempItem = [array objectAtIndex:indexPath.row];
    
    if (tempItem!=nil) {
        
        tempItem.myIndexPath = indexPath;
        self.myItemView.carType = self.carType;
        [self.myItemView updateData:tempItem];
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
