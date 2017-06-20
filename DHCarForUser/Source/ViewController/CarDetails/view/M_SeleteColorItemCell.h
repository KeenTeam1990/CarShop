//
//  M_SeleteColorItemCell.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/24.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"

typedef void (^TSeleteColorItemCellBlock)();

@interface M_SeleteColorItemCell : DLTableViewCell

AS_BLOCK(TSeleteColorItemCellBlock, block);

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;

@end
