//
//  D_CarListViewController.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_CarListViewController.h"
#import "M_CarListView.h"
#import "D_CarDetailViewController.h"
#import "TTReqEngine.h"

@interface D_CarListViewController ()

AS_MODEL_STRONG(M_CarListView, myListView);

@end

@implementation D_CarListViewController

DEF_FACTORY(D_CarListViewController);
DEF_MODEL(myListView);
DEF_MODEL(carType);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initView];
    
    [self initData];
}

-(void)initView
{
    NSString* tempTitle = @"";
    NSString* tempRightLabel = @"";
    if (self.carType == EB_NewCar) {
        tempTitle = @"优选";
        tempRightLabel = @"筛选";
    }else if (self.carType == EB_SpeciaiCar){
        tempTitle = @"特价";
    }else if (self.carType == EB_RentaiCar){
        tempTitle = @"租购";
    }
    
    [self addCustomNavBar:tempTitle
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:tempRightLabel];
    
    self.myListView = [M_CarListView allocInstanceFrame:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight)];
    self.myListView.carType = self.carType;
    [self.baseView addSubview:self.myListView];
}

-(void)initData
{
    __weak D_CarListViewController* tempSelf = self;
    
    self.myListView.block = ^(M_CarItemModel* model){
        TCarBottomType temptype;
        
        if (model.myCar_Sales) {
            temptype = EB_SpeciaiCar;
        }else if (model.myCar_Lease) {
            temptype = EB_RentaiCar;
        }else if (model.myCar_New) {
            temptype = EB_NewCar;
        }
        [tempSelf toDetailsController:model.myCar_Id withCarType:temptype];
    };
    
    self.myListView.getDataBlock = ^(NSInteger tag){
        if (tag == 0) {
            [tempSelf getData];
        }
    };
    
    [self.myListView getData];
}

-(void)getData
{
//    NSString* tempClType=@"";
//    if (self.carType == EB_NewCar) {
//        tempClType = @"3";
//    }else if (self.carType == EB_SpeciaiCar){
//        tempClType = @"1";
//    }else if (self.carType == EB_RentaiCar){
//        tempClType = @"2";
//    }
    
}

-(void)toDetailsController:(NSString*)carId withCarType:(TCarBottomType)type
{
    D_CarDetailViewController* tempControlelr = [D_CarDetailViewController allocInstance];
    tempControlelr.myCarId = carId;
    tempControlelr.carType = type;
    [self.navigationController pushViewController:tempControlelr animated:YES];
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
