//
//  M_IndexModel.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/12.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"
#import "M_CarListModel.h"

@interface M_IndexCoverModel : DLBaseModel

AS_FACTORY(M_IndexCoverModel);

AS_MODEL_STRONG(NSString, myId);
AS_MODEL_STRONG(NSString, myTitle);
AS_MODEL_STRONG(NSString, myContent);
AS_MODEL_STRONG(NSString, myCover);
AS_MODEL_STRONG(NSString, myUrl);

@end

@interface M_IndexLineItemModel : DLBaseModel

AS_FACTORY(M_IndexLineItemModel);

AS_MODEL_STRONG(NSString, myType);//推荐类型  1活动 2汽车

AS_MODEL_STRONG(M_IndexCoverModel, myCoverModel);
AS_MODEL_STRONG(M_CarItemModel, myCarModel);

@end

@interface M_IndexItemModel : DLBaseModel

AS_FACTORY(M_IndexItemModel);

AS_MODEL_STRONG(NSMutableArray, myIndexArray);

@end

@interface M_IndexModel : DLBaseModel

AS_FACTORY(M_IndexModel);

AS_MODEL_STRONG(NSMutableArray, myIndexArray);

@end
