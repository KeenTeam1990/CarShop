//
//  D_DealerHomeViewController.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_DealerHomeViewController.h"
#import "M_DealerHomeTabView.h"
#import "M_DealerHomeView.h"
#import "M_CarDistributorItemView.h"
#import "D_CarDetailViewController.h"
#import "TTReqEngine.h"
#import "M_CarListModel.h"
#import "DLPageErrorView.h"
#define textLableTextSize 12

@interface D_DealerHomeViewController ()

AS_MODEL_STRONG(M_CarDistributorItemView, myDealerItemView);
AS_MODEL_STRONG(M_DealerHomeTabView, myTabView);
AS_MODEL_STRONG(M_DealerHomeView, myNewCarView);
AS_MODEL_STRONG(M_DealerHomeView, mySpeciaiCarView);
AS_MODEL_STRONG(M_DealerHomeView, myRentaiCarView);
AS_MODEL_STRONG(UIButton, myOpenCallBtn);
AS_MODEL_STRONG(DLPageErrorView, myErrorViewNew);
@property (nonatomic,strong)UILabel *textLable;
@end

@implementation D_DealerHomeViewController

DEF_FACTORY(D_DealerHomeViewController);

DEF_MODEL(myItemModel);
DEF_MODEL(myDealerItemView);
DEF_MODEL(myNewCarView);
DEF_MODEL(myRentaiCarView);
DEF_MODEL(mySpeciaiCarView);
DEF_MODEL(myTabView);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initView];
    
    [self initData];
}

-(void)initView
{
    [self addCustomNavBar:@"经销商"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    
    self.myDealerItemView = [M_CarDistributorItemView allocInstanceFrame:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, 130)];
    self.myDealerItemView.showLine = NO;
    [self.baseView addSubview:self.myDealerItemView];
    
    self.myOpenCallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myOpenCallBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor]; style.borderWidth = 1;
                                                 style.borderColor = [UIColor blackColor];
                                                 style.cornerRedius = 5;);
    self.myOpenCallBtn.tintColor = [UIColor blackColor];
    [self.myOpenCallBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.myOpenCallBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    self.myOpenCallBtn.frame = CGRectMake(self.myDealerItemView.frame.size.width-110, 110-35, 80, 30);
    [self.myOpenCallBtn addTarget:self action:@selector(openCallBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.myOpenCallBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
    self.myOpenCallBtn.userInteractionEnabled = YES;
    [self.myDealerItemView addSubview:self.myOpenCallBtn];
    
    self.myTabView = [M_DealerHomeTabView allocInstanceFrame:CGRectMake(0, NavigationBarHeight+130, self.baseView.frame.size.width, 50)];
    [self.baseView addSubview:self.myTabView];
    
    self.myNewCarView = [M_DealerHomeView allocInstanceFrame:CGRectMake(0, NavigationBarHeight+180, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight-180)];
    self.myNewCarView.carType = EB_NewCar;
    self.myNewCarView.hidden = YES;
    [self.baseView addSubview:self.myNewCarView];
    
    self.mySpeciaiCarView = [M_DealerHomeView allocInstanceFrame:CGRectMake(0, NavigationBarHeight+180, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight-180)];
    self.mySpeciaiCarView.carType = EB_SpeciaiCar;
    [self.baseView addSubview:self.mySpeciaiCarView];
    
    self.myRentaiCarView = [M_DealerHomeView allocInstanceFrame:CGRectMake(0, NavigationBarHeight+180, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight-180)];
    self.myRentaiCarView.carType = EB_RentaiCar;
    [self.baseView addSubview:self.myRentaiCarView];
    
    CGFloat textLableWidth=[Unity getLableWidthWithString:@"敬请期待更多的特价车上线~~~~" andFontSize:textLableTextSize];
    _textLable=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-textLableWidth/2-30, SCREEN_HEIGHT/2-15+90, textLableWidth+100, 30)];
    _textLable.text=@"敬请期待更多的特价车上线~~~~";
    _textLable.hidden = YES;
    [self.baseView addSubview:_textLable];
    
    self.myErrorViewNew = [[DLPageErrorView alloc]initWithFrame:self.myNewCarView.frame];
    self.myErrorViewNew.hidden = YES;
    __weak D_DealerHomeViewController *tempSelf = self;
    self.myErrorViewNew.block = ^(NSInteger tag )
    {
        if ([tempSelf.myRentaiCarView isHidden] &&[tempSelf.mySpeciaiCarView isHidden]) {
            [tempSelf getNewCarData];
        }
        if ([tempSelf.myNewCarView isHidden] &&[tempSelf.mySpeciaiCarView isHidden]) {
            [tempSelf getRentalData];
        }
        if ([tempSelf.myNewCarView isHidden] &&[tempSelf.myRentaiCarView isHidden]) {
            [tempSelf getSpecialCarData];
        }
    };
    [self.baseView addSubview:self.myErrorViewNew];
}
-(void)openCallBtnPressed:(UIButton *)button
{
    if (self.myItemModel.dealer_tel != nil) {
        [Unity openCallPhone:self.myItemModel.dealer_tel];
    }
}
-(void)initData 
{
    self.myRentaiCarView.hidden = YES;
    
    [self.myTabView addItem:[[M_DealerHomeTabItemModel alloc] initData:@"特价" withSelete:YES]];
    [self.myTabView addItem:[[M_DealerHomeTabItemModel alloc] initData:@"租购" withSelete:NO]];
    [self.myTabView addItem:[[M_DealerHomeTabItemModel alloc] initData:@"优选" withSelete:NO]];
    
    [self.myTabView updateData];
    
    __weak D_DealerHomeViewController* tempSelf = self;
    self.myTabView.block = ^(NSInteger tag){
        
        tempSelf.myRentaiCarView.hidden = YES;
        tempSelf.mySpeciaiCarView.hidden = YES;
        tempSelf.myNewCarView.hidden = YES;
        tempSelf.myErrorViewNew.hidden = YES;
        
        switch (tag) {

            case 0:
            {
                tempSelf.mySpeciaiCarView.hidden = NO;
                
                if ([tempSelf.mySpeciaiCarView.myDataArray count] == 0) {
                    [tempSelf getSpecialCarData];
                    
                }
            }
                break;
            case 1:
            {
                tempSelf.myRentaiCarView.hidden = NO;
                tempSelf.textLable.hidden=YES;
                if ([tempSelf.myRentaiCarView.myDataArray count] == 0) {
                    [tempSelf getRentalData];
                }
            }
                break;
            case 2:
            {
                tempSelf.myNewCarView.hidden = NO;
                tempSelf.textLable.hidden=YES;
                if ([tempSelf.myNewCarView.myDataArray count] == 0) {
                    [tempSelf getNewCarData];
                }
            }
                break;
            default:
                break;
        }
    };
    
    self.myNewCarView.getDataBlock=^(NSInteger tag){
        if (tag == 0) {
            [tempSelf getNewCarData];
        }
    };
    
    self.mySpeciaiCarView.getDataBlock=^(NSInteger tag){
        if (tag == 0) {
            [tempSelf getSpecialCarData];
        }
    };
    
    self.myRentaiCarView.getDataBlock=^(NSInteger tag){
        if (tag == 0) {
            [tempSelf getRentalData];
        }
    };
    
    if (self.myItemModel!=nil) {
        [self.myDealerItemView updateData:myItemModel];
    }
    
    self.myNewCarView.block = ^(M_CarItemModel* model){
        [tempSelf toDetailsController:model.myCar_Id withCarType:EB_NewCar];
    };
    
    self.mySpeciaiCarView.block = ^(M_CarItemModel* model){
        [tempSelf toDetailsController:model.myCar_Id withCarType:EB_SpeciaiCar];
    };
    
    self.myRentaiCarView.block = ^(M_CarItemModel* model){
        [tempSelf toDetailsController:model.myCar_Id withCarType:EB_RentaiCar];
    };
    
    [self.mySpeciaiCarView getData];
}

-(void)showPageError:(BOOL)show withIsError:(BOOL)error
{

    self.myErrorViewNew.isError = error;
    self.myErrorViewNew.hidden = !show;
//    self.myTableView.hidden = show;
    
//    [self.baseView bringSubviewToFront:self.myErrorView];
    
    if (error) {
        self.myErrorViewNew.myIcon = [UIImage imageNamed:@"loaderror_icon.png"];
    }else{
        self.myErrorViewNew.myIcon = [UIImage imageNamed:@"loadzero_icon.png"];
    }
}
-(void)getNewCarData
{
    //type：类型 必填 1特价 2租购 3优选
    [TTReqEngine C_Getcar_dealerlistSetCity_id:APPDELEGATE.viewController.myCityModel.myCity_Id
                                 withDealer_id:self.myItemModel.dealer_id
                                       withLng:nil
                                       withLat:nil
                                      withType:@"3"
                                    withLimitd:self.myNewCarView.myPageModel.limit
                                      withPage:nil
                                       withMax:self.myNewCarView.myPageModel.nextMax
                                  withcar_Type:nil
                               withPrice_range:nil
                               withInstallment:nil
                     withcar_Downpayment_range:nil
                               withBigbrand_id:nil
                                  withBrand_id:nil
                                 withSeries_id:nil
                                     withBlock:^(BOOL success, id dataModel) {
                                         if (success) {
                                             
                                             M_CarListModel* tempModel = (M_CarListModel*)dataModel;
                                             if (tempModel!=nil) {
                                                 
                                                 [self.myNewCarView.myPageModel toData:tempModel.myPageModel];
                                                 
                                                 [self.myNewCarView updateData:tempModel.myItemArray];
                                             }
                                             if ([self.myNewCarView.myDataArray count]==0) {
                                                 [self showPageError:YES withIsError:NO];
                                             }
                                         }
                                         else{
                                             [self showPageError:YES withIsError:YES];
                                         }
                                         [self.myNewCarView updateListState:success];
                                     }];
}

-(void)getSpecialCarData
{
    //type：类型 必填 1特价 2租购 3优选
    [TTReqEngine C_Getcar_dealerlistSetCity_id:APPDELEGATE.viewController.myCityModel.myCity_Id
                                 withDealer_id:self.myItemModel.dealer_id
                                       withLng:nil
                                       withLat:nil
                                      withType:@"1"
                                    withLimitd:self.mySpeciaiCarView.myPageModel.limit
                                      withPage:nil
                                       withMax:self.mySpeciaiCarView.myPageModel.nextMax
                                  withcar_Type:nil
                               withPrice_range:nil
                               withInstallment:nil
                     withcar_Downpayment_range:nil
                               withBigbrand_id:nil
                                  withBrand_id:nil
                                 withSeries_id:nil
                                     withBlock:^(BOOL success, id dataModel) {
                                         if (success) {
                                             
                                             M_CarListModel* tempModel = (M_CarListModel*)dataModel;
                                             if (tempModel!=nil) {
                                                 
                                                 [self.mySpeciaiCarView.myPageModel toData:tempModel.myPageModel];
                                                 
                                                 [self.mySpeciaiCarView updateData:tempModel.myItemArray];
                                             }
                                             if ([self.mySpeciaiCarView.myDataArray count] ==0) {
                                                 [self showPageError:YES withIsError:NO];
                                             }
                                         }
                                         else{
                                             [self showPageError:YES withIsError:YES];
                                         }
                                         [self judegtLableHidenOrNot];
                                         [self.mySpeciaiCarView updateListState:success];
                                     }];
}
-(void)judegtLableHidenOrNot
{
//    if (self.mySpeciaiCarView.myDataArray.count == 0) {
//        self. textLable.hidden = NO;
//    }
//    else
//    {
//        self.textLable.hidden =YES;
//    }
}

-(void)getRentalData
{
    //type：类型 必填 1特价 2租购 3优选
    [TTReqEngine C_Getcar_dealerlistSetCity_id:APPDELEGATE.viewController.myCityModel.myCity_Id
                                 withDealer_id:self.myItemModel.dealer_id
                                       withLng:nil
                                       withLat:nil
                                      withType:@"2"
                                    withLimitd:self.myRentaiCarView.myPageModel.limit
                                      withPage:nil
                                       withMax:self.myRentaiCarView.myPageModel.nextMax
                                  withcar_Type:nil
                               withPrice_range:nil
                               withInstallment:nil
                     withcar_Downpayment_range:nil
                               withBigbrand_id:nil
                                  withBrand_id:nil
                                 withSeries_id:nil
                                     withBlock:^(BOOL success, id dataModel) {
                                         if (success) {
                                             
                                             M_CarListModel* tempModel = (M_CarListModel*)dataModel;
                                             if (tempModel!=nil) {
                                                 
                                                 [self.myRentaiCarView.myPageModel toData:tempModel.myPageModel];
                                                 
                                                 [self.myRentaiCarView updateData:tempModel.myItemArray];
                                             }
                                             if ([self.myRentaiCarView.myDataArray count]==0) {
                                                 [self showPageError:YES withIsError:NO];
                                             }
                                         }
                                         else
                                         {
                                             [self showPageError:YES withIsError:YES];
                                         }
                                         [self.myRentaiCarView updateListState:success];
                                     }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
}

-(void)toDetailsController:(NSString*)car_id withCarType:(TCarBottomType)cartype
{
    D_CarDetailViewController* tempController = [D_CarDetailViewController allocInstance];
    tempController.myDealerItemModel = self.myItemModel;
    tempController.myCarId = car_id;
    tempController.carType = cartype;
    [self.navigationController pushViewController:tempController animated:YES];
}

-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
