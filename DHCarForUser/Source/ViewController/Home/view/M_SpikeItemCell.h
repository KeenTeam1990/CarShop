//
//  M_SpikeItemCell.h
//  DHCarForUser
//
//  Created by lucaslu on 16/1/14.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"

typedef void (^TSpikeItemCellBlock)(NSInteger tag,id data);

@interface M_SpikeItemCell : DLTableViewCell

AS_BLOCK(TSpikeItemCellBlock, block);

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;

@end
