//
//  M_SeleteDealerItemCell.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"
#import "M_DealerItemModel.h"

//tag
// 0
// 1 试乘试驾
// 2 预定
// 3 拨打电话
typedef void (^TSeleteDealerItemCellBlock)(NSInteger tag,M_DealerItemModel* model);

@interface M_SeleteDealerItemCell : DLTableViewCell

AS_BLOCK(TSeleteDealerItemCellBlock, block);

AS_BOOL(isRadio);

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;

@end
