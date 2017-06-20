//
//  M_CarCommentListModel.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_CarCommentItemModel : DLBaseModel

AS_FACTORY(M_CarCommentItemModel);

AS_MODEL_STRONG(NSString, myOrder_ID);
AS_MODEL_STRONG(NSString, myOrder_Number);
AS_MODEL_STRONG(NSString, myCar_id);
AS_MODEL_STRONG(NSString, myEvaluate);
AS_MODEL_STRONG(NSString, myEvaluateCreatime);
AS_MODEL_STRONG(NSString, myUser_id);
AS_MODEL_STRONG(NSString, myUser_Name);
AS_MODEL_STRONG(NSString, myUser_Photo);
AS_MODEL_STRONG(NSString, myUser_Phone);
AS_MODEL_STRONG(NSString, myUser_Bir);
AS_MODEL_STRONG(NSString, myUser_Sex);

@end

@interface M_CarCommentListModel : DLBaseModel

AS_FACTORY(M_CarCommentListModel);

AS_MODEL_STRONG(NSMutableArray, myItemArray);

@end
