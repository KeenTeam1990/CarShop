//
//  D_SeckillDetailsViewController.h
//  DHCarForUser
//
//  Created by lucaslu on 16/1/13.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLTableViewController.h"

typedef void (^TBingPhoneBlock)(bool result);

@interface D_SeckillDetailsViewController : DLTableViewController

AS_FACTORY(D_SeckillDetailsViewController);

AS_MODEL_STRONG(NSString, spike_id);

AS_BLOCK(TBingPhoneBlock, backBlock);

@end
