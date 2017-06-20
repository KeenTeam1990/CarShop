//
//  M_CarInsuranceListModel.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_CarInsuranceItemModel : DLBaseModel

AS_FACTORY(M_CarInsuranceItemModel);

AS_MODEL_STRONG(NSString, insuranceId);
AS_MODEL_STRONG(NSString, carNumber);
AS_MODEL_STRONG(NSString, carShelfNumber);
AS_MODEL_STRONG(NSString, insuranceCommpany);
AS_MODEL_STRONG(NSString, insuranceCreateTime);

@end

@interface M_CarInsuranceListModel : DLBaseModel

AS_FACTORY(M_CarInsuranceListModel);

AS_MODEL_STRONG(NSMutableArray, myItemArray);

@end
