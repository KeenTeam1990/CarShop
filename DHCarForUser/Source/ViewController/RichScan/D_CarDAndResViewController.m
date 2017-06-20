//
//  D_CarDAndResViewController.m
//  DHCarForUser
//
//  Created by lucaslu on 16/4/3.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "D_CarDAndResViewController.h"
#import "M_DealerListModel.h"
#import "M_CarListModel.h"
#import "TTReqEngine.h"
#import "M_CarDetailsView.h"
#import "D_WebViewController.h"
#import "M_CarDetailHeaderView.h"
#import "M_CarDAndResFooterView.h"
#import "M_SeleteColorView.h"
#import "M_SeleteLeaseView.h"
#import "D_LLDetailOrderViewController.h"
#import "D_InquiryFinishViewController.h"
#import "M_SeleteColorItemCell.h"
#import "M_CarDistributorItemView.h"
#import "M_FieldOrButtonView.h"
#import "M_ShareView.h"
#import "WeiboSDK.h"

@interface D_CarDAndResViewController ()

AS_MODEL_STRONG(M_DealerListModel, myDealerListModel);

AS_MODEL_STRONG(M_CarItemModel, myCarItemModel);

AS_MODEL_STRONG(M_CarDetailHeaderView, myHeaderView);

AS_MODEL_STRONG(NSMutableArray, myIconTextArray);

AS_MODEL_STRONG(NSMutableArray, mySeleteDataArray);

AS_MODEL_STRONG(M_CarDAndResFooterView, myFooterView);

AS_MODEL_STRONG(M_SeleteColorView, myColorView);
AS_MODEL_STRONG(M_SeleteLeaseView, myLeaseView);

AS_MODEL_STRONG(M_CarColorItemModel, myColorItemModel);
AS_MODEL_STRONG(M_CarLeaseItemModel, myLeaseItemModel);

AS_MODEL_STRONG(NSString, orderID);
AS_MODEL_STRONG(M_ShareView, myShareView);
@end

@implementation D_CarDAndResViewController

DEF_FACTORY(D_CarDAndResViewController);

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    [self addCustomNavBar:@"详情"
              withLeftBtn:@"icon_back.png"
             withRightBtn:@"icon_share.png"
            withLeftLabel:@"返回"
           withRightLabel:nil];
    
    CGRect tempFrame    = CGRectMake(0, NavigationBarHeight, self.baseView.bounds.size.width, self.baseView.bounds.size.height-NavigationBarHeight);
    
    self.myIconTextArray = [NSMutableArray allocInstance];
    self.mySeleteDataArray = [NSMutableArray allocInstance];
    
    [self initTablePlainView:tempFrame withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    
    NSInteger headerHeight = 220+100;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        headerHeight = 440+100;
    }
    
    self.myHeaderView = [M_CarDetailHeaderView allocInstanceFrame:CGRectMake(0, 0, self.myTableView.frame.size.width, headerHeight)];
    __weak D_CarDAndResViewController *tempSelf = self;
    self.myHeaderView.myBlock =^(NSInteger tag){
        switch (tag) {
            case 9991:
            {
                NSLog(@"选择颜色");
                tempSelf.myColorView.hidden = NO;
            }
                break;
            case 99990:
            {
                tempSelf.myLeaseView.hidden = NO;
                NSLog(@"选择分期");
            }
                break;
            default:
                break;
        }
    };
    
    self.myFooterView = [M_CarDAndResFooterView allocInstanceFrame:CGRectMake(0, 0, self.baseView.frame.size.width, 520)];
    self.myTableView.tableFooterView = self.myFooterView;
    
    self.myColorView = [M_SeleteColorView allocInstanceFrame:CGRectMake(self.baseView.frame.size.width, 0, self.baseView.frame.size.width, self.baseView.frame.size.height)];
    self.myColorView.hidden = YES;
    [self.baseView addSubview:self.myColorView];
    
    self.myLeaseView = [M_SeleteLeaseView allocInstanceFrame:CGRectMake(self.baseView.frame.size.width, 0, self.baseView.frame.size.width, self.baseView.frame.size.height)];
    self.myLeaseView.hidden = YES;
    [self.baseView addSubview:self.myLeaseView];
    
    self.myShareView  =[M_ShareView allocInstanceFrame:self.baseView.bounds];
    self.myShareView.hidden = YES;
    [self.baseView addSubview:self.myShareView];
}

-(void)initData
{
    __weak D_CarDAndResViewController* tempSelf = self;
    
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
            case 5:
            {
                [tempSelf getCode:(NSString*)data];
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
    
    [self getDataFromUrl];
    
    [self.myShareView addIconItem:@"微信好友" withIcon:@"share_weixin.png"];
    [self.myShareView addIconItem:@"朋友圈" withIcon:@"share_pengyouquan.png"];
    [self.myShareView addIconItem:@"微博" withIcon:@"share_weibo.png"];
    self.myShareView.block = ^(NSInteger tag){
        if (tag == 0) {
            tempSelf.myShareView.hidden = YES;
        }else if (tag == 1){
            [tempSelf share:0];
        }else if (tag == 2){
            [tempSelf share:1];
        }else if (tag == 3){
            [tempSelf wbshare];
            
            //            D_CarDAndResViewController* tempControl = [D_CarDAndResViewController allocInstance];
            //            [tempSelf.navigationController pushViewController:tempControl animated:YES];
        }
    };
    [self.myShareView updateData];
}
-(void)getDataFromUrl
{
//    self.myGetUrl = @"http://180.97.15.55:9103/2.0/qr/detail?dealer_id=239&cid=114847&type=2&sales_uid=9588&token=8c11c22aa0db94989bf4d0443b2b0b45e24e791a&source=android";
    
    [DLHttpHelper GetData:self.myGetUrl
           withParameters:nil
                  success:^(id responseObject) {
                      
        NSLog(@"成功返回的数据  %@",responseObject);
        self.myCarItemModel = [[M_CarItemModel alloc]init];
                   
        self.myCarItemModel.showQRCodeData = YES;
                      
        [self.myCarItemModel parseData:responseObject];
        
                      if (self.myCarItemModel.myCar_New) {
                          self.carType = EB_NewCar;
                      }else if (self.myCarItemModel.myCar_Sales) {
                          self.carType = EB_SpeciaiCar;
                      }else if (self.myCarItemModel.myCar_Lease) {
                          self.carType = EB_RentaiCar;
                      }
                      
        [self upDataTitle];
        
        if ([self.myCarItemModel.myCar_Id notEmpty]) {
            
            [self updateHeaderData:self.myCarItemModel];
        }
        
        [self updateCarTypeData];
                      
    } failure:^(NSString *error) {
        NSLog(@"错误");
    }];
}

-(void)getCode:(NSString*)phone
{
    [TTReqEngine C_GetCodeSetPhone:phone
                          withType:@"ordinary"
                         withBlock:^(BOOL success, id dataModel) {
                             if (success) {
                                 [self.myFooterView getCodeFinish];
                                 [SVProgressHUD showSuccessWithStatus:@"验证码发送成功!"];
                             }
                         }];
}

-(void)pay:(id)data
{
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
                                          Inquiry_quoted_id:nil
                                                       type:temptype
                                                     car_id:self.myCarItemModel.myCar_Id
                                                  dealer_id:self.myCarItemModel.myDealerItemModel.dealer_id
                                                    city_id:APPDELEGATE.viewController.myCityModel.myCity_Id
                                                    earnest:self.myCarItemModel.myCar_Deposit
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
                                                              
                                                              D_PayViewController* tempController = [D_PayViewController allocInstance];
                                                              
                                                              tempController.myItemModel = self.myCarItemModel;
                                                              tempController.myDealerItemModel = self.myCarItemModel.myDealerItemModel;
                                                              tempController.order_id = tempModel.order_id;
                                                              tempController.order_num = tempModel.order_no;
                                                              tempController.showAliview = YES;
                                                              self.orderID = tempModel.order_id;
                                                              
                                                              tempController.block = ^(NSInteger tag){
                                                                  if (tag == 0) {
                                                                      
                                                                      D_InquiryFinishViewController* tempController = [D_InquiryFinishViewController allocInstance];
                                                                      tempController.myCarModel = self.myCarItemModel;
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

-(void)updateCarTypeData
{
    if (self.myCarItemModel!=nil) {
        [self.myFooterView updateData:self.myCarItemModel withCarType:self.carType];
    }
}

-(void)upDataTitle
{
    [self.customNavBar updateTitle:self.myCarItemModel.myBrand_Name];
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

-(void)toWebController:(NSString*)title withUrl:(NSString*)url
{
    D_WebViewController* tempController = [D_WebViewController allocInstance];
    tempController.myTitle = title;
    tempController.myUrl = url;
    [self.navigationController pushViewController:tempController animated:YES];
}

-(void)updateHeaderData:(M_CarItemModel*)model
{
    [self.myHeaderView updateData:model];
    
    if ([model.myParameterArray count]>0) {
        
        NSInteger headerHeight = 220+100;
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            headerHeight = 440+100;
        }
        
        CGRect tempFrame = self.myHeaderView.frame;
        tempFrame.size.height = headerHeight+30*([model.myParameterArray count]%2==0?[model.myParameterArray count]/2:([model.myParameterArray count]/2)+1);
//        if ([model.myColorArray count] !=0 && [model.myColorArray count] != 0) {
//            tempFrame.size.height += 100;
//        }
//        else if([model.myColorArray count] != 0 &&[model.myLeaseArray count] == 0 ){
//            tempFrame.size.height += 50;
//        }
//        else if([model.myLeaseArray count] != 0 && [model.myColorArray count] == 0){
//            tempFrame.size.height += 50;
//        }
        self.myHeaderView.frame = tempFrame;
    }
    
    self.myTableView.tableHeaderView = self.myHeaderView;
    
    [self initLineData];
    
    [self.myTableView reloadData];
}

-(void)initLineData
{
    [self.myIconTextArray removeAllObjects];
    
    M_DetailIconTextModel* temoITItem = [M_DetailIconTextModel allocInstance];
    temoITItem.myText = @"车型说明";
    temoITItem.myImage = @"icon_car.png";
    NSString *str = [NSString stringWithFormat:@"%@/customservice?car_id=%@&type=explain",KH5Host,self.myCarItemModel.myCar_Id];
    temoITItem.myUrl = str;
    temoITItem.myTag = 0;
    [self.myIconTextArray addObject:temoITItem];
    
    
    temoITItem = [M_DetailIconTextModel allocInstance];
    temoITItem.myText = @"产品参数";
    temoITItem.myImage = @"icon_spec.png";
    str = [NSString stringWithFormat:@"%@/customservice?car_id=%@&type=parameter",KH5Host,self.myCarItemModel.myCar_Id];
    temoITItem.myUrl = str;
    temoITItem.myTag = 1;
    [self.myIconTextArray addObject:temoITItem];
    
    temoITItem = [M_DetailIconTextModel allocInstance];
    temoITItem.myText = @"售后政策";
    temoITItem.myImage = @"icon_shou.png";
    str = [NSString stringWithFormat:@"%@/customservice?car_id=%@&type=policy",KH5Host,self.myCarItemModel.myCar_Id];
    temoITItem.myUrl = str;
    temoITItem.myTag = 2;
    [self.myIconTextArray addObject:temoITItem];
    
    if (self.carType == EB_RentaiCar) {
        temoITItem = [M_DetailIconTextModel allocInstance];
        temoITItem.myText = @"租购说明";
        temoITItem.myImage = @"icon_sound2.png";
        str = [NSString stringWithFormat:@"%@/customservice?car_id=%@&type=hire&city_id=%@",KH5Host,self.myCarItemModel.myCar_Id,APPDELEGATE.viewController.myCityModel.myCity_Id];
        temoITItem.myUrl = str;
        temoITItem.myTag = 3;
        [self.myIconTextArray addObject:temoITItem];
    }
    
    [self.mySeleteDataArray removeAllObjects];
    
    NSMutableDictionary* tempDic = [NSMutableDictionary allocInstance];
    [tempDic setObject:@"颜色：" forKey:@"key"];
    [tempDic setObject:@"请选择颜色" forKey:@"value"];
    [self.mySeleteDataArray addObject:tempDic];
    
    if (self.carType == EB_RentaiCar) {
        tempDic = [NSMutableDictionary allocInstance];
        [tempDic setObject:@"租购方案：" forKey:@"key"];
        [tempDic setObject:@"请选择租购方案" forKey:@"value"];
        [self.mySeleteDataArray addObject:tempDic];
    }
}

#pragma mark-
#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    
    if (section == 0) {
        count = [self.myIconTextArray count];
    }else if (section == 1){
        count = [self.mySeleteDataArray count];
    }else if (section == 2){
        count = 1;
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSLog(@"ssssssssssss");
        DLTableViewCell* cell = [DLTableViewCell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        if ([self.myIconTextArray count]>indexPath.row) {
            M_DetailIconTextModel* tempItem = [self.myIconTextArray objectAtIndex:indexPath.row];
            if (tempItem!=nil) {
                cell.textLabel.text = tempItem.myText;
                cell.imageView.image = [UIImage imageNamed:tempItem.myImage];
            }
        }
        
        UIImageView* tempLine = [cell.contentView viewWithTag:1001];
        if (tempLine == nil) {
            tempLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, tableView.frame.size.width, 1)];
            tempLine.backgroundColor = RGBCOLOR(202, 202, 202);
            [cell.contentView addSubview:tempLine];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        return cell;
        
    }else if (indexPath.section == 2){
        NSLog(@"55555555555");
        DLTableViewCell* cell = [DLTableViewCell reusableCellOfTableView:tableView identifier:@"DistributorCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        M_CarDistributorItemView* tempView = [cell.contentView viewWithTag:1002];
        
        if (tempView == nil) {
            tempView = [M_CarDistributorItemView allocInstanceFrame:CGRectMake(0, 0, tableView.frame.size.width, 120)];
            tempView.showLine = NO;
            tempView.showPrice = YES;
            tempView.showDistance = YES;
            tempView.tag = 1002;
            [cell.contentView addSubview:tempView];
        }
        UIButton * myOpenCallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        myOpenCallBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor]; style.borderWidth = 1;
                                                style.borderColor = [UIColor grayColor];
                                                style.cornerRedius = 5;);
        myOpenCallBtn.tintColor = [UIColor blackColor];
        [myOpenCallBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [myOpenCallBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        myOpenCallBtn.frame = CGRectMake(tableView.frame.size.width-110, 120-35, 80, 30);
        [myOpenCallBtn addTarget:self action:@selector(openCallBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [myOpenCallBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
        myOpenCallBtn.userInteractionEnabled = YES;
        [tempView addSubview:myOpenCallBtn];
        
        UIImageView* tempLine = [cell.contentView viewWithTag:1001];
        if (tempLine == nil) {
            tempLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 119, tableView.frame.size.width, 1)];
            tempLine.backgroundColor = RGBCOLOR(202, 202, 202);
            tempLine.tag = 1001;
            [cell.contentView addSubview:tempLine];
        }
        
        M_FieldOrButtonView* tempSelasView = [cell.contentView viewWithTag:1005];
        if (tempSelasView == nil) {
            tempSelasView  = [M_FieldOrButtonView allocInstanceFrame:CGRectMake(0, 120, tableView.frame.size.width, 50)];
            tempSelasView.tag = 1005;
            [cell.contentView addSubview:tempSelasView];
        }
        
        UIImageView* tempLine2 = [cell.contentView viewWithTag:1004];
        if (tempLine2 == nil) {
            tempLine2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 169, tableView.frame.size.width, 1)];
            tempLine2.backgroundColor = RGBCOLOR(202, 202, 202);
            tempLine2.tag = 1001;
            [cell.contentView addSubview:tempLine2];
        }
        
        if(self.myCarItemModel.myDealerItemModel!=nil){
            [tempView updateData:self.myCarItemModel.myDealerItemModel];
        }
        
        [tempSelasView updateSetting:YES withShowBtn:NO withShowDrowBtn:YES withLabel:@"销售顾问:" withPlaceholder:@"请选择销售顾问"];
        M_UserInfoModel* tempInfo = nil;
        
        if ([self.myCarItemModel.mySelasArray count] == 1) {
            [tempSelasView showDrowButton:NO];
            tempInfo = [self.myCarItemModel.mySelasArray objectAtIndex:0];
        }else if([self.myCarItemModel.mySelasArray count]>1){
            [tempSelasView showDrowButton:YES];
            tempInfo = [self.myCarItemModel.mySelasArray objectAtIndex:0];
        }
        
        if (tempInfo!=nil) {
            [tempSelasView updateContent:tempInfo.user_name];
        }
        
        tempSelasView.block = ^(NSInteger tag,id data){
            if (tag == 0) {
                
            }
        };
        
        return cell;
        
    }else if (indexPath.section == 1){
        NSLog(@"6666666666");
        M_SeleteColorItemCell *cell = [M_SeleteColorItemCell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
        
        if ([self.mySeleteDataArray count]>indexPath.row) {
            [cell configCellIndexPath:indexPath withDataArray:self.mySeleteDataArray];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.myCarItemModel.myItemColorModel==nil) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        UIImageView* tempLine = [cell.contentView viewWithTag:1001];
        if (tempLine == nil) {
            tempLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, tableView.frame.size.width, 1)];
            tempLine.backgroundColor = RGBCOLOR(202, 202, 202);
            [cell.contentView addSubview:tempLine];
        }
        
        cell.block = ^(){
            
            if (indexPath.row == 0) {
                if (self.myCarItemModel.myItemColorModel==nil) {
                    self.myColorView.hidden = NO;
                    
                    [self.myColorView updateData:self.myCarItemModel.myColorArray];
                    
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
                
                [self.myLeaseView updateData:self.myCarItemModel.myLeaseArray];
                
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
        
    }
    
    return nil;
}
-(void)openCallBtnPressed:(UIButton *)button
{
    [Unity openCallPhone:self.myCarItemModel.myDealerItemModel.dealer_tel];
}
#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    
    if (indexPath.section == 0) {
        height = 50;
    }else if (indexPath.section == 1){
        height = 50;
    }else if (indexPath.section == 2){
        height = 120+50;
    }
    
    return height;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"111111");
//    DLTableViewCell *cell = []
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        NSLog(@"第一个Cell");
        M_DetailIconTextModel* tempItem = [self.myIconTextArray objectAtIndex:indexPath.row];
        if (tempItem!=nil                                                      ) {
            if(![tempItem.myUrl isEqualToString:@""])
            {
                 [self toWebController:tempItem.myText withUrl:tempItem.myUrl];
            }
           
        }
    }
    if (indexPath.section ==2) {
        NSLog(@"第三个Cell");
    }
    if (indexPath.section == 1) {
        NSLog(@"第二个section");
    }
    [self.myTableView reloadData];
}
-(void)wbshare
{
    self.myShareView.hidden = YES;
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:@""];
    request.userInfo = @{@"ShareMessageFrom": @"D_CarDetailViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
}

- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
    NSString* tempStr=  @" ";
    if (self.myCarItemModel!=nil) {
        if ([self.myCarItemModel.myBrand_Name notEmpty]&& [self.myCarItemModel.mySubbrand_Name notEmpty]&&
            [self.myCarItemModel.myCar_Name notEmpty]) {
            tempStr = [NSString stringWithFormat:@"%@ %@ %@",self.myCarItemModel.myBrand_Name,self.myCarItemModel.mySubbrand_Name,self.myCarItemModel.myCar_Name];
        }
    }
    
    //    message.text = NSLocalizedString(@"东汇汽车", nil);
    
    //    WBImageObject *image = [WBImageObject object];
    //    image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"100×100" ofType:@"png"]];
    //    message.imageObject = image;
    
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = @"identifier1";
    webpage.title = NSLocalizedString(@"东汇汽车", nil);
    webpage.description = tempStr;
    webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"100×100" ofType:@"png"]];
    webpage.webpageUrl = [NSString stringWithFormat:@"%@/car?car_id=%@",KH5Host,self.myCarId];
    message.mediaObject = webpage;
    
    return message;
}


-(void)share:(int)scene
{
    self.myShareView.hidden = YES;
    
    NSString* tempStr=  @" ";
    if (self.myCarItemModel!=nil) {
        if ([self.myCarItemModel.myBrand_Name notEmpty]&& [self.myCarItemModel.mySubbrand_Name notEmpty]&&
            [self.myCarItemModel.myCar_Name notEmpty]) {
            tempStr = [NSString stringWithFormat:@"%@ %@ %@",self.myCarItemModel.myBrand_Name,self.myCarItemModel.mySubbrand_Name,self.myCarItemModel.myCar_Name];
        }
    }
    [self sendLinkContent:scene withTitle:@"东汇汽车" withContent:tempStr];
}

- (void) sendLinkContent:(int)scene withTitle:(NSString*)title withContent:(NSString*)content
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = content;
    [message setThumbImage:[UIImage imageNamed:@"100×100.png"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = [NSString stringWithFormat:@"%@/car?car_id=%@",KH5Host,self.myCarId];
    
    message.mediaObject = ext;
    //message.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req];
}
-(void)rightBtnPressed:(id)sender
{
    self.myShareView.hidden = NO;
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
