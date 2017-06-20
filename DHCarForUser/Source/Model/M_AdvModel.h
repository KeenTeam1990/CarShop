//
//  M_AdvModel.h
//  Auction
//
//  Created by 卢迎志 on 15-1-4.
//
//

#import "DLBaseModel.h"

@interface M_AdvModel : DLBaseModel

AS_FACTORY(M_AdvModel);

AS_MODEL_STRONG(NSMutableArray, itemArray);

@end
