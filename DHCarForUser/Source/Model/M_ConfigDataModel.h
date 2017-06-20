//
//  M_ConfigDataModel.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/22.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_ConfigDataItemModel : DLBaseModel

AS_FACTORY(M_ConfigDataItemModel);

AS_MODEL_STRONG(NSString, myImg);
AS_MODEL_STRONG(NSString, myName);
AS_MODEL_STRONG(NSString, myUrl);

AS_BOOL(isSelete);

@end

@interface M_ConfigDataModel : DLBaseModel

AS_FACTORY(M_ConfigDataModel);

AS_MODEL_STRONG(NSMutableArray, myItemArray);
AS_MODEL_STRONG(NSString, type);

@end
