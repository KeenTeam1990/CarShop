//
//  M_CarItemCell.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"
#import "AppPublicData.h"

@interface M_CarItemCell : DLTableViewCell

AS_BLOCK(TCarItemViewBlock, block);

AS_MODEL(TCarBottomType, carType);

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;

@end
