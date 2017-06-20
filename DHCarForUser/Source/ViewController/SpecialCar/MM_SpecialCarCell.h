//
//  MM_SpecialCarCell.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/3.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"


@interface MM_SpecialCarCell : DLTableViewCell

AS_MODEL_STRONG(NSMutableArray, myViewArray);
AS_MODEL_STRONG(NSMutableArray, myDataArray);

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;
@end
