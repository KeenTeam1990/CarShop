//
//  H_HomeViewController.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/3.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "H_HomeViewController.h"
#import "D_CarDetailViewController.h"

#import "D_CarGasViewController.h"
#import "D_CarRemoteViewController.h"
#import "D_CarInsuranceViewController.h"
#import "D_WebViewController.h"
#import "D_DealerViewController.h"
#import "D_DealerHomeViewController.h"
#import "D_CarListViewController.h"

#import "D_MessageViewController.h"
#import "D_SeleteCityViewController.h"
#import "QueryModelsItemViewController.h"
#import "MobClick.h"
#import "TTReqEngine.h"
#import "M_CarListModel.h"
#import "M_IndexModel.h"
#import "M_IconView.h"

#import "H_HomeImageCell.h"
#import "H_HomeCar1Cell.h"
#import "H_HomeCar2Cell.h"
#import "H_HomeCar4Cell.h"

#import "D_LLDetailOrderViewController.h"
#import "D_SeckillDetailsViewController.h"
#import "M_SpikeListModel.h"
#import "M_SpikeItemCell.h"

#import "SpecialCarViewController.h"
#import "BuyCarViewController.h"
#import "RentalCarViewController.h"

#import "LL_RichScanViewController.h"

#import "D_LoginViewController.h"
#define KIconListHeight 100
#define KBannerHeight 200

@interface H_HomeViewController ()

AS_MODEL_STRONG(H_HomeHeaderView, myHeaderView);
AS_MODEL_STRONG(M_IndexModel, myIndexModel);

AS_MODEL_STRONG(M_IconView, myLeftIconBtn);
AS_MODEL_STRONG(M_IconView, myRightIconBtn);

AS_MODEL_STRONG(M_CityItemModel, myLocationModel);

AS_MODEL_STRONG(NSMutableArray, mySplicArray);

AS_MODEL_STRONG(NSString, userPositionString);

@end

@implementation H_HomeViewController

DEF_FACTORY(H_HomeViewController);

DEF_MODEL(myIndexModel);
DEF_MODEL(myHeaderView);
DEF_MODEL(myLeftIconBtn);
DEF_MODEL(myRightIconBtn);
DEF_MODEL(userPositionString);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.mySplicArray = [NSMutableArray allocInstance];
    
    [self addCustomNavBar:@""
              withLeftBtn:@""
             withRightBtn:@""
            withLeftLabel:@""
           withRightLabel:@""];
    [self updateSenterView];
    [self initView];
    [self initData];
    self.baseView.backgroundColor = [Unity getGrayBackColor];
    

    [APPDELEGATE.viewController cityLocation:^(id data) {
        if (data!=nil) {
            
            M_CityItemModel* tempModel = (M_CityItemModel*)data;
            if ([tempModel.myCity_Status notEmpty]) {
                if ([tempModel.myCity_Status isEqualToString:@"1"]) {
                    [self showChangeCityAlart:tempModel];
                }
            }
        }
    }];

    // ???什么通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSpikeList) name:@"SpikeEnd" object:nil];

}
-(void)updateSenterView
{
    UIImageView *imageView= [[UIImageView alloc]init];
    UIImage *image = [UIImage imageNamed:@"logo"];
    imageView.frame = CGRectMake((self.customNavBar.frame.size.width-image.size.width)/2,(self.customNavBar.frame.size.height -image.size.height)/2 , image.size.width, image.size.height);
    imageView.image = image;
    [self.customNavBar addSubview:imageView];
}
-(void)showChangeCityAlart:(M_CityItemModel*)locationModel
{
    NSString* tempStr = @"";
    
    if (APPDELEGATE.viewController.myCityModel !=nil && locationModel!=nil) {
        
        if (APPDELEGATE.viewController.myCityModel.myCity_Name != nil) {
            if (![APPDELEGATE.viewController.myCityModel.myCity_Name isEqualToString:locationModel.myCity_Name]) {
                tempStr = [NSString stringWithFormat:@"系统定位到您在%@,需要切换到%@吗？",locationModel.myCity_Name,locationModel.myCity_Name];
                UIAlertView* tempView = [[UIAlertView alloc]initWithTitle:@"" message:tempStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                tempView.tag = 9009;
                [tempView show];
            }
        }
    }else{
        return;
    }
    
    self.myLocationModel = locationModel;
}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 9009) {
        if (buttonIndex == 0) {
            
        }else if (buttonIndex == 1){
            
            if (self.myLocationModel!=nil) {
                
                APPDELEGATE.viewController.myCityModel = self.myLocationModel;
    
                [self.myLeftIconBtn updateModel:@"location.png" withText:self.myLocationModel.myCity_Name];
                
                [self initData];
            }
        }
    }
}

-(void)initView
{
    [self initTablePlainView:CGRectMake(5, NavigationBarHeight, self.baseView.frame.size.width-10, self.baseView.frame.size.height-NavigationBarHeight-TabBarHeight)
           withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    
    NSInteger tempHeight = KBannerHeight;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        tempHeight= KIconListHeight*2+KBannerHeight*2;
    }
    self.myHeaderView = [[H_HomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.baseView.frame.size.width, tempHeight)];
    self.myHeaderView.delegate = self;
    self.myTableView.tableHeaderView = self.myHeaderView;
    
    __weak H_HomeViewController* tempself = self;
    
    [self.myTableView addPullToRefreshWithActionHandler:^{
        
        [tempself getData];
    }];
    
    [self initNavBarBtnView];
}

-(void)initNavBarBtnView
{
    self.myLeftIconBtn = [M_IconView allocInstanceFrame:CGRectMake(0, 0, 80, 48)];
    [self.myLeftIconBtn updateModel:@"location.png" withText:APPDELEGATE.viewController.myCityModel.myCity_Name];
    [self.baseView addSubview:self.myLeftIconBtn];
    
//    [self.customNavBar updateBackImage:@"logo"];
    
    self.myRightIconBtn = [M_IconView allocInstanceFrame:CGRectMake(self.baseView.frame.size.width-80, 0, 80, 48)];
    [self.myRightIconBtn updateModel:@"RichScan" withText:@"扫一扫"];
    self.myRightIconBtn.showNum = NO;
    [self.baseView addSubview:self.myRightIconBtn];
    
    __weak H_HomeViewController* tempSelf = self;
    self.myLeftIconBtn.block = ^(NSInteger tag){
        [tempSelf leftBtnPressed:nil];
    };
    
    self.myRightIconBtn.block = ^(NSInteger tag){
        [tempSelf rightBtnPressed:nil];
    };
}

-(void)getData
{
    [SVProgressHUD showWithStatus:@"请稍候..."];
    
    [TTReqEngine C_GetRecommend_App_IndexCity_id:APPDELEGATE.viewController.myCityModel.myCity_Id
                                       withBlock:^(BOOL success, id dataModel) {
                                           if (success) {
                                               
                                               self.myIndexModel = (M_IndexModel*)dataModel;
                                               
                                               [self.myDataArray removeAllObjects];
                                               
                                               [self.myDataArray addObjectsFromArray:self.myIndexModel.myIndexArray];
                                               
                                               [self.myTableView reloadData];
                                           }
                                           
                                           [self getBannerData];
                                       }];
}

-(void)getBannerData
{
    [TTReqEngine C_GetRecommend_BannerCity_id:APPDELEGATE.viewController.myCityModel.myCity_Id
                                    withBlock:^(BOOL success, id dataModel) {
                                        if (success) {
                                            
                                            M_BannerModel* tempModel = (M_BannerModel*)dataModel;
                                            
//                                            M_BannerModel* tempModel = [[M_BannerModel alloc]init];
                                            if (tempModel!=nil) {
                                                
                                                self.myTableView.tableHeaderView  = nil;
                                                
                                                CGRect tempFrame = self.myHeaderView.frame;
                                                
                                                if ([tempModel.myItemArray count]>0) {
                                                    
                                                    NSInteger tempHeight = KIconListHeight+KBannerHeight;
                                                    
                                                    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                                                        tempHeight= KIconListHeight*2+KBannerHeight*2;
                                                    }
                                                    
                                                    tempFrame.size.height = tempHeight;
                                                    
                                                }else{
                                                    NSInteger tempHeight = KIconListHeight;
                                                    
                                                    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                                                        tempHeight= KIconListHeight*2;
                                                    }
                                                    
                                                    tempFrame.size.height = tempHeight;
                                                }
                                                self.myHeaderView.frame = tempFrame;
                                                
                                                self.myTableView.tableHeaderView = self.myHeaderView;
                                                
                                                [self.myHeaderView updateBannerData:tempModel.myItemArray];
                                            }
                                            [self.myTableView reloadData];
                                        }
                                        
                                        [self getSpikeList];
                                    }];
}

-(void)getSpikeList
{
    [TTReqEngine C_GetSpike_ListSetCity_id:APPDELEGATE.viewController.myCityModel.myCity_Id
                                 withBlock:^(BOOL success, id dataModel) {
                                     
                                     [SVProgressHUD dismiss];
                                     
                                     if (success) {
                                         M_SpikeListModel* tempModel = (M_SpikeListModel*)dataModel;
                                         if (tempModel!=nil) {
                                             
                                             [self.mySplicArray removeAllObjects];
                                             
                                             [self.mySplicArray addObjectsFromArray:tempModel.myItemArray];
                                             
                                             [self.myTableView reloadData];
                                         }
                                     }
                                     [self.myTableView.pullToRefreshView stopAnimating];
                                     [self.myHeaderView updatePoints_Sign];
                                 }];
}
//-(void)getConfigData
//{
//    [TTReqEngine C_GetConfig_GetType:<#(NSString *)#> withBlock:<#^(BOOL success, id dataModel)block#>]
//}
-(void)initData
{
    [self getData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick event:@"main_main"];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:YES];
    
    [self.myHeaderView updatePoints_Sign];

    if (APPDELEGATE.viewController.updateSpike) {
        
        [SVProgressHUD showWithStatus:@"请等待..."];
        [self getSpikeList];
        
        APPDELEGATE.viewController.updateSpike = NO;
    }
    [self performSelector:@selector(upDateJPushDetail) withObject:nil afterDelay:1.5];
    

}

-(void)upDateJPushDetail
{
    if (APPDELEGATE.viewController.JPushData!=nil) {
        [APPDELEGATE.viewController toDetails:self];
    }
}


#pragma homeHeader delegate

-(void)tapBannerModel:(M_BannerItemModel *)model
{
    if (model!=nil) {
        if ([model.itemUrl notEmpty]) {
            [self toWebController:model.itemName withUrl:model.itemUrl];
        }
    }
}

-(void)selectIconForTag:(NSInteger)tag withModel:(id)data
{
    NSInteger selectTag = tag;
    
    switch (selectTag-1100) {
//        case 0:
//        {
//            if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
//                
//                if ([APPDELEGATE.viewController.myUserModel.user_has_sign notEmpty] &&
//                    [APPDELEGATE.viewController.myUserModel.user_has_sign isEqualToString:@"1"]) {
//                    
//                }else{
//                    [TTReqEngine C_GetPoints_SignSetUid:[DLAppData sharedInstance].myUserKey
//                                              withBlock:^(BOOL success, id dataModel) {
//                                                  if (success) {
//                                                      [APPDELEGATE.viewController getUserData:^(id data) {
//                                                          [SVProgressHUD showSuccessWithStatus:@"签到成功!"];
//                                                          
//                                                          [self.myHeaderView showAniw];
//                                                          
//                                                          [self.myHeaderView updatePoints_Sign];
//                                                      }];
//                                                  }
//                                              }];
//                }
//            }
//            else{
//                [APPDELEGATE.viewController openLogin:self];
//            }
//        }
//            break;
//        case 1:
//        {
//            NSString *str = [NSString stringWithFormat:@"%@/html?k=7",KH5Host];
//            [self toWebController:@"东汇七天乐" withUrl:str];
//        }
//            break;
//        case 2:
//        {
//            if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
//                [MobClick event:@"main_carinsurance"];
//                NSString *str = [NSString stringWithFormat:@"%@/insurance",KH5Host];
//                [self toWebController:@"车险折上折" withUrl:str];
//            }
//            else{
//                [APPDELEGATE.viewController openLogin:self];
//            }
//        }
//            break;
//            
//        case 3:
//        {
//            [MobClick event:@"main_welfare"];
//            NSString *str = [NSString stringWithFormat:@"%@/html?k=publicwelfare&app=1",KH5Host];
//            [self toWebController:@"东汇公益" withUrl:str];
//        }
//            break;
//        case 4:
//        {
//            [MobClick event:@"main_integral"];
//             NSString *str = [NSString stringWithFormat:@"%@/html?k=integralshop",KH5Host];
//            [self toWebController:@"积分商城" withUrl:str];
//        }
//            break;
//            
//        case 5:
//        {
//            [MobClick event:@"main_carbusiness"];
//             NSString *str = [NSString stringWithFormat:@"%@/html?k=carinformation",KH5Host];
//            [self toWebController:@"车商资讯" withUrl:str];
//        }
//            break;
//        case 6:
//        {
//            if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
//                [MobClick event:@"main_life"];
//                NSString *str = [NSString stringWithFormat:@"%@/html?k=live",KH5Host];
//                [self toWebController:@"汇生活" withUrl:str];
//            }
//            else{
//                [APPDELEGATE.viewController openLogin:self];
//            }
//        }
//            break;
//        case 7:
//        {
//            [MobClick event:@"main_service"];
//            [self.navigationController pushViewController:[D_DealerViewController allocInstance] animated:YES];
//        }
//            break;
        case 0:
        {   
            SpecialCarViewController *tempView = [[SpecialCarViewController alloc]init];
            [self.navigationController pushViewController:tempView animated:YES];
        }
            break;
        case 1:
        {
            RentalCarViewController *tempView = [[RentalCarViewController alloc]init];
            [self.navigationController pushViewController:tempView animated:YES];
            
        }
            break;
        case 2:
        {
            BuyCarViewController *tempView = [[BuyCarViewController alloc]init];
            [self.navigationController pushViewController:tempView animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource
//1.tableview共有多少组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
//2.section有几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.mySplicArray count];
    }else if (section == 1){
        
//        NSLog(@"slslsllslslslsslsllsslslsl   %d",[self.myDataArray count]);
        return [self.myDataArray count];
    }
    return 0;
}
//3.告知每行显示什么
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        M_SpikeItemCell* cell = [M_SpikeItemCell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
        
        [cell configCellIndexPath:indexPath withDataArray:self.mySplicArray];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.block = ^(NSInteger tag,id data){
            if (tag == 0) {
                [self toSpike:(M_SpikeItemModel*)data];
            }
        };
        
        return cell;
        
    }else if (indexPath.section == 1){
        M_IndexItemModel* tempItem = [self.myDataArray objectAtIndex:indexPath.row];
        
        if ([tempItem.myIndexArray count]>0) {
            if ([tempItem.myIndexArray count] == 1) {
                
                M_IndexLineItemModel* tempLineItem = [tempItem.myIndexArray objectAtIndex:0];
                if (tempLineItem!=nil) {
                    if ([tempLineItem.myType notEmpty]) {
                        if ([tempLineItem.myType isEqualToString:@"1"]) {//活动
                            
                            H_HomeImageCell *cell = [H_HomeImageCell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
                            
                            [cell configCellIndexPath:indexPath withDataArray:tempItem.myIndexArray];
                            
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            
                            return cell;
                            
                        }else if ([tempLineItem.myType isEqualToString:@"2"]){//汽车
                            
                            H_HomeCar1Cell *cell = [H_HomeCar1Cell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
                            
                            [cell configCellIndexPath:indexPath withDataArray:tempItem.myIndexArray];
                            
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            
                            return cell;
                        }
                    }
                }
            }else if ([tempItem.myIndexArray count] == 2) {
                
                H_HomeCar2Cell *cell = [H_HomeCar2Cell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];

                [cell configCellIndexPath:indexPath withDataArray:tempItem.myIndexArray];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.block = ^(id data){
                    [self toIndexController:data];
                };
                
                return cell;
                
            }else if ([tempItem.myIndexArray count] == 4) {
                
                H_HomeCar4Cell *cell = [H_HomeCar4Cell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
                
                [cell configCellIndexPath:indexPath withDataArray:tempItem.myIndexArray];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.block = ^(id data){
                    [self toIndexController:data];
                };
                
                return cell;
            }
        }
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    
    if (indexPath.section == 0) {
        return 230;
    }else if (indexPath.section == 1){
        M_IndexItemModel* tempItem = [self.myDataArray objectAtIndex:indexPath.row];
        
        if ([tempItem.myIndexArray count]>0) {
            if ([tempItem.myIndexArray count] == 1) {
                
                M_IndexLineItemModel* tempLineItem = [tempItem.myIndexArray objectAtIndex:0];
                if (tempLineItem!=nil) {
                    if ([tempLineItem.myType notEmpty]) {
                        if ([tempLineItem.myType isEqualToString:@"1"]) {//活动
                            height = 190;
                        }else if ([tempLineItem.myType isEqualToString:@"2"]){//汽车
                            height = 125;
                        }
                    }
                }
            }else if ([tempItem.myIndexArray count] ==  2){
                height = 195;
            }else if ([tempItem.myIndexArray count] ==  4){
                height = 395;
            }
        }
    }
//    打印每一行cell的高度
//    NSLog(@"height = %f",height);
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        M_SpikeItemModel* tempItem = [self.mySplicArray objectAtIndex:indexPath.row];
        if (tempItem!=nil) {
            
//            NSString* tempStar = [Unity dayOrTime:tempItem.spike_started_at];
//            if (tempStar != nil) {
//                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"" message:@"秒杀还没有开始,请您稍等!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
//                [alter show];
//                return;
//            }
//
//            NSString* tempEnd = [Unity dayOrTime:tempItem.spike_ended_at];
//            if (tempEnd == nil) {
//                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"" message:@"秒杀已经结束,请您等待下次秒杀！" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
//                [alter show];
//                return;
//            }

            
            if ([[[DLUserDefaults sharedInstance] objectForKey:@"uid"] notEmpty]) {
                
                if ([[[DLUserDefaults sharedInstance] objectForKey:@"uid"] notEmpty]) {
                    D_SeckillDetailsViewController* tempController=  [D_SeckillDetailsViewController allocInstance];
                    tempController.backBlock = ^(bool result) {
                        if (result) {
                            [SVProgressHUD showWithStatus:@"请等待..."];
                            [self getSpikeList];
                        }};
                    tempController.spike_id = tempItem.spike_id;
                    [self.navigationController pushViewController:tempController animated:YES];
                }else{
                    [APPDELEGATE.viewController openBingPhone:self withBlock:^(bool result) {
                        if (result) {
                            D_SeckillDetailsViewController* tempController=  [D_SeckillDetailsViewController allocInstance];
                            tempController.spike_id = tempItem.spike_id;
                            tempController.backBlock = ^(bool result) {
                                if (result) {
                                    [SVProgressHUD showWithStatus:@"请等待..."];
                                    [self getSpikeList];
                                }};
                            [self.navigationController pushViewController:tempController animated:YES];
                        }
                    }];
                }
                
            }else{
                [APPDELEGATE.viewController openLogin:self];
            }
        }
    }else if (indexPath.section == 1){
        M_IndexItemModel* tempItem = [self.myDataArray objectAtIndex:indexPath.row];
        
        if ([tempItem.myIndexArray count]>0) {
            if ([tempItem.myIndexArray count] == 1) {
                
                [self toIndexController:[tempItem.myIndexArray objectAtIndex:0]];
            }
        }
    }
}

-(void)toSpike:(M_SpikeItemModel*)data
{
//    [TTReqEngine C_GetSpike_RushSetID:data.spike_id
//                              withUid:[DLAppData sharedInstance].myUserKey
//                        withTimestamp:data.timestamp
//                            withBlock:^(BOOL success, id dataModel) {
//                                if (success) {
//                                    [SVProgressHUD showSuccessWithStatus:@"秒杀成功"];
//                                }
//                            }];
}

-(void)toIndexController:(M_IndexLineItemModel*)model
{
    M_IndexLineItemModel* tempLineItem = model;
    if (tempLineItem!=nil) {
        if ([tempLineItem.myType notEmpty]) {
            if ([tempLineItem.myType isEqualToString:@"1"]) {//活动
                
                if (tempLineItem.myCoverModel!=nil) {
                    [self toWebController:tempLineItem.myCoverModel.myTitle
                                  withUrl:tempLineItem.myCoverModel.myUrl];
                }
                
            }else if ([tempLineItem.myType isEqualToString:@"2"]){//汽车
                if (tempLineItem.myCarModel!=nil) {
                    
                    TCarBottomType temptype;
                    
                    if (tempLineItem.myCarModel.myCar_Sales) {
                        temptype = EB_SpeciaiCar;
                    }else if (tempLineItem.myCarModel.myCar_Lease) {
                        temptype = EB_RentaiCar;
                    }else if (tempLineItem.myCarModel.myCar_New) {
                        temptype = EB_NewCar;
                    }
                    
                    [self toCarDetailsController:tempLineItem.myCarModel.myCar_Id withCarType:temptype];
                }
            }
        }
    }
}

-(void)toCarDetailsController:(NSString*)carId withCarType:(TCarBottomType)type
{
    [MobClick event:@"main_cardetail"];
    D_CarDetailViewController* tempController = [D_CarDetailViewController allocInstance];
    tempController.myCarId = carId;
    tempController.carType = type;
    [self.navigationController pushViewController:tempController animated:YES];
}

-(void)toWebController:(NSString*)title withUrl:(NSString*)url
{
    if (![url isEqualToString:@""]) {
        D_WebViewController* tempController = [D_WebViewController allocInstance];
        tempController.myTitle = title;
        tempController.myUrl = url;
        [self.navigationController pushViewController:tempController animated:YES];
    }
}

-(void)leftBtnPressed:(id)sender
{
    D_SeleteCityViewController* tempController =[D_SeleteCityViewController allocInstance];
    tempController.block = ^(M_CityItemModel* model){
        if (model!=nil) {
            
            if (![APPDELEGATE.viewController.myCityModel.myCity_Id isEqualToString:model.myCity_Id]) {
                [DLAppData sharedInstance].currCityChangeToDealer = YES;
                [DLAppData sharedInstance].currCityChangeToSpecial = YES;
                [DLAppData sharedInstance].currCityChangeToRental = YES;
                [DLAppData sharedInstance].currCityChangeToNew = YES;
            }else{
                [DLAppData sharedInstance].currCityChangeToDealer = NO;
                [DLAppData sharedInstance].currCityChangeToSpecial = NO;
                [DLAppData sharedInstance].currCityChangeToRental = NO;
                [DLAppData sharedInstance].currCityChangeToNew = NO;
            }
            
            APPDELEGATE.viewController.myCityModel = model;
            
            [[DLUserDefaults sharedInstance] setObject:model.myCity_Id forKey:@"city_id"];
            [[DLUserDefaults sharedInstance] setObject:model.myCity_Name forKey:@"city_name"];
            
            [self getData];
            
            [self.myLeftIconBtn updateModel:@"location.png" withText:model.myCity_Name];
        }
    };
    [MobClick event:@"main_city"];
    [self.navigationController pushViewController:tempController animated:YES];
}

-(void)rightBtnPressed:(id)sender
{
    if ([APPDELEGATE.viewController.myUserModel.user_id notEmpty]) {
        NSLog(@"已登录");
        LL_RichScanViewController *tempView = [[LL_RichScanViewController alloc]init];
        [self.navigationController pushViewController:tempView animated:YES];
        [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
        
    }
    else
    {
        NSLog(@"未登录");
        D_LoginViewController *loginView = [[D_LoginViewController alloc]init];
        loginView.isLogin = YES;
        [self presentViewController:loginView animated:YES completion:^{
            
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
