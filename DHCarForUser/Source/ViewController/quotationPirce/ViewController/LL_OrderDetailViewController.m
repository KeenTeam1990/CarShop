//
//  LL_OrderDetailViewController.m
//  DHCarForSales
//
//  Created by leiyu on 15/12/23.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "LL_OrderDetailViewController.h"
#import "LL_DeatailOrderHeadView.h"
#import "TTReqEngine.h"
#import "M_MyOrderModel.h"
#import "D_CommunicateViewController.h"
#import "D_PayViewController.h"
#import "D_ReserveViewController.h"
#import "D_WebViewController.h"

@interface LL_OrderDetailViewController ()

AS_MODEL_STRONG(LL_DeatailOrderHeadView, myHeaderView);

AS_MODEL_STRONG(UIView , myBottomView);

@end

@implementation LL_OrderDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initView];
    [self getData];
}

-(void)initView
{
    [self addCustomNavBar:@"报价详情"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight)
           withSeparatoStyle:UITableViewCellSeparatorStyleSingleLine];
    
    self.myHeaderView=[[LL_DeatailOrderHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400)];
    //self.myTableView.tableHeaderView=_headView;
    
    [self initFootViewWithFrame:CGRectMake(0, self.baseView.frame.size.height-60, self.baseView.frame.size.width, 60)];
}

-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initFootViewWithFrame:(CGRect)frame
{
    self.myBottomView = [[UIView alloc]initWithFrame:frame];
    [self.myBottomView setBackgroundColor:[Unity getColor:@"#ffffff"]];
    [self.baseView addSubview:self.myBottomView];
    
    UIButton *myCommunicateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myCommunicateButton.frame  = CGRectMake(20, 10, frame.size.width/2-40, 40);
    myCommunicateButton.layer.masksToBounds = YES;
    myCommunicateButton.layer.cornerRadius = 5;
    [myCommunicateButton setTitle:@"联系顾问" forState:UIControlStateNormal];
    [myCommunicateButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchDown];
    myCommunicateButton.tag = 1000;
    [myCommunicateButton setBackgroundColor:[Unity getColor:@"#f89f1c"]];
    [self.myBottomView addSubview:myCommunicateButton];
    
    UIButton *myPayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myPayButton.frame = CGRectMake(frame.size.width/2+20, CGRectGetMinY(myCommunicateButton.frame), frame.size.width/2-40, 40);
    myPayButton.layer.masksToBounds = YES;
    myPayButton.layer.cornerRadius = 5;
    [myPayButton setTitle:@"订金支付" forState:UIControlStateNormal];
    [myPayButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchDown];
    myPayButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [myPayButton setBackgroundColor:[Unity getColor:@"#f71e24"]];
    myPayButton.tag = 1001;
    [self.myBottomView addSubview:myPayButton];
    
}
-(void)buttonClickAction:(UIButton *)button
{
    switch (button.tag-1000) {
        case 0:
        {
            NSLog(@"联系顾问");
            if ([self.myEntry notEmpty]) {
                if ([self.myEntry isEqualToString:@"message"]) {
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    D_CommunicateViewController* tempController = [[D_CommunicateViewController alloc]init];
                    tempController.myTargetUid = self.myItemModel.mySalesUid;
                    tempController.myQuotedId = self.myItemModel.myQuoteId;
                    [self.navigationController pushViewController:tempController animated:YES];
                }
            }
        }
            break;
        case 1:
        {
            NSLog(@"499订金支付");
            
            if (self.myItemModel.myOrderModel!=nil) {
                
                    if ([self.myItemModel.myOrderModel.order_step notEmpty]) {
                        if ([self.myItemModel.myOrderModel.order_step isEqualToString:@"0"]||[self.myItemModel.myOrderModel.order_step isEqualToString:@"1"]) {
                            D_PayViewController* tempController = [D_PayViewController allocInstance];
                            self.myItemModel.myInquiryModel.car.myCar_Deposit = self.myItemModel.myEarnest;
                            tempController.myItemModel = self.myItemModel.myInquiryModel.car;
                            tempController.order_id = self.myItemModel.myOrderModel.order_id;
                            tempController.order_num = self.myItemModel.myOrderModel.order_no;
                            
                            tempController.block = ^(NSInteger tag){
                                if (tag == 0) {
                                    [self.navigationController popViewControllerAnimated:YES];
                                }
                            };
                            
                            [self.navigationController pushViewController:tempController animated:YES];
                        }else{
                            
                        }
                    }
                
            }else{
                D_ReserveViewController* tempController = [D_ReserveViewController allocInstance];
                self.myItemModel.myInquiryModel.car.myCar_Deposit = self.myItemModel.myEarnest;
                tempController.myItemModel = self.myItemModel.myInquiryModel.car;
                tempController.myDealerItemModel = self.myItemModel.myDealerModel;
                tempController.carType = EB_NewCar;
                tempController.myInquiry_Quoted_Id = self.myItemModel.myQuoteId;
                [self.navigationController pushViewController:tempController animated:YES];
                
                tempController.block = ^(NSInteger tag){
                    if (tag == 0) {
                        [self getData];
                    }
                };
            }
        }
            break;
        default:
            break;
    }
    
}

-(void)getData
{
    [TTReqEngine C_GetQuoted_Get:self.myQuotedId
                       withBlock:^(BOOL success, id dataModel) {
        if (success) {
            
            self.myItemModel = (M_QuoteItemModel*)dataModel;
            
            [self initData];
        }
    }];
}

-(void)initData
{
    if (self.myItemModel!=nil) {
        
        if ([self.myItemModel.myHasConverted notEmpty]) {
            if ([self.myItemModel.myHasConverted isEqualToString:@"1"]) {
                UIButton* tempView = [self.myBottomView viewWithTag:1001];
                if (tempView!=nil) {
                    
                    if ([self.myItemModel.myOrderModel.order_step notEmpty]) {
                        if ([self.myItemModel.myOrderModel.order_step isEqualToString:@"0"]||
                            [self.myItemModel.myOrderModel.order_step isEqualToString:@"1"]) {
                            [tempView setTitle:[NSString stringWithFormat:@"%@元订金支付",self.myItemModel.myEarnest] forState:UIControlStateNormal];
                        }else{
                            [tempView setTitle:@"查看订单" forState:UIControlStateNormal];
                        }
                    }
                }
                
                UIButton* tempView2 = [self.myBottomView viewWithTag:1000];
                if (tempView2!=nil) {
                    tempView2.hidden = YES;
                }
                
            }else{
                if ([self.myItemModel.mySalesUid notEmpty]) {
                    if ([self.myItemModel.mySalesUid integerValue]<=0) {
                        UIButton* tempView = [self.myBottomView viewWithTag:1001];
                        if (tempView!=nil) {
                            if ([self.myItemModel.myEarnest notEmpty]) {
                                UIButton* tempView = [self.myBottomView viewWithTag:1001];
                                if (tempView!=nil) {
                                    [tempView setTitle:[NSString stringWithFormat:@"%@元订金预定",self.myItemModel.myEarnest] forState:UIControlStateNormal];
                                }
                            }
                        }
                        UIButton* tempView2 = [self.myBottomView viewWithTag:1000];
                        if (tempView2!=nil) {
                            tempView2.hidden = YES;
                        }
                    }else{
                        UIButton* tempView = [self.myBottomView viewWithTag:1001];
                        if (tempView!=nil) {
                            tempView.hidden = NO;
                        }
                        UIButton* tempView2 = [self.myBottomView viewWithTag:1000];
                        if (tempView2!=nil) {
                            tempView2.hidden = NO;
                        }
                    }
                }
            }
        }
        
        [self.myHeaderView upDateWithMyOrdelDeatailModel:self.myItemModel];
        
        
        if (self.myItemModel.myOrderModel!=nil) {
            if ([self.myItemModel.myOrderModel.order_step notEmpty]) {
                if (![self.myItemModel.myOrderModel.order_step isEqualToString:@"0"]) {
                    UIButton* tempView = [self.myBottomView viewWithTag:1001];
                    if (tempView!=nil) {
                        tempView.hidden = YES;
                    }
                    
                    UIButton* tempView2 = [self.myBottomView viewWithTag:1000];
                    if (tempView2!=nil) {
                        CGRect tempFrame = tempView2.frame;
                        tempFrame.size.width = self.baseView.frame.size.width-40;
                        tempView2.frame = tempFrame;
                    }
                }
            }
        }
        
        __weak LL_OrderDetailViewController* tempSelf = self;
        self.myHeaderView.block = ^(NSInteger tag,id data){
            if (tag == 0) {
                M_QuoteComboItemModel* tempItem = (M_QuoteComboItemModel*)data;
                if (tempItem!=nil) {
                    D_WebViewController *tempController = [[D_WebViewController alloc]init];
                    tempController.myTitle = @"购车礼包";
                    tempController.myUrl = [NSString stringWithFormat:@"%@/spree?id=%@",KH5Host,tempItem.myComboId];
                    [tempSelf.navigationController pushViewController:tempController animated:YES];
                }
            }
            if (tag == 3) {
                 M_QuoteItemModel* tempItem = (M_QuoteItemModel*)data;
                [Unity openCallPhone:tempItem.myDealerModel.dealer_tel];
            }
        };
        
        self.myTableView.tableHeaderView = self.myHeaderView;
        
        [self.myTableView reloadData];
    }
    
}


@end
