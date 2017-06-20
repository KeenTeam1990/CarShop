//
//  Buy2ViewController.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/20.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "Buy2ViewController.h"

@interface Buy2ViewController ()

@end

@implementation Buy2ViewController

DEF_FACTORY(Buy2ViewController);

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    
    [self initData];
    
}

-(void)initView
{
    // 初始化导航条 @"返回箭头"
    [self addCustomNavBar:@"优选"
              withLeftBtn:nil
             withRightBtn:nil
            withLeftLabel:nil
           withRightLabel:nil];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight-TabBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    
}

-(void)initData
{
    UIImage *tempImage = [UIImage imageNamed:@"buyCarMain.png"];
    UIImageView *mainView = [[UIImageView alloc]initWithFrame:CGRectMake(0,NavigationBarHeight+20 , self.baseView.frame.size.width,self.baseView.frame.size.height-NavigationBarHeight-TabBarHeight)];
    mainView.image = tempImage;
    mainView.contentMode = UIViewContentModeScaleAspectFit;
    self.myTableView.tableHeaderView = mainView;
    
}

-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:YES];
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
