//
//  D_PayViewController.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/15.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewController.h"
#import "M_CarListModel.h"
#import "M_DealerItemModel.h"

//0 成功
//1 失败／取消
typedef void (^TPayViewControllerBlock)(NSInteger tag);

@interface D_PayViewController : DLTableViewController

AS_FACTORY(D_PayViewController);

AS_BLOCK(TPayViewControllerBlock, block);

AS_MODEL_STRONG(M_CarItemModel, myItemModel);
AS_MODEL_STRONG(M_DealerItemModel, myDealerItemModel);
AS_MODEL_STRONG(NSString, order_id);
AS_MODEL_STRONG(NSString, order_num);
AS_MODEL_STRONG(NSString, myDealerId);
//AS_MODEL_STRONG(NSString, myOrderCarHeadInfo);//关于订单车的相关信息

AS_MODEL_STRONG(NSString, myAlipayStr);

AS_BOOL(showAliview);

-(void)handlerAliPay:(NSDictionary*)dic;

-(void)handlerWxPay:(NSString*)result;

@end
