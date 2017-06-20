//
//  D_CarGasViewController.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_CarGasViewController.h"
#import "D_CarGasRecordViewController.h"
#import "M_CarGasHeaderView.h"
//#import "D_PayViewController.h"
#import "TTReqEngine.h"
#import "M_OrderAddModel.h"


@interface D_CarGasViewController ()

AS_MODEL_STRONG(M_CarGasHeaderView, myHeaderView);

@end

@implementation D_CarGasViewController

DEF_FACTORY(D_CarGasViewController);
DEF_MODEL(myHeaderView);

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    
    [self initData];
}

-(void)initView
{
    [self addCustomNavBar:@"加油卡充值"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:@"充值记录"];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.bounds.size.width, self.baseView.bounds.size.height-NavigationBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    
    self.myHeaderView = [M_CarGasHeaderView allocInstanceFrame:CGRectMake(0, 0, self.baseView.frame.size.width, 150)];
    
    self.myTableView.tableHeaderView = self.myHeaderView;
}

-(void)initData
{
    [self.myHeaderView updateData];
    
    __weak D_CarGasViewController* tempSelf = self;
    self.myHeaderView.block = ^(){
        [tempSelf pay];
    };
}

-(void)pay
{
    if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
        
//        [TTReqEngine PostOrder_Gas_Add:@"1" withBlock:^(BOOL success, id dataModel) {
//            if (success) {
//                M_OrderAddModel* tempData = (M_OrderAddModel*)dataModel;
//                if (tempData!=nil) {
//                    
////                    D_PayViewController* tempController=  [D_PayViewController allocInstance];
////                    tempController.order_num = tempData.order_num;
////                    tempController.myItemModel = [M_CarItemModel allocInstance];
////                    tempController.myItemModel.myCar_Deposit = tempData.order_price;
////                    [self.navigationController pushViewController:tempController animated:YES];
//                }
//            }
//        }];
        
    }else{
        [APPDELEGATE.viewController openLogin:self];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
}

-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnPressed:(id)sender
{
    if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
        [self.navigationController pushViewController:[D_CarGasRecordViewController allocInstance] animated:YES];
    }else{
        [APPDELEGATE.viewController openLogin:self];
    }
    
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
