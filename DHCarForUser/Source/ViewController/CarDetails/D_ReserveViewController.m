//
//  D_ReserveViewController.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_ReserveViewController.h"
#import "M_ReserveHeaderView.h"
#import "DLPickerView.h"
#import "M_BrandListModel.h"
#import "M_SubBrandListModel.h"
#import "TTReqEngine.h"
#import "M_CarYearListModel.h"
#import "M_CarListModel.h"
#import "D_SeleteCityViewController.h"
#import "M_CityListModel.h"
#import "DLDateOrTimePickerView.h"

#import "D_SeleteDealerViewController.h"
#import "D_PayViewController.h"
#import "M_MyOrderModel.h"
#import "M_ReserveFooterView.h"
#import "M_CarDistributorItemCell.h"

#import "M_SeleteColorItemCell.h"
#import "M_SeleteColorView.h"
#import "M_SeleteLeaseView.h"
#import "D_LLDetailOrderViewController.h"
#import "D_InquiryFinishViewController.h"


@interface D_ReserveViewController ()<UIAlertViewDelegate>

AS_MODEL_STRONG(M_ReserveHeaderView, myHeaderView);
AS_MODEL_STRONG(M_ReserveFooterView, myFooterView);

AS_MODEL_STRONG(DLPickerView, myPickerView);
AS_MODEL_STRONG(M_BrandListModel, myBrandListModel);
AS_MODEL_STRONG(M_SubBrandListModel, mySubBrandListModel);
AS_MODEL_STRONG(M_CarYearListModel, myCarYearListModel);
AS_MODEL_STRONG(M_CarListModel, myCarListModel);
AS_MODEL_STRONG(M_CityItemModel, myCurrCityModel);
AS_MODEL_STRONG(DLDateOrTimePickerView, myDateOrTimePickerView);

AS_MODEL_STRONG(NSMutableArray, mySeleteDataArray);

AS_MODEL_STRONG(M_SeleteColorView, myColorView);
AS_MODEL_STRONG(M_SeleteLeaseView, myLeaseView);

AS_MODEL_STRONG(M_CarColorItemModel, myColorItemModel);
AS_MODEL_STRONG(M_CarLeaseItemModel, myLeaseItemModel);

AS_MODEL_STRONG(NSString, orderID);

@end

@implementation D_ReserveViewController

DEF_FACTORY(D_ReserveViewController);

DEF_MODEL(myHeaderView);
DEF_MODEL(myFooterView);

DEF_MODEL(myItemModel);
DEF_MODEL(carType);

DEF_MODEL(myDealerItemModel);
DEF_MODEL(myPickerView);
DEF_MODEL(myBrandListModel);
DEF_MODEL(myCarListModel);
DEF_MODEL(mySubBrandListModel);
DEF_MODEL(myCarYearListModel);
DEF_MODEL(myDateOrTimePickerView);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.mySeleteDataArray = [NSMutableArray allocInstance];
    
    [self initView];
    
    [self initData];
    
    [self addTapToBaseView];
    
    [self addKeywordNotify];
}

-(void)notifyshowKeyword:(CGRect)keyRect
{
    CGRect tempFrame = self.myTableView.frame;
    tempFrame.size.height = self.baseView.frame.size.height-NavigationBarHeight-keyRect.size.height;
    self.myTableView.frame = tempFrame;
    
    [self.myTableView scrollRectToVisible:[self.myFooterView getCurrFieldRect:self.myTableView] animated:YES];
}

-(void)notifyhideKeyword
{
    CGRect tempFrame = self.myTableView.frame;
    tempFrame.size.height = self.baseView.frame.size.height-NavigationBarHeight;
    self.myTableView.frame = tempFrame;
}

-(void)initView
{
    // 初始化导航条
    [self addCustomNavBar:@"预定"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    
    self.myHeaderView = [M_ReserveHeaderView allocInstanceFrame:CGRectMake(0, 0, self.baseView.frame.size.width, 120)];
    self.myTableView.tableHeaderView = self.myHeaderView;
    
    self.myFooterView = [M_ReserveFooterView allocInstanceFrame:CGRectMake(0, 0, self.baseView.frame.size.width, 520)];
    self.myTableView.tableFooterView = self.myFooterView;
    
    self.myColorView = [M_SeleteColorView allocInstanceFrame:CGRectMake(self.baseView.frame.size.width, 0, self.baseView.frame.size.width, self.baseView.frame.size.height)];
    self.myColorView.hidden = YES;
    [self.baseView addSubview:self.myColorView];
    
    self.myLeaseView = [M_SeleteLeaseView allocInstanceFrame:CGRectMake(self.baseView.frame.size.width, 0, self.baseView.frame.size.width, self.baseView.frame.size.height)];
    self.myLeaseView.hidden = YES;
    [self.baseView addSubview:self.myLeaseView];
    
    if (self.myDealerItemModel !=nil) {
        if (self.myDealerItemModel.myLeaseArray.count != 0) {
            self.myLeaseItemModel = [self.myDealerItemModel.myLeaseArray objectAtIndex:self.selectButtonIndex];
        }
    }
}

-(void)initData
{
    if (self.myItemModel!=nil) {
        
        [self.myHeaderView updateData:self.myItemModel withCarType:self.carType];
        [self.myFooterView updateData:self.myItemModel withCarType:self.carType];
        
        if (APPDELEGATE.viewController.myCityModel!=nil) {
            self.myCurrCityModel = APPDELEGATE.viewController.myCityModel;
        }
    }
    
    if (self.myDealerItemModel!=nil) {
        
        [self.myDataArray removeAllObjects];
        
        [self.myDataArray addObject:self.myDealerItemModel];
        
        [self.myTableView reloadData];
    }
    
    __weak D_ReserveViewController* tempSelf = self;

    self.myColorView.block = ^(id data){
        M_CarColorItemModel* tempItem = (M_CarColorItemModel*)data;
        if (tempItem!=nil) {
            tempSelf.myColorItemModel = tempItem;
            
            NSMutableDictionary* tempDic = [tempSelf.mySeleteDataArray objectAtIndex:0];
            if (tempDic!=nil) {
                [tempDic setObject:tempItem.myCar_Color_Name forKey:@"value"];
            }
        }
        
        [tempSelf.myColorView showBack:NO];
        
        [tempSelf.myTableView reloadData];
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             CGRect tempFrame = tempSelf.myColorView.frame;
                             tempFrame.origin.x = tempSelf.baseView.frame.size.width;
                             tempSelf.myColorView.frame = tempFrame;
                         } completion:^(BOOL finished) {
                             tempSelf.myColorView.hidden = YES;
                         }];
    };
    
    self.myLeaseView.block = ^(id data){
        M_CarLeaseItemModel* tempItem = (M_CarLeaseItemModel*)data;
        if (tempItem!=nil) {
            tempSelf.myLeaseItemModel = tempItem;
            NSInteger monthIndex = [tempSelf.myDealerItemModel.myLeaseArray indexOfObject:tempItem];
            tempSelf.monthBlock(monthIndex);
            NSMutableDictionary* tempDic = [tempSelf.mySeleteDataArray objectAtIndex:1];
            if (tempDic!=nil) {
                [tempDic setObject:[NSString stringWithFormat:@"%@期 首付：%@万元",tempItem.myLease_Loan,tempItem.myLease_Panyment] forKey:@"value"];
            }
        }
        
        [tempSelf.myLeaseView showBack:NO];
        
        [tempSelf.myTableView reloadData];
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             CGRect tempFrame = tempSelf.myLeaseView.frame;
                             tempFrame.origin.x = tempSelf.baseView.frame.size.width;
                             tempSelf.myLeaseView.frame = tempFrame;
                         } completion:^(BOOL finished) {
                             tempSelf.myLeaseView.hidden = YES;
                         }];
    };
    
    self.myFooterView.block = ^(NSInteger tag,id data){
        //tag
        //4 city
        //5 code
        //8 surebtn
        //9 bindphone
        switch (tag) {
            case 4:
            {
                D_SeleteCityViewController* tempController = [D_SeleteCityViewController allocInstance];
                
                [tempSelf.navigationController pushViewController:tempController animated:YES];
                
                tempController.block = ^(M_CityItemModel* model){
                    if (model!=nil) {
                        tempSelf.myCurrCityModel = model;
                        
                        [tempSelf.myHeaderView updateContent:model.myCity_Name withTag:4];
                    }
                };
            }
                break;
            case 5:
            {
                //[tempSelf getCode:data];
            }
                break;
            case 8:
            {
                [tempSelf pay:data];
            }
                break;
            default:
                break;
        }
    };
    
    NSMutableDictionary* tempDic = [NSMutableDictionary allocInstance];
    [tempDic setObject:@"颜色：" forKey:@"key"];
    if (self.myItemModel.myItemColorModel!=nil) {
        
        self.myColorItemModel = self.myItemModel.myItemColorModel;
        
        [self.myDealerItemModel.myColorArray removeAllObjects];
        [self.myDealerItemModel.myColorArray addObject:self.myItemModel.myItemColorModel];
        
        [tempDic setObject:self.myItemModel.myItemColorModel.myCar_Color_Name forKey:@"value"];
    }else{
        [tempDic setObject:@"请选择颜色" forKey:@"value"];
    }
    
    [self.mySeleteDataArray addObject:tempDic];
    
    if (self.carType == EB_RentaiCar) {
        tempDic = [NSMutableDictionary allocInstance];
        [tempDic setObject:@"租购方案：" forKey:@"key"];
        //[tempDic setObject:@"请选择租购方案" forKey:@"value"];
        [tempDic setObject:self.monthToPay forKey:@"value"];
        [self.mySeleteDataArray addObject:tempDic];
    }
}

-(void)pay:(id)data
{
    if (self.myCurrCityModel==nil) {
        [SVProgressHUD showErrorWithStatus:@"请选择所在城市"];
        return;
    }
    
    if (self.myColorItemModel == nil) {
        [SVProgressHUD showErrorWithStatus:@"请选择颜色"];
        return;
    }
    
    if (self.myLeaseItemModel == nil && self.carType == EB_RentaiCar) {
        [SVProgressHUD showErrorWithStatus:@"请选择租购期数"];
        return;
    }
    
    NSDictionary* tempDic = (NSDictionary*)data;
    
    NSString* tempName = [tempDic hasItemAndBack:@"name"];
    NSString* tempMemo = [tempDic hasItemAndBack:@"memo"];
    NSString* tempPhone =  [tempDic hasItemAndBack:@"phone"];
    NSString* tempCode = [tempDic hasItemAndBack:@"comphone"];
    
    NSString* tempLease = @"";
    
    if (self.carType == EB_RentaiCar) {
        tempLease = self.myLeaseItemModel.myLease_Loan;
    }
    
    NSString* temptype = @"";
    if(self.carType == EB_NewCar){
        temptype = @"3";
    }else if(self.carType == EB_SpeciaiCar){
        temptype = @"1";
    }else if(self.carType == EB_RentaiCar){
        temptype = @"2";
    }
    
    [TTReqEngine C_PostOrder_CreatePostInquiry_CreateSetUid:[DLAppData sharedInstance].myUserKey
                                          Inquiry_quoted_id:self.myInquiry_Quoted_Id
                                                       type:temptype
                                                     car_id:self.myItemModel.myCar_Id
                                                  dealer_id:self.myDealerItemModel.dealer_id
                                                    city_id:APPDELEGATE.viewController.myCityModel.myCity_Id
                                                    earnest:self.myItemModel.myCar_Deposit
                                                       memo:tempMemo
                                               car_color_id:self.myColorItemModel.myCar_Color_Id
                                                      phone:tempPhone
                                              inviter_phone:tempCode
                                                   realname:tempName
                                                installment:tempLease
                                                  withBlock:^(BOOL success, id dataModel) {
                                                      if (success) {
                                                          M_MyOrderTtemModel* tempModel = (M_MyOrderTtemModel*)dataModel;
                                                          if (tempModel!=nil) {
                                                              
                                                              if (self.block!=nil) {
                                                                  self.block(0);
                                                              }
                                                              if (self.updateBlock != nil) {
                                                                  self.updateBlock(0);
                                                              }
                                                              D_PayViewController* tempController = [D_PayViewController allocInstance];
                                                              
                                                              tempController.myItemModel = self.myItemModel;
                                                              tempController.myDealerItemModel = self.myDealerItemModel;
                                                              tempController.order_id = tempModel.order_id;
                                                              tempController.order_num = tempModel.order_no;
                                                              tempController.showAliview = YES;
                                                              self.orderID = tempModel.order_id;
                                                              
                                                              tempController.block = ^(NSInteger tag){
                                                                  if (tag == 0) {
                                                                      
//                                                                      UIAlertView* tempAl = [[UIAlertView alloc]initWithTitle:@"提示" message:@"支付成功，是否立即查看订单？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//                                                                      
//                                                                      tempAl.tag = 9001;
//                                                                      
//                                                                      [tempAl show];

                                                                      D_InquiryFinishViewController* tempController = [D_InquiryFinishViewController allocInstance];
                                                                      tempController.myCarModel = self.myItemModel;
                                                                      tempController.orderId = tempModel.order_id;
                                                                      tempController.showPay = YES;
                                                                      [self.navigationController pushViewController:tempController animated:YES];
                                                                      
                                                                  }
                                                              };
                                                              
                                                              [self.navigationController pushViewController:tempController animated:YES];
                                                          }
                                                      }
                                                  }];
}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 9001) {
        if (buttonIndex == 0) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else if (buttonIndex == 1){
            [self.navigationController popToRootViewControllerAnimated:NO];
            
            D_LLDetailOrderViewController* tempController = [D_LLDetailOrderViewController allocInstance];
            tempController.orderID = self.orderID;
            [APPDELEGATE.viewController.homeController.navigationController pushViewController:tempController animated:NO];
        }
    }
}

-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.mySeleteDataArray count];
    }else if (section == 1){
        return [self.myDataArray count];
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        M_SeleteColorItemCell *cell = [M_SeleteColorItemCell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
        
        if ([self.mySeleteDataArray count]>indexPath.row) {
            [cell configCellIndexPath:indexPath withDataArray:self.mySeleteDataArray];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.myItemModel.myItemColorModel==nil) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.block = ^(){
            
            if (indexPath.row == 0) {
                if (self.myItemModel.myItemColorModel==nil) {
                    self.myColorView.hidden = NO;
                    
                    [self.myColorView updateData:self.myDealerItemModel.myColorArray];
                    
                    [UIView animateWithDuration:0.5 animations:^{
                        CGRect tempFrame =self.myColorView.frame;
                        tempFrame.origin.x = 0;
                        self.myColorView.frame = tempFrame;
                    } completion:^(BOOL finished) {
                        
                        [self.myColorView showBack:YES];
                        
                    }];
                }
            }else if (indexPath.row == 1){
                self.myLeaseView.hidden = NO;
                
                [self.myLeaseView updateData:self.myDealerItemModel.myLeaseArray];
                
                [UIView animateWithDuration:0.5 animations:^{
                    CGRect tempFrame =self.myLeaseView.frame;
                    tempFrame.origin.x = 0;
                    self.myLeaseView.frame = tempFrame;
                } completion:^(BOOL finished) {
                    
                    [self.myLeaseView showBack:YES];
                }];
            }
        };
        
        return cell;
        
    }else if (indexPath.section == 1){
        M_CarDistributorItemCell *cell = [M_CarDistributorItemCell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
        
        if ([self.myDataArray count]>indexPath.row) {
            [cell configCellIndexPath:indexPath withDataArray:self.myDataArray andwithType:self.carType];
        }
        cell.myBlock = ^(M_DealerItemModel *model){
            [Unity openCallPhone:model.dealer_tel];
        };
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 60;
    }else if (indexPath.section == 1){
        return 120;
    }
    return 0;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
