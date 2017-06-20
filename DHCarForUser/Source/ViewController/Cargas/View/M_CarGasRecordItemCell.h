//
//  M_CarGasRecordItemCell.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"
#import "M_CarGasListModel.h"

typedef void (^TVarGasRecordItemBlock)(M_CarGasItemModel* model);

@interface M_CarGasRecordItemCell : DLTableViewCell

AS_BLOCK(TVarGasRecordItemBlock, block);

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;

@end
