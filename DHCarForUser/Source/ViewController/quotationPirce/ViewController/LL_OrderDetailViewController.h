//
//  LL_OrderDetailViewController.h
//  DHCarForSales
//
//  Created by leiyu on 15/12/23.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewController.h"

#import "M_CarMessageDetailModel.h"

@interface LL_OrderDetailViewController : DLTableViewController

AS_MODEL_STRONG(M_QuoteItemModel, myItemModel);

AS_MODEL_STRONG(NSString, myQuotedId);

AS_MODEL_STRONG(NSString, myEntry);

AS_MODEL_STRONG(NSString, myTitle);

@end
