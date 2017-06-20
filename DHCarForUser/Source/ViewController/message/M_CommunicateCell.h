//
//  M_CommunicateCell.h
//  DHCarForSales
//
//  Created by leiyu on 15/11/5.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"
@class M_MyMessageItemModel;
@interface M_CommunicateCell : DLTableViewCell
@property(nonatomic,strong)M_MyMessageItemModel *model;
-(void)updateData:(M_MyMessageItemModel*)data;

@end
