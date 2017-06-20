//
//  MyCenterViewController.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/10/30.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLTableViewController.h"
@interface MyCenterViewController : DLTableViewController

AS_FACTORY(MyCenterViewController);
AS_MODEL_STRONG(NSArray, dataArray);
AS_MODEL_STRONG(NSString, countOrderStr);

@end
