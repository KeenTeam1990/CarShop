//
//  D_DealerViewController.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_DealerViewController.h"
#import "M_DealerListModel.h"
#import "M_DealerItemModel.h"
#import "M_DealerItemCell.h"
#import "D_DealerHomeViewController.h"
#import "TTReqEngine.h"


@interface D_DealerViewController ()

AS_MODEL_STRONG(DLPageModel, myPageModel);

AS_BOOL(isRefreshing);
AS_BOOL(isLoadingMore);

@end

@implementation D_DealerViewController

DEF_FACTORY(D_DealerViewController);

DEF_MODEL(isLoadingMore);
DEF_MODEL(isRefreshing);

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myPageModel = [DLPageModel allocInstance];
    
    // Do any additional setup after loading the view.
    [self initView];
}

-(void)initView
{
    [self addCustomNavBar:@"经销商查询"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.bounds.size.width, self.baseView.bounds.size.height-NavigationBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    
    __weak D_DealerViewController* tempself = self;
    
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
}

-(void)resetGetData
{
    [self.myTableView triggerPullToRefresh];
}

-(void)initData
{
    [TTReqEngine C_GetdealerList_SetCity_id:APPDELEGATE.viewController.myCityModel.myCity_Id
                                 withCar_id:nil
                                   withType:@"0"
                            withBigbrand_id:nil
                               withBrand_id:nil
                              withSeries_id:nil
                                 withLimitd:self.myPageModel.limit
                                   withPage:nil
                                    withMax:self.myPageModel.nextMax
                                  withBlock:^(BOOL success, id dataModel) {
                                     if (success) {
                                         M_DealerListModel* tempModel = dataModel;
                                         if (tempModel!=nil) {
          
                                             [self.myPageModel toData:tempModel.myPageModel];
                                             
                                             if ([tempModel.myDealerListArray count] == 0) {
                                                 [self showPageError:YES withIsError:NO];
                                             }else{
                                                 
                                                 if (self.isRefreshing) {
                                                     [self.myDataArray removeAllObjects];
                                                 }
              
                                                 [self.myDataArray addObjectsFromArray:tempModel.myDealerListArray];
              
                                                 [self.myTableView reloadData];
                                             }
                                         }
                                         
                                         if ([DLAppData sharedInstance].currCityChangeToDealer) {
                                             [DLAppData sharedInstance].currCityChangeToDealer = NO;
                                         }
                                     }else{
                                         [self showPageError:YES withIsError:YES];
                                     }
                                     [self updateListState:success];
                                  }];
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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
    
    if ([DLAppData sharedInstance].currCityChangeToDealer) {
        [self.myTableView triggerPullToRefresh];
    }else{
        if ([self.myDataArray count] == 0) {
            [self.myTableView triggerPullToRefresh];
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
    M_DealerItemCell *cell = [M_DealerItemCell reusableCellOfTableView:tableView style:UITableViewCellStyleValue1];
    cell.myBlock=^(NSString *phoneNum)
    {
        if ([phoneNum notEmpty]) {
            [Unity openCallPhone:phoneNum];
        }
    };
    
    [cell configCellIndexPath:indexPath withDataArray:self.myDataArray];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_DealerItemModel* tempItem = [self.myDataArray objectAtIndex:indexPath.row];
    if (tempItem!=nil) {
        D_DealerHomeViewController* tempController = [D_DealerHomeViewController allocInstance];
        tempController.myItemModel = tempItem;
        [self.navigationController pushViewController:tempController animated:YES];
    }
}

-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of an y resources that can be recreated.
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
