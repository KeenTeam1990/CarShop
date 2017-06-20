
//
//  DLPageTableView.m
//  DHCarForUser
//
//  Created by leiyu on 16/4/4.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLPageTableView.h"
#import "DLPageModel.h"

@interface DLPageTableView()
AS_BOOL(isRefresh);
AS_BOOL(isLoadingMore);
AS_MODEL_STRONG(DLPageModel, pageModel);
@end
@implementation DLPageTableView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initTableView:CGRectMake(0, 0, frame.size.width, frame.size.height) withSeparatoStyle:UITableViewCellSeparatorStyleSingleLine];
        [self.myTableView addPullToRefreshWithActionHandler:^{
            
        }];
        [self.myTableView addInfiniteScrollingWithActionHandler:^{
            
        }];
        
    }
    return self;
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
    if (self.pageModel.hasMore) {
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
    if (self.isRefresh) {
        self.isRefresh = NO;
        [self.myTableView.pullToRefreshView stopAnimating];
        self.myTableView.infiniteScrollingView.enabled = YES;
        if (reachedTheEnd) {
            self.myTableView.infiniteScrollingView.enabled = NO;
        }
    }
}

@end
