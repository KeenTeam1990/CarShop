//
//  D_ReserveViewController.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewController.h"
#import "M_CarListModel.h"
#import "AppPublicData.h"
#import "M_DealerItemModel.h"

typedef void (^TReserveViewControllerBlock)(NSInteger tag);
typedef void (^TSelectMonthBlock)(NSInteger tag);
typedef void(^updateCell)(NSInteger indexRow);


@interface D_ReserveViewController : DLTableViewController

AS_FACTORY(D_ReserveViewController);

AS_BLOCK(TReserveViewControllerBlock, block);
AS_BLOCK(TSelectMonthBlock, monthBlock);
AS_BLOCK(updateCell, updateBlock);


AS_INT(selectButtonIndex);

AS_MODEL_STRONG(M_CarItemModel, myItemModel);
AS_MODEL(TCarBottomType, carType);
AS_MODEL_STRONG(M_DealerItemModel, myDealerItemModel);
AS_MODEL_STRONG(NSString, myInquiry_Quoted_Id);
AS_MODEL_STRONG(NSString, monthToPay);

@end
