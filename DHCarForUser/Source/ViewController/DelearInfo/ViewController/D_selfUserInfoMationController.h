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

AS_FACTORY(D_selfUserInfoMationController);

AS_MODEL_STRONG(M_MyMessageItemModel, salesInfoModel);

AS_MODEL_STRONG(M_DealerItemModel, myDealerItemModel);
-(void)upDateWithMessage:(M_MyMessageItemModel *)messageModel andWithDealerModel:(M_DealerItemModel *)dealerModel;
@end
