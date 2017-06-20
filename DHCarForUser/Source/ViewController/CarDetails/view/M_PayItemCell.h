//
//  M_PayItemCell.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/17.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"

@interface M_PayItemCell : DLTableViewCell

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;

@end
