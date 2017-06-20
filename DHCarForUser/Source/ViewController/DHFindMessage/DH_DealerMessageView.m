//
//  DH_DealerMessageView.m
//  DHCarForUser
//
//  Created by 张海亮 on 16/4/4.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DH_DealerMessageView.h"
#import "DHFindTableCell.h"
@interface DH_DealerMessageView ()
AS_BOOL(isRefreshing);
AS_BOOL(isLoadingMore);
@end

@implementation DH_DealerMessageView

DEF_FACTORY_FRAME(DH_DealerMessageView);
DEF_MODEL(block);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.myPageModel = [DLPageModel allocInstance];
        
        [self initTableView:CGRectMake(0, 0, frame.size.width, frame.size.height) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
        
        __weak DH_DealerMessageView* tempself = self;
        
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
-(void)initData
{
    if (self.block!=nil) {
        self.block(0,nil);
    }
}

-(void)updateData:(NSArray *)dataArr;
{
    if ([dataArr count] == 0) {
        [self showPageError:YES withIsError:NO];
    }else{
        
        [self showPageError:NO withIsError:NO];
        
        if (self.isRefreshing) {
            [self.myDataArray removeAllObjects];
        }
        
        [self.myDataArray addObjectsFromArray:dataArr];
        
        [self.myTableView reloadData];
    }
}

-(void)resetGetData
{
    [self.myTableView triggerPullToRefresh];
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myDataArray count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"identify";
    DHFindTableCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[DHFindTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    
    NSDictionary *titleData = [self.myDataArray objectAtIndex:indexPath.row];
    cell.messageTitleLabel.text = [titleData hasItemAndBack:@"title"];
    cell.messageReadLabel.text = [NSString stringWithFormat:@"阅读:  %@",[titleData hasItemAndBack:@"readcount"]];
    [cell.carImageView setImageWithURL:[NSURL URLWithString:[titleData hasItemAndBack:@"cover"]] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
    NSString *time = [NSString fromString:[titleData hasItemAndBack:@"created_at"]];
    cell.messageReleaseTimeLabel.text = [self changeTime:time];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *tempItem = [self.myDataArray objectAtIndex:indexPath.row];
    if (tempItem!= nil) {
        if (self.block != nil) {
            self.block(1,tempItem);
        }
    }
    
}

-(NSString *)changeTime:(NSString *)timeValue
{
    
    
    
    NSDateFormatter *fromtter = [[NSDateFormatter alloc] init];
    [fromtter setDateFormat:@"YY:MM:dd hh:mm"];
    NSTimeInterval time = [timeValue doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    //NSTimeInterval time1  = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSinceDate:date];
    NSDate *now = [NSDate date];
    NSInteger distanceTime = [now timeIntervalSinceDate:date];
    NSString *timeStr;
    if (distanceTime>24*60*60) {
        timeStr = [fromtter stringFromDate:date];
    } else {
        if (distanceTime < 60) {
            timeStr = @"刚刚";
        } else {
            NSInteger min = (NSInteger)distanceTime/60;
            if (min>=60) {
                //小时
                NSInteger hour = (NSInteger)min/60;
                timeStr = [NSString stringWithFormat:@"%ld小时前",(long)hour];
            }
            else{
                timeStr = [NSString stringWithFormat:@"%ld分钟前",(long)min];
            }
        }
    }    return timeStr;
}



@end
