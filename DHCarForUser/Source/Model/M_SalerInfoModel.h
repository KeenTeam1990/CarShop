//
//  M_SalerInfoModel.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/12/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"
#import "M_DealerItemModel.h"
@interface M_SalerInfoModel : DLBaseModel

AS_FACTORY(M_SalerInfoModel);

AS_MODEL_STRONG(NSString, sales_id);
AS_MODEL_STRONG(NSString, sales_name);
AS_MODEL_STRONG(NSString, sales_photo);
AS_MODEL_STRONG(NSString, sales_role);
AS_MODEL_STRONG(NSString, sales_sex);
AS_MODEL_STRONG(NSString, sales_sig);
AS_MODEL_STRONG(NSString, sales_star);
AS_MODEL_STRONG(NSString, sales_work_year);
AS_MODEL_STRONG(M_DealerItemModel, dealer);

@end
