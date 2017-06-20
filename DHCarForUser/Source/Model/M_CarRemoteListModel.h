//
//  M_CarRemoteListModel.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_CarRemoteItemModel : DLBaseModel

AS_FACTORY(M_CarRemoteItemModel);

AS_MODEL_STRONG(NSString, rentalCarId);//id
AS_MODEL_STRONG(NSString, provinceName);//省份名称
AS_MODEL_STRONG(NSString, cityName);//城市名称
AS_MODEL_STRONG(NSString, countyName);//县名称
AS_MODEL_STRONG(NSString, cityCode);//城市编码
AS_MODEL_STRONG(NSString, rentalCar_Person);//人数id
AS_MODEL_STRONG(NSString, rentalCar_PersonName);//人数
AS_MODEL_STRONG(NSString, rentalCar_Type);//类型id
AS_MODEL_STRONG(NSString, rentalCar_TypeName);//类型
AS_MODEL_STRONG(NSString, rentalCar_MakeTime);//预约时间
AS_MODEL_STRONG(NSString, rentalCar_CreateTime);//提交时间


@end

@interface M_CarRemoteListModel : DLBaseModel

AS_FACTORY(M_CarRemoteListModel);

AS_MODEL_STRONG(NSMutableArray, myItemArray);

@end
