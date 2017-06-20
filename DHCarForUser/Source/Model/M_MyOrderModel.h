//
//  M_MyOrderModel.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/12.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"
#import "M_CarListModel.h"
#import "M_UserInfoModel.h"
#import "M_DealerItemModel.h"


@interface M_OrderCodeModel : DLBaseModel

AS_FACTORY(M_OrderCodeModel);

AS_MODEL_STRONG(NSString, myCodeId);
AS_MODEL_STRONG(NSString, myCodeStr);
AS_MODEL_STRONG(NSString, myPhone);
AS_MODEL_STRONG(NSString, myType);

@end

@interface M_WxPayModel : DLBaseModel

AS_FACTORY(M_WxPayModel);

AS_MODEL_STRONG(NSString, appid);
AS_MODEL_STRONG(NSString, partnerid);
AS_MODEL_STRONG(NSString, noncestr);
AS_MODEL_STRONG(NSString, prepayid);
AS_MODEL_STRONG(NSString, timestamp);
AS_MODEL_STRONG(NSString, sign);
AS_MODEL_STRONG(NSString, packagevalue);

@end

@interface M_QuoteComboItemModel : DLBaseModel

AS_FACTORY(M_QuoteComboItemModel);

AS_MODEL_STRONG(NSString, myComboId);
AS_MODEL_STRONG(NSString, myComboTitle);
AS_MODEL_STRONG(NSString, myComboContent);
AS_MODEL_STRONG(NSString, myDealerId);

@end

@class M_MyOrderTtemModel;

@interface M_QuoteItemModel : DLBaseModel

AS_FACTORY(M_QuoteItemModel);

AS_MODEL_STRONG(NSString, myQuoteId);
AS_MODEL_STRONG(NSString, myFirstPrice);
AS_MODEL_STRONG(NSString, myFirstInfo);

AS_MODEL_STRONG(NSString, myLastPrice);
AS_MODEL_STRONG(NSString, myLastInfo);

AS_MODEL_STRONG(NSMutableArray, myFirstComboArray);
AS_MODEL_STRONG(NSMutableArray,myLastComboArray);

AS_MODEL_STRONG(NSString, myHasConverted);
AS_MODEL_STRONG(NSString, myEarnest);

AS_MODEL_STRONG(NSString, myUid);
AS_MODEL_STRONG(NSString, mySalesUid);
AS_MODEL_STRONG(NSString, myInquiryId);
AS_MODEL_STRONG(NSString, myExpectSalesUid);

AS_MODEL_STRONG(M_DealerItemModel, myDealerModel);

AS_MODEL_STRONG(M_MyOrderTtemModel, myInquiryModel);

AS_MODEL_STRONG(M_MyOrderTtemModel, myOrderModel);

@end

@interface M_MyOrderTtemModel : DLBaseModel

AS_FACTORY(M_MyOrderTtemModel);

AS_MODEL_STRONG(NSString, order_id);//订单id
AS_MODEL_STRONG(NSString, order_no);//订单编号
AS_MODEL_STRONG(NSString, order_time);//订单时间
AS_MODEL_STRONG(NSString, order_price);//订单价格

AS_MODEL_STRONG(NSString, order_create_time);//订单时间
AS_MODEL_STRONG(NSString, order_update_time);//订单时间
AS_MODEL_STRONG(NSString, order_finish_time);//订单时间

AS_MODEL_STRONG(NSString, order_step);//0未支付 1未发码 2未核销 3未上传凭证 4凭证待审核 5订单完成 -1订单关闭未退款 -2订单关闭已退款 -3凭证未通过审核 -4订单过期关闭 -5订单支付失败 -6订单支付成功待对账

AS_MODEL_STRONG(NSString, myDealer_count);//共询价几个经销商
AS_MODEL_STRONG(NSString, myQuoted_count);//共几个经销商报价

AS_MODEL_STRONG(NSString, myQuoted_at);//询价时间

AS_MODEL_STRONG(NSString, myAlipayStr);//支付宝参数

AS_MODEL_STRONG(NSMutableArray, myDealerArray);//询价 经销商信息

AS_MODEL_STRONG(NSMutableArray, myQuoteArray);//询价信息

AS_MODEL_STRONG(M_CarItemModel, car);//车信息
AS_MODEL_STRONG(M_UserInfoModel, user);//订单id
AS_MODEL_STRONG(M_DealerItemModel, myDealerModel);//经销商

AS_MODEL_STRONG(M_WxPayModel, myWxPayModel);//微信

AS_MODEL_STRONG(M_OrderCodeModel, myCodeModel);//发码信息

AS_MODEL_STRONG(M_QuoteItemModel, myQuoteModel);//询价信息

AS_MODEL_STRONG(NSMutableArray, myCertificateArray);

@end

@interface M_MyOrderModel : DLBaseModel

AS_FACTORY(M_MyOrderModel)

AS_MODEL_STRONG(NSMutableArray, myItemArray);




@end
