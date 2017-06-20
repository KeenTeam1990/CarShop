//
//  M_SubBrandListModel.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_SubBrandItemModel : DLBaseModel

AS_FACTORY(M_SubBrandItemModel);

AS_MODEL_STRONG(NSString, subbrand_id);
AS_MODEL_STRONG(NSString, subbrand_name);
AS_MODEL_STRONG(NSString, subbrand_code);
AS_MODEL_STRONG(NSString, subbrand_type);
AS_MODEL_STRONG(NSString, subbrand_logo);

AS_BOOL(seleted);

@end

@interface M_SubBrandListModel : DLBaseModel

AS_FACTORY(M_SubBrandListModel);

AS_MODEL_STRONG(NSMutableArray, myItemArray);

@end
