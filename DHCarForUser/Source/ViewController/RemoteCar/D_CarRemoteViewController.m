//
//  D_CarRemoteViewController.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_CarRemoteViewController.h"
#import "M_CarRemoteHeaderView.h"
#import "D_CarRemoteRecordViewController.h"
#import "TTReqEngine.h"
#import "DLPickerView.h"
#import "M_CarRemoteListModel.h"
#import "M_CarTypeListModel.h"
#import "M_CarPersonListModel.h"
#import "DLDateOrTimePickerView.h"
#import "M_CityListModel.h"
#import "D_SeleteCityViewController.h"

@interface D_CarRemoteViewController ()<DLPickerViewDelegate>

AS_MODEL_STRONG(M_CarRemoteHeaderView, myHeaderView);

AS_MODEL_STRONG(DLPickerView, myPickerView);

AS_MODEL_STRONG(M_CarRemoteListModel, myListModel);
AS_MODEL_STRONG(M_CarRemoteItemModel, myItemMode);

AS_MODEL_STRONG(M_CarTypeListModel, myTypeListModel);
AS_MODEL_STRONG(M_CarPersonListModel, myPersonListModel);

AS_MODEL_STRONG(DLDateOrTimePickerView, myDateOrTimePickerView);

AS_MODEL_STRONG(M_CityItemModel, myCurrCityModel);
AS_MODEL_STRONG(M_CarPersonItemModel, myCurrPersonModel);
AS_MODEL_STRONG(M_CarTypeItemModel, myCurrTypeModel);
AS_MODEL_STRONG(NSString, myDateStr);


@end

@implementation D_CarRemoteViewController

DEF_FACTORY(D_CarRemoteViewController);
DEF_MODEL(myHeaderView);
DEF_MODEL(myPickerView);
DEF_MODEL(myListModel);
DEF_MODEL(myItemMode);

DEF_MODEL(myPersonListModel);
DEF_MODEL(myTypeListModel);

DEF_MODEL(myDateOrTimePickerView);

DEF_MODEL(myDateStr);
DEF_MODEL(myCurrTypeModel);
DEF_MODEL(myCurrPersonModel);
DEF_MODEL(myCurrCityModel);

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    
    [self initData];
}

-(void)initView
{
    [self addCustomNavBar:@"异地用车"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:@"用车记录"];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.bounds.size.width, self.baseView.bounds.size.height-NavigationBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    
    self.myHeaderView = [M_CarRemoteHeaderView allocInstanceFrame:CGRectMake(0, 0, self.baseView.frame.size.width, 300)];
    self.myTableView.tableHeaderView = self.myHeaderView;
}

-(void)initData
{
    [self getCarType];
    
    self.myDateStr = [[NSDate date] dateToString];
    [self.myHeaderView updateData:self.myDateStr withTag:1];
    
    if ([APPDELEGATE.viewController.myCityModel.myCity_Id notEmpty]) {
        
        self.myCurrCityModel = APPDELEGATE.viewController.myCityModel;
        
        [self.myHeaderView updateData:self.myCurrCityModel.myCity_Name withTag:0];
    }
    
    __weak D_CarRemoteViewController* tempSelf = self;
    self.myHeaderView.block = ^(NSInteger tag,id data){
        if (tag == 0) {
            
            D_SeleteCityViewController* tempController = [D_SeleteCityViewController allocInstance];
            
            [tempSelf.navigationController pushViewController:tempController animated:YES];
            
            tempController.block = ^(M_CityItemModel* model){
                tempSelf.myCurrCityModel = model;
                
                [tempSelf.myHeaderView updateData:model.myCity_Name withTag:0];
            };
            
        }else if (tag == 1){
            [tempSelf showDateOrTimeView:@"选择日期" withDefault:data withTag:1009];
        }else if (tag == 2){
            [tempSelf seleteCarTypeItem:tempSelf.myTypeListModel withSeleteStr:data];
        }else if (tag == 3){
            [tempSelf seleteCarPersonItem:tempSelf.myPersonListModel withSeleteStr:data];
        }else if (tag == 4){
            [tempSelf sure];
        }
    };
}

-(void)sure
{
    if ([[DLAppData sharedInstance].myUserKey notEmpty]&& [DLAppData sharedInstance].myUserName) {
//        [TTReqEngine PostRental_Car_Add:self.myCurrCityModel.myCity_Code
//                           withMakeTime:self.myDateStr
//                      withRentalCarType:self.myCurrTypeModel.myCarType
//                    withRentalCarPerson:self.myCurrPersonModel.myCarPersonId
//                              withBlock:^(BOOL success, id dataModel) {
//                                  if (success) {
//                                      [SVProgressHUD showSuccessWithStatus:@"提交成功！"];
//                                      [self.navigationController popViewControllerAnimated:YES];
//                                  }
//                              }];
    }
    else{
        [APPDELEGATE.viewController openLogin:self];
    }
}

-(void)getCarType
{
//    [TTReqEngine PostCar_TypewithBlock:^(BOOL success, id dataModel) {
//        if (success) {
//            self.myTypeListModel = (M_CarTypeListModel*)dataModel;
//            
//            if ([self.myTypeListModel.myItemArray count]>0) {
//                M_CarTypeItemModel* tempItem = [self.myTypeListModel.myItemArray objectAtIndex:0];
//                if (tempItem!=nil) {
//                    self.myCurrTypeModel = tempItem;
//                    [self.myHeaderView updateData:tempItem.myCarTypeName withTag:2];
//                }
//            }
//            
//            [self getCarPerson];
//        }
//    }];
}

-(void)getCarPerson
{
//    [TTReqEngine PostCar_PersonwithBlock:^(BOOL success, id dataModel) {
//        if (success) {
//            self.myPersonListModel = (M_CarPersonListModel*)dataModel;
//            
//            if ([self.myPersonListModel.myItemArray count]>0) {
//                M_CarPersonItemModel* tempItem = [self.myPersonListModel.myItemArray objectAtIndex:0];
//                if (tempItem!=nil) {
//                    self.myCurrPersonModel = tempItem;
//                    [self.myHeaderView updateData:tempItem.myCarPersonName withTag:3];
//                }
//            }
//        }
//    }];
}

-(void)showDateOrTimeView:(NSString*)title withDefault:(NSString*)time withTag:(NSInteger)tag
{
    self.myDateOrTimePickerView = [DLDateOrTimePickerView allocInstanceFrame:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight)];
    self.myDateOrTimePickerView.tag = tag;
    
    [self.myDateOrTimePickerView updateViewData:title withData:[time stringToDate] withMode:YES];
    
    [self.myDateOrTimePickerView setMaxTime:nil withMinTime:[[NSDate systemTime] stringToDate]];
    
    [self.baseView addSubview:self.myDateOrTimePickerView];
    
    __weak D_CarRemoteViewController* tempSelf = self;
    self.myDateOrTimePickerView.block = ^(int tag,id data){
        if (tag == 1) {
            tempSelf.myDateStr = data;
            [tempSelf.myHeaderView  updateData:data withTag:1];
        }else if (tag == 0){
            [tempSelf.myDateOrTimePickerView removeFromSuperview];
            tempSelf.myDateOrTimePickerView = nil;
        }
    };
    
    [self.myDateOrTimePickerView startAnimation];
}


-(void)seleteCarTypeItem:(M_CarTypeListModel*)data withSeleteStr:(NSString*)content
{
    int defaultIndex = 0;
    
    DLPickerDataSource* tempData = [DLPickerDataSource allocInstance];
    
    tempData.pickComponentsCount = 1;
    
    for (int i=0; i<[data.myItemArray count]; i++) {
        
        M_CarTypeItemModel* tempItem = [data.myItemArray objectAtIndex:i];
        if (tempItem!=nil) {
            
            if ([tempItem.myCarTypeName notEmpty]) {
                
                NSMutableDictionary* tempdic = [NSMutableDictionary dictionary];
                [tempdic setObject:tempItem.myCarTypeName forKey:PopText];
                [tempData.firstArray addObject:tempdic];
                
                if ([tempItem.myCarTypeName isEqualToString:content]) {
                    defaultIndex = i;
                }
            }
        }
    }
    
    NSMutableDictionary* tempDefaultdic = [NSMutableDictionary dictionary];
    [tempDefaultdic setObject:[NSNumber numberWithInt:defaultIndex] forKey:KPICKER_FIRST];
    
    [self showPickerView:@"选择车辆类型" withData:tempData withDefault:tempDefaultdic withTag:1001];
}


-(void)seleteCarPersonItem:(M_CarPersonListModel*)data withSeleteStr:(NSString*)content
{
    int defaultIndex = 0;
    
    DLPickerDataSource* tempData = [DLPickerDataSource allocInstance];
    
    tempData.pickComponentsCount = 1;
    
    for (int i=0; i<[data.myItemArray count]; i++) {
        
        M_CarPersonItemModel* tempItem = [data.myItemArray objectAtIndex:i];
        if (tempItem!=nil) {
            
            if ([tempItem.myCarPersonName notEmpty]) {
                
                NSMutableDictionary* tempdic = [NSMutableDictionary dictionary];
                [tempdic setObject:tempItem.myCarPersonName forKey:PopText];
                [tempData.firstArray addObject:tempdic];
                
                if ([tempItem.myCarPersonName isEqualToString:content]) {
                    defaultIndex = i;
                }
            }
        }
    }
    
    NSMutableDictionary* tempDefaultdic = [NSMutableDictionary dictionary];
    [tempDefaultdic setObject:[NSNumber numberWithInt:defaultIndex] forKey:KPICKER_FIRST];
    
    [self showPickerView:@"选择用车人数" withData:tempData withDefault:tempDefaultdic withTag:1002];
}

-(void)showPickerView:(NSString*)title withData:(DLPickerDataSource*)data withDefault:(NSDictionary*)dic withTag:(NSInteger)tag
{
    self.myPickerView = [[DLPickerView alloc]initWithFrame:CGRectMake(0,NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight)];
    self.myPickerView.delegate = self;
    [self.myPickerView updateViewData:title withData:data withDefault:dic];
    self.myPickerView.tag = tag;
    [self.baseView addSubview:self.myPickerView];
    
    [self.myPickerView startAnimation];
}

#pragma DLPickerViewDelegate

-(void)pickerSureBtnPressed:(NSString *)seleteValue
{
    if (self.myPickerView.tag == 1001) {
        [self.myHeaderView updateData:seleteValue withTag:2];
        
        if ([self.myTypeListModel.myItemArray count]>0) {
            M_CarTypeItemModel* tempItem = [self.myTypeListModel.myItemArray objectAtIndex:self.myPickerView.myDataSource.seleteFirstIndex];
            if (tempItem!=nil) {
                self.myCurrTypeModel = tempItem;
            }
        }
    }else if (self.myPickerView.tag == 1002) {
        [self.myHeaderView updateData:seleteValue withTag:3];
        
        if ([self.myPersonListModel.myItemArray count]>0) {
            M_CarPersonItemModel* tempItem = [self.myPersonListModel.myItemArray objectAtIndex:self.myPickerView.myDataSource.seleteFirstIndex];
            if (tempItem!=nil) {
                self.myCurrPersonModel = tempItem;
            }
        }
    }
}

-(void)pickerCancelBtnPressed
{
    [self.myPickerView removeFromSuperview];
    self.myPickerView = nil;
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

-(void)rightBtnPressed:(id)sender
{
    if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
        [self.navigationController pushViewController:[D_CarRemoteRecordViewController allocInstance] animated:YES];
    }else{
        [APPDELEGATE.viewController openLogin:self];
    }
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
