//
//  M_CityItemCell.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"

@interface M_CityItemCell : DLTableViewCell

AS_MODEL_STRONG(UIImageView, myLineView);

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;

@end
