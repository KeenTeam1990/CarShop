//
//  M_CarGasListModel.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_CarGasItemModel : DLBaseModel

AS_FACTORY(M_CarGasItemModel);

AS_MODEL_STRONG(NSString, order_gas_id);//id
AS_MODEL_STRONG(NSString, order_gas_number);//编号
AS_MODEL_STRONG(NSString, order_gas_price);//价格
AS_MODEL_STRONG(NSString, order_gas_state);//状态，0待付款，1 已支付(待审核)，2 已审核
AS_MODEL_STRONG(NSString, order_gas_createtime);//提交时间
AS_MODEL_STRONG(NSString, order_gas_enquiry_pay);//支付方式：支付宝／微信
AS_MODEL_STRONG(NSString, order_gas_enquiry_pay_number);//交易号码
AS_MODEL_STRONG(NSString, order_gas_enquiry_pay_time);//支付时间
AS_MODEL_STRONG(NSString, order_gas_enquiry_pay_state);//支付状态，0待支付，1已支付

@end

@interface M_CarGasListModel : DLBaseModel

AS_FACTORY(M_CarGasListModel);

AS_MODEL_STRONG(NSMutableArray, myItemArray);

@end
