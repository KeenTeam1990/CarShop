//
//  M_QueryModelsModel.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/12.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_QueryModelsModel : DLBaseModel

AS_FACTORY(M_QueryModelsModel);

AS_MODEL_STRONG(NSMutableArray, itemArray);


//AS_MODEL_STRONG(NSString, rentalImageViewStr);
//AS_MODEL_STRONG(NSString, discountStr);
//AS_MODEL_STRONG(NSString, carName);
//AS_MODEL_STRONG(NSString, carName1);
//AS_MODEL_STRONG(NSString, carColor);
//AS_MODEL_STRONG(NSString, carStr);
//AS_MODEL_STRONG(NSString, dateStr);

@end
