//
//  M_MymessageListModel.h
//  DHCarForSales
//
//  Created by leiyu on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"
#import "M_UserInfoModel.h"
@interface M_MymessageListModel : DLBaseModel
AS_FACTORY(M_MymessageListModel);
AS_MODEL_STRONG(NSString, count);
AS_MODEL_STRONG(NSString, no_read_count);
AS_MODEL_STRONG(NSMutableArray,item );


@end



@interface M_MymessageLast_infoModel : DLBaseModel
AS_FACTORY(M_MymessageLast_infoModel)
AS_MODEL_STRONG(NSString, message_id);
AS_MODEL_STRONG(NSString, message_txt);
AS_MODEL_STRONG(NSString, message_time);

@end

@interface M_MymessageListItemModel : DLBaseModel
AS_FACTORY(M_MymessageListItemModel)
AS_MODEL_STRONG(NSString, order_id);
AS_MODEL_STRONG(NSString, order_number);
AS_MODEL_STRONG(M_UserInfoModel, user);
AS_MODEL_STRONG(M_MymessageLast_infoModel, last_info);
AS_MODEL_STRONG(NSString, read_no_number);

@end
