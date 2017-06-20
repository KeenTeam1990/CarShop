//
//  H_HomeCar2Cell.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/21.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"
#import "AppPublicData.h"

typedef void (^THomeCar2CellBlock)(id data);

@interface H_HomeCar2Cell : DLTableViewCell

AS_BLOCK(THomeCar2CellBlock, block);

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;

@end
