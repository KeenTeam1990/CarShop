//
//  M_Shaixuan3Cell.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/22.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"

typedef void (^TShaixuan3CellBlock)(id data);

@interface M_Shaixuan3Cell : DLTableViewCell

AS_BLOCK(TShaixuan3CellBlock, block);

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;

@end
