//
//  M_DealerItemModel.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//  经销商单个数据模型

#import "DLBaseModel.h"

@interface M_DealerItemModel : DLBaseModel

AS_FACTORY(M_DealerItemModel);

AS_MODEL_STRONG(NSIndexPath, myIndexPath);
AS_MODEL_STRONG(NSString, dealer_id);//id
AS_MODEL_STRONG(NSString, dealer_name);//名称
AS_MODEL_STRONG(NSString, dealer_sname);//简称
AS_MODEL_STRONG(NSString, dealer_code);//代码
AS_MODEL_STRONG(NSString, province_name);//省份名称
AS_MODEL_STRONG(NSString, province_id);//省份名称
AS_MODEL_STRONG(NSString, city_name);//城市名称
AS_MODEL_STRONG(NSString, city_id);//城市名称
AS_MODEL_STRONG(NSString, county_name);//县名称
AS_MODEL_STRONG(NSString, city_code);//城市编码
AS_MODEL_STRONG(NSString, dealer_address);//详细地址
AS_MODEL_STRONG(NSString, dealer_zip);//邮编
AS_MODEL_STRONG(NSString, dealer_tel);//电话
AS_MODEL_STRONG(NSString, dealer_email);//邮箱
AS_MODEL_STRONG(NSString, dealer_lat);//经度
AS_MODEL_STRONG(NSString, dealer_lng);//纬度
AS_MODEL_STRONG(NSString, dealer_distance);//距离（公里）
AS_MODEL_STRONG(NSString, dealer_star);//星级
AS_MODEL_STRONG(NSString, dealer_car_price);//报价（万元）
AS_MODEL_STRONG(NSString, dealer_lease_price);//租购报价（万元）
AS_MODEL_STRONG(NSString, dealer_car_id);//经销商专属carid

AS_FLOAT_ASSIGN(distance);
AS_FLOAT_ASSIGN(price);

AS_BOOL(myCar_Lease);//是否租购
AS_BOOL(myCar_Sales);//是否特价
AS_BOOL(myCar_New);//是否新车

AS_MODEL_STRONG(NSMutableArray, myLeaseArray);
AS_MODEL_STRONG(NSMutableArray, myColorArray);

AS_BOOL(selete);

-(void)toData:(M_DealerItemModel*)data;

@end
