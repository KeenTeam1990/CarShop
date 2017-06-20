//
//  M_CarDealerSpecialItemCell.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/23.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"

typedef void (^TCarDealerSpecialItemCellBlock)(NSInteger tag,id data);

@interface M_CarDealerSpecialItemCell : DLTableViewCell

AS_BLOCK(TCarDealerSpecialItemCellBlock, block);

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;

@end
