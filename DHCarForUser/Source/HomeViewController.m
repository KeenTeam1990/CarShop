//
//  HomeViewController.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/10/28.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
DEF_FACTORY(HomeViewController);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.homeVC        = [[H_HomeViewController alloc]init];
//    self.homeVC = DEF_FACTORY(H_HomeViewController);
    self.buyCarVC      = [[BuyCarViewController alloc]init];
    self.myCenterVC    = [[MyCenterViewController alloc]init];
    self.rentalCarVC   = [[RentalCarViewController alloc]init];
    self.specialCarVC  = [[SpecialCarViewController alloc]init];
    self.findMessageVC = [[DHFindViewController alloc] init];
    
    self.myTabBarController = [[UITabBarController alloc]init];
    self.myTabBarController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    DLBaseNavigationController* tempNav1 = [DLBaseNavigationController sharedInstanceRoot:self.homeVC];
    DLBaseNavigationController* tempNav2 = [DLBaseNavigationController sharedInstanceRoot:self.specialCarVC];
    DLBaseNavigationController* tempNav3 = [DLBaseNavigationController sharedInstanceRoot:self.rentalCarVC];
    DLBaseNavigationController* tempNav4 = [DLBaseNavigationController sharedInstanceRoot:self.buyCarVC];
    DLBaseNavigationController* tempNav6 = [DLBaseNavigationController sharedInstanceRoot:self.findMessageVC];
    DLBaseNavigationController* tempNav5 = [DLBaseNavigationController sharedInstanceRoot:self.myCenterVC];
    
    tempNav1.navigationBarHidden = YES;
    tempNav2.navigationBarHidden = YES;
    tempNav3.navigationBarHidden = YES;
    tempNav4.navigationBarHidden = YES;
    tempNav5.navigationBarHidden = YES;
    tempNav6.navigationBarHidden = YES;

    
    self.myTabBarController.viewControllers = [NSArray arrayWithObjects:tempNav1,tempNav6,tempNav5, nil];
    //self.myTabBarController.viewControllers = [NSArray arrayWithObjects:tempNav1,tempNav2,tempNav3,tempNav4,tempNav5, nil];
    
    [self initCustomTabItems];
    
    [self.view addSubview:self.myTabBarController.view];
    
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotification:) name:@"123456" object:nil];
}
//- (void)pushNotification:(NSNotification *)notification
//{
//    NSDictionary *dict = notification.userInfo;
//    
//    // kpiid  其实就是后台传出来需要点击cell的id
//    NSLog(@"===notification===%@",[dict valueForKey:@"type"]);
//    
////    [self selectKPIModuleId:[[dict valueForKey:@"type"] integerValue]];
//}
//- (void)selectKPIModuleId:(int)kpiid     // 此处是tableview  didselect方法中单独提取的方法
//{
//    
//    //销售利润
//    if(kpiid==0){
//        
//    }
//}
-(void)initCustomTabItems
{
    self.tabBarView = [DLCustomTabBarView allocInstanceFrame:CGRectMake(0, self.myTabBarController.view.bounds.size.height-TabBarHeight, self.view.bounds.size.width, TabBarHeight)];
    self.tabBarView.delegate = self;
    [self.myTabBarController.view addSubview:self.tabBarView];
    
    [self.tabBarView addTabItem:@"首页" withIcon:@"首页" withIcon_H:@"首页bar"];
    //[self.tabBarView addTabItem:@"特价" withIcon:@"特价" withIcon_H:@"特价bar"];
    [self.tabBarView addTabItem:@"发现" withIcon:@"发现" withIcon_H:@"发现bar"];

//    [self.tabBarView addTabItem:@"租购" withIcon:@"租购" withIcon_H:@"租购bar"];
//    [self.tabBarView addTabItem:@"优选" withIcon:@"汇买车" withIcon_H:@"汇买车bar"];
    [self.tabBarView addTabItem:@"我的" withIcon:@"我的" withIcon_H:@"我的bar"];
    
    [self.tabBarView updateData];
    
    [self makeTabBarHidden:YES];
    
}

//是否显示下边控制菜单
-(void)showOrHideCustomTabaBar:(BOOL)sender
{
    if (self.tabBarView.hidden == !sender) {
        return;
    }
    
    [UIView beginAnimations:@"TabbarHide" context:nil];
    CGRect tempRect = self.tabBarView.frame;
    if ( sender )
    {
        tempRect.origin.y = self.myTabBarController.view.bounds.size.height - TabBarHeight;
    }
    else
    {
        tempRect.origin.y = self.myTabBarController.view.bounds.size.height;
    }
    
    self.tabBarView.frame = tempRect;
    
    self.tabBarView.hidden = !sender;
    
    [UIView commitAnimations];
}

- (void)makeTabBarHidden:(BOOL)hide
{
    if ( [self.myTabBarController.view.subviews count] < 2 )
    {
        return;
    }
    UIView *contentView;
    
    if ( [[self.myTabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
    {
        contentView = [self.myTabBarController.view.subviews objectAtIndex:1];
    }
    else
    {
        contentView = [self.myTabBarController.view.subviews objectAtIndex:0];
    }
    [UIView beginAnimations:@"TabbarHide" context:nil];
    if ( hide )
    {
        contentView.frame = self.myTabBarController.view.bounds;
    }
    else
    {
        contentView.frame = CGRectMake(self.myTabBarController.view.bounds.origin.x,
                                       self.myTabBarController.view.bounds.origin.y,
                                       self.myTabBarController.view.bounds.size.width,
                                       self.myTabBarController.view.bounds.size.height - self.myTabBarController.tabBar.frame.size.height);
    }
    
    self.myTabBarController.tabBar.hidden = hide;
    
    [UIView commitAnimations];
}

#pragma DLCustomTabBarViewDelegate

-(void)seleteTabBar:(NSInteger)tag
{
    [self.myTabBarController setSelectedIndex:tag];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
