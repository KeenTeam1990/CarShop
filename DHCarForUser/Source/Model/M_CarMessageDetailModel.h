//
//  M_CarMessageDetailModel.h
//  DHCarForSales
//
//  Created by leiyu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"
#import "M_MyOrderModel.h"
#import "M_UserInfoModel.h"

@interface M_MyMessageModel : DLBaseModel

AS_FACTORY(M_MyMessageModel);

AS_MODEL_STRONG(NSMutableArray, myItemArray);

@end


@interface M_MyMessageItemModel : DLBaseModel

AS_FACTORY(M_MyMessageItemModel);

AS_MODEL_STRONG(NSString, myMessage_id);

AS_MODEL_STRONG(M_UserInfoModel, myFromModel);
AS_MODEL_STRONG(M_UserInfoModel, myToModel);

AS_MODEL_STRONG(NSString, myUserType);//0 左  1 右

AS_MODEL_STRONG(NSString, myContent);
AS_MODEL_STRONG(NSString, myType);
AS_MODEL_STRONG(NSString, myIsRead);
AS_MODEL_STRONG(NSString, myTimer);
AS_MODEL_STRONG(NSString, myGroup);//inquiry_quoted_id

AS_MODEL_STRONG(NSString, myCardId);
AS_MODEL_STRONG(NSString, myCardCarImg);
AS_MODEL_STRONG(NSString, myCardDesc);
AS_MODEL_STRONG(NSString, myCardInfo);
AS_MODEL_STRONG(NSString, myCardSales);

AS_BOOL(timeButtonShowOrNot);


@end

@interface M_CarMessageDetailModel : DLBaseModel

AS_FACTORY(M_CarMessageDetailModel);

AS_MODEL_STRONG(NSMutableArray, myItemArray);

AS_MODEL_STRONG(M_QuoteItemModel, myQuoteModel);

@end
