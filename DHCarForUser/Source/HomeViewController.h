//
//  HomeViewController.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/10/28.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DLCustomTabBarView.h"
#import "Buy2ViewController.h"
#import "BuyCarViewController.h"
#import "MyCenterViewController.h"
#import "RentalCarViewController.h"
#import "SpecialCarViewController.h"
#import "H_HomeViewController.h"
#import "DHFindViewController.h"
@interface HomeViewController : UIViewController<DLCustomTabBarViewDelegate>

AS_FACTORY(HomeViewController);

AS_MODEL_STRONG(UITabBarController, myTabBarController);
AS_MODEL_STRONG(H_HomeViewController, homeVC);
AS_MODEL_STRONG(BuyCarViewController, buyCarVC);
AS_MODEL_STRONG(MyCenterViewController, myCenterVC);
AS_MODEL_STRONG(RentalCarViewController, rentalCarVC);
AS_MODEL_STRONG(SpecialCarViewController, specialCarVC);
AS_MODEL_STRONG(DHFindViewController, findMessageVC);
AS_MODEL_STRONG(DLCustomTabBarView, tabBarView);

//是否显示下边控制菜单
-(void)showOrHideCustomTabaBar:(BOOL)sender;

@end
