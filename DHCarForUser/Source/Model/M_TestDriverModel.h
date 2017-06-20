//
//  M_TestDriverModel.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"
#import "M_CarListModel.h"
#import "M_DealerItemModel.h"
@interface  M_TestDriverItemModel: DLBaseModel

AS_FACTORY(M_TestDriverItemModel);
AS_MODEL_STRONG(NSString, test_drive_id);//试驾ID
AS_MODEL_STRONG(NSString, test_drive_username);//姓名
AS_MODEL_STRONG(NSString, test_drive_user_phone);//联系方式
AS_MODEL_STRONG(NSString, test_drive_make_time);//试乘时间
AS_MODEL_STRONG(NSString, test_drive_createtime);//提交时间
AS_MODEL_STRONG(NSString, province_name);//省份名称
AS_MODEL_STRONG(NSString, city_name);//城市名称
AS_MODEL_STRONG(NSString, county_name);//县名称
AS_MODEL_STRONG(NSString, city_code);//城市编码
AS_MODEL_STRONG(NSString, test_drive_memo);//补充说明
//AS_MODEL_STRONG(NSString, dealer_car_id);//补充说明

AS_MODEL_STRONG(NSString, myGreated_at);//订单创建时间
AS_MODEL_STRONG(NSString, myID);//
AS_MODEL_STRONG(NSString, mycar_id);//

AS_MODEL_STRONG(NSString, myBigBrand_Name);//大品牌名称
AS_MODEL_STRONG(NSString, myBrand_Id);//品牌ID
AS_MODEL_STRONG(NSString, myBrand_Name);//品牌名称
AS_MODEL_STRONG(NSString, mySubbrand_Id);//车系ID
AS_MODEL_STRONG(NSString, mySubbrand_Name);//车系名称
AS_MODEL_STRONG(NSString, myCar_Name);//车型名称
AS_MODEL_STRONG(NSString, myCar_Year);//年份
AS_MODEL_STRONG(NSString, myCar_Img);//图片

AS_MODEL_STRONG(NSString, dealer_name);//名称
AS_MODEL_STRONG(NSString, dealer_sname);//简称
AS_MODEL_STRONG(NSString, dealer_code);//代码


AS_MODEL_STRONG(NSString, dealer_address);//详细地址
AS_MODEL_STRONG(NSString, dealer_zip);//邮编
AS_MODEL_STRONG(NSString, dealer_tel);//电话
AS_MODEL_STRONG(NSString, dealer_email);//邮箱
AS_MODEL_STRONG(NSString, dealer_lat);//经度s
AS_MODEL_STRONG(NSString, dealer_lng);//纬度


//AS_MODEL_STRONG(M_CarItemModel, car);
//AS_MODEL_STRONG(M_DealerItemModel, dealer);

@end

@interface M_TestDriverModel : DLBaseModel

AS_FACTORY(M_TestDriverModel);
AS_MODEL_STRONG(NSMutableArray, myItemArray);

@property(nonatomic ,strong) NSString *dealer_car_id;
@property(nonatomic ,strong) NSString *dealer_car_id1;
@property(nonatomic ,strong) NSString *city_code;
@property(nonatomic ,strong) NSString *test_drive_make_time;
@property(nonatomic ,strong) NSString *dealer_id;


AS_MODEL_STRONG(NSString, rentalImageViewStr);
AS_MODEL_STRONG(NSString, discountStr);
AS_MODEL_STRONG(NSString, carName);
AS_MODEL_STRONG(NSString, carName1);
AS_MODEL_STRONG(NSString, carColor);
AS_MODEL_STRONG(NSString, carStr);
AS_MODEL_STRONG(NSString, dateStr);
//@property(nonatomic ,strong) NSString *dealer_car_id;
//@property(nonatomic ,strong) NSString *dealer_car_id;
//@property(nonatomic ,strong) NSString *dealer_car_id;
//@property(nonatomic ,strong) NSString *dealer_car_id;

@end
