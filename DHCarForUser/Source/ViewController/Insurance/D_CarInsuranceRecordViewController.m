//
//  D_CarInsuranceRecordViewController.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_CarInsuranceRecordViewController.h"
#import "M_CarInsuranceRecordItemCell.h"
#import "M_CarInsuranceListModel.h"
#import "TTReqEngine.h"


@interface D_CarInsuranceRecordViewController ()

AS_MODEL_STRONG(NSString, totalPage);
AS_MODEL_STRONG(NSString, pageIndex);
AS_MODEL_STRONG(NSString, pageNum);

AS_BOOL(isRefreshing);
AS_BOOL(isLoadingMore);

@end

@implementation D_CarInsuranceRecordViewController

DEF_FACTORY(D_CarInsuranceRecordViewController);

DEF_MODEL(totalPage);
DEF_MODEL(pageIndex);
DEF_MODEL(pageNum);

DEF_MODEL(isLoadingMore);
DEF_MODEL(isRefreshing);

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageIndex = @"0";
    self.pageNum = @"10";
    
    [self initView];
    

}

-(void)initView
{
    [self addCustomNavBar:@"保险政策记录"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.bounds.size.width, self.baseView.bounds.size.height-NavigationBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    
    __weak D_CarInsuranceRecordViewController* tempself = self;
    
    [self.myTableView addPullToRefreshWithActionHandler:^{
        
        if (tempself.isLoadingMore || tempself.isRefreshing) {
            return;
        }
        
        tempself.isRefreshing = YES;
        
        tempself.pageIndex = @"0";
        
        [tempself initData];
    }];
    
    // setup infinite scrolling
    [self.myTableView addInfiniteScrollingWithActionHandler:^{
        if (tempself.isLoadingMore || tempself.isRefreshing) {
            return;
        }
        
        tempself.isLoadingMore = YES;
        
        [tempself loadMoreData];
    }];
    
    [self.myTableView triggerPullToRefresh];
}

-(void)initData
{
    
    [self getData];
}

-(void)getData
{
    
}


-(void)loadMoreData
{
    NSInteger pageI = [self.pageIndex integerValue];
    
    pageI+=[self.pageNum integerValue];
    
    if (pageI>=[self.totalPage integerValue]) {
        pageI = [self.totalPage integerValue];
    }
    
    self.pageIndex = [NSString fromInt:(int)pageI];
    
    [self initData];
}


-(void)updateListState:(BOOL)success
{
    if (success) {
        [self closeRefresh];
    }else{
        [self tableViewDidFinishedLoadingWithReachedTheEnd:YES];
    }
}

-(void)closeRefresh
{
    if ([self.pageIndex integerValue] >= [self.totalPage integerValue] || [self.totalPage integerValue]<=[self.pageNum integerValue]) {
        [self tableViewDidFinishedLoadingWithReachedTheEnd:YES];
    }else{
        [self tableViewDidFinishedLoadingWithReachedTheEnd:NO];
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


#pragma mark-
#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_CarInsuranceRecordItemCell *cell = [M_CarInsuranceRecordItemCell reusableCellOfTableView:tableView style:UITableViewCellStyleValue1];
    
    NSLog(@"cell frame：%@", NSStringFromCGRect(cell.bounds));
    
    [cell configCellIndexPath:indexPath withDataArray:self.myDataArray];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
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
