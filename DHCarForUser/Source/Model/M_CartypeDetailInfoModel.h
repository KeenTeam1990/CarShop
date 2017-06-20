//
//  M_CartypeDetailInfoModel.h
//  DHCarForSales
//
//  Created by leiyu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"
#import "M_CarDetailInfoModel.h"


//***************************车的代理人
@interface M_CarDealerModel : DLBaseModel
AS_FACTORY (M_CarDealerModel);
AS_MODEL_STRONG(NSString, dealer_id);
AS_MODEL_STRONG(NSString, dealer_name);
AS_MODEL_STRONG(NSString, dealer_sname);
AS_MODEL_STRONG(NSString, dealer_code);
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
AS_MODEL_STRONG(NSString, dealer_distance);
AS_MODEL_STRONG(NSString, dealer_star);
AS_MODEL_STRONG(NSString, dealer_car_price);
AS_MODEL_STRONG(NSString, dealer_car_id);


@end

@interface M_CartypeDetailInfoModel : DLBaseModel
AS_FACTORY(M_CartypeDetailInfoModel) ;
AS_MODEL_STRONG(M_carItemDetailInfoModel, car);
AS_MODEL_STRONG(M_CarDealerModel, dealer)

@end