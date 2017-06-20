//
//  QueryModelsItemViewController.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/16.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewController.h"
#import "M_MyOrderModel.h"
@interface QueryModelsItemViewController : DLTableViewController

AS_FACTORY(QueryModelsItemViewController)

AS_MODEL_STRONG(NSString, order_id);

@end
