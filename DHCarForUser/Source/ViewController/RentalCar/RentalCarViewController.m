//
//  RentalCarViewController.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/10/30.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "RentalCarViewController.h"
#import "M_CarListView.h"
#import "D_CarDetailViewController.h"
#import "TTReqEngine.h"
#import "M_RentalShaixuanView.h"
#import "M_Shaixuan3View.h"
#import "M_ConfigDataModel.h"
#import "D_DealerViewController.h"

@interface RentalCarViewController ()

AS_MODEL_STRONG(M_CarListView, myListView);
AS_MODEL_STRONG(M_RentalShaixuanView, myTopView);
AS_MODEL_STRONG(M_ConfigDataModel, myConfig4Model);
AS_MODEL_STRONG(M_ConfigDataModel, myConfig5Model);

AS_MODEL_STRONG(M_Shaixuan3View, myShaixuanView);

@end

@implementation RentalCarViewController

DEF_FACTORY(RentalCarViewController);

DEF_MODEL(myListView);

DEF_MODEL(myTopView);
DEF_MODEL(myConfig4Model);
DEF_MODEL(myConfig5Model);

DEF_MODEL(myShaixuanView);

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self initView];
    
    [self initData];
}

-(void)initView
{
    // 初始化导航条 @"返回箭头"
    [self addCustomNavBar:@"租购"
              withLeftBtn:@"ic_goBack"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:@"经销商"];
    
    self.myTopView = [M_RentalShaixuanView allocInstanceFrame:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, 50)];
    [self.baseView addSubview:self.myTopView];
    
    self.myListView = [M_CarListView allocInstanceFrame:CGRectMake(0, NavigationBarHeight+self.myTopView.frame.size.height, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight-self.myTopView.frame.size.height)];
    self.myListView.carType = EB_RentaiCar;
    [self.baseView addSubview:self.myListView];
    
    self.myShaixuanView = [M_Shaixuan3View allocInstanceFrame:self.baseView.bounds];
    self.myShaixuanView.hidden = YES;
    [self.baseView addSubview:self.myShaixuanView];
}

-(void)initData
{
    __weak RentalCarViewController* tempSelf = self;
    self.myListView.block = ^(M_CarItemModel* model){
        [tempSelf toDetailsController:model.myCar_Id];
    };
    self.myListView.getDataBlock = ^(NSInteger tag){
        if (tag == 0) {
            [tempSelf getData];
        }
    };
    
//    NSArray* tempArray2 = @[@"1万以下",@"1到3万",@"3万以上"];
    
    self.myConfig4Model = [M_ConfigDataModel allocInstance];
    
//    for (int i=0; i<[tempArray2 count]; i++) {
//        M_ConfigDataItemModel* tempItem = [M_ConfigDataItemModel allocInstance];
//        tempItem.myName = [tempArray2 objectAtIndex:i];
//        [self.myConfig4Model.myItemArray addObject:tempItem];
//    }
    
//    NSArray* tempArray3 = @[@"6期",@"12期",@"24期",@"36期"];
    
    self.myConfig5Model = [M_ConfigDataModel allocInstance];
    
//    for (int i=0; i<[tempArray3 count]; i++) {
//        M_ConfigDataItemModel* tempItem = [M_ConfigDataItemModel allocInstance];
//        tempItem.myName = [tempArray3 objectAtIndex:i];
//        [self.myConfig5Model.myItemArray addObject:tempItem];
//    }
    
    self.myTopView.block = ^(NSInteger tag,id data){
        tempSelf.myShaixuanView.topTag = tag;
        tempSelf.myShaixuanView.hidden = NO;
        if (tag == 0) {
            if ([tempSelf.myConfig4Model.myItemArray count] == 0) {
                 [tempSelf getConfigData:@"4"];
            }
           [tempSelf.myShaixuanView updateData:tempSelf.myConfig4Model.myItemArray];
          
        }else if (tag == 1){
            if ([tempSelf.myConfig5Model.myItemArray count] == 0) {
                [tempSelf getConfigData:@"5"];
            }
            [tempSelf.myShaixuanView updateData:tempSelf.myConfig5Model.myItemArray];
        }
    };
    
    self.myShaixuanView.block = ^(NSInteger tag,NSInteger topTag,id data){
        
        if (tag == 0) {
            tempSelf.myShaixuanView.hidden = YES;
            M_ConfigDataItemModel* tempItem = (M_ConfigDataItemModel*)data;
            if (tempItem!=nil) {
                if (tempItem.isSelete) {
                    if (topTag == 0) {
                        tempSelf.myTopView.leftText = tempItem.myName;
                    }else if (topTag == 1) {
                        tempSelf.myTopView.rightText = tempItem.myName;
                    }
                }else{
                    if (topTag == 0) {
                        tempSelf.myTopView.leftText = @"";
                    }else if (topTag == 1) {
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
    
}

-(void)rightBtnPressed:(id)sender
{
//    [self.myTopView resetData];
//    
//    if (self.myConfig4Model!=nil) {
//        for (int i=0; i<[self.myConfig4Model.myItemArray count]; i++) {
//            M_ConfigDataItemModel* tempItem = [self.myConfig4Model.myItemArray objectAtIndex:i];
//            if (tempItem!=nil) {
//                tempItem.isSelete = NO;
//            }
//        }
//    }
//    if (self.myConfig5Model!=nil) {
//        for (int i=0; i<[self.myConfig5Model.myItemArray count]; i++) {
//            M_ConfigDataItemModel* tempItem = [self.myConfig5Model.myItemArray objectAtIndex:i];
//            if (tempItem!=nil) {
//                tempItem.isSelete = NO;
//            }
//        }
//    }
//    
//    self.myListView.myPageModel.nextMax = @"";
//    
//    [self.myListView getData];
    
    
    [self.navigationController pushViewController:[D_DealerViewController allocInstance] animated:YES];
}
-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getData
{
    //type：类型 必填 1特价 2租购 3优选
    self.myTopView.userInteractionEnabled = NO;
    [TTReqEngine C_Getcar_dealerlistSetCity_id:APPDELEGATE.viewController.myCityModel.myCity_Id
                                 withDealer_id:nil
                                       withLng:nil
                                       withLat:nil
                                      withType:@"2"
                                    withLimitd:self.myListView.myPageModel.limit
                                      withPage:nil
                                       withMax:self.myListView.myPageModel.nextMax
                                  withcar_Type:nil
                               withPrice_range:nil
                               withInstallment:self.myTopView.rightText
                     withcar_Downpayment_range:self.myTopView.leftText
                               withBigbrand_id:nil
                                  withBrand_id:nil
                                 withSeries_id:nil
                                     withBlock:^(BOOL success, id dataModel) {
                                         self.myTopView.userInteractionEnabled = YES;
                                         if (success) {
                                             
                                             M_CarListModel* tempModel = (M_CarListModel*)dataModel;
                                            if (tempModel!=nil) {

                                                [self.myListView.myPageModel toData:tempModel.myPageModel];
                                                
                                                [self.myListView updateData:tempModel.myItemArray];
                                            }
                                             if([tempModel.myItemArray count]==0)
                                             {
                                                 [self.myListView showPageError:YES withIsError:NO];
                                             }
                                             
                                            if ([DLAppData sharedInstance].currCityChangeToRental) {
                                                [DLAppData sharedInstance].currCityChangeToRental = NO;
                                            }
                                         }
                                         else
                                         {
                                             [self.myListView showPageError:YES withIsError:YES];
                                         }
                                         [self.myListView updateListState:success];
                                     }];    
}

-(void)toDetailsController:(NSString*)carId
{
    [MobClick event:@"rent_cardetail"];
    D_CarDetailViewController* tempControlelr = [D_CarDetailViewController allocInstance];
    tempControlelr.myCarId = carId;
    tempControlelr.carType = EB_RentaiCar;
    [self.navigationController pushViewController:tempControlelr animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
    
    if ([DLAppData sharedInstance].currCityChangeToRental) {
        [self.myListView getData];
    }else{
        if ([self.myListView.myDataArray count] == 0) {
            [self.myListView getData];
        }
    }
    [MobClick event:@"main_rent"];
}

-(void)getConfigData:(NSString*)type
{
    [TTReqEngine C_GetConfig_GetType:type
                           withBlock:^(BOOL success, id dataModel) {
                               if (success) {
                                   if ([type isEqualToString:@"4"]) {
                                       self.myConfig4Model = (M_ConfigDataModel*)dataModel;
                                         [self.myShaixuanView updateData:self.myConfig4Model.myItemArray];
                                       
                                   }else if ([type isEqualToString:@"5"]) {
                                       self.myConfig5Model = (M_ConfigDataModel*)dataModel;
                                       [self.myShaixuanView updateData:self.myConfig5Model.myItemArray];
                                   }
                               }
//                               if ([type isEqualToString:@"4"]) {
//                                   [self getConfigData:@"5"];
//                               }
                           }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
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
