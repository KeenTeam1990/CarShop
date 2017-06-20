//
//  MyCollectViewController.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/10.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "MyCollectViewController.h"
#import "Dh_MyCollectModel.h"
#import "M_MyCollectCell.h"
#import "TTReqEngine.h"
#import "D_CarDetailViewController.h"
#import "M_CarListModel.h"
#import "M_CollectSeleteView.h"

@interface MyCollectViewController ()<D_CarDetailViewControllerDelegate>

AS_MODEL_STRONG(DLPageModel, myPageModel);

AS_BOOL(isRefreshing);
AS_BOOL(isLoadingMore);

AS_MODEL_STRONG(M_CollectSeleteView, myDialogView);

@end

@implementation MyCollectViewController

DEF_MODEL(typeStr);
DEF_MODEL(isLoadingMore);
DEF_MODEL(isRefreshing);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.myPageModel = [DLPageModel allocInstance];
    self.dataArray = [NSMutableArray allocInstance];
    
    [self addCustomNavBar:self.typeStr
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.bounds.size.width, self.baseView.bounds.size.height-NavigationBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    
    __weak MyCollectViewController* tempself = self;
    
    [self.myTableView addPullToRefreshWithActionHandler:^{
        
        if (tempself.isLoadingMore || tempself.isRefreshing) {
            return;
        }
        
        tempself.isRefreshing = YES;
        
        tempself.myPageModel.nextMax = @"";
        
        [tempself initData];
    }];
    
    [self.myTableView addInfiniteScrollingWithActionHandler:^{
        if (tempself.isLoadingMore || tempself.isRefreshing) {
            return;
        }
        
        tempself.isLoadingMore = YES;
        
        [tempself initData];
    }];
    [self.myTableView triggerPullToRefresh];
    [self addCustomNavBar:self.typeStr
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    self.myDialogView = [M_CollectSeleteView allocInstanceFrame:CGRectMake(0, 0, self.baseView.bounds.size.width, self.baseView.bounds.size.height)];
    self.myDialogView.hidden = YES;
    [self.baseView addSubview:self.myDialogView];
    
    self.myDialogView.block = ^(NSString *tag,id data){
        M_CarItemModel* tempItem = (M_CarItemModel*)data;
        if (tempItem!=nil) {
            D_CarDetailViewController* tempController = [D_CarDetailViewController allocInstance];

            tempController.myDelegate = tempself;
            if ([tag  isEqualToString:@"特价"]) {
                tempController.carType = EB_SpeciaiCar;
            }else if ([tag isEqualToString:@"租购"]){
                tempController.carType = EB_RentaiCar;
            }else if ([tag isEqualToString:@"优选"]){
                tempController.carType = EB_NewCar;
            }
            
            tempController.myCarId = tempItem.myCar_Id;
            [tempself.navigationController pushViewController:tempController animated:YES];
        }
    };
    

}

-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
}

-(void)resetGetData
{
    
    [self.myTableView triggerPullToRefresh];
}

-(void)initData
{
    if ([self.typeStr isEqualToString:@"我的收藏"]) {
        ;
        [TTReqEngine C_GetFavorite_ListSetUid:[DLAppData sharedInstance].myUserKey
                                    withLimit:self.myPageModel.limit
                                     withPage:nil
                                      withMax:self.myPageModel.nextMax
                                    withBlock:^(BOOL success, id dataModel)
         {

             if (success) {
                 
                 M_CarListModel *model = (M_CarListModel *)dataModel;
                 if (model !=nil)
                 {
                     [self.myPageModel toData:model.myPageModel];
                  
                     if ([model.myItemArray count] == 0) {
                         [self showPageError:YES withIsError:NO];
                     }else{
                         [self showPageError:NO withIsError:NO];
                         if (self.isRefreshing) {
                             [self.dataArray removeAllObjects];
                         }
                         
                         [self.dataArray addObjectsFromArray:model.myItemArray];
                         
                         [self.myTableView reloadData];
                     }
                 }
                 
             }
             [self updateListState:success];
         }];
    }
    else
    {
        [TTReqEngine C_GetView_ListSetUid:APPDELEGATE.viewController.myUserModel.user_id
                                withLimit:self.myPageModel.limit
                                 withPage:nil
                                  withMax:self.myPageModel.nextMax
                                withBlock:^(BOOL success, id dataModel) {
            
                if (success)
                {
                    M_CarListModel *model = (M_CarListModel *)dataModel;
                    if (model !=nil)
                    {
                        [self.myPageModel toData:model.myPageModel];
                        if ([model.myItemArray count] == 0) {
                            [self showPageError:YES withIsError:NO];
                        }else{
                            [self showPageError:NO withIsError:NO];
                            if (self.isRefreshing) {
                                [self.dataArray removeAllObjects];
                            }
                            
                            [self.dataArray addObjectsFromArray:model.myItemArray];
                            
                            [self.myTableView reloadData];
                        }
                    }
                    
                }
                [self updateListState:success];
        }];
    }
}

-(void)updateListState:(BOOL)success
{
    if (success) {
        [self closeRefresh];
    }else{
        [self showPageError:YES withIsError:YES];
        [self tableViewDidFinishedLoadingWithReachedTheEnd:YES];
    }
}

-(void)closeRefresh
{
    if (self.myPageModel.hasMore) {
        [self tableViewDidFinishedLoadingWithReachedTheEnd:NO];
    }else{
        [self tableViewDidFinishedLoadingWithReachedTheEnd:YES];
    }
}

- (void)tableViewDidFinishedLoadingWithReachedTheEnd:(BOOL)reachedTheEnd
{
    if (self.isLoadingMore) {
        self.isLoadingMore = NO;
        [self.myTableView.infiniteScrollingView stopAnimating];
        if (reachedTheEnd) {
            self.myTableView.infiniteScrollingView.enabled = NO;
        }
    }
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        [self.myTableView.pullToRefreshView stopAnimating];
        self.myTableView.infiniteScrollingView.enabled = YES;
        if (reachedTheEnd) {
            self.myTableView.infiniteScrollingView.enabled = NO;
        }
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_MyCollectCell *cell=[M_MyCollectCell reusableCellOfTableView:tableView style:UITableViewCellStyleValue1];
    
    if ([self.typeStr isEqualToString:@"我的收藏"])
    {
         cell.mydelBtn.hidden = YES;
    }
    
    cell.block = ^(NSInteger tag,id data){
        
        M_CarItemModel* tempModel = data;
        
        __weak MyCollectViewController * tempVC = self;
        
        if ([self.typeStr isEqualToString:@"我的收藏"]) {
            
           
            
        [TTReqEngine C_PostFavorite_DelSetID:nil
                                         Uid:[DLAppData sharedInstance].myUserKey
                                  withCar_id:tempModel.myCar_Id
                                 withCity_id:APPDELEGATE.viewController.myCityModel.myCity_Id
                                   withBlock:^(BOOL success, id dataModel) {
                                       if (success) {
                                           [SVProgressHUD showSuccessWithStatus:@"删除收藏成功！"];
                                           [tempVC resetGetData];

                                       }
                                       
                                   }];
        }else
        {
            [TTReqEngine C_PostView_ListDelSetID:tempModel.readID
                                       withBlock:^(BOOL success, id dataModel) {
                                           if (success) {
                                               [SVProgressHUD showSuccessWithStatus:@"删除浏览车型成功！"];
                                               [tempVC resetGetData];
                                           }
                                       }];
        }        
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configCellIndexPath:indexPath withDataArray:self.dataArray];
    
    return cell;
}



-(void)delCollectConfigCellIndexPath:(int)indexPath
{
    [self.dataArray removeObjectAtIndex:indexPath];
    [self.myTableView reloadData];
}
#pragma mark - UITableViewDataSource
//1.tableview共有多少组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//2.section有几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    M_CarItemModel* temoItem = [self.dataArray objectAtIndex:indexPath.row];
    if (temoItem!=nil) {
        
        self.myDialogView.showNew = temoItem.myCar_New;
        self.myDialogView.showRental = temoItem.myCar_Lease;
        self.myDialogView.showSpecia = temoItem.myCar_Sales;
        if ( self.myDialogView.showNew || self.myDialogView.showRental ||self.myDialogView.showSpecia) {
            [self.myDialogView showDialog:temoItem];
        }
        
    }
}

#pragma mark ShouldRefresh
-(void)shouleRefreach
{
    [self.dataArray removeAllObjects];
    [self.myTableView reloadData];
    [self resetGetData];
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
