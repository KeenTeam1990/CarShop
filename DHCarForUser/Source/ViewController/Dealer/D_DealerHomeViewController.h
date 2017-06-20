//
//  D_DealerHomeViewController.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewController.h"
#import "M_DealerItemModel.h"

@interface D_DealerHomeViewController : DLTableViewController

AS_FACTORY(D_DealerHomeViewController);

AS_MODEL_STRONG(M_DealerItemModel, myItemModel);

@end
