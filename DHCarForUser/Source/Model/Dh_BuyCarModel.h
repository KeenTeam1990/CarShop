//
//  Dh_BuyCarModel.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/3.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface Dh_BuyCarModel : DLBaseModel

AS_MODEL_STRONG(NSString, rentalImageViewStr);
AS_MODEL_STRONG(NSString, discountStr);
AS_MODEL_STRONG(NSString, carName);
AS_MODEL_STRONG(NSString, originalPrice);
AS_MODEL_STRONG(NSString, presentPrice);


@end
