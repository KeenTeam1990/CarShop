//
//  M_DealerItemCell.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"
typedef void (^MyBlock )(NSString *phoneNum);
@interface M_DealerItemCell : DLTableViewCell
AS_BLOCK(MyBlock, myBlock);
-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;

@end
