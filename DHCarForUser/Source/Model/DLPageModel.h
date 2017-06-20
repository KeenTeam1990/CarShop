//
//  DLPageModel.h
//  Auction
//
//  Created by 卢迎志 on 15-3-2.
//
//

#import "DLBaseModel.h"

@interface DLPageModel : NSObject

AS_FACTORY(DLPageModel);

AS_BOOL(hasMore);
AS_MODEL_STRONG(NSString, nextMax);
AS_MODEL_STRONG(NSString, lastMax);
AS_MODEL_STRONG(NSString, count);
AS_MODEL_STRONG(NSString, limit);

-(void)toData:(DLPageModel*)data;

+(id)copyClone:(DLPageModel*)model;

@end
