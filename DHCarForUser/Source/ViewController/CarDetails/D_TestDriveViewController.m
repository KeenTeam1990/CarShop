//
//  D_TestDriveViewController.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_TestDriveViewController.h"
#import "M_TestDeviceHeaderView.h"
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

@interface D_TestDriveViewController ()
AS_MODEL_STRONG(M_TestDeviceHeaderView, myHeaderView);
AS_MODEL_STRONG(M_CityItemModel, myCurrCityModel);

AS_MODEL_STRONG(NSString, myPhone);

AS_MODEL_STRONG(DLDateOrTimePickerView, myDateOrTimePickerView);

@end

@implementation D_TestDriveViewController

DEF_FACTORY(D_TestDriveViewController);

DEF_MODEL(myHeaderView);
DEF_MODEL(myItemModel);
DEF_MODEL(myDealerItemModel);
DEF_MODEL(myPhone);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
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
    
    [self.myTableView scrollRectToVisible:[self.myHeaderView getCurrFieldRect:self.myTableView] animated:YES];
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
    [self addCustomNavBar:@"预约试驾"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    
    self.myHeaderView = [M_TestDeviceHeaderView allocInstanceFrame:CGRectMake(0, 0, self.baseView.frame.size.width, 670)];
    
    self.myTableView.tableHeaderView = self.myHeaderView;
}

-(void)initData
{
    if (self.myItemModel!=nil) {
        
        [self.myHeaderView updateDealerData:self.myDealerItemModel];
        [self.myHeaderView updateData:self.myItemModel];
        
        if ([[DLAppData sharedInstance].myUserName notEmpty]) {
            self.myPhone = [DLAppData sharedInstance].myUserName;
        }
        
        if (APPDELEGATE.viewController.myCityModel!=nil) {
            self.myCurrCityModel = APPDELEGATE.viewController.myCityModel;
        }
    }
    
    [self.myHeaderView updateContent:[[NSDate new] dateToString]  withTag:6];
    
    __weak D_TestDriveViewController* tempSelf = self;
    self.myHeaderView.block = ^(NSInteger tag,id data){
        //tag
        //8 surebtn
        switch (tag) {
            case 6:
            {
                [tempSelf showDateOrTimeView:@"选择日期" withDefault:data withTag:2001];
            }
                break;
            case 8:
                {
                    [tempSelf sure:data];
                }
                break;
            case 10:
            {
                M_DealerItemModel *model = (M_DealerItemModel *)data;
                [Unity openCallPhone:model.dealer_tel];
            }break;
            default:
                break;
        }
    };
}

-(void)showDateOrTimeView:(NSString*)title withDefault:(NSString*)time withTag:(NSInteger)tag
{
    self.myDateOrTimePickerView = [DLDateOrTimePickerView allocInstanceFrame:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight)];
    self.myDateOrTimePickerView.tag = tag;
    
    [self.myDateOrTimePickerView updateViewData:title withData:[time stringToDate] withMode:YES];
    
    [self.myDateOrTimePickerView setMaxTime:nil withMinTime:[[[NSDate new] dateToString] stringToDate]];
    
    [self.baseView addSubview:self.myDateOrTimePickerView];
    
    __weak D_TestDriveViewController* tempSelf = self;
    self.myDateOrTimePickerView.block = ^(int tag,id data){
        if (tag == 1) {
            [tempSelf.myHeaderView updateContent:data withTag:6];
        }else if (tag == 0){
            [tempSelf.myDateOrTimePickerView removeFromSuperview];
            tempSelf.myDateOrTimePickerView = nil;
        }
    };
    
    [self.myDateOrTimePickerView startAnimation];
}

-(void)sure:(id)data
{
    NSDictionary* tempDic = (NSDictionary*)data;
    
    NSString* tempName = [tempDic hasItemAndBack:@"name"];
    NSString* temptime = [tempDic hasItemAndBack:@"time"];
    NSString* tempMemo = [tempDic hasItemAndBack:@"memo"];
    NSString* tempPhone =  [tempDic hasItemAndBack:@"phone"];

    [TTReqEngine C_PostTrydriving_AddSetUid:[DLAppData sharedInstance].myUserKey
                                 withCar_id:self.myItemModel.myCar_Id
                              withDealer_id:self.myDealerItemModel.dealer_id
                                  withPhone:tempPhone
                               withRealname:tempName
                                    withMem:tempMemo
                                   withTime:temptime
                                  withBlock:^(BOOL success, id dataModel) {
                                      if (success) {
                                          [SVProgressHUD showSuccessWithStatus:@"预约试驾申请成功！"];
                                          [self.navigationController popViewControllerAnimated:YES];
                                      }
                                  }];
}

-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
 
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
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
