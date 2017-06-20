//
//  D_LoginViewController.h
//  DHCarForSales
//
//  Created by lucaslu on 15/10/31.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewController.h"

typedef void (^TLoginViewControllerBlock)(NSInteger tag);

@interface D_LoginViewController : DLTableViewController

AS_FACTORY(D_LoginViewController);

AS_BLOCK(TLoginViewControllerBlock, block);

AS_BOOL(isLogin);

-(void)handlerWxLogin:(int)errorcode withCode:(NSString*)code;

-(void)handlerWbLogin:(int)errorcode;

@end
