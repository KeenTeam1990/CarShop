//
//  DHChangePasswordViewController.h
//  DHCarForUser
//
//  Created by 张海亮 on 16/3/23.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLTableViewController.h"
@protocol MyDelegate
-(void)successGoBackAndRefreshViewController;
@end
@interface DHChangePasswordViewController : DLTableViewController
AS_DELEGATE(id<MyDelegate>, mydelegate);
@end
