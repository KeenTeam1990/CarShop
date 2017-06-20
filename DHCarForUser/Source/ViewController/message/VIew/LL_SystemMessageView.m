
//
//  LL_SystemMessageVIew.m
//  DHCarForUser
//
//  Created by leiyu on 15/12/24.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "LL_SystemMessageView.h"
#import "LL_MessageSystemCell.h"
#import "LL_SystemModel.h"
@implementation LL_SystemMessageView

DEF_FACTORY_FRAME(LL_SystemMessageView);
DEF_MODEL(block);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.myDataArray = [[NSMutableArray alloc]init];
        self.myPageModel = [DLPageModel allocInstance];
        
        [self initTableView:CGRectMake(0, 0, frame.size.width, frame.size.height) withSeparatoStyle:UITableViewCellSeparatorStyleSingleLine];
        
        __weak LL_SystemMessageView* tempself = self;
        
        [self.myTableView addPullToRefreshWithActionHandler:^{
            
            if (tempself.isLoading || tempself.isRefresh) {
                return;
            }
            
            tempself.isRefresh = YES;
            
            tempself.myPageModel.nextMax = @"";
            
            [tempself initData];
        }];
        
        // setup infinite scrolling
        [self.myTableView addInfiniteScrollingWithActionHandler:^{
            if (tempself.isLoading || tempself.isRefresh) {
                return;
            }
            
            tempself.isLoading = YES;
            
            [tempself initData];
        }];

    }
    return self;
}

-(void)initData
{
    if (self.block!=nil) {
        self.block(0,nil);
    }
}

-(void)resetGetData
{
    [self.myTableView triggerPullToRefresh];
}

-(void)updateData:(NSMutableArray *)dataArr
{
    if ([dataArr count] == 0) {
        [self showPageError:YES withIsError:YES];
    }else{
        [self showPageError:NO withIsError:NO];
        
        if (self.isRefresh)
        {
            [self.myDataArray removeAllObjects];
        }
        [self.myDataArray addObjectsFromArray:dataArr];
        
        [self.myTableView reloadData];
    }
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
    if (self.isLoading) {
        self.isLoading = NO;
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",[self.myDataArray count]);
    return [self.myDataArray count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LL_MessageSystemCell *cell=[LL_MessageSystemCell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
    
    if ([self.myDataArray count]>indexPath.row) {
        LL_SystemModel  *model=self.myDataArray[indexPath.row];
        if (model!=nil) {
            [cell updataTestModel:model];
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     LL_SystemModel  *model=self.myDataArray[indexPath.row];
    CGFloat textHeight = [Unity getLabelHeightWithWidth:self.bounds.size.width -10-4-10-10 andDefaultHeight:25 andFontSize:12 andText:model.myContent];
    return textHeight+23;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LL_SystemModel *tempItem = [self.myDataArray objectAtIndex:indexPath.row];
    if (tempItem!= nil) {
        if (self.block != nil) {
            self.block(1,tempItem);
        }
    }
}


@end
