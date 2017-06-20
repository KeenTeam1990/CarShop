//
//  D_ShaixuanViewController.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_ShaixuanViewController.h"
#import "M_ShaixuanLeftView.h"
#import "M_ShaixuanTableView.h"
#import "M_ShaixuanLeftItemCell.h"
#import "TTReqEngine.h"
#import "M_SubBrandListModel.h"
#import "M_BrandListModel.h"
#import "M_CarPriceListModel.h"
#import "M_CarTypeListModel.h"
#import "M_CarYearListModel.h"

@interface D_ShaixuanViewController ()

AS_MODEL_STRONG(M_ShaixuanLeftView, myLeftView);
AS_MODEL_STRONG(M_ShaixuanTableView, mySTableView);

AS_MODEL_STRONG(M_CarPriceListModel, myPriceModel);
AS_MODEL_STRONG(M_CarTypeListModel, myTypeModel);
AS_MODEL_STRONG(M_CarYearListModel, myYearModel);
AS_MODEL_STRONG(M_SubBrandListModel, mySubBrandModel);
AS_MODEL_STRONG(M_BrandListModel, myBrandModel);

AS_MODEL_STRONG(M_BrandBigItemModel, myBigBrandItemModel);
AS_MODEL_STRONG(M_BrandItemModel, myBrandItemModel);
AS_MODEL_STRONG(M_SubBrandItemModel, mySubBrandItemModel);
AS_MODEL_STRONG(M_CarYearItemModel, myYearItemModel);
AS_MODEL_STRONG(M_CarTypeItemModel, myTypeItemModel);
AS_MODEL_STRONG(M_CarPriceItemModel, myPriceItemModel);

@end

@implementation D_ShaixuanViewController

DEF_FACTORY(D_ShaixuanViewController);

DEF_MODEL(myLeftView);
DEF_MODEL(mySTableView);

DEF_MODEL(myBrandModel);
DEF_MODEL(myPriceModel);
DEF_MODEL(mySubBrandModel);
DEF_MODEL(myTypeModel);
DEF_MODEL(myYearModel);
DEF_MODEL(myBigBrandItemModel);
DEF_MODEL(myPriceItemModel);
DEF_MODEL(mySubBrandItemModel);
DEF_MODEL(myTypeItemModel);
DEF_MODEL(myYearItemModel);
DEF_MODEL(myBrandItemModel);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initView];
    
    [self initData];
}

-(void)initView
{
    // 初始化导航条
    [self addCustomNavBar:@"筛选"
              withLeftBtn:@""
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:@"确定"];
    
    [self initButton:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, 50)];
    
    self.myLeftView = [M_ShaixuanLeftView allocInstanceFrame:CGRectMake(0, NavigationBarHeight+50, 80, self.baseView.frame.size.height-NavigationBarHeight-50)];
    [self.baseView addSubview:self.myLeftView];
    
    self.mySTableView = [M_ShaixuanTableView allocInstanceFrame:CGRectMake(80, NavigationBarHeight+50, self.baseView.frame.size.width-80, self.baseView.frame.size.height-NavigationBarHeight-50)];
    [self.mySTableView setBackgroundColor:[UIColor redColor]];
    [self.baseView addSubview:self.mySTableView];
}

-(void)initButton:(CGRect)frame
{
    UIImage* tempBtnBg = [UIImage imageNamed:@"登录.png"];
    UIImage* tempBtn_HBg = [UIImage imageNamed:@"登录按下.png"];
    
    UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tempBtn addTarget:self action:@selector(buttonBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [tempBtn setBackgroundImage:[tempBtnBg stretchableImageWithLeftCapWidth:tempBtnBg.size.width/2 topCapHeight:tempBtnBg.size.height/2] forState:UIControlStateNormal];
    [tempBtn setBackgroundImage:[tempBtn_HBg stretchableImageWithLeftCapWidth:tempBtn_HBg.size.width/2 topCapHeight:tempBtn_HBg.size.height/2] forState:UIControlStateHighlighted];
    [tempBtn setTitle:@"一键清除筛选条件" forState:UIControlStateNormal];
    [tempBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    tempBtn.frame = CGRectMake(20, frame.origin.y+(frame.size.height-40)/2, frame.size.width-40, 40);

    [self.baseView addSubview:tempBtn];
}

-(void)buttonBtnPressed:(id)sender
{
    self.myYearItemModel = nil;
    self.myTypeItemModel = nil;
    self.mySubBrandItemModel = nil;
    self.myPriceItemModel = nil;
    self.myBigBrandItemModel = nil;
    self.myBrandItemModel = nil;
    
    for (int i=0; i<[self.myBrandModel.myBigBrandArray count]; i++) {
        M_BrandBigItemModel* tempItem = [self.myBrandModel.myBigBrandArray objectAtIndex:i];
        if (tempItem!=nil) {
            tempItem.seleted = NO;
            
            for (int j=0; j<[tempItem.myBrandArray count]; j++) {
                M_BrandItemModel* tempItem2 = [tempItem.myBrandArray objectAtIndex:j];
                if (tempItem2!=nil) {
                    tempItem2.seleted = NO;
                }
            }
        }
    }
    
    for (int i=0; i<[self.mySubBrandModel.myItemArray count]; i++) {
        M_SubBrandItemModel* tempItem = [self.mySubBrandModel.myItemArray objectAtIndex:i];
        if (tempItem!=nil) {
            tempItem.seleted = NO;
        }
    }
    for (int i=0; i<[self.myYearModel.myItemArray count]; i++) {
        M_CarYearItemModel* tempItem = [self.myYearModel.myItemArray objectAtIndex:i];
        if (tempItem!=nil) {
            tempItem.seleted = NO;
        }
    }
    for (int i=0; i<[self.myTypeModel.myItemArray count]; i++) {
        M_CarTypeItemModel* tempItem = [self.myTypeModel.myItemArray objectAtIndex:i];
        if (tempItem!=nil) {
            tempItem.seleted = NO;
        }
    }
    for (int i=0; i<[self.myPriceModel.myItemArray count]; i++) {
        M_CarPriceItemModel* tempItem = [self.myPriceModel.myItemArray objectAtIndex:i];
        if (tempItem!=nil) {
            tempItem.seleted = NO;
        }
    }
    
    [self.myLeftView updateTabIndex:0];
    
    [self updateRightCount];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
}

-(void)initData
{
    NSMutableArray* tempNameArray = [NSMutableArray arrayWithObjects:@"品牌",@"车系",@"车型",@"年代",@"类型",@"价格", nil];
    
    NSMutableArray* tempArray = [NSMutableArray array];
    for (int i=0; i<6; i++) {
        M_ShaiXuanLeftItemModel* tempItem = [M_ShaiXuanLeftItemModel allocInstance];
        tempItem.myTitle = [tempNameArray objectAtIndex:i];
        if (i == 0) {
            tempItem.currSeleted = YES;
        }
        [tempArray addObject:tempItem];
    }
    
    [self.myLeftView updateData:tempArray];
    
    __weak D_ShaixuanViewController* tempSelf = self;
    self.myLeftView.block = ^(NSInteger tag){
        [tempSelf seleteLeftIndex:tag];
    };
    
    [self updateRightCount];
    
    [self getBrandData];
    [self getCarTypeData];
    [self getCarPriceData];
    
    self.mySTableView.block = ^(NSInteger tabIndex,id data){
        switch (tabIndex) {
            case 0:
                {
                    M_BrandBigItemModel* tempBigBrandItemModel = (M_BrandBigItemModel*)data;
                    if (tempBigBrandItemModel.seleted) {
                        tempSelf.myBigBrandItemModel = tempBigBrandItemModel;
                    }else{
                        tempSelf.myBigBrandItemModel = nil;
                    }
                }
                break;
            case 1:
                {
                    M_BrandItemModel* tempBrandItemModel = (M_BrandItemModel*)data;
                    if (tempBrandItemModel.seleted) {
                        tempSelf.myBrandItemModel = tempBrandItemModel;
                    }else{
                        tempSelf.myBrandItemModel = nil;
                    }
                    if (tempSelf.myBigBrandItemModel!=nil) {
                        [tempSelf getSubBrandData:tempSelf.myBigBrandItemModel.myBigBrand_id];
                    }
                }
                break;
            case 2:
                {
                    M_SubBrandItemModel* tempSubBrandItemModel = (M_SubBrandItemModel*)data;
                    if (tempSubBrandItemModel.seleted) {
                        tempSelf.mySubBrandItemModel = tempSubBrandItemModel;
                    }else{
                        tempSelf.mySubBrandItemModel = nil;
                    }
                    if (tempSelf.mySubBrandItemModel!=nil) {
                        [tempSelf getCarYearData:tempSelf.mySubBrandItemModel.subbrand_id];
                    }
                }
                break;
            case 3:
                {
                    M_CarYearItemModel* tempYearItemModel = (M_CarYearItemModel*)data;
                    if (tempYearItemModel.seleted) {
                        tempSelf.myYearItemModel = tempYearItemModel;
                    }else{
                        tempSelf.myYearItemModel = nil;
                    }
                }
                break;
            case 4:
                {
                    M_CarTypeItemModel* tempTypeItemModel = (M_CarTypeItemModel*)data;
                    if (tempTypeItemModel.seleted) {
                        tempSelf.myTypeItemModel = tempTypeItemModel;
                    }else{
                        tempSelf.myTypeItemModel = nil;
                    }
                }
                break;
            case 5:
                {
                    M_CarPriceItemModel* tempPriceItemModel = (M_CarPriceItemModel*)data;
                    if (tempPriceItemModel.seleted) {
                        tempSelf.myPriceItemModel = tempPriceItemModel;
                    }else{
                        tempSelf.myPriceItemModel = nil;
                    }
                }
                break;
            default:
                break;
        }
        [tempSelf updateRightCount];
    };
}

-(void)updateRightCount
{
    NSInteger count = 0;
    
    if (self.myPriceItemModel!=nil) {
        count++;
    }
    if (self.myBrandItemModel!=nil) {
        count++;
    }
    if (self.myTypeItemModel!=nil) {
        count++;
    }
    if (self.myBigBrandItemModel!=nil) {
        count++;
    }
    if (self.mySubBrandItemModel!=nil) {
        count++;
    }
    if (self.myYearItemModel!=nil) {
        count++;
    }
    
    if (count>0) {
        [self.customNavBar updateRightBtn:[NSString stringWithFormat:@"确定(%d)",count] withImage:nil];
    }else{
        [self.customNavBar updateRightBtn:@"确定" withImage:nil];
    }
}

-(void)getBrandData
{
    [TTReqEngine PostBigbrand_List:@"" withBlock:^(BOOL success, id dataModel) {
        if (success) {
            self.myBrandModel = (M_BrandListModel*)dataModel;
            
            if (self.myBrandModel!=nil) {
                if ([self.myBrandModel.myBigBrandArray count]>0) {
                    
                    [self.mySTableView updateData:self.myBrandModel.myBigBrandArray withType:0];
                    
                    if (self.myBigBrandItemModel!=nil) {
                        for (int i=0; i<[self.myBrandModel.myBigBrandArray count]; i++) {
                            M_BrandBigItemModel* tempItem = [self.myBrandModel.myBigBrandArray objectAtIndex:i];
                            if (tempItem!=nil) {
                                if ([self.myBigBrandItemModel.myBigBrand_id isEqualToString:tempItem.myBigBrand_id]) {
                                    tempItem.seleted = YES;
                                    
                                    if (self.myBrandItemModel!=nil) {
                                        for (int j=0; j<[tempItem.myBrandArray count]; j++) {
                                            M_BrandItemModel* tempItem2 = [tempItem.myBrandArray objectAtIndex:j];
                                            if (tempItem2!=nil) {
                                                
                                                if ([tempItem2.myBrand_id isEqualToString:self.myBrandItemModel.myBrand_id]) {
                                                    tempItem2.seleted = YES;
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                    break;
                                }
                            }
                        }
                    }
                }
            }
        }
    }];
}

-(void)getSubBrandData:(NSString*)bigBrandId
{
    [TTReqEngine PostSubbrand_List:bigBrandId
                      withDealerId:nil
                      withStartNum:@"0"
                       withPageNum:@"100000"
                         withBlock:^(BOOL success, id dataModel) {
                             if (success) {
                                 self.mySubBrandModel = (M_SubBrandListModel*)dataModel;
                                 
                                 if (self.mySubBrandItemModel!=nil) {
                                     for (int i=0; i<[self.mySubBrandModel.myItemArray count]; i++) {
                                         M_SubBrandItemModel* tempItem = [self.mySubBrandModel.myItemArray objectAtIndex:i];
                                         if (tempItem!=nil) {
                                             if ([tempItem.subbrand_id isEqualToString:self.mySubBrandItemModel.subbrand_id]) {
                                                 tempItem.seleted = YES;
                                                 break;
                                             }
                                         }
                                     }
                                 }
                             }
                       }];
}

-(void)getCarYearData:(NSString*)subBrandId
{
    [TTReqEngine PostCar_Year:subBrandId
                 withDealerId:nil
                    withBlock:^(BOOL success, id dataModel) {
                        if (success) {
                            self.myYearModel = (M_CarYearListModel*)dataModel;
                        
                            if (self.myYearItemModel!=nil) {
                                
                                for (int i=0; i<[self.myYearModel.myItemArray count]; i++) {
                                    M_CarYearItemModel* tempItem = [self.myYearModel.myItemArray objectAtIndex:i];
                                    if (tempItem!=nil) {
                                        if ([tempItem.myYear isEqualToString:self.myYearItemModel.myYear]) {
                                            tempItem.seleted = YES;
                                            break;
                                        }
                                    }
                                }
                            }
                            
                        }
                    }];
}

-(void)getCarTypeData
{
    [TTReqEngine PostCar_TypewithBlock:^(BOOL success, id dataModel) {
        if (success) {
            self.myTypeModel = (M_CarTypeListModel*)dataModel;
            
            if (self.myTypeItemModel!=nil) {
                for (int i=0; i<[self.myTypeModel.myItemArray count]; i++) {
                    M_CarTypeItemModel* tempItem = [self.myTypeModel.myItemArray objectAtIndex:i];
                    if (tempItem!=nil) {
                        if ([tempItem.myCarType isEqualToString:self.myTypeItemModel.myCarType]) {
                            tempItem.seleted = YES;
                            break;
                        }
                    }
                }
            }
        }
    }];
}

-(void)getCarPriceData
{
    [TTReqEngine PostCar_PricewithBlock:^(BOOL success, id dataModel) {
        if (success) {
            self.myPriceModel = (M_CarPriceListModel*)dataModel;
            if (self.myPriceItemModel!=nil) {
                for (int i=0; i<[self.myPriceModel.myItemArray count]; i++) {
                    M_CarPriceItemModel* tempItem = [self.myPriceModel.myItemArray objectAtIndex:i];
                    if (tempItem!=nil) {
                        tempItem.seleted = NO;
                    }
                }
            }
        }
    }];
}

-(void)seleteLeftIndex:(NSInteger)tag
{
    switch (tag) {
        case 0:
            [self.mySTableView updateData:self.myBrandModel.myBigBrandArray withType:tag];
            break;
        case 1:
            {
                if (self.myBigBrandItemModel == nil) {
                    [SVProgressHUD showErrorWithStatus:@"请选择品牌"];
                    [self.myLeftView updateTabIndex:0];
                }else{
                    [self.mySTableView updateData:self.myBigBrandItemModel.myBrandArray withType:tag];
                }
            }
            break;
        case 2:
            {
                if (self.myBigBrandItemModel == nil) {
                    [SVProgressHUD showErrorWithStatus:@"请选择品牌"];
                     [self.myLeftView updateTabIndex:0];
                }else{
                    if (self.myBrandItemModel == nil) {
                        [SVProgressHUD showErrorWithStatus:@"请选择车系"];
                         [self.myLeftView updateTabIndex:1];
                    }else{
                        [self.mySTableView updateData:self.mySubBrandModel.myItemArray withType:tag];
                    }
                }
            }
            break;
        case 3:
            {
                if (self.myBigBrandItemModel == nil) {
                    [SVProgressHUD showErrorWithStatus:@"请选择品牌"];
                     [self.myLeftView updateTabIndex:0];
                }else{
                    if (self.myBrandItemModel == nil) {
                        [SVProgressHUD showErrorWithStatus:@"请选择车系"];
                         [self.myLeftView updateTabIndex:1];
                    }else{
                        if (self.mySubBrandItemModel == nil) {
                            [SVProgressHUD showErrorWithStatus:@"请选择车型"];
                             [self.myLeftView updateTabIndex:2];
                        }else{
                            [self.mySTableView updateData:self.myYearModel.myItemArray withType:tag];
                        }
                    }
                }
            }
            break;
        case 4:
            [self.mySTableView updateData:self.myTypeModel.myItemArray withType:tag];
            break;
        case 5:
            [self.mySTableView updateData:self.myPriceModel.myItemArray withType:tag];
            break;
        default:
            break;
    }
}

-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnPressed:(id)sender
{
    NSMutableDictionary* tempDic = [NSMutableDictionary dictionary];
    
    if (self.myBigBrandItemModel != nil) {
        [tempDic setObject:self.myBigBrandItemModel forKey:@"bigbrand"];
    }
    
    if (self.myBrandItemModel != nil) {
        [tempDic setObject:self.myBrandItemModel forKey:@"brand"];
    }
    
    if (self.mySubBrandItemModel != nil) {
        [tempDic setObject:self.mySubBrandItemModel forKey:@"subbrand"];
    }
    
    if (self.myPriceItemModel != nil) {
        [tempDic setObject:self.myPriceItemModel forKey:@"price"];
    }
    
    if (self.myYearItemModel != nil) {
        [tempDic setObject:self.myYearItemModel forKey:@"year"];
    }
    
    if (self.myTypeItemModel != nil) {
        [tempDic setObject:self.myTypeItemModel forKey:@"type"];
    }
    
    if ([tempDic.allKeys count]>0) {
        if (self.block!=nil) {
            self.block(tempDic);
        }
    }else{
        if (self.block!=nil) {
            self.block(nil);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)updateDic:(NSMutableDictionary*)dataDic
{
    if (dataDic!=nil) {
        self.myBigBrandItemModel = [dataDic hasItemAndBack:@"bigbrand"];
        self.myBrandItemModel = [dataDic hasItemAndBack:@"brand"];
        self.mySubBrandItemModel = [dataDic hasItemAndBack:@"subbrand"];
        self.myYearItemModel = [dataDic hasItemAndBack:@"year"];
        self.myTypeItemModel = [dataDic hasItemAndBack:@"type"];
        self.myPriceItemModel = [dataDic hasItemAndBack:@"price"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
