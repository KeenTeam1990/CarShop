//
//  M_DealerListModel.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_DealerListModel : DLBaseModel

AS_FACTORY(M_DealerListModel);

AS_MODEL_STRONG(NSMutableArray, myDealerListArray);

@end
