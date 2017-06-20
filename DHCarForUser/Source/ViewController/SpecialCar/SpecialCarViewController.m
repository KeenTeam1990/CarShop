//
//  SpecialCarViewController.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/10/30.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "SpecialCarViewController.h"
#import "M_CarListView.h"
#import "D_CarDetailViewController.h"
#import "TTReqEngine.h"
#import "MobClick.h"
#import "D_DealerViewController.h"
#define textLableTextSize 12

@interface SpecialCarViewController ()

AS_MODEL_STRONG(M_CarListView, myListView);
@property(nonatomic,strong)UILabel *textLable;
@end

@implementation SpecialCarViewController

DEF_FACTORY(SpecialCarViewController);
DEF_MODEL(myListView);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initView];
    
    [self initData];
}

-(void)initView
{
    // 初始化导航条 @"返回箭头"
    [self addCustomNavBar:@"特价"
              withLeftBtn:@"ic_goBack"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:@"经销商"];
    
    self.myListView = [M_CarListView allocInstanceFrame:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight)];
    self.myListView.carType = EB_SpeciaiCar;
    [self.baseView addSubview:self.myListView];
    
    CGFloat textLableWidth=[Unity getLableWidthWithString:@"敬请期待更多的特价车上线~~~~" andFontSize:textLableTextSize];
    _textLable=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-textLableWidth/2-30, SCREEN_HEIGHT/2-15, textLableWidth+100, 30)];
    _textLable.text=@"敬请期待更多的特价车上线~~~~";
    _textLable.hidden = YES;
    [self.baseView addSubview:_textLable];
}

-(void)initData
{   
    __weak SpecialCarViewController* tempSelf = self;
    
    self.myListView.block = ^(M_CarItemModel* model){
        [tempSelf toDetailsController:model.myCar_Id];
    };
    self.myListView.getDataBlock = ^(NSInteger tag){
        if (tag == 0) {
            [tempSelf getData];
        }
    };
    
    [self.myListView getData];
}



-(void)rightBtnPressed:(id)sender
{
    [self.navigationController pushViewController:[D_DealerViewController allocInstance] animated:YES];

}
-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getData
{
    //type：类型 必填 1特价 2租购 3优选
    [TTReqEngine C_Getcar_dealerlistSetCity_id:APPDELEGATE.viewController.myCityModel.myCity_Id
                                 withDealer_id:nil
                                       withLng:nil
                                       withLat:nil
                                      withType:@"1"
                                    withLimitd:self.myListView.myPageModel.limit
                                      withPage:nil
                                       withMax:self.myListView.myPageModel.nextMax
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
                                                 
                                                 [self.myListView.myPageModel toData:tempModel.myPageModel];
                                                 
                                                 [self.myListView updateData:tempModel.myItemArray];
                                                 
                                                 [self judegeLableShowOrNot];
                                                                         }
                                             
                                             if ([DLAppData sharedInstance].currCityChangeToSpecial) {
                                                 
                                                 [DLAppData sharedInstance].currCityChangeToSpecial = NO;
                                                 
                                             }
                                             if([tempModel.myItemArray count]==0)
                                             {
                                                 [self.myListView showPageError:YES withIsError:NO];
                                             }
                                         }
                                         else{
                                             [self.myListView showPageError:YES withIsError:YES];
                                         }
                                         [self.myListView updateListState:success];
                                     }];
}
-(void)judegeLableShowOrNot
{
//    if (self.myListView.myDataArray.count==0) {
//        
//        _textLable.hidden=NO;
//    }
//    else
//    {
//        _textLable.hidden=YES;
//    }
}

-(void)toDetailsController:(NSString*)carid
{
    [MobClick event:@"sale_cardetail"];
    D_CarDetailViewController* tempControlelr = [D_CarDetailViewController allocInstance];
    tempControlelr.myCarId = carid;
    tempControlelr.carType = EB_SpeciaiCar;
    [self.navigationController pushViewController:tempControlelr animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
    
    if ([DLAppData sharedInstance].currCityChangeToSpecial) {
        [self.myListView getData];
    }else{
        if ([self.myListView.myDataArray count] == 0) {
            [self.myListView getData];
        }
    }
    [MobClick event:@"main_sale"];
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
