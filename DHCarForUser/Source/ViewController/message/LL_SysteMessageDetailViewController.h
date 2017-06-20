//
//  LL_SysteMessageDetailViewController.h
//  DHCarForUser
//
//  Created by leiyu on 16/4/8.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLBaseViewController.h"
#import "LL_SystemModel.h"
@interface LL_SysteMessageDetailViewController : DLBaseViewController
AS_MODEL_STRONG(LL_SystemModel, contentModel);
AS_BOOL(showPush);

AS_BOOL(comeFromAD);
@end
