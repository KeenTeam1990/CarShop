//
//  M_CarTypeListModel.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_CarTypeItemModel : DLBaseModel

AS_FACTORY(M_CarTypeItemModel);

AS_MODEL_STRONG(NSString, myCarType);
AS_MODEL_STRONG(NSString, myCarTypeName);

AS_BOOL(seleted);

@end

@interface M_CarTypeListModel : DLBaseModel

AS_FACTORY(M_CarTypeListModel);

AS_MODEL_STRONG(NSMutableArray, myItemArray);

@end
