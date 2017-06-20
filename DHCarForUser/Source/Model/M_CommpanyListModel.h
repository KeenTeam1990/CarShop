//
//  M_CommpanyListModel.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/15.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_CommpanyItemModel : DLBaseModel

AS_FACTORY(M_CommpanyItemModel);

AS_MODEL_STRONG(NSString, insurance_commpany_id);
AS_MODEL_STRONG(NSString, insurance_commpany_name);

@end

@interface M_CommpanyListModel : DLBaseModel

AS_FACTORY(M_CommpanyListModel);

AS_MODEL_STRONG(NSMutableArray, myItemArray);

@end
