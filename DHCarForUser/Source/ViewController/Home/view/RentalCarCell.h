//
//  RentalCarCell.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/7.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"

@interface RentalCarCell : DLTableViewCell

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;

@end
