//
//  HotInquiryCell.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"

typedef void (^THotInquiryCellBlock)(NSIndexPath* indexPath);

@interface HotInquiryCell : DLTableViewCell

AS_BOOL(showSpecial);
AS_BLOCK(THotInquiryCellBlock, block);

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;

@end
