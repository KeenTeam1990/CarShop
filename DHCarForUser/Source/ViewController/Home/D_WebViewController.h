//
//  D_WebViewController.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseViewController.h"

@interface D_WebViewController : DLBaseViewController

AS_FACTORY(D_WebViewController);

AS_MODEL_STRONG(NSString, myTitle);
AS_MODEL_STRONG(NSString, myUrl);

AS_BOOL(showPush);

AS_BOOL(comeFromAD);

@end
