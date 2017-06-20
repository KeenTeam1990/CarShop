//
//  M_MyOlderCell.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/12.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"
#import "M_MyOrderModel.h"

typedef void (^TMyOlderCellBlock)(NSInteger tag,id data);

@interface M_MyOlderCell : DLTableViewCell<UIAlertViewDelegate>

AS_BLOCK(TMyOlderCellBlock, block);

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;
@end
