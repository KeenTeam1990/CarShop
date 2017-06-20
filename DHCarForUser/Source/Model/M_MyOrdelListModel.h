//
//  M_MyOrdelListModel.h
//  DHCarForSales
//
//  Created by leiyu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"
#import "M_UserInfoModel.h"
#import "M_CarDetailInfoModel.h"

@interface M_MyOrdelListModel : DLBaseModel
AS_FACTORY(M_MyOrdelListModel);
AS_MODEL_STRONG(NSString, count);
AS_MODEL_STRONG(NSString, order_buy);
AS_MODEL_STRONG(NSString, order_no_buy);
AS_MODEL_STRONG(NSMutableArray ,item );
@end

@interface M_MyOrderItemModel : DLBaseModel
AS_FACTORY(M_MyOrderItemModel)
AS_MODEL_STRONG(NSString, order_id);
AS_MODEL_STRONG(NSString, order_number);

AS_MODEL_STRONG(NSString, order_time);
AS_MODEL_STRONG(NSString, order_price);


AS_MODEL_STRONG(NSString, order_state);
AS_MODEL_STRONG(NSString, order_type);
AS_MODEL_STRONG(NSString, order_enquiry_offer)
AS_MODEL_STRONG(NSString, order_enquiry_offer_end);
AS_MODEL_STRONG(NSString, order_enquiry_memo1)
AS_MODEL_STRONG(NSString, order_enquiry_memo2);
AS_MODEL_STRONG(NSString, order_enquiry_memo3)
AS_MODEL_STRONG(M_carItemDetailInfoModel  , car);
AS_MODEL_STRONG(M_UserInfoModel, user);


@end
