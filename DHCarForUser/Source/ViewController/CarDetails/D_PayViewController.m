//
//  D_PayViewController.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/15.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_PayViewController.h"
#import "M_PayHeaderView.h"
#import "M_PayItemCell.h"
#import "M_PayWebViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "WXApiObject.h"
#import "TTReqEngine.h"
#import "M_MyOrderModel.h"
#import "D_ReserveViewController.h"

@interface D_PayViewController ()

AS_MODEL_STRONG(M_PayHeaderView, myHeaderView);
AS_MODEL_STRONG(M_WxPayModel, myWxPayModel);

@end

@implementation D_PayViewController

DEF_FACTORY(D_PayViewController);

DEF_MODEL(myItemModel);
DEF_MODEL(myDealerItemModel);
DEF_MODEL(order_num);
DEF_MODEL(order_id);
DEF_MODEL(myHeaderView);
DEF_MODEL(myDealerId);
//DEF_MODEL(myOrderCarHeadInfo);


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initView];
    
    [self initData];
}

-(void)initView
{
    [self addCustomNavBar:@"支付"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleSingleLine];
    
    self.myHeaderView = [M_PayHeaderView allocInstanceFrame:CGRectMake(0, 0, self.baseView.frame.size.width, 120)];
    self.myTableView.tableHeaderView = self.myHeaderView;
    
    UIView* tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.baseView.frame.size.width, 70)];
    
    UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tempBtn addTarget:self action:@selector(payBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    tempBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor redColor];
                                      style.cornerRedius = 5;);
    [tempBtn setTitle:@"确定" forState:UIControlStateNormal];
    [tempBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tempBtn.frame = CGRectMake(20, (tempView.frame.size.height-40)/2, tempView.frame.size.width-40, 40);
    [tempView addSubview:tempBtn];
    
    self.myTableView.tableFooterView = tempView;
}

-(void)payBtnPressed:(id)sender
{
    NSInteger tabIndex= -1;
    
    for (int i=0; i<[self.myDataArray count]; i++) {
        NSMutableDictionary* tempDic = [self.myDataArray objectAtIndex:i];
        if (tempDic!=nil) {
            NSString* tempSeleted = [tempDic hasItemAndBack:@"seleted"];
            if ([tempSeleted notEmpty]) {
                if ([tempSeleted isEqualToString:@"1"]) {
                    tabIndex = i;
                    break;
                }
            }
        }
    }
    
    if (tabIndex == -1) {
        [SVProgressHUD showErrorWithStatus:@"请选择支付方式"];
        return;
    }
    
    if (tabIndex == 0) {
        
        APPDELEGATE.myPayController = self;
        
        [[AlipaySDK defaultService] payOrder:self.myAlipayStr fromScheme:@"dhcarforuser" callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            [self handlerAliPay:resultDic];
        }];
    }else if (tabIndex == 1){
        
        APPDELEGATE.myPayController = self;
        
        NSString* temptime = self.myWxPayModel.timestamp;
        
        PayReq* req = [[PayReq alloc]init];
        req.openID = self.myWxPayModel.appid;
        req.partnerId = self.myWxPayModel.partnerid;
        req.prepayId = self.myWxPayModel.prepayid;
        req.package = self.myWxPayModel.packagevalue;
        req.nonceStr = self.myWxPayModel.noncestr;
        req.timeStamp = (UInt32)[temptime integerValue];
        req.sign = self.myWxPayModel.sign;
        
        [WXApi sendReq:req];
    }
}

-(void)handlerAliPay:(NSDictionary*)dic
{
    APPDELEGATE.myPayController = nil;
    if (dic!=nil) {
        NSString* tempResultStatus = [NSString fromString:[dic hasItemAndBack:@"resultStatus"]];
        if ([tempResultStatus notEmpty]) {
            if ([tempResultStatus isEqualToString:@"6001"]) {
                [SVProgressHUD showErrorWithStatus:@"用户中途取消"];
                
            }else if ([tempResultStatus isEqualToString:@"9000"]) {
                
                [TTReqEngine C_PostOrder_PayUid:[DLAppData sharedInstance].myUserKey
                                    withOrderId:self.order_id
                                     withStatus:@"1"
                                      withBlock:^(BOOL success, id dataModel) {
                                          if (self.showAliview) {
                                              
                                          }else{
                                              [SVProgressHUD showSuccessWithStatus:@"支付成功！"];
                                          }
                                          
                                          if (self.block!=nil) {
                                              self.block(0);
                                          }
                                      }];
            }else if ([tempResultStatus isEqualToString:@"4000"]) {
                
                [TTReqEngine C_PostOrder_PayUid:[DLAppData sharedInstance].myUserKey
                                    withOrderId:self.order_id
                                     withStatus:@"1"
                                      withBlock:^(BOOL success, id dataModel) {
                                          [SVProgressHUD showErrorWithStatus:@"支付失败！"];
                                      }];
            }
        }
    }
}

-(void)handlerWxPay:(NSString*)result
{
    APPDELEGATE.myPayController = nil;
    if ([result notEmpty]) {
        //成功
        if ([result isEqualToString:@"0"]) {
            
            if (self.showAliview) {
                
            }else{
                [SVProgressHUD showSuccessWithStatus:@"支付成功！"];
            }
            
            if (self.block!=nil) {
                self.block(0);
            }
        }
        //失败
        else if ([result isEqualToString:@"-1"]){
            [SVProgressHUD showErrorWithStatus:@"支付失败！"];
        }
        //取消
        else if ([result isEqualToString:@"-2"]){
            [SVProgressHUD showErrorWithStatus:@"用户中途取消"];
        }
    }
}

-(void)initData
{
    [self.myHeaderView updateData:self.order_num withPrice:nil withModel:self.myItemModel];
    
    NSMutableDictionary* tempDic = [NSMutableDictionary dictionary];
    [tempDic setObject:@"支付宝支付" forKey:@"name"];
    [tempDic setObject:@"1" forKey:@"id"];
    [tempDic setObject:@"1" forKey:@"seleted"];
    [tempDic setObject:@"pay_zhifubao.png" forKey:@"icon"];
    [self.myDataArray addObject:tempDic];
    
    tempDic = [NSMutableDictionary dictionary];
    [tempDic setObject:@"微信支付" forKey:@"name"];
    [tempDic setObject:@"2" forKey:@"id"];
    [tempDic setObject:@"0" forKey:@"seleted"];
    [tempDic setObject:@"pay_weixin.png" forKey:@"icon"];
    [self.myDataArray addObject:tempDic];
    
    [self.myTableView reloadData];
    
    [self getOrderData];
}

-(void)getOrderData
{
    [TTReqEngine C_GetOrderMylistSetID:self.order_id
                             withBlock:^(BOOL success, id dataModel) {
                                 if (success) {
                                     
                                     M_MyOrderTtemModel* tempModel = (M_MyOrderTtemModel*)dataModel;
                                     //这块我加的
                                     [self.myHeaderView updateData:tempModel.order_no withPrice:tempModel.order_price withModel:tempModel.car];
                                     //试试
                                     if (tempModel!=nil) {
                                         
                                         self.myAlipayStr = tempModel.myAlipayStr;
                                         
                                         self.myWxPayModel = tempModel.myWxPayModel;
                                     }
                                 }
                             }];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_PayItemCell *cell = [M_PayItemCell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
    
    if ([self.myDataArray count] > indexPath.row) {
        [cell configCellIndexPath:indexPath withDataArray:self.myDataArray];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary* tempDic = [self.myDataArray objectAtIndex:indexPath.row];
    if (tempDic!=nil) {
        [tempDic setObject:@"1" forKey:@"seleted"];
        
        for (int i=0; i<[self.myDataArray count]; i++) {
            NSMutableDictionary* tempItem = [self.myDataArray objectAtIndex:i];
            if (tempItem!=nil) {
                if (indexPath.row == i) {
                    [tempItem setObject:@"1" forKey:@"seleted"];
                }else{
                    [tempItem setObject:@"0" forKey:@"seleted"];
                }
            }
        }
        
        [self.myTableView reloadData];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.baseView.frame.size.width, 70)];
    
    UIView* tempBackView = [tempView viewWithTag:1002];
    if (tempBackView == nil) {
        
        tempBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 26, tempView.frame.size.width, 43)];
        tempBackView.backgroundColor = [UIColor whiteColor];
        tempBackView.tag = 1002;
        [tempView addSubview:tempBackView];
    }
    
    
    
    UILabel* tempTitel = [tempView viewWithTag:1001];
    
    if (tempTitel==nil) {
        
        tempTitel = [[UILabel alloc]initWithFrame:CGRectMake(10, 26, tempView.frame.size.width-20, 44)];
        [tempTitel setBackgroundColor:[UIColor whiteColor]];
        tempTitel.tag = 1001;
        tempTitel.font = [UIFont boldSystemFontOfSize:14];
        tempTitel.tintColor = [UIColor blackColor];
        
        [tempView addSubview:tempTitel];
    }
    
    UIImageView* temppLine = [tempView viewWithTag:1003];
    if (temppLine == nil) {
        temppLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 68, tempView.frame.size.width, 1)];
        temppLine.backgroundColor = RGBCOLOR(233, 233, 233);
        temppLine.tag = 1003;
        [tempView addSubview:temppLine];
    }
    
    tempTitel.text = @"选择支付方式";
    
    return tempView;
}

-(void)leftBtnPressed:(id)sender
{
    NSInteger numViewController = [self.navigationController.viewControllers count];
    id viewController = [self.navigationController.viewControllers objectAtIndex:numViewController-2];
    
    if ([viewController isKindOfClass:[D_ReserveViewController class]]) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:numViewController-3] animated:YES];
    } else {
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
