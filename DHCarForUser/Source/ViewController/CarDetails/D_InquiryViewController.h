//
//  D_InquiryViewController.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewController.h"
#import "AppPublicData.h"
#import "M_CarListModel.h"
#import "M_DealerItemModel.h"

@interface D_InquiryViewController : DLTableViewController

AS_FACTORY(D_InquiryViewController);

AS_MODEL_STRONG(M_CarItemModel, myItemModel);

AS_MODEL(TCarBottomType, carType);

AS_MODEL_STRONG(NSMutableArray, myDealerArray);

@end
