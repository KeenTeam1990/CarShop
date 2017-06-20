//
//  QueryModelsViewController.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/10.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "QueryModelsViewController.h"
#import "M_QueryModelsCell.h"
#import "M_QueryModelsModel.h"
#import "TTReqEngine.h"
#import "QueryModelsItemViewController.h"
#import "M_MyOrderModel.h"
@interface QueryModelsViewController ()

AS_MODEL_STRONG(DLPageModel, myPageModel);

AS_BOOL(isRefreshing);
AS_BOOL(isLoadingMore);

@end

@implementation QueryModelsViewController

DEF_MODEL(isLoadingMore);
DEF_MODEL(isRefreshing);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.myPageModel = [DLPageModel allocInstance];
    
    [self addCustomNavBar:@"询价车型"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.bounds.size.width, self.baseView.bounds.size.height-NavigationBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    
    __weak QueryModelsViewController* tempself = self;
    
    [self.myTableView addPullToRefreshWithActionHandler:^{
        
        if (tempself.isLoadingMore || tempself.isRefreshing) {
            return;
        }
        
        tempself.isRefreshing = YES;
        
        tempself.myPageModel.nextMax = @"";
        
        [tempself initData];
    }];
    
    // setup infinite scrolling
    [self.myTableView addInfiniteScrollingWithActionHandler:^{
        if (tempself.isLoadingMore || tempself.isRefreshing) {
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
    [TTReqEngine C_GetInquiry_ListSetUid:[DLAppData sharedInstance].myUserKey
                               withLimit:self.myPageModel.limit
                                withPage:nil
                                 withMax:self.myPageModel.nextMax
                               withBlock:^(BOOL success, id dataModel) {
                                   if (success) {
                                       M_MyOrderModel *tempModel = (M_MyOrderModel*)dataModel;
                                       if (tempModel !=nil) {
                                           
                                           [self.myPageModel toData:tempModel.myPageModel];
                                           
                                           if ([tempModel.myItemArray count] == 0) {
                                               [self showPageError:YES withIsError:NO];
                                           }else{
                                               [self showPageError:NO withIsError:NO];
                                               if (self.isRefreshing) {
                                                   [self.myDataArray removeAllObjects];
                                               }
                                               [self.myDataArray addObjectsFromArray:tempModel.myItemArray];
                                               
                                               [self.myTableView reloadData];
                                           }
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
    M_QueryModelsCell *cell=[M_QueryModelsCell reusableCellOfTableView:tableView style:UITableViewCellStyleValue1 ];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([self.myDataArray count]>indexPath.row  ) {
        [cell configCellIndexPath:indexPath withDataArray:self.myDataArray];
    }
    
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
    return 160;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_MyOrderTtemModel *tempModel = [self.myDataArray objectAtIndex:indexPath.row];
    
    if (tempModel!=nil) {
        
        QueryModelsItemViewController *queryVC = [[QueryModelsItemViewController alloc]init];
        queryVC.order_id = tempModel.order_id;
        
        [self.navigationController pushViewController:queryVC animated:YES];
    }
}

//删除按钮的title
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除订单";
}

//删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.myDataArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
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
