//
//  QueryModelsItemViewController.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/16.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "QueryModelsItemViewController.h"
#import "QueryModelsItemCell.h"
#import "QueryModelsItemHeadView.h"
#import "TTReqEngine.h"
#import "M_MyOrderModel.h"
#import "D_CommunicateViewController.h"
#import "D_ReserveViewController.h"
#import "LL_OrderDetailViewController.h"
#import "D_WebViewController.h"

@interface QueryModelsItemViewController ()

AS_MODEL_STRONG(QueryModelsItemHeadView, myHeaderView);

AS_MODEL_STRONG(M_MyOrderTtemModel, myItemModel);

AS_INT(selectIndex);

@end

@implementation QueryModelsItemViewController


DEF_FACTORY(QueryModelsItemViewController);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initData];
    
    [self initView];
    self.selectIndex = -1;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (self.selectIndex != -1) {
        [self initData];
    }
}

-(void)initView
{
    [self addCustomNavBar:@"询价详情"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.bounds.size.width, self.baseView.bounds.size.height-NavigationBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    
    self.myHeaderView = [[QueryModelsItemHeadView alloc]initWithFrame:CGRectMake(0, 0, self.myTableView.frame.size.width, 110)];
    self.myTableView.tableHeaderView = self.myHeaderView;
}

-(void)initData
{
    [TTReqEngine C_GetInquiry_GetSetUid:[DLAppData sharedInstance].myUserKey
                                 withID:self.order_id
                              withBlock:^(BOOL success, id dataModel) {
                                 
                                  if (success) {
                                      
                                      M_MyOrderTtemModel* tempModel = (M_MyOrderTtemModel*)dataModel;
                                      if (tempModel!=nil) {
                                          
                                          self.myItemModel = tempModel;
                                          
                                          [self.myHeaderView updataMOdel:tempModel];
                                          
                                          [self.myDataArray removeAllObjects];
                                          
                                          [self.myDataArray addObjectsFromArray:tempModel.myQuoteArray];
                                          
                                          [self.myTableView reloadData];
                                      }
                                  }
                              }];
}


#pragma mark - 
#pragma UITableViewDataSoure

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myDataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QueryModelsItemCell *Cell = [QueryModelsItemCell reusableCellOfTableView:tableView style:UITableViewCellStyleValue1];
    Cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if ([self.myDataArray count]>indexPath.row) {
        [Cell configCellIndexPath:indexPath withDataArray:self.myDataArray];
    }
    
    Cell.block = ^(NSInteger tag,id data){
        
        if (tag == 0) {
            M_QuoteItemModel* tempModel = (M_QuoteItemModel*)data;
            if (tempModel!=nil) {

                D_CommunicateViewController* tempController = [[D_CommunicateViewController alloc]init];
                NSLog(@"name = %@",tempModel.myDealerModel.dealer_name);
                NSLog(@"name2222222222 = %@",tempModel.mySalesUid);
                NSLog(@"name3333333333 = %@",tempModel.myQuoteId);

                tempController.myTargetUid = tempModel.mySalesUid;
                tempController.myQuotedId = tempModel.myQuoteId;
                [self.navigationController pushViewController:tempController animated:YES];
            }
        }else if (tag == 1){
            M_QuoteComboItemModel* tempitem = (M_QuoteComboItemModel*)data;
            if (tempitem!=nil) {
                D_WebViewController *tempController = [[D_WebViewController alloc]init];
                tempController.myTitle = @"购车礼包";
                tempController.myUrl = [NSString stringWithFormat:@"%@/spree?id=%@",KH5Host,tempitem.myComboId];
                [self.navigationController pushViewController:tempController animated:YES];
            }
        }else if (tag == 2){
            M_QuoteItemModel* tempModel = (M_QuoteItemModel*)data;
            if (tempModel!=nil) {
                self.myItemModel.car.myCar_Deposit = tempModel.myEarnest;
                
                D_ReserveViewController* tempController = [D_ReserveViewController allocInstance];
                tempController.myItemModel = self.myItemModel.car;
                tempController.carType = EB_NewCar;
                tempController.myDealerItemModel = tempModel.myDealerModel;
                tempController.updateBlock = ^(NSInteger update){
                    self.selectIndex = update;
                };
                [self.navigationController pushViewController:tempController animated:YES];
            }
        }else if(tag == 3){
            M_QuoteItemModel* tempModel = (M_QuoteItemModel*)data;
            if (tempModel!=nil) {
                [Unity openCallPhone:tempModel.myDealerModel.dealer_tel];
            }
        }
    };

    return Cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat tempHeight = 120;
    M_QuoteItemModel* tempModel = [self.myDataArray objectAtIndex:indexPath.row];
    if (tempModel!=nil) {
        
        NSString* tempInfo = @"";
        UIImage* tempIcon = [UIImage imageNamed:@"礼包.png"];
        
        if ([tempModel.myLastPrice notEmpty] && ![tempModel.myLastPrice isEqualToString:@"0"]) {
            tempInfo = tempModel.myLastInfo;
            
            if ([tempModel.myLastComboArray count]) {
                tempHeight+=30;
                for (int i=0; i<[tempModel.myLastComboArray count]; i++) {
                    M_QuoteComboItemModel* tempComboItem = [tempModel.myLastComboArray objectAtIndex:i];
                    if (tempComboItem!=nil) {
                        NSString* tempStr = [NSString stringWithFormat:@"%@:%@",tempComboItem.myComboTitle,tempComboItem.myComboContent];
                        
                        NSInteger tempH = [tempStr sizeWithFont:SYSTEMFONT(12) byWidth:self.myTableView.frame.size.width-40-tempIcon.size.width].height+10;
                        
                        if (tempH < 20) {
                            tempH = 20;
                        }
                        tempHeight+=tempH;
                    }
                }
            }
            
        }else if ([tempModel.myFirstPrice notEmpty] && ![tempModel.myFirstPrice isEqualToString:@"0"]){
            tempInfo = tempModel.myFirstInfo;
            
            if ([tempModel.myFirstComboArray count]) {
                tempHeight+=30;
                for (int i=0; i<[tempModel.myFirstComboArray count]; i++) {
                    M_QuoteComboItemModel* tempComboItem = [tempModel.myFirstComboArray objectAtIndex:i];
                    if (tempComboItem!=nil) {
                        NSString* tempStr = [NSString stringWithFormat:@"%@:%@",tempComboItem.myComboTitle,tempComboItem.myComboContent];
                        
                        NSInteger tempH = [tempStr sizeWithFont:SYSTEMFONT(12) byWidth:self.myTableView.frame.size.width-40-tempIcon.size.width].height+10;
                        
                        if (tempH < 20) {
                            tempH = 20;
                        }
                        tempHeight+=tempH;
                    }
                }
            }
        }
        
        if ([tempInfo notEmpty]) {
            tempHeight += [Unity getLabelHeightWithWidth:tableView.frame.size.width-40 andDefaultHeight:30 andFontSize:12 andText:tempInfo]+85;
        }else{
            tempHeight = 160;
        }
    }
    
    return tempHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_QuoteItemModel* tempModel = [self.myDataArray objectAtIndex:indexPath.row];
    if (tempModel!=nil) {
        tempModel.myInquiryModel = self.myItemModel;
        tempModel.myInquiryModel.car.myCar_Deposit = tempModel.myEarnest;
        
        LL_OrderDetailViewController* tempController = [[LL_OrderDetailViewController alloc]init];
        tempController.myEntry = @"nomessage";
        tempController.myQuotedId = tempModel.myQuoteId;
        [self.navigationController pushViewController:tempController animated:YES];
    }
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
