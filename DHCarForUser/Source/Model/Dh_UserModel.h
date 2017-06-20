//
//  Dh_UserModel.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/10/28.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLBaseModel.h"




@interface Dh_UserModel : DLBaseModel

AS_FACTORY(Dh_UserModel);

AS_MODEL_STRONG(NSString, user_name);
AS_MODEL_STRONG(NSString, user_id);
AS_MODEL_STRONG(NSString, user_photo);
AS_MODEL_STRONG(NSString, user_phone);
//AS_MODEL_STRONG(NSString, user_phone);
AS_MODEL_STRONG(NSString, user_birthday);
AS_MODEL_STRONG(NSString, user_sex);
AS_MODEL_STRONG(NSString, province_name);
AS_MODEL_STRONG(NSString, city_name);
AS_MODEL_STRONG(NSString, county_name);
AS_MODEL_STRONG(NSString, city_code);
AS_MODEL_STRONG(NSString, user_gold);
AS_MODEL_STRONG(NSString, user_order_gas);
@end


