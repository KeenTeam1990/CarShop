//
//  H_HomeCar1Cell.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/21.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "H_HomeCar1Cell.h"
#import "M_CarItem2View.h"
#import "M_CarListModel.h"
#import "M_IndexModel.h"

@interface H_HomeCar1Cell ()

AS_MODEL_STRONG(M_CarItem2View, myItemView);
AS_MODEL_STRONG(UIImageView, myLineView);

@end

@implementation H_HomeCar1Cell

DEF_MODEL(myItemView);

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        self.myItemView = [M_CarItem2View allocInstanceFrame:CGRectMake(0, 0, self.bounds.size.width, 110)];
        self.myItemView.showIcon = YES;
        [self.contentView addSubview:self.myItemView];
        
        self.myLineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 119, self.bounds.size.width, 6)];
        [self.myLineView setBackgroundColor:[Unity getGrayBackColor]];
        self.myLineView.hidden = YES;
        [self.contentView addSubview:self.myLineView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempFrame =self.myItemView.frame;
    tempFrame.size.width = self.bounds.size.width;
    tempFrame.size.height = self.bounds.size.height;
    self.myItemView.frame = tempFrame;
    
    tempFrame = self.myLineView.frame;
    tempFrame.size.width = self.bounds.size.width;
    tempFrame.origin.y = self.bounds.size.height-6;
    self.myLineView.frame = tempFrame;
    
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    M_IndexLineItemModel* tempItem = [array objectAtIndex:0];
    
    if (tempItem!=nil) {

        [self.myItemView updateData:tempItem.myCarModel];
    }
    
    self.myLineView.hidden = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
