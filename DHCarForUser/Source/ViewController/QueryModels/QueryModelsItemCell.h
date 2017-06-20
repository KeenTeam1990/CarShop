//
//  QueryModelsItemCell.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/16.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"

typedef void (^TQueryModelsItemCellBlock)(NSInteger tag,id data);

@interface QueryModelsItemCell : DLTableViewCell

AS_BLOCK(TQueryModelsItemCellBlock, block);

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;

@end
