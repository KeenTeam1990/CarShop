//
//  LL_SystemModel.h
//  DHCarForSales
//
//  Created by leiyu on 16/3/30.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface LL_SystemModel : DLBaseModel
AS_FACTORY_FRAME(LL_SystemModel);
AS_MODEL_STRONG(NSString , myId);
AS_MODEL_STRONG(NSString, myFromId);
AS_MODEL_STRONG(NSString, myToId);
AS_MODEL_STRONG(NSString, myType);
AS_MODEL_STRONG(NSString, myTargetId);
AS_MODEL_STRONG(NSString, myTitle);
AS_MODEL_STRONG(NSString, myContent);
AS_MODEL_STRONG(NSString, myCreateAt);
@end

@interface LL_SystemModelArr : DLBaseModel
AS_FACTORY_FRAME(LL_SystemModelArr);
AS_MODEL_STRONG(NSMutableArray, myDataArr);
@end