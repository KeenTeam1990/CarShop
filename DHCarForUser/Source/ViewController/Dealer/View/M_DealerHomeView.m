//
//  M_DealerHomeView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_DealerHomeView.h"
#import "M_CarItem2Cell.h"
#import "M_CarListModel.h"


@interface M_DealerHomeView ()

AS_BOOL(isRefreshing);
AS_BOOL(isLoadingMore);

@end

@implementation M_DealerHomeView

DEF_FACTORY_FRAME(M_DealerHomeView);
DEF_MODEL(block);

DEF_MODEL(isLoadingMore);
DEF_MODEL(isRefreshing);
DEF_MODEL(getDataBlock);

DEF_MODEL(carType);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        
        self.myPageModel = [DLPageModel allocInstance];
        
        [self initTableView:CGRectMake(0, 0, frame.size.width, frame.size.height) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
        
        __weak M_DealerHomeView* tempself = self;
        
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
    return self;
}

-(void)getData
{
    [self.myTableView triggerPullToRefresh];
}
-(void)initData
{
    if (self.getDataBlock!=nil) {
        self.getDataBlock(0);
    }
}

-(void)updateData:(NSMutableArray*)data
{
    if (self.isRefreshing) {
        [self.myDataArray removeAllObjects];
    }
    [self.myDataArray addObjectsFromArray:data];
    
    [self.myTableView reloadData];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    M_CarItem2Cell *cell = [M_CarItem2Cell reusableCellOfTableView:tableView style:UITableViewCellStyleValue1];
    
    cell.carType = self.carType;
    
    [cell configCellIndexPath:indexPath withDataArray:self.myDataArray];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_CarItemModel* tempItem =[self.myDataArray objectAtIndex:indexPath.row];
    if (tempItem!=nil) {
        if (self.block!=nil) {
            self.block(tempItem);
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
