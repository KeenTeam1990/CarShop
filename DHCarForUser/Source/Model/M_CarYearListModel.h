//
//  M_CarYearListModel.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_CarYearItemModel : DLBaseModel

AS_FACTORY(M_CarYearItemModel);

AS_MODEL_STRONG(NSString, myYear);

AS_BOOL(seleted);

@end

@interface M_CarYearListModel : DLBaseModel

AS_FACTORY(M_CarYearListModel);

AS_MODEL_STRONG(NSMutableArray, myItemArray);

@end
