//
//  M_CarPriceListModel.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_CarPriceItemModel : DLBaseModel

AS_FACTORY(M_CarPriceitemModel);

AS_MODEL_STRONG(NSString, myCarPriceId);
AS_MODEL_STRONG(NSString, myCarPriceName);

AS_BOOL(seleted);

@end

@interface M_CarPriceListModel : DLBaseModel

AS_FACTORY(M_CarPriceListModel);

AS_MODEL_STRONG(NSMutableArray, myItemArray);

@end
