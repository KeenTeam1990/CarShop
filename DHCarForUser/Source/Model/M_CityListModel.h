//
//  M_CityListModel.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_ProvinceItemModel : DLBaseModel
AS_FACTORY(M_ProvinceItemModel);

AS_MODEL_STRONG(NSString, myProvince_id);
AS_MODEL_STRONG(NSString, myProvince_Name);
AS_MODEL_STRONG(NSMutableArray, myCityArray1);

@end


@interface M_CityItemModel : DLBaseModel

AS_FACTORY(M_CityItemModel);

AS_MODEL_STRONG(NSString, myProvince_Id);
AS_MODEL_STRONG(NSString, myCity_Id);
AS_MODEL_STRONG(NSString, myCity_Code);
AS_MODEL_STRONG(NSString, myCity_Name);
AS_MODEL_STRONG(NSString, myCity_First);
AS_MODEL_STRONG(NSString, myCity_Status);
AS_MODEL_STRONG(NSString, myDealer_count);
AS_MODEL_STRONG(NSMutableArray, myCityArray);

@end



@interface M_CityListModel : DLBaseModel

AS_FACTORY(M_CityListModel);

AS_MODEL_STRONG(NSMutableArray, myAllCityArray);

@end

@interface M_CityList2Model : DLBaseModel

AS_FACTORY(M_CityList2Model);

AS_MODEL_STRONG(NSMutableArray, myAllCityArray);

@end

