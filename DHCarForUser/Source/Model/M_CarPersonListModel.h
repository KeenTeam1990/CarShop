//
//  M_CarPersonListModel.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_CarPersonItemModel : DLBaseModel

AS_FACTORY(M_CarPersonItemModel);

AS_MODEL_STRONG(NSString, myCarPersonId);
AS_MODEL_STRONG(NSString, myCarPersonName);


@end

@interface M_CarPersonListModel : DLBaseModel

AS_FACTORY(M_CarPersonListModel);

AS_MODEL_STRONG(NSMutableArray, myItemArray);

@end
