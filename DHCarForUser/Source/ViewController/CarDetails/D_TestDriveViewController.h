//
//  D_TestDriveViewController.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewController.h"
#import "M_CarListModel.h"
#import "AppPublicData.h"
#import "M_DealerItemModel.h"

@interface D_TestDriveViewController : DLTableViewController

AS_FACTORY(D_TestDriveViewController);

AS_MODEL_STRONG(M_CarItemModel, myItemModel);
AS_MODEL_STRONG(M_DealerItemModel, myDealerItemModel);

@end
