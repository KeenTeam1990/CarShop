//
//  M_CommuniteUserCell.h
//  DHCarForSales
//
//  Created by leiyu on 15/11/3.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"
@class M_CommunicateModel;

@interface M_CommuniteUserCell : DLTableViewCell

@property(nonatomic,strong)M_CommunicateModel *model;

-(void)updateData:(M_CommunicateModel*)data;
@end
