//
//  D_CarInsuranceViewController.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_CarInsuranceViewController.h"
#import "M_CarInsuranceHeaderView.h"
#import "D_CarInsuranceRecordViewController.h"
#import "TTReqEngine.h"
#import "DLPickerView.h"
#import "M_CommpanyListModel.h"

@interface D_CarInsuranceViewController ()<DLPickerViewDelegate>

AS_MODEL_STRONG(M_CarInsuranceHeaderView, myHeaderView);
AS_MODEL_STRONG(DLPickerView, myPickerView);

AS_MODEL_STRONG(M_CommpanyListModel, myListModel);
AS_MODEL_STRONG(M_CommpanyItemModel, myItemMode);

@end

@implementation D_CarInsuranceViewController

DEF_FACTORY(D_CarInsuranceViewController);
DEF_MODEL(myHeaderView);
DEF_MODEL(myPickerView);
DEF_MODEL(myListModel);
DEF_MODEL(myItemMode);

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
    tempFrame.size.height = self.baseView.frame.size.height - NavigationBarHeight-keyRect.size.height;
    self.myTableView.frame = tempFrame;
    
    [self.myTableView scrollRectToVisible:[self.myHeaderView getCurrFieldRect:self.myTableView] animated:YES];
}

-(void)notifyhideKeyword
{
    CGRect tempFrame = self.myTableView.frame;
    tempFrame.size.height = self.baseView.frame.size.height - NavigationBarHeight;
    self.myTableView.frame = tempFrame;
}

-(void)initView
{
    [self addCustomNavBar:@"保险政策"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:@"政策记录"];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.bounds.size.width, self.baseView.bounds.size.height-NavigationBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    
    self.myHeaderView = [M_CarInsuranceHeaderView allocInstanceFrame:CGRectMake(0, 0, self.baseView.frame.size.width, 300)];
    
    self.myTableView.tableHeaderView = self.myHeaderView;
}

-(void)initData
{
    __weak D_CarInsuranceViewController* tempSelf = self;
    self.myHeaderView.block = ^(NSInteger tag,id data){
        //0 提交
        //1 选择
        switch (tag) {
            case 0:
                {
                    [tempSelf sureBtn:data];
                }
                break;
            case 1:
                {
                    [tempSelf baseSingleTap];
                    [tempSelf selete:data];
                }
                break;
                
            default:
                break;
        }
    };
    
    [self getCommpany];
}

-(void)sureBtn:(id)data
{
    NSDictionary* tempDic = (NSDictionary*)data;
    if (tempDic!=nil) {
        
        if ([[DLAppData sharedInstance].myUserKey notEmpty] && [DLAppData sharedInstance].myUserName) {
            NSString* templabel1 = [tempDic hasItemAndBack:@"label1"];
            NSString* templabel2 = [tempDic hasItemAndBack:@"label2"];
            
            if ([templabel1  empty]) {
                [SVProgressHUD showErrorWithStatus:@"请输入驾驶证号码"];
                return;
            }
            if ([templabel2  empty]) {
                [SVProgressHUD showErrorWithStatus:@"请输入车架号"];
                return;
            }
            
            
        }
        else{
            [APPDELEGATE.viewController openLogin:self];
        }
    }
}

-(void)selete:(NSString*)data
{
    [self seleteCarItem:self.myListModel withSeleteStr:data];
}

-(void)getCommpany
{
//    [TTReqEngine PostInsurance_Commpany_ListwithBlock:^(BOOL success, id dataModel) {
//        if (success) {
//            self.myListModel = (M_CommpanyListModel*)dataModel;
//            
//            if ([self.myListModel.myItemArray count]>0) {
//                M_CommpanyItemModel* tempItem = [self.myListModel.myItemArray objectAtIndex:0];
//                if (tempItem!=nil) {
//                    self.myItemMode = tempItem;
//                    [self.myHeaderView updateData:tempItem.insurance_commpany_name];
//                }
//            }
//        }
//    }];
}

-(void)seleteCarItem:(M_CommpanyListModel*)data withSeleteStr:(NSString*)content
{
    int defaultIndex = 0;
    
    DLPickerDataSource* tempData = [DLPickerDataSource allocInstance];
    
    tempData.pickComponentsCount = 1;
    
    for (int i=0; i<[data.myItemArray count]; i++) {
        
        M_CommpanyItemModel* tempItem = [data.myItemArray objectAtIndex:i];
        if (tempItem!=nil) {
            
            if ([tempItem.insurance_commpany_name notEmpty]) {
                
                NSMutableDictionary* tempdic = [NSMutableDictionary dictionary];
                [tempdic setObject:tempItem.insurance_commpany_name forKey:PopText];
                [tempData.firstArray addObject:tempdic];
                
                if ([tempItem.insurance_commpany_name isEqualToString:content]) {
                    defaultIndex = i;
                }
            }
        }
    }
    
    NSMutableDictionary* tempDefaultdic = [NSMutableDictionary dictionary];
    [tempDefaultdic setObject:[NSNumber numberWithInt:defaultIndex] forKey:KPICKER_FIRST];
    
    [self showPickerView:@"选择保险公司" withData:tempData withDefault:tempDefaultdic withTag:1001];
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
    [self.myHeaderView updateData:seleteValue];
    
    if ([self.myListModel.myItemArray count]>0) {
        M_CommpanyItemModel* tempItem = [self.myListModel.myItemArray objectAtIndex:self.myPickerView.myDataSource.seleteFirstIndex];
        if (tempItem!=nil) {
            
            self.myItemMode = tempItem;
            
            [self.myHeaderView updateData:tempItem.insurance_commpany_name];
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
        [MobClick event:@"main_insuranceList"];
    [self.navigationController pushViewController:[D_CarInsuranceRecordViewController allocInstance] animated:YES];
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
