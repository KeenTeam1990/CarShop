//
//  M_MessageFirstCell.h
//  DHCarForSales
//
//  Created by leiyu on 15/11/2.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"

#import "M_MymessageListModel.h"

@interface M_MessageFirstCell : DLTableViewCell

AS_MODEL_STRONG(M_MymessageListItemModel , message_ItemModel);//实际数据模型

-(void)updataItemModel:(M_MymessageListItemModel *)model;



@end
