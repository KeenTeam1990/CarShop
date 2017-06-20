//
//  MyOrderViewController.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/10.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "MyOrderViewController.h"
#import "M_MyOrderModel.h"
#import "M_MyOlderCell.h"
#import "M_MyOrderModel.h"
#import "TTReqEngine.h"
#import "MCertificateViewController.h"
#import "D_LLDetailOrderViewController.h"

#import "D_PayViewController.h"

@interface MyOrderViewController ()

AS_MODEL_STRONG(DLPageModel, myPageModel);

AS_BOOL(isRefreshing);
AS_BOOL(isLoadingMore);

@end

@implementation MyOrderViewController

DEF_MODEL(isLoadingMore);
DEF_MODEL(isRefreshing);

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myPageModel = [DLPageModel allocInstance];
    
    [self addCustomNavBar:@"我的订单"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.bounds.size.width, self.baseView.bounds.size.height-NavigationBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    
    
    // Do any additional setup after loading the view.
    
    __weak MyOrderViewController* tempself = self;
    
    [self.myTableView addPullToRefreshWithActionHandler:^{
        
        if (tempself.isLoadingMore || tempself.isRefreshing)
        {
            return;
        }
        
        tempself.isRefreshing = YES;
        
        tempself.myPageModel.nextMax = @"";
        
        [tempself initData];
    }];
    
    // setup infinite scrolling
    [self.myTableView addInfiniteScrollingWithActionHandler:^{
        if (tempself.isLoadingMore || tempself.isRefreshing)
        {
            return;
        }
        
        tempself.isLoadingMore = YES;
        
        [tempself initData];
    }];
    
    [self.myTableView triggerPullToRefresh];
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
    [TTReqEngine C_GetOrderMylistSetUid:[DLAppData sharedInstance].myUserKey
                               withStep:nil
                             withLimitd:self.myPageModel.limit
                               withPage:nil
                                withMax:self.myPageModel.nextMax
                              withBlock:^(BOOL success, id dataModel) {
        
        if (success) {
            M_MyOrderModel *myOrderModel = (M_MyOrderModel *)dataModel;
            
            [self.myPageModel toData:myOrderModel.myPageModel];
            
            if ([myOrderModel.myItemArray count] == 0) {
                [self showPageError:YES withIsError:NO];
            }else{
                [self showPageError:NO withIsError:NO];
                if (self.isRefreshing) {
                    [self.myDataArray removeAllObjects];
                }
                
                [self.myDataArray addObjectsFromArray:myOrderModel.myItemArray];
                [self.myTableView reloadData];
            }
        }
        [self updateListState:success];

    }];
    
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
    M_MyOlderCell *cell=[M_MyOlderCell reusableCellOfTableView:tableView style:UITableViewCellStyleValue1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configCellIndexPath:indexPath withDataArray:self.myDataArray];
    
    cell.block = ^(NSInteger tag,id data){
    
        M_MyOrderTtemModel* tempModel = data;
        if (tag == 0) {
            D_PayViewController* tempController = [D_PayViewController allocInstance];
            tempController.order_id = tempModel.order_id;
            tempController.order_num = tempModel.order_no;
            tempController.myItemModel = tempModel.car;
            
            __weak D_PayViewController* tempCon =tempController;
            tempController.block = ^(NSInteger tag){
                if (tag == 0) {
                    [tempCon.navigationController popViewControllerAnimated:YES];
                    
                    [self resetGetData];
                }
            };
            
            [self.navigationController pushViewController:tempController animated:YES];
        }else if (tag == 1){
            MCertificateViewController *tempVC = [[MCertificateViewController alloc]init];
            tempVC.myOrderID = tempModel.order_id;
            tempVC.block = ^(){
                [self resetGetData];
            };
            
            [self.navigationController pushViewController:tempVC animated:YES];
        }else if (tag == 2)
        {
            [TTReqEngine C_PostOrder_DeleteUid:[DLAppData sharedInstance].myUserKey
                                   withOrderId:tempModel.order_id
                                     withBlock:^(BOOL success, id dataModel) {
                                       if (success)
                                       {
                                           [self resetGetData];
                                       }
                                   }];
        }
    };
    
    return cell;
}

#pragma mark - UITableViewDataSource

//2.section有几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myDataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_MyOrderTtemModel *tempModel = [self.myDataArray objectAtIndex:indexPath.row];
    
    if (tempModel!=nil) {
        D_LLDetailOrderViewController *olderItemVC = [[D_LLDetailOrderViewController alloc]init];
        olderItemVC.orderID = tempModel.order_id;
        [self.navigationController pushViewController:olderItemVC animated:YES];
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
