//
//  M_CarWebItemCell.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"

typedef void (^TCarWebItemCellBlock)(NSInteger tag,NSInteger height);

@interface M_CarWebItemCell : DLTableViewCell

AS_BLOCK(TCarWebItemCellBlock, block);

AS_INT(currType);

-(void)configCellIndexPath:(NSIndexPath*)indexPath withData:(NSString*)url;

@end
