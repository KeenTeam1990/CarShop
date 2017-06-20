//
//  M_ShaixuanLeftItemCell.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"

@interface M_ShaiXuanLeftItemModel : DLBaseModel

AS_FACTORY(M_ShaiXuanLeftItemModel);

AS_MODEL_STRONG(NSString, myTitle);
AS_BOOL(currSeleted);

@end

@interface M_ShaixuanLeftItemCell : DLTableViewCell

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;

@end
