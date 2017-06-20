//
//  M_CarListView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarListView.h"
#import "M_CarListModel.h"
#import "M_CarItem2Cell.h"

@interface M_CarListView ()

AS_BOOL(isRefreshing);
AS_BOOL(isLoadingMore);

@end

@implementation M_CarListView

DEF_FACTORY_FRAME(M_CarListView);
DEF_MODEL(carType);
DEF_MODEL(block);

DEF_MODEL(isLoadingMore);
DEF_MODEL(isRefreshing);
DEF_MODEL(getDataBlock);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.myPageModel = [DLPageModel allocInstance];
        
        [self initTableView:CGRectMake(0, 0, frame.size.width, frame.size.height) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
        
        __weak M_CarListView* tempself = self;
        
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
    }
    return self;
}

-(void)getData
{
    self.myErrorView.hidden = YES;
    self.myTableView.hidden = NO;
    [self.myDataArray removeAllObjects];
    [self.myTableView reloadData];
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
    if ([data count] == 0) {
        [self showPageError:YES withIsError:NO];
    }else{
        [self showPageError:NO withIsError:NO];
        if (self.isRefreshing) {
            [self.myDataArray removeAllObjects];
        }
        [self.myDataArray addObjectsFromArray:data];
        
        [self.myTableView reloadData];
    }
}

-(void)resetGetData
{
    [self getData];
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

#pragma mark-
#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_CarItem2Cell *cell = [M_CarItem2Cell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
    cell.carType = self.carType;
    
    if ([self.myDataArray count] > indexPath.row) {
        [cell configCellIndexPath:indexPath withDataArray:self.myDataArray];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_CarItemModel* tempItem = [self.myDataArray objectAtIndex:indexPath.row];
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
