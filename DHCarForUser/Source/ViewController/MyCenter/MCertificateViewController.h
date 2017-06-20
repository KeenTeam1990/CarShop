//
//  MCertificateViewController.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/15.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewController.h"

typedef void (^TMCertificateViewControllerBlock)();

@interface MCertificateViewController : DLTableViewController

AS_FACTORY(MCertificateViewController);

AS_BLOCK(TMCertificateViewControllerBlock, block);

AS_MODEL_STRONG(NSString, myOrderID);

@end
