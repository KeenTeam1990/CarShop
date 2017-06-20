//
//  D_CarDetailViewController.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/2.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_CarDetailViewController.h"

#import "M_CarDetailTabView.h"

#import "M_CarDistributorItemView.h"
#import "M_CarDetailsBottomView.h"
#import "M_DealerListModel.h"
#import "M_CarListModel.h"
#import "TTReqEngine.h"
#import "M_CarDistributorItemCell.h"
#import "M_CarParamterItemCell.h"
#import "M_CarCommentItemCell.h"
#import "M_CarCommentListModel.h"

#import "D_InquiryViewController.h"
#import "D_ReserveViewController.h"
#import "D_TestDriveViewController.h"

#import "M_CarDetailsView.h"
#import "D_WebViewController.h"

#import "WXApiObject.h"
#import "WXApi.h"
#import "M_ShareView.h"
#import "WeiboSDK.h"
#import "D_CarDAndResViewController.h"

@interface D_CarDetailViewController ()

AS_MODEL_STRONG(M_CarDetailTabView, myTabView);
AS_MODEL_STRONG(M_CarDetailsBottomView, myBottomView);

AS_MODEL_STRONG(M_DealerListModel, myDealerListModel);
AS_MODEL_STRONG(M_CarItemModel, myCarItemModel);

AS_MODEL_STRONG(M_CarDetailsView, myNewView);
AS_MODEL_STRONG(M_CarDetailsView, myReatalView);
AS_MODEL_STRONG(M_CarDetailsView, mySpecialView);

AS_MODEL_STRONG(UIButton, mySaveBtn);

AS_MODEL_STRONG(M_ShareView, myShareView);

AS_BOOL(isShouldRefresh);//代理方法是否需要刷新

@end

@implementation D_CarDetailViewController

DEF_FACTORY(D_CarDetailViewController);

DEF_MODEL(myTabView);

DEF_MODEL(myBottomView);
DEF_MODEL(myCarId);

DEF_MODEL(myDealerListModel);
DEF_MODEL(myCarItemModel);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initView];
    
    [self initData];
    
}

-(void)initView
{
    [self addCustomNavBar:@"详情"
              withLeftBtn:@"icon_back.png"
             withRightBtn:@"icon_share.png"
            withLeftLabel:@"返回"
           withRightLabel:nil];
    
    self.mySaveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage* tempImage = [UIImage imageNamed:@"icon_star.png"];
    UIImage* tempImage2 = [UIImage imageNamed:@"icon_star2.png"];
    self.mySaveBtn.frame = CGRectMake(self.baseView.frame.size.width-tempImage.size.width*2-40, 0, 40, NavigationBarHeight);
    [self.mySaveBtn setImage:tempImage forState:UIControlStateNormal];
    [self.mySaveBtn setImage:tempImage2 forState:UIControlStateSelected];
    [self.mySaveBtn addTarget:self action:@selector(saveBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.baseView addSubview:self.mySaveBtn];
    
    self.myTabView      = [M_CarDetailTabView allocInstanceFrame:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, 60)];
    [self.baseView addSubview:self.myTabView];
    
    CGRect tempFrame    = CGRectMake(0, NavigationBarHeight+self.myTabView.frame.size.height, self.baseView.bounds.size.width, self.baseView.bounds.size.height-NavigationBarHeight-self.myTabView.frame.size.height);
    
    self.myNewView      = [M_CarDetailsView allocInstanceFrame:tempFrame];
    self.myReatalView   = [M_CarDetailsView allocInstanceFrame:tempFrame];
    self.mySpecialView  = [M_CarDetailsView allocInstanceFrame:tempFrame];
    
    [self.baseView addSubview:self.myNewView];
    [self.baseView addSubview:self.myReatalView];
    [self.baseView addSubview:self.mySpecialView];
    
    self.myBottomView   = [M_CarDetailsBottomView allocInstanceFrame:CGRectMake(0, self.baseView.frame.size.height-TabBarHeight, self.baseView.frame.size.width, TabBarHeight)];
    self.myBottomView.hidden = YES;
    [self.baseView addSubview:self.myBottomView];
    
    self.myNewView.hidden = YES;
    self.myReatalView.hidden = YES;
    self.mySpecialView.hidden = YES;
    
    self.myShareView  =[M_ShareView allocInstanceFrame:self.baseView.bounds];
    self.myShareView.hidden = YES;
    [self.baseView addSubview:self.myShareView];
}

-(void)initData
{
    __weak D_CarDetailViewController* tempSelf = self;
    
    self.myTabView.block = ^(NSInteger tabIndex){
        
        tempSelf.myNewView.hidden = YES;
        tempSelf.myReatalView.hidden = YES;
        tempSelf.mySpecialView.hidden = YES;
        
        if (tabIndex == 0) {
            if (tempSelf.myCarItemModel!=nil) {
                if (tempSelf.myCarItemModel.myCar_Sales) {
                    tempSelf.mySpecialView.hidden = NO;
                    [tempSelf.myBottomView setCarType:EB_SpeciaiCar];
                }else if (tempSelf.myCarItemModel.myCar_Lease){
                    tempSelf.myReatalView.hidden = NO;
                    [tempSelf.myBottomView setCarType:EB_RentaiCar];
                }else if (tempSelf.myCarItemModel.myCar_New){
                    tempSelf.myNewView.hidden = NO;
                     [tempSelf.myBottomView setCarType:EB_NewCar];
                }
            }
        }else if (tabIndex == 1){
            if (tempSelf.myCarItemModel!=nil) {
                if (tempSelf.myCarItemModel.myCar_Sales) {
                    if (tempSelf.myCarItemModel.myCar_Lease){
                        tempSelf.myReatalView.hidden = NO;
                         [tempSelf.myBottomView setCarType:EB_RentaiCar];
                    }else if (tempSelf.myCarItemModel.myCar_New){
                        tempSelf.myNewView.hidden = NO;
                        [tempSelf.myBottomView setCarType:EB_NewCar];
                    }
                }else{
                    if (tempSelf.myCarItemModel.myCar_New){
                        tempSelf.myNewView.hidden = NO;
                         [tempSelf.myBottomView setCarType:EB_NewCar];
                    }
                }
            }
        }else if (tabIndex == 2){
            if (tempSelf.myCarItemModel!=nil) {
                tempSelf.myNewView.hidden = NO;
                [tempSelf.myBottomView setCarType:EB_NewCar];
            }
        }
    };
    
    self.myBottomView.block = ^(NSInteger tag,BOOL isCollect){
        switch (tag) {
            case 1:
                [tempSelf toOpenCell];
                break;
            case 2:
                [tempSelf toInquiryController];
                break;
            case 3:
                [tempSelf toReserveController:nil];
                break;
            default:
                break;
        }
    };
    
    self.myNewView.block = ^(NSInteger tag,id data){
        if (tag == 0) {
            //试乘试驾
            M_DealerItemModel* tempItem = (M_DealerItemModel*)data;
            if (tempItem!=nil) {
                [tempSelf toTestDevierController:tempItem];
            }
        }else if (tag == -1)//拨打电话
        {
            M_DealerItemModel* tempItem = (M_DealerItemModel*)data;
            if (tempItem!=nil) {
                [tempSelf toOpenCell:tempItem];
            }
        }else if (tag == -2)//预定
        {
            M_DealerItemModel* tempItem = (M_DealerItemModel*)data;
            if (tempItem!=nil) {
                [tempSelf toReserveController:tempItem];
            }
        }else {
            M_DetailIconTextModel* tempItem = (M_DetailIconTextModel*)data;
            if (tempItem!=nil) {
                [tempSelf toWebController:tempItem.myText withUrl:tempItem.myUrl];
            }
        }
    };
    
    self.mySpecialView.block = ^(NSInteger tag,id data){
        if (tag == 9999) {
            tempSelf.myBottomView.showLeftBtn = YES;
        }else {
            M_DetailIconTextModel* tempItem = (M_DetailIconTextModel*)data;
            if (tempItem!=nil) {
                [tempSelf toWebController:tempItem.myText withUrl:tempItem.myUrl];
            }
        }
    };
    
    self.myReatalView.block = ^(NSInteger tag,id data){
        if (tag == 9999) {
            tempSelf.myBottomView.showLeftBtn = YES;
        }else {
            M_DetailIconTextModel* tempItem = (M_DetailIconTextModel*)data;
            if (tempItem!=nil) {
                [tempSelf toWebController:tempItem.myText withUrl:tempItem.myUrl];
            }
        }
    };
    
    [self.myShareView addIconItem:@"微信好友" withIcon:@"share_weixin.png"];
    [self.myShareView addIconItem:@"朋友圈" withIcon:@"share_pengyouquan.png"];
    [self.myShareView addIconItem:@"微博" withIcon:@"share_weibo.png"];
    
    [self.myShareView updateData];
    
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
    
    [self getDetailsData];
}

-(void)saveBtnPressed:(id)sender
{
    [self collect:!self.mySaveBtn.isSelected];
}

-(void)rightBtnPressed:(id)sender
{
    self.myShareView.hidden = NO;
}

-(void)updateTabFrame
{
    if (self.myCarItemModel!=nil) {
        
        if ([self.myCarItemModel.has_Favorite isEqualToString:@"1"]) {
            
            self.mySaveBtn.selected = YES;
        }else
        {
            self.mySaveBtn.selected = NO;
        }
        
        M_CarDetailTabItemModel* tempItem = nil;
        
        if (self.myCarItemModel.myCar_Sales) {
            tempItem = [M_CarDetailTabItemModel allocInstance];
            tempItem.myName = @"特价";
            [self.myTabView addTabItem:tempItem];
        }
        if (self.myCarItemModel.myCar_Lease) {
            tempItem = [M_CarDetailTabItemModel allocInstance];
            tempItem.myName = @"租购";
            [self.myTabView addTabItem:tempItem];
        }
        if (self.myCarItemModel.myCar_New) {
            tempItem = [M_CarDetailTabItemModel allocInstance];
            tempItem.myName = @"优选";
            [self.myTabView addTabItem:tempItem];
        }
        
        [self.myTabView defaultShow];
        
        [self.myTabView updateData];
        
        if ([self.myTabView count] < 2) {
            
            self.myTabView.hidden = YES;
            
            CGRect tempFrame = self.myNewView.frame;
            tempFrame.origin.y = NavigationBarHeight;
            if ([self.myCarItemModel.myDealersArray count]>0) {
                tempFrame.size.height = self.baseView.bounds.size.height-NavigationBarHeight-TabBarHeight;
            }else{
                tempFrame.size.height = self.baseView.bounds.size.height-NavigationBarHeight;
            }
            
            self.myNewView.frame = tempFrame;
            
            tempFrame = self.myReatalView.frame;
            tempFrame.origin.y = NavigationBarHeight;
            if ([self.myCarItemModel.myDealersArray count]>0) {
                tempFrame.size.height = self.baseView.bounds.size.height-NavigationBarHeight-TabBarHeight;
            }else{
                tempFrame.size.height = self.baseView.bounds.size.height-NavigationBarHeight;
            }
            self.myReatalView.frame = tempFrame;
            
            tempFrame = self.mySpecialView.frame;
            tempFrame.origin.y = NavigationBarHeight;
            if ([self.myCarItemModel.myDealersArray count]>0) {
                tempFrame.size.height = self.baseView.bounds.size.height-NavigationBarHeight-TabBarHeight;
            }else{
                tempFrame.size.height = self.baseView.bounds.size.height-NavigationBarHeight;
            }
            self.mySpecialView.frame = tempFrame;
            
        }else{
            
            self.myTabView.hidden = NO;
            
            CGRect tempFrame = self.myNewView.frame;
            tempFrame.origin.y = NavigationBarHeight+self.myTabView.frame.size.height;
            if ([self.myCarItemModel.myDealersArray count]>0) {
                tempFrame.size.height = self.baseView.bounds.size.height-NavigationBarHeight-TabBarHeight-self.myTabView.frame.size.height;
            }else{
                tempFrame.size.height = self.baseView.bounds.size.height-NavigationBarHeight-self.myTabView.frame.size.height;
            }
            self.myNewView.frame = tempFrame;
            
            tempFrame = self.myReatalView.frame;
            tempFrame.origin.y = NavigationBarHeight+self.myTabView.frame.size.height;
            if ([self.myCarItemModel.myDealersArray count]>0) {
                tempFrame.size.height = self.baseView.bounds.size.height-NavigationBarHeight-TabBarHeight-self.myTabView.frame.size.height;
            }else{
                tempFrame.size.height = self.baseView.bounds.size.height-NavigationBarHeight-self.myTabView.frame.size.height;
            }
            self.myReatalView.frame = tempFrame;
            
            tempFrame = self.mySpecialView.frame;
            tempFrame.origin.y = NavigationBarHeight+self.myTabView.frame.size.height;
            if ([self.myCarItemModel.myDealersArray count]>0) {
                tempFrame.size.height = self.baseView.bounds.size.height-NavigationBarHeight-TabBarHeight-self.myTabView.frame.size.height;
            }else{
                tempFrame.size.height = self.baseView.bounds.size.height-NavigationBarHeight-self.myTabView.frame.size.height;
            }
            self.mySpecialView.frame = tempFrame;
        }
    }
}

-(void)updateCarTypeData
{
    if (self.myCarItemModel!=nil) {
        if ([self.myCarItemModel.has_Favorite isEqualToString:@"1"]) {
            
            self.mySaveBtn.selected = YES;
        }else
        {
            self.mySaveBtn.selected = NO;
        }
        
        self.myNewView.hidden = YES;
        self.myReatalView.hidden = YES;
        self.mySpecialView.hidden = YES;
        
        if (self.carType == EB_NewCar) {
            self.myNewView.hidden = NO;
        }else if (self.carType == EB_RentaiCar) {
            self.myReatalView.hidden = NO;
        }else if (self.carType == EB_SpeciaiCar) {
            self.mySpecialView.hidden = NO;
        }
        
        self.myTabView.hidden = YES;
        
        CGRect tempFrame = self.myNewView.frame;
        tempFrame.origin.y = NavigationBarHeight;
        if ([self.myCarItemModel.myDealersArray count]>0) {
            tempFrame.size.height = self.baseView.bounds.size.height-NavigationBarHeight-TabBarHeight;
        }else{
            tempFrame.size.height = self.baseView.bounds.size.height-NavigationBarHeight;
        }
        
        self.myNewView.frame = tempFrame;
        
        tempFrame = self.myReatalView.frame;
        tempFrame.origin.y = NavigationBarHeight;
        if ([self.myCarItemModel.myDealersArray count]>0) {
            tempFrame.size.height = self.baseView.bounds.size.height-NavigationBarHeight-TabBarHeight;
        }else{
            tempFrame.size.height = self.baseView.bounds.size.height-NavigationBarHeight;
        }
        self.myReatalView.frame = tempFrame;
        
        tempFrame = self.mySpecialView.frame;
        tempFrame.origin.y = NavigationBarHeight;
        if ([self.myCarItemModel.myDealersArray count]>0) {
            tempFrame.size.height = self.baseView.bounds.size.height-NavigationBarHeight-TabBarHeight;
        }else{
            tempFrame.size.height = self.baseView.bounds.size.height-NavigationBarHeight;
        }
        self.mySpecialView.frame = tempFrame;
        
        [self.myBottomView setCarType:self.carType];
    }
}

-(void)collect:(BOOL)isCollect
{
    if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
        if (isCollect) {
            [self addCollect];
        }else{
            [self delCollect];
        }
    }
    else{
        [APPDELEGATE.viewController openLogin:self];
    }
}

-(void)addCollect
{
    [TTReqEngine C_PostFavorite_AddSetUid:[DLAppData sharedInstance].myUserKey
                               withCar_id:self.myCarId
                              withCity_id:APPDELEGATE.viewController.myCityModel.myCity_Id
                                withBlock:^(BOOL success, id dataModel) {
                                    [self.mySaveBtn setSelected:YES];
                                    self.isShouldRefresh = NO;
                                    [SVProgressHUD showSuccessWithStatus:@"收藏成功！"];
                                }];
}

-(void)delCollect
{
    [TTReqEngine C_PostFavorite_DelSetID:nil
                                     Uid:[DLAppData sharedInstance].myUserKey
                              withCar_id:self.myCarId
                             withCity_id:APPDELEGATE.viewController.myCityModel.myCity_Id
                               withBlock:^(BOOL success, id dataModel) {
                                   [self.mySaveBtn setSelected:NO];
                                   self.isShouldRefresh = YES;
                                   [SVProgressHUD showSuccessWithStatus:@"取消收藏成功！"];
                               }];
}

-(void)toTestDevierController:(M_DealerItemModel*)data
{
    if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
        
        
        if ([DLAppData sharedInstance].myUserName == nil || [DLAppData sharedInstance].myUserName.length == 0) {
            [APPDELEGATE.viewController bindPhone:self withBlock:^(bool result) {
                if (result) {
                    [SVProgressHUD showSuccessWithStatus:@"手机号码绑定成功"];
                }
            }];
            
            return;
        }
        
        D_TestDriveViewController* tempController = [D_TestDriveViewController allocInstance];
        tempController.myItemModel = self.myCarItemModel;
        tempController.myDealerItemModel = data;
        [self.navigationController pushViewController:tempController animated:YES];
    }else{
        [APPDELEGATE.viewController openLogin:self];
    }
}

-(void)toReserveController:(M_DealerItemModel*)model
{
    if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
        
        if ([DLAppData sharedInstance].myUserName == nil || [DLAppData sharedInstance].myUserName.length == 0) {
            [APPDELEGATE.viewController bindPhone:self withBlock:^(bool result) {
                if (result) {
                    [SVProgressHUD showSuccessWithStatus:@"手机号码绑定成功"];
                }
            }];
            return;
        }
        
        M_DealerItemModel* tempDealerModel = nil;
        
        if (self.myCarItemModel!=nil) {
            if (!self.mySpecialView.hidden){
                NSMutableArray* tempArray = [self.myCarItemModel.myDealersArray objectAtIndex:0];
                
                for (int i=0; i<[tempArray count]; i++) {
                    M_DealerItemModel* tempItem = [tempArray objectAtIndex:i];
                    if (tempItem!=nil) {
                        if (tempItem.selete) {
                            tempDealerModel = tempItem;
                            break;
                        }
                    }
                }
                
            }else if (!self.myReatalView.hidden) {
                NSMutableArray* tempArray = [self.myCarItemModel.myDealersArray objectAtIndex:1];
                for (int i=0; i<[tempArray count]; i++) {
                    M_DealerItemModel* tempItem = [tempArray objectAtIndex:i];
                    if (tempItem!=nil) {
                        if (tempItem.selete) {
                            tempDealerModel = tempItem;
                            break;
                        }
                    }
                }
            }else if (!self.myNewView.hidden){
                tempDealerModel = model;
            }
        }
        
        if (tempDealerModel == nil) {
            [SVProgressHUD showErrorWithStatus:@"请选择经销商"];
            return;
        }
        
        D_ReserveViewController* tempController = [D_ReserveViewController allocInstance];
        tempController.myItemModel = self.myCarItemModel;
        if (!self.myReatalView.hidden) {
            tempController.carType = EB_RentaiCar;
            tempController.selectButtonIndex = self.myReatalView.selectIndex;
            if (self.myReatalView.payMonth.length == 0) {
                ;
            }
            else{
                tempController.monthToPay = self.myReatalView.payMonth;
            }
            tempController.monthBlock = ^(NSInteger monthIndex){
                [self.myReatalView updateMonth:monthIndex];
            };
        }else if (!self.mySpecialView.hidden){
            tempController.carType = EB_SpeciaiCar;
        }else if (!self.myNewView.hidden){
            tempController.carType = EB_NewCar;
        }

        tempController.myDealerItemModel = tempDealerModel;
        [self.navigationController pushViewController:tempController animated:YES];
    }
    else{
        [APPDELEGATE.viewController openLogin:self];
    }
}

-(void)toOpenCell:(M_DealerItemModel*)model
{
    if ([model.dealer_tel notEmpty]) {
        [Unity openCallPhone:model.dealer_tel];
    }
}

-(void)toOpenCell
{
    M_DealerItemModel* tempDealerModel = nil;
    
    if (self.myCarItemModel!=nil) {
        if (!self.mySpecialView.hidden){
            NSMutableArray* tempArray = [self.myCarItemModel.myDealersArray objectAtIndex:0];
            
            for (int i=0; i<[tempArray count]; i++) {
                M_DealerItemModel* tempItem = [tempArray objectAtIndex:i];
                if (tempItem!=nil) {
                    if (tempItem.selete) {
                        tempDealerModel = tempItem;
                        break;
                    }
                }
            }
            
        }else if (!self.myReatalView.hidden) {
            NSMutableArray* tempArray = [self.myCarItemModel.myDealersArray objectAtIndex:1];
            for (int i=0; i<[tempArray count]; i++) {
                M_DealerItemModel* tempItem = [tempArray objectAtIndex:i];
                if (tempItem!=nil) {
                    if (tempItem.selete) {
                        tempDealerModel = tempItem;
                        break;
                    }
                }
            }
        }
    }
    if (tempDealerModel!=nil) {
        [self toOpenCell:tempDealerModel];
    }
}

-(void)toInquiryController
{
    if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
        
        if ([DLAppData sharedInstance].myUserName == nil || [DLAppData sharedInstance].myUserName.length == 0) {
            [APPDELEGATE.viewController bindPhone:self withBlock:^(bool result) {
                if (result) {
                    [SVProgressHUD showSuccessWithStatus:@"手机号码绑定成功"];
                }
            }];
            
            return;
        }
        
        D_InquiryViewController* tempController = [D_InquiryViewController allocInstance];
        tempController.myItemModel = self.myCarItemModel;
        NSMutableArray* tempArray = [NSMutableArray array];
        
        if (!self.myNewView.hidden){
            NSMutableArray* tempArray2 = [self.myCarItemModel.myDealersArray objectAtIndex:2];
            for (int i=0; i<[tempArray2 count]; i++) {
                M_DealerItemModel* tempItem = [tempArray2 objectAtIndex:i];
                if (tempItem!=nil) {
                    if (tempItem.selete) {
                        [tempArray addObject:tempItem];
                    }
                }
            }
        }
        
        if ([tempArray count] == 0) {
            [SVProgressHUD showErrorWithStatus:@"请选择经销商"];
            return;
        }
        tempController.myDealerArray = tempArray;
        
        tempController.carType = EB_NewCar;
        [self.navigationController pushViewController:tempController animated:YES];
    }
    else{
        [APPDELEGATE.viewController openLogin:self];
    }
}

-(void)getDetailsData
{
    [TTReqEngine C_Getcar_dealerSetCity_id:APPDELEGATE.viewController.myCityModel.myCity_Id
                                withCar_id:self.myCarId
                                    withID:nil
                             withDealer_id:self.myDealerItemModel.dealer_id
                                   withLng:nil
                                   withLat:nil
                                 withBlock:^(BOOL success, id dataModel) {
                                     if (success) {
                                         
                                         self.myCarItemModel = (M_CarItemModel*)dataModel;
                                         
                                         [self upDataTitle];

                                         self.myBottomView.hidden = YES;
                                        
                                         if ([self.myCarItemModel.myCar_Id notEmpty]) {
                                             
                                             [self.myNewView updateHeaderData:self.myCarItemModel];
                                             [self.myReatalView updateHeaderData:self.myCarItemModel];
                                             [self.mySpecialView updateHeaderData:self.myCarItemModel];
                                             
                                             if ([self.myCarItemModel.myDealersArray count]>0) {
                                                 
                                                 if (self.carType == EB_NewCar) {
                                                     NSMutableArray* tempArray3 = [self.myCarItemModel.myDealersArray objectAtIndex:2];
                                                     if ([tempArray3 count]>0) {
                                                         self.myBottomView.hidden = NO;
                                                         [self.myNewView updateData:tempArray3 withTabIndex:2];
                                                     }else{
                                                         [self.myNewView updateData:[NSMutableArray array] withTabIndex:2];
                                                     }
                                                 }else if (self.carType == EB_RentaiCar) {
                                                     NSMutableArray* tempArray2 = [self.myCarItemModel.myDealersArray objectAtIndex:1];
                                                     if ([tempArray2 count]>0) {
                                                         self.myBottomView.hidden = NO;
                                                         self.myBottomView.showLeftBtn = YES;
                                                         [self.myReatalView updateData:tempArray2 withTabIndex:1];
                                                     }else{
                                                         [self.myReatalView updateData:[NSMutableArray array] withTabIndex:1];
                                                     }
                                                 }else if (self.carType == EB_SpeciaiCar) {
                                                     NSMutableArray* tempArray1 = [self.myCarItemModel.myDealersArray objectAtIndex:0];
                                                     if ([tempArray1 count]>0) {
                                                         self.myBottomView.hidden = NO;
                                                         [self.mySpecialView updateData:tempArray1 withTabIndex:0];
                                                     }else{
                                                         [self.mySpecialView updateData:[NSMutableArray array] withTabIndex:0];
                                                     }
                                                 }
                                             }
                                         }
                                         
                                         //[self updateTabFrame];
                                         
                                         [self updateCarTypeData];
                                     }
                                 }];
}

-(void)upDataTitle
{
    [self.customNavBar updateTitle:self.myCarItemModel.myBrand_Name];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
}

-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    if (self.myDelegate != nil && self.isShouldRefresh == YES) {
        [self.myDelegate shouleRefreach];
    }
}

-(void)toWebController:(NSString*)title withUrl:(NSString*)url
{
   if(![url isEqualToString:@""])
   {
       D_WebViewController* tempController = [D_WebViewController allocInstance];
       tempController.myTitle = title;
       tempController.myUrl = url;
       [self.navigationController pushViewController:tempController animated:YES];
   }
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
