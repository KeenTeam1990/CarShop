//
//  D_selfUserInfoMationController.h
//  DHCarForSales
//
//  Created by leiyu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewController.h"
#import "M_CarMessageDetailModel.h"
@interface D_selfUserInfoMationController : DLTableViewController<UIActionSheetDelegate>

@property(nonatomic,strong)M_MyMessageItemModel *salesInfoModel;

@end
