//
//  D_LLDetailOrderViewController.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/15.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_LLDetailOrderViewController.h"
#import "D_LLDetailOrderHeadView.h"
#import "TTReqEngine.h"
#import "M_MyOrderModel.h"
#import "D_PayViewController.h"
#import "MCertificateViewController.h"
#import "M_MyOrderModel.h"
#import "D_WebViewController.h"

@interface D_LLDetailOrderViewController ()

AS_MODEL_STRONG(D_LLDetailOrderHeadView, myHeaderView);

AS_MODEL_STRONG(UIButton, myBottomBtn);

@end

@implementation D_LLDetailOrderViewController

DEF_FACTORY(D_LLDetailOrderViewController);

DEF_MODEL(orderID);

DEF_MODEL(myHeaderView);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self addCustomNavBar:@"订单详情"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.bounds.size.width, self.baseView.bounds.size.height-NavigationBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    
    self.myHeaderView = [[D_LLDetailOrderHeadView alloc]initWithFrame:CGRectMake(0, 0, self.myTableView.frame.size.width, 1000)];
    
    __weak D_LLDetailOrderViewController *tempVC = self;
    
    self.myHeaderView.block = ^(NSInteger tag,id data){
        if (tag == 0) {
            M_QuoteComboItemModel *dataModel = (M_QuoteComboItemModel *)data;
            
            if (dataModel!=nil) {
                D_WebViewController *tempController = [[D_WebViewController alloc]init];
                tempController.myTitle = @"购车礼包";
                tempController.myUrl = [NSString stringWithFormat:@"%@/spree?id=%@",KH5Host,dataModel.myComboId];
                [tempVC.navigationController pushViewController:tempController animated:YES];
            }
        }else if (tag == 1){
            [tempVC resendCode:data];
        }
        else if (tag == 2){
             M_MyOrderTtemModel *dataModel = (M_MyOrderTtemModel *)data;
            if (dataModel.myDealerModel.dealer_tel != nil) {
                 [Unity openCallPhone:dataModel.myDealerModel.dealer_tel];
            }
           
        }
    };
    //self.myTableView.tableHeaderView = self.myHeaderView;
    
    [self initData];
    
    self.myBottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myBottomBtn.frame = CGRectMake(10, self.baseView.frame.size.height-TabBarHeight+(TabBarHeight-40)/2, self.baseView.frame.size.width-20, 40);
    [self.myBottomBtn addTarget:self action:@selector(buttonBtnpressed:) forControlEvents:UIControlEventTouchUpInside];
    self.myBottomBtn.hidden = YES;
//    [self.myBottomBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [self.myBottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.myBottomBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor redColor];
                                               style.cornerRedius = 2;);
    self.myBottomBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.myBottomBtn.tag = 1001;
    [self.baseView addSubview:self.myBottomBtn];
}

-(void)resendCode:(M_MyOrderTtemModel*)model
{
    [TTReqEngine C_GetCode_Send:[DLAppData sharedInstance].myUserKey
                       withType:@"0"
                 withRelated_id:model.order_id
                      withBlock:^(BOOL success, id dataModel) {
                          if (success) {
                              [SVProgressHUD showSuccessWithStatus:@"已重新发码，请查收信息"];
                          }
                      }];
}

-(void)buttonBtnpressed:(id)sender
{
    UIButton* tempBtm = (UIButton*)sender;
    if (tempBtm.tag == 1001) {
        
        D_PayViewController* tempController=  [D_PayViewController allocInstance];
        tempController.myItemModel = self.itemModel.car;
        tempController.myDealerItemModel = self.itemModel.myDealerModel;
        tempController.order_num = self.itemModel.order_no;
        tempController.order_id= self.itemModel.order_id;
        
        __weak D_PayViewController* tempCon = tempController;
        tempController.block = ^(NSInteger tag){
            if (tag == 0) {
                [tempCon.navigationController popViewControllerAnimated:NO];
                [self.navigationController popViewControllerAnimated:YES];
            }
        };
        
        [self.navigationController pushViewController:tempController animated:YES];
        
    }else if (tempBtm.tag == 1002){
        MCertificateViewController* tempController = [MCertificateViewController allocInstance];
        tempController.myOrderID = self.itemModel.order_id;
        [self.navigationController pushViewController:tempController animated:YES];
    }
}

-(void)initData
{
    [TTReqEngine C_GetOrderMylistSetID:self.orderID
                             withBlock:^(BOOL success, id dataModel) {
                                 if (success) {
                                     
                                     self.itemModel = (M_MyOrderTtemModel*)dataModel;
                                     
                                     [self.myHeaderView updataData:self.itemModel];
                                     
                                     self.myBottomBtn.hidden = YES;
                                     //0未支付 1未发码 2未核销 3未上传凭证 4凭证待审核 5订单完成 -1订单关闭未退款 -2订单关闭已退款 -3凭证未通过审核 -4订单过期关闭
                                     if (self.itemModel!=nil && [self.itemModel.order_step notEmpty]) {
                                        
                                         if ([self.itemModel.order_step isEqualToString:@"0"]) {
                                             self.myBottomBtn.hidden = NO;
                                             self.myBottomBtn.tag = 1001;
                                             [self.myBottomBtn setTitle:@"立即支付" forState:UIControlStateNormal];
                                             
                                         }else if ([self.itemModel.order_step isEqualToString:@"1"]) {
                                         }else if ([self.itemModel.order_step isEqualToString:@"2"]) {
                                         }else if ([self.itemModel.order_step isEqualToString:@"3"]) {
                                             self.myBottomBtn.hidden = NO;
                                             self.myBottomBtn.tag = 1002;
                                             [self.myBottomBtn setTitle:@"上传凭证信息" forState:UIControlStateNormal];
                                             
                                             
                                         }else if ([self.itemModel.order_step isEqualToString:@"4"]) {
                                         }else if ([self.itemModel.order_step isEqualToString:@"5"]) {
                                         }else if ([self.itemModel.order_step isEqualToString:@"－1"]) {
                                         }else if ([self.itemModel.order_step isEqualToString:@"－2"]) {
                                         }else if ([self.itemModel.order_step isEqualToString:@"－3"]) {
                                         }else if ([self.itemModel.order_step isEqualToString:@"－4"]) {
                                         }else if ([self.itemModel.order_step isEqualToString:@"－5"]) {
                                         }else if ([self.itemModel.order_step isEqualToString:@"－6"]) {
                                         }
                                     }
                                     
                                     
                                     self.myTableView.tableHeaderView = self.myHeaderView;
                                     
                                     [self.myTableView reloadData];
                                 }
                             }];
}

-(void)leftBtnPressed:(id)sender
{
    if (self.showPush) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
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
