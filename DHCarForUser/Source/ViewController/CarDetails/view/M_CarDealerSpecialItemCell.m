//
//  M_CarDealerSpecialItemCell.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/23.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarDealerSpecialItemCell.h"

#import "M_CarDistributorItemView.h"
#import "M_DealerItemModel.h"

@interface M_CarDealerSpecialItemCell ()

AS_MODEL_STRONG(M_CarDistributorItemView, myItemView);

AS_MODEL_STRONG(M_DealerItemModel, myItemModel);

@end

@implementation M_CarDealerSpecialItemCell

DEF_MODEL(myItemView);

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        self.myItemView = [M_CarDistributorItemView allocInstanceFrame:CGRectMake(5, 5, self.bounds.size.width-10, 110)];
        self.myItemView.showSelete = YES;
        [self.contentView addSubview:self.myItemView];
        
        __weak M_CarDealerSpecialItemCell* tempSelf = self;
        self.myItemView.block = ^(){
            if (tempSelf.block!=nil) {
                tempSelf.block(0,tempSelf.myItemModel);
            }
        };
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempFrame = self.myItemView.frame;
    tempFrame.size.width = self.bounds.size.width-10;
    self.myItemView.frame = tempFrame;
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    M_DealerItemModel* tempItem = [array objectAtIndex:indexPath.row];
    if (tempItem!=nil) {
        
        self.myItemModel = tempItem;
        
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
