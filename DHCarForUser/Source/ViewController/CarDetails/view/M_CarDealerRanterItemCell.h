//
//  M_CarDealerRanterItemCell.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/23.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"

typedef void (^TCarDealerRanterItemCellBlock)(NSInteger tag,id data);

@interface M_CarDealerRanterItemCell : DLTableViewCell

AS_BLOCK(TCarDealerRanterItemCellBlock, block);

AS_BOOL(showFirstSelete);

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;

@end
