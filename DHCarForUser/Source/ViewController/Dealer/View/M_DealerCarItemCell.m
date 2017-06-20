//
//  M_DealerCarItemCell.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/10.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_DealerCarItemCell.h"
#import "M_DealerCarItemView.h"
#import "M_CarListModel.h"

@interface M_DealerCarItemCell ()

AS_MODEL_STRONG(M_DealerCarItemView, myItemView);

@end

@implementation M_DealerCarItemCell

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
        
        self.myItemView = [M_DealerCarItemView allocInstanceFrame:CGRectMake(0, 0, self.bounds.size.width, 110)];
        
        [self.contentView addSubview:self.myItemView];
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
