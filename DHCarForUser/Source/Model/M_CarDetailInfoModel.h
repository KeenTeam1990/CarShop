//
//  M_CarDetailInfoModel.h
//  DHCarForSales
//
//  Created by leiyu on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_CarDetailInfoModel : DLBaseModel
AS_FACTORY(M_CarDetailInfoModel);
AS_MODEL_STRONG(NSString, count);
AS_MODEL_STRONG(NSMutableArray, item);
@end


@interface M_carItemDetailInfoModel : DLBaseModel
AS_FACTORY(M_carItemDetailInfoModel);
AS_MODEL_STRONG(NSString, car_id);
AS_MODEL_STRONG(NSString, bigbrand_id);
AS_MODEL_STRONG(NSString, bigbrand_name);
AS_MODEL_STRONG(NSString, brand_id);
AS_MODEL_STRONG(NSString, brand_name);
AS_MODEL_STRONG(NSString, subbrand_id);
AS_MODEL_STRONG(NSString, subbrand_name);
AS_MODEL_STRONG(NSString, car_name);
AS_MODEL_STRONG(NSString, car_code);
AS_MODEL_STRONG(NSString, car_year);
AS_MODEL_STRONG(NSString, car_img);
AS_MODEL_STRONG(NSString, car_info);
AS_MODEL_STRONG(NSString, car_drive);
AS_MODEL_STRONG(NSString, car_amt);
AS_MODEL_STRONG(NSString, car_out);
AS_MODEL_STRONG(NSString, car_oil);
AS_MODEL_STRONG(NSString, car_price);
AS_MODEL_STRONG(NSString, dealer_car_id);
AS_MODEL_STRONG(NSString, car_deposit);
AS_MODEL_STRONG(NSString, car_type);
AS_MODEL_STRONG(NSString, car_type_name);
AS_MODEL_STRONG(NSString, dealer_car_price);
AS_MODEL_STRONG(NSString, car_lease);
AS_MODEL_STRONG(NSString, car_sales);


AS_MODEL_STRONG(NSMutableArray, color);
AS_MODEL_STRONG(NSString, car_color);


AS_MODEL_STRONG(NSString, lease_price);
AS_MODEL_STRONG(NSMutableArray, lease);

AS_MODEL_STRONG(NSMutableArray, parameter);//发动机参数
AS_MODEL_STRONG(NSMutableArray, loan)//金融贷款
AS_MODEL_STRONG(NSMutableArray, policy)//售后政策

@end
//**********************************carParameterModel
@interface M_LLCarParameterItemModel : DLBaseModel
AS_FACTORY(M_LLCarParameterItemModel);
AS_MODEL_STRONG(NSString, item_id);
AS_MODEL_STRONG(NSString, item_name);
AS_MODEL_STRONG(NSString, item_value);
@end

@interface M_CarParameterModel : DLBaseModel
AS_FACTORY(M_CarParameterModel);
AS_MODEL_STRONG(NSString, parameter_id);
AS_MODEL_STRONG(NSString, parameter_name);
AS_MODEL_STRONG(NSMutableArray , parametaer_item);
@end

//***********************金融贷款
@interface M_CarLoanModel : DLBaseModel
AS_FACTORY(M_CarLoanModel);
AS_MODEL_STRONG(NSString , loan_id);
AS_MODEL_STRONG(NSString, loan_title);
AS_MODEL_STRONG(NSString, loan_wap);
@end

//***************************售后政策
@interface M_CarPolicyModel : DLBaseModel
AS_FACTORY(M_CarPolicyModel);
AS_MODEL_STRONG(NSString , policy_id);
AS_MODEL_STRONG(NSString, policy_title);
AS_MODEL_STRONG(NSString, policy_wap);

@end

//**********************************colormodel
@interface M_CarColorArrModel : DLBaseModel
AS_FACTORY(M_CarColorArrModel);
AS_MODEL_STRONG(NSMutableArray, color);
@end


@interface M_CarColorModel : DLBaseModel
AS_FACTORY(M_CarColorModel);
AS_MODEL_STRONG(NSString, car_color_id);
AS_MODEL_STRONG(NSString, car_color_name);
AS_MODEL_STRONG(NSString, car_color_img);
@end


//*************************************leaseModel
@interface M_CarLeaseArrModel : DLBaseModel
AS_FACTORY(M_CarLeaseArrModel);
AS_MODEL_STRONG(NSMutableArray,lease);
@end

@interface M_CarLeaseModel : DLBaseModel
AS_FACTORY(M_CarLeaseModel);
AS_MODEL_STRONG(NSString, lease_id);
AS_MODEL_STRONG(NSString, lease_loan);
AS_MODEL_STRONG(NSString, lease_panyment);
@end