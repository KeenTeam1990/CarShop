//
//  LL_SendBaoJiaInfoCell.h
//  DHCarForSales
//
//  Created by leiyu on 15/12/20.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"
#import "M_CarMessageDetailModel.h"

typedef void(^MyDetailViewBlock)(NSInteger tab,id data);

@interface LL_SendBaoJiaInfoCell : DLTableViewCell

AS_BLOCK(MyDetailViewBlock, myBlock);
-(void)updataItem:(M_MyMessageItemModel *)model;

@end
