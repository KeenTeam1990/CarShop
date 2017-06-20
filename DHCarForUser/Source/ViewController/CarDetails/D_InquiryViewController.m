//
//  D_InquiryViewController.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_InquiryViewController.h"
#import "TTReqEngine.h"
#import "M_ReserveHeaderView.h"
#import "M_SeleteColorItemCell.h"
#import "M_CarDistributorItemCell.h"
#import "M_SeleteColorView.h"
#import "D_InquiryFinishViewController.h"
#import "M_MyOrderModel.h"

@interface D_InquiryViewController ()

AS_MODEL_STRONG(M_ReserveHeaderView, myHeaderView);

AS_MODEL_STRONG(M_CityItemModel, myCurrCityModel);

AS_MODEL_STRONG(NSMutableArray, mySeleteDataArray);

AS_MODEL_STRONG(UIButton, mySureBtn);

AS_MODEL_STRONG(M_SeleteColorView, myColorView);
AS_MODEL_STRONG(M_CarColorItemModel, myColorItemModel);

@end

@implementation D_InquiryViewController

DEF_FACTORY(D_InquiryViewController);

DEF_MODEL(myItemModel);
DEF_MODEL(myHeaderView);
DEF_MODEL(carType);
DEF_MODEL(myDealerArray);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.mySeleteDataArray = [NSMutableArray allocInstance];

    [self initView];
    
    [self initData];
    
    [self addTapToBaseView];
}

-(void)initView
{
    // 初始化导航条
    [self addCustomNavBar:@"询价"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight-50) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    
    self.myHeaderView = [M_ReserveHeaderView allocInstanceFrame:CGRectMake(0, 0, self.baseView.frame.size.width, 120)];
    self.myTableView.tableHeaderView = self.myHeaderView;
    
    self.mySureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mySureBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor redColor];
                                             style.cornerRedius=5;);
    [self.mySureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.mySureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.mySureBtn addTarget:self action:@selector(sureBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.mySureBtn.frame = CGRectMake(10, self.baseView.frame.size.height-50, self.baseView.frame.size.width-20, 40);
    [self.baseView addSubview:self.mySureBtn];
    
    self.myColorView = [M_SeleteColorView allocInstanceFrame:CGRectMake(self.baseView.frame.size.width, 0, self.baseView.frame.size.width, self.baseView.frame.size.height)];
    self.myColorView.hidden = YES;
    [self.baseView addSubview:self.myColorView];
}

-(void)sureBtnPressed:(id)sender
{
    if (self.myColorItemModel == nil) {
        [SVProgressHUD showErrorWithStatus:@"请选择颜色"];
        return;
    }
    
    NSString* tempStr = @"";
    
    for (int i=0; i<[self.myDataArray count]; i++) {
        M_DealerItemModel* tempItem = [self.myDataArray objectAtIndex:i];
        if (tempItem!=nil) {
            if (tempStr.length == 0) {
                tempStr = tempItem.dealer_id;
            }else{
                tempStr = [NSString stringWithFormat:@"%@,%@",tempStr,tempItem.dealer_id];
            }
        }
    }
    
    if (tempStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择经销商"];
        return;
    }
    
    [TTReqEngine C_PostInquiry_CreateSetUid:[DLAppData sharedInstance].myUserKey
                                 withCar_id:self.myItemModel.myCar_Id
                                withCity_id:APPDELEGATE.viewController.myCityModel.myCity_Id
                           withCar_color_id:self.myColorItemModel.myCar_Color_Id
                             withDealer_ids:tempStr
                                  withBlock:^(BOOL success, id dataModel) {
                                      if (success) {
                                          
                                          M_MyOrderTtemModel* tempModel = (M_MyOrderTtemModel*)dataModel;
                                          
                                          D_InquiryFinishViewController* tempController = [D_InquiryFinishViewController allocInstance];
                                          tempController.myCarModel = self.myItemModel;
                                          tempController.orderId = tempModel.order_id;
                                          tempController.showPay = NO;
                                          [self.navigationController pushViewController:tempController animated:YES];
                                      }
                                  }];
}

-(void)initData
{
    if (self.myItemModel!=nil) {
        [self.myHeaderView updateData:self.myItemModel withCarType:self.carType];
        
        if (APPDELEGATE.viewController.myCityModel!=nil) {
            self.myCurrCityModel = APPDELEGATE.viewController.myCityModel;
        }
    }
    
    if ([self.myDealerArray count]>0) {
        [self.myDataArray removeAllObjects];
        [self.myDataArray addObjectsFromArray:self.myDealerArray];
    }
    
    NSMutableDictionary* tempDic = [NSMutableDictionary allocInstance];
    [tempDic setObject:@"颜色：" forKey:@"key"];
    [tempDic setObject:@"请选择颜色" forKey:@"value"];
    [self.mySeleteDataArray addObject:tempDic];
    
    [self.myTableView reloadData];
    
    __weak D_InquiryViewController* tempSelf = self;
    self.myColorView.block = ^(id data){
        M_CarColorItemModel* tempItem = (M_CarColorItemModel*)data;
        if (tempItem!=nil) {
            tempSelf.myColorItemModel = tempItem;
            
            NSMutableDictionary* tempDic = [tempSelf.mySeleteDataArray objectAtIndex:0];
            if (tempDic!=nil) {
                [tempDic setObject:tempItem.myCar_Color_Name forKey:@"value"];
            }
            
            [tempSelf updateDealerData];
        }
        
        [tempSelf.myColorView showBack:NO];
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             CGRect tempFrame = tempSelf.myColorView.frame;
                             tempFrame.origin.x = tempSelf.baseView.frame.size.width;
                             tempSelf.myColorView.frame = tempFrame;
                         } completion:^(BOOL finished) {
                             tempSelf.myColorView.hidden = YES;
                         }];
    };
}

-(void)updateDealerData
{
    if (self.myColorItemModel!=nil) {
        
        NSMutableArray* tempArray = [NSMutableArray allocInstance];
        
        for (int i=0; i<[self.myDealerArray count]; i++) {
            M_DealerItemModel* tempItem = [self.myDealerArray objectAtIndex:i];
            if (tempItem!=nil) {
                if ([tempItem.myColorArray count]>0) {
                    for (int j=0; j<[tempItem.myColorArray count]; j++) {
                        M_CarColorItemModel* tempColorItem = [tempItem.myColorArray objectAtIndex:j];
                        if (tempColorItem!=nil) {
                            if ([tempColorItem.myCar_Color_Id isEqualToString:self.myColorItemModel.myCar_Color_Id]) {
                                [tempArray addObject:tempItem];
                            }
                        }
                    }
                }
            }
        }
        
        [self.myDataArray removeAllObjects];
        
        [self.myDataArray addObjectsFromArray:tempArray];
        
        [self.myTableView reloadData];
    }
}

-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.mySeleteDataArray count];
    }else if (section == 1){
        return [self.myDataArray count];
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        M_SeleteColorItemCell *cell = [M_SeleteColorItemCell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
        
        if ([self.mySeleteDataArray count]>indexPath.row) {
            [cell configCellIndexPath:indexPath withDataArray:self.mySeleteDataArray];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.block = ^(){
        
            self.myColorView.hidden = NO;
            
            [self.myColorView updateData:self.myItemModel.myColorArray];
            
            [UIView animateWithDuration:0.5 animations:^{
                CGRect tempFrame =self.myColorView.frame;
                tempFrame.origin.x = 0;
                self.myColorView.frame = tempFrame;
            } completion:^(BOOL finished) {
                
                [self.myColorView showBack:YES];
                
            }];
        };
        
        return cell;
    }else if (indexPath.section == 1){
        
        M_CarDistributorItemCell *cell = [M_CarDistributorItemCell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
        cell.myBlock = ^(id data){
            M_DealerItemModel *model = (M_DealerItemModel *)data;
            NSLog(@"%@",model.dealer_tel);
            [Unity openCallPhone:model.dealer_tel];
        };
        
        if ([self.myDataArray count]>indexPath.row) {
            [cell configCellIndexPath:indexPath withDataArray:self.myDataArray andwithType:self.carType];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 60;
    }else if (indexPath.section == 1){
        return 120;
    }
    
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 50;
    }
    
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* tempView=  [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
    [tempView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel* tempLabel = [tempView viewWithTag:1001];
    if (tempLabel== nil) {
        tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, tempView.frame.size.width-40, tempView.frame.size.height)];
        tempLabel.tag = 1001;
        tempLabel.font = [UIFont systemFontOfSize:12];
        tempLabel.textColor = RGBCOLOR(202, 202, 202);
        [tempView addSubview:tempLabel];
        
    }
    
    tempLabel.text = [NSString stringWithFormat:@"选择经销商(已选择%ld家经销商)",[self.myDataArray count]];
    
    NSMutableAttributedString* tempAttr = [[NSMutableAttributedString alloc]initWithString:tempLabel.text];
    
    [tempAttr addAttribute:NSFontAttributeName
                     value:[UIFont systemFontOfSize:14]
                     range:NSMakeRange(0, 5)];
    [tempAttr addAttribute:NSForegroundColorAttributeName
                     value:[UIColor blackColor]
                     range:NSMakeRange(0, 5)];
    
    tempLabel.attributedText = tempAttr;
    
    return tempView;
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
