//
//  M_MyCollectCell.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/12.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"
#import "Dh_MyCollectModel.h"


typedef void (^TMyCollectCellBlock)(NSInteger tag,id data);


@interface M_MyCollectCell : DLTableViewCell<UIAlertViewDelegate>

AS_BLOCK(TMyCollectCellBlock, block);

AS_MODEL_STRONG(UIButton, mydelBtn);

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;

@end
