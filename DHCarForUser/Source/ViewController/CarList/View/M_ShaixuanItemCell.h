//
//  M_ShaixuanItemCell.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"

typedef void (^TShaixuanItemCellBlock)();

@interface M_ShaixuanItemCell : DLTableViewCell

AS_BLOCK(TShaixuanItemCellBlock, block);

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array withTab:(NSInteger)tabIndex;

@end
