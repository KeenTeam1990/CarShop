//
//  M_CarDistributorItemCell.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/8.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"
#import "AppPublicData.h"
typedef void (^MyBlock)(id data);
@interface M_CarDistributorItemCell : DLTableViewCell
AS_BLOCK(MyBlock, myBlock);
-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array andwithType:(TCarBottomType )type;

@end
