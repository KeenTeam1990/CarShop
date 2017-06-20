//
//  BuyCarViewController.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/10/30.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "BuyCarViewController.h"
#import "M_CarListView.h"
#import "D_CarDetailViewController.h"
#import "TTReqEngine.h"
#import "M_CarListModel.h"
#import "M_BrandListModel.h"
#import "M_SubBrandListModel.h"
#import "M_CarYearListModel.h"
#import "M_CarTypeListModel.h"
#import "M_CarPriceListModel.h"
#import "M_SearchView.h"
#import "M_BuyShaixuanView.h"
#import "M_Shaixuan3View.h"
#import "M_ShaixuanBrandView.h"
#import "M_ConfigDataModel.h"
#import "M_SeriesListModel.h"
#import "D_DealerViewController.h"

@interface BuyCarViewController ()

AS_MODEL_STRONG(M_CarListView, myListView);

AS_MODEL_STRONG(M_SearchView, mySearchView);
AS_MODEL_STRONG(M_BuyShaixuanView, myTopView);
AS_MODEL_STRONG(M_Shaixuan3View, myShaixuanView);
AS_MODEL_STRONG(M_ShaixuanBrandView, myShaixuanBrandView);

AS_MODEL_STRONG(M_ConfigDataModel, myConfig2Model);
AS_MODEL_STRONG(M_ConfigDataModel, myConfig3Model);
AS_MODEL_STRONG(M_SeriesListModel, mySeriesListModel);

AS_MODEL_STRONG(M_SeriesItemModel, myCurrCarModel);

@end

@implementation BuyCarViewController

DEF_FACTORY(BuyCarViewController);
DEF_MODEL(myListView);


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initView];
    
    [self initData];
    
    //[self addTapToBaseView];
    
}

-(void)initView
{
    // 初始化导航条 @"返回箭头"
    [self addCustomNavBar:@"优选"
              withLeftBtn:@"ic_goBack"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:@"经销商"];

     self.mySearchView = [M_SearchView allocInstanceFrame:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, 0)];
    self.mySearchView.hidden  =YES;
    [self.baseView addSubview:self.mySearchView];
    
    self.myTopView = [M_BuyShaixuanView allocInstanceFrame:CGRectMake(0, NavigationBarHeight+self.mySearchView.frame.size.height, self.baseView.frame.size.width, 50)];
    [self.baseView addSubview:self.myTopView];
    
    self.myListView = [M_CarListView allocInstanceFrame:CGRectMake(0, NavigationBarHeight+self.mySearchView.frame.size.height+self.myTopView.frame.size.height, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight-self.mySearchView.frame.size.height-self.myTopView.frame.size.height)];
    self.myListView.carType = EB_NewCar;
    [self.baseView addSubview:self.myListView];
    
    self.myShaixuanView = [M_Shaixuan3View allocInstanceFrame:self.baseView.bounds];
    self.myShaixuanView.hidden = YES;
    [self.myShaixuanView updateShowFrame:self.myListView.frame];
    [self.baseView addSubview:self.myShaixuanView];
    
    self.myShaixuanBrandView = [M_ShaixuanBrandView allocInstanceFrame:self.baseView.bounds];
    self.myShaixuanBrandView.hidden = YES;
    [self.myShaixuanBrandView updateTableFrame:self.myListView.frame];
    [self.baseView addSubview:self.myShaixuanBrandView];
    
}

-(void)initData
{
    __weak BuyCarViewController* tempSelf = self;
    self.myListView.block = ^(M_CarItemModel* model){
        [tempSelf toDetailsController:model.myCar_Id];
    };
    
    self.myListView.getDataBlock = ^(NSInteger tag){
        if (tag == 0) {
            [tempSelf getData];
        }
    };
    
    self.myConfig3Model = [M_ConfigDataModel allocInstance];
    
//    NSArray* tempArray1 = @[@"微型车型",@"小型车",@"紧凑型车",@"中型车",@"中大型车",@"豪华车",@"跑车",@"MPV",@"SUV"];
    
//    for (int i=0; i<[tempArray1 count]; i++) {
//        M_ConfigDataItemModel* tempItem = [M_ConfigDataItemModel allocInstance];
//        tempItem.myName = [tempArray1 objectAtIndex:i];
//        [self.myConfig3Model.myItemArray addObject:tempItem];
//    }
    
//    NSArray* tempArray2 = @[@"8万以下",@"8-10万",@"10-15万",@"15-20万",@"20-30万",@"30-50万",@"50万以上"];
    
    self.myConfig2Model = [M_ConfigDataModel allocInstance];
    
    self.mySeriesListModel = [M_SeriesListModel allocInstance];
//    for (int i=0; i<[tempArray2 count]; i++) {
//        M_ConfigDataItemModel* tempItem = [M_ConfigDataItemModel allocInstance];
//        tempItem.myName = [tempArray2 objectAtIndex:i];
//        [self.myConfig2Model.myItemArray addObject:tempItem];
//    }
    
    self.myTopView.block = ^(NSInteger tag,id data){
        tempSelf.myShaixuanView.topTag = tag;
        tempSelf.myShaixuanView.hidden = YES;
        tempSelf.myShaixuanBrandView.hidden = YES;
        if (tag == 1) {
            if([tempSelf.myConfig3Model.myItemArray count] ==0)
            {
                [tempSelf getConfigData:@"3"];
            }
            tempSelf.myShaixuanView.hidden = NO;
            [tempSelf.myShaixuanView updateData:tempSelf.myConfig3Model.myItemArray];
        }else if (tag == 2){
            if([tempSelf.myConfig2Model.myItemArray count] ==0)
            {
                [tempSelf getConfigData:@"2"];
            }
            tempSelf.myShaixuanView.hidden = NO;
            [tempSelf.myShaixuanView updateData:tempSelf.myConfig2Model.myItemArray];
        }else if (tag == 0){
            if ([tempSelf.mySeriesListModel.myItemArray count] == 0) {
                [tempSelf getSeriesData];
            }
            if (tempSelf.mySeriesListModel!=nil && [tempSelf.mySeriesListModel.myItemArray count]>0) {
                tempSelf.myShaixuanBrandView.hidden = NO;
                
                [tempSelf.myShaixuanBrandView upDateData:tempSelf.mySeriesListModel];
            }else{
                tempSelf.myTopView.leftText = @"";
            }
        }
    };
    
    self.myShaixuanView.block = ^(NSInteger tag,NSInteger topTag,id data){
        
        if (tag == 0) {
            tempSelf.myShaixuanView.hidden = YES;
            M_ConfigDataItemModel* tempItem = (M_ConfigDataItemModel*)data;
            if(tempItem!=nil){
                if (tempItem.isSelete) {
                    if (topTag == 1) {
                        tempSelf.myTopView.centerText = tempItem.myName;
                    }else if (topTag == 2) {
                        tempSelf.myTopView.rightText = tempItem.myName;
                    }
                }else{
                    if (topTag == 1) {
                        tempSelf.myTopView.centerText = @"";
                    }else if (topTag == 2) {
                        tempSelf.myTopView.rightText = @"";
                    }
                }
            }
            
            [tempSelf.myListView getData];
        }else if (tag == 1){
            tempSelf.myShaixuanView.hidden = YES;
            [tempSelf.myTopView updateBtnData];
        }
    };
    
    self.myShaixuanBrandView.block = ^(NSInteger tag,id data){
        if (tag == 0) {
            
            M_SeriesItemModel* tempItem = (M_SeriesItemModel*)data;
            if (tempItem!=nil) {
                tempSelf.myTopView.leftText = tempItem.myName;
            }else{
                tempSelf.myTopView.leftText = @"";
            }
            [tempSelf.myListView getData];
            
            tempSelf.myShaixuanBrandView.hidden = YES;
            [tempSelf.myTopView updateBtnData];
            
        }else if (tag == 1){
            tempSelf.myShaixuanBrandView.hidden = YES;
            [tempSelf.myTopView updateBtnData];
        }
    };
    
    self.mySearchView.block = ^(NSString* keyword){
        
    };
}

-(void)getData
{
    //type：类型 必填 1特价 2租购 3优选
    self.myTopView.userInteractionEnabled = NO;
    [TTReqEngine C_Getcar_dealerlistSetCity_id:APPDELEGATE.viewController.myCityModel.myCity_Id
                                 withDealer_id:nil
                                       withLng:nil
                                       withLat:nil
                                      withType:@"3"
                                    withLimitd:self.myListView.myPageModel.limit
                                      withPage:nil
                                       withMax:self.myListView.myPageModel.nextMax
                                  withcar_Type:self.myTopView.rightText
                               withPrice_range:self.myTopView.centerText
                               withInstallment:nil
                     withcar_Downpayment_range:nil
                               withBigbrand_id:nil
                                  withBrand_id:self.myShaixuanBrandView.myBid
                                 withSeries_id:self.myShaixuanBrandView.mySid
                                     withBlock:^(BOOL success, id dataModel) {
                                         self.myTopView.userInteractionEnabled = YES;
                                         if (success) {
                                             
                                             M_CarListModel* tempModel = (M_CarListModel*)dataModel;
                                             if (tempModel!=nil) {
                 
                                                 [self.myListView.myPageModel toData:tempModel.myPageModel];
                                                 
                                                 [self.myListView updateData:tempModel.myItemArray];
                                             }
                                             if ([DLAppData sharedInstance].currCityChangeToNew) {
                                                 [DLAppData sharedInstance].currCityChangeToNew = NO;
                                             }
                                             if([tempModel.myItemArray count]==0){
                                                 [self.myListView showPageError:YES withIsError:NO];
                                             }
                                         }
                                         else
                                         {
                                             [self.myListView showPageError:YES withIsError:YES];
                                         }
//                                         [self getSeriesData];
                                         [self.myListView updateListState:success];
                                     }];
}

-(void)getConfigData:(NSString*)type
{
    [TTReqEngine C_GetConfig_GetType:type
                           withBlock:^(BOOL success, id dataModel) {
                               if (success) {
                                   if ([type isEqualToString:@"2"]) {
                                       self.myConfig2Model = (M_ConfigDataModel*)dataModel;
                                        [self.myShaixuanView updateData:self.myConfig2Model.myItemArray];
                                       
                                   }else if ([type isEqualToString:@"3"]) {
                                       self.myConfig3Model = (M_ConfigDataModel*)dataModel;
                                        [self.myShaixuanView updateData:self.myConfig3Model.myItemArray];
                                   }
                               }
//                               if ([type isEqualToString:@"2"]) {
//                                   [self getConfigData:@"3"];
//                               }
                           }];
}

-(void)getSeriesData
{
    [TTReqEngine C_GetSeries_ListSetBigbrand_id:nil withStatus:nil withBlock:^(BOOL success, id dataModel) {
        if (success) {
             self.mySeriesListModel = (M_SeriesListModel*)dataModel;
            self.myShaixuanBrandView.hidden = NO;
            [self.myShaixuanBrandView upDateData:self.mySeriesListModel];
        }
//        [self getConfigData:@"2"];

    }];
}
-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)toDetailsController:(NSString*)carId
{
    [MobClick event:@"buy_cardetail"];
    D_CarDetailViewController* tempControlelr = [D_CarDetailViewController allocInstance];
    tempControlelr.myCarId = carId;
    tempControlelr.carType = EB_NewCar;
    [self.navigationController pushViewController:tempControlelr animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
    
    if ([DLAppData sharedInstance].currCityChangeToNew) {
        [self.myListView getData];
    }else{
        if ([self.myListView.myDataArray count] == 0) {
            [self.myListView getData];
        }
    }
    [MobClick event:@"main_buy"];
}

-(void)rightBtnPressed:(id)sender
{
    [self.myTopView resetData];
    
    if (self.myConfig2Model!=nil) {
        for (int i=0; i<[self.myConfig2Model.myItemArray count]; i++) {
            M_ConfigDataItemModel* tempItem = [self.myConfig2Model.myItemArray objectAtIndex:i];
            if (tempItem!=nil) {
                tempItem.isSelete = NO;
            }
        }
    }
    if (self.myConfig3Model!=nil) {
        for (int i=0; i<[self.myConfig3Model.myItemArray count]; i++) {
            M_ConfigDataItemModel* tempItem = [self.myConfig3Model.myItemArray objectAtIndex:i];
            if (tempItem!=nil) {
                tempItem.isSelete = NO;
            }
        }
    }
    
    self.myShaixuanBrandView.myBid = @"";
    self.myShaixuanBrandView.mySid = @"";
    
    if (self.mySeriesListModel!=nil) {
        for (int i=0; i<[self.mySeriesListModel.myItemArray count]; i++) {
            M_SeriesBrandModel* tempItem = [self.mySeriesListModel.myItemArray objectAtIndex:i];
            if (tempItem!=nil) {
                tempItem.isSelete = NO;
                
                for (int j=0; j<[tempItem.mySeriesArray count]; j++) {
                    M_SeriesItemModel* tempItem2 = [tempItem.mySeriesArray objectAtIndex:j];
                    if (tempItem2!=nil) {
                        tempItem2.isSelete = NO;
                    }
                }
            }
        }
    }
    
    [self.myListView getData];
    
    [self.navigationController pushViewController:[D_DealerViewController allocInstance] animated:YES];
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
