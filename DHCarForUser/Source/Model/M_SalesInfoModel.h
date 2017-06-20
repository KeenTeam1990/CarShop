//
//  M_SalesInfoModel.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_SalesInfoModel : DLBaseModel

AS_FACTORY(M_SalesInfoModel);

AS_MODEL_STRONG(NSString, sales_id);
AS_MODEL_STRONG(NSString, sales_name);
AS_MODEL_STRONG(NSString, myCar_id);
AS_MODEL_STRONG(NSString, sales_photo);
AS_MODEL_STRONG(NSString, sales_sex);
AS_MODEL_STRONG(NSString, sales_role);
AS_MODEL_STRONG(NSString, sales_star);
AS_MODEL_STRONG(NSString, sales_work_year);
AS_MODEL_STRONG(NSString, sales_sig);
AS_MODEL_STRONG(NSString, dealer_id);
AS_MODEL_STRONG(NSString, dealer_name);

AS_MODEL_STRONG(NSString, dealer_sname);
AS_MODEL_STRONG(NSString, province_name);
AS_MODEL_STRONG(NSString, city_name);
AS_MODEL_STRONG(NSString, county_name);
AS_MODEL_STRONG(NSString, city_code);

AS_MODEL_STRONG(NSString, dealer_address);
AS_MODEL_STRONG(NSString, dealer_zip);
AS_MODEL_STRONG(NSString, dealer_tel);
AS_MODEL_STRONG(NSString, dealer_email);
AS_MODEL_STRONG(NSString, dealer_lat);

AS_MODEL_STRONG(NSString, dealer_lng);
AS_MODEL_STRONG(NSString, dealer_star);
AS_MODEL_STRONG(NSString, dealer_distance);

@end
