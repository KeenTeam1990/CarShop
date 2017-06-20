//
//  D_LLDetailOrderViewController.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/15.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewController.h"
#import "M_MyOrderModel.h"

@interface D_LLDetailOrderViewController : DLTableViewController

AS_FACTORY(D_LLDetailOrderViewController);

AS_MODEL_STRONG(NSString, orderID);
AS_MODEL_STRONG(M_MyOrderTtemModel, itemModel);
AS_MODEL_STRONG(NSMutableArray, dataArray);

AS_BOOL(showPush);

@end
