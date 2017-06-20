//
//  MBannerView.m
//  Auction
//
//  Created by 卢迎志 on 14-12-9.
//
//

#import "MBannerView.h"


@implementation MBannerView

DEF_FACTORY_FRAME(MBannerView);
DEF_MODEL(myDataArray);
DEF_MODEL(myPageView);
DEF_MODEL(myScrollView);
DEF_MODEL(myTimer);
DEF_MODEL(myViewArray);
DEF_MODEL(delegate);

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.myViewArray = [NSMutableArray allocInstance];
        self.myDataArray = [NSMutableArray allocInstance];
        
        self.myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.myScrollView.delegate = self;
        self.myScrollView.pagingEnabled = YES;
        [self.myScrollView setShowsVerticalScrollIndicator:NO];
        [self.myScrollView setShowsHorizontalScrollIndicator:NO];
        [self addSubview:self.myScrollView];
        
        self.myPageView = [DLPageView allocInstanceFrame:CGRectMake(0, self.myScrollView.frame.size.height - 20, self.myScrollView.frame.size.width-20, 20)];
        self.myPageView.hidesForSinglePage = YES;
        self.myPageView.pageAlignment = EPageAlignmentRight;
        [self addSubview:self.myPageView];
        
        [self initTimer];
    }
    return self;
}

-(void)updateViewArray:(NSMutableArray*)data
{
    [self.myDataArray removeAllObjects];
    [self.myDataArray addObjectsFromArray:data];
    
    int x = 0;
    int y = 0;
    
    for (int i=0; i<[self.myViewArray count]; i++) {
        UIView* tempView = [self.myViewArray objectAtIndex:i];
        if (tempView!=nil) {
            [tempView removeFromSuperview];
        }
    }
    
    [self.myViewArray removeAllObjects];
    
    for (int i=0; i<[data count]; i++) {
        M_BannerItemModel* item = [data objectAtIndex:i];
        if (item!=nil) {
            
            UIImageView* tempView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, self.myScrollView.frame.size.width, self.myScrollView.frame.size.height)];
            
            [tempView setImageWithURL:[NSURL URLWithString:item.itemImage] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
            [tempView setClipsToBounds:YES];
            
            tempView.contentMode = UIViewContentModeScaleAspectFill;
            
            [tempView setUserInteractionEnabled:YES];
            UITapGestureRecognizer *tempsingleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
            tempsingleTap.numberOfTapsRequired=1;
            [tempView addGestureRecognizer:tempsingleTap];
            
            tempView.tag = 1000+i;
            
            [self.myScrollView addSubview:tempView];
            [self.myViewArray addObject:tempView];
            
            x += self.myScrollView.frame.size.width;
        }
    }
    
    self.myScrollView.contentSize = CGSizeMake(self.myScrollView.frame.size.width*[data count], self.myScrollView.frame.size.height);
    self.myPageView.numberOfPages = [data count];
    self.myPageView.currentPage = 0;
    
}

-(void)initTimer
{
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.myTimer forMode:NSRunLoopCommonModes];
}

-(void)scrollTimer
{
    NSInteger currPage = self.myPageView.currentPage;
    
    currPage++;
    
    if (currPage > self.myPageView.numberOfPages) {
        currPage = 0;
    }
    self.myPageView.currentPage = currPage;
    
    if (self.myPageView.currentPage == self.myPageView.numberOfPages) {
        self.myPageView.currentPage = 0;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.myScrollView.contentOffset = CGPointMake(self.myScrollView.frame.size.width*self.myPageView.currentPage, 0);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)singleTap:(UITapGestureRecognizer*)gesture
{
    UIView* tempView = (UIView*)gesture.view;
    
    M_BannerItemModel* item = [self.myDataArray objectAtIndex:tempView.tag - 1000];
    
    if ([item.itemUrl isEqualToString:@""]) {
        return;
    }else   	
    {
        if (self.delegate !=nil && [self.delegate respondsToSelector:@selector(bannerItem:)] && item!=nil) {
            [self.delegate bannerItem:item];
        }
    }
 
}

-(void)start
{
    //开启定时器
    [myTimer setFireDate:[NSDate distantPast]];
}
-(void)stop
{
    //关闭定时器
    [myTimer setFireDate:[NSDate distantFuture]];
}

-(void)afterInterval:(float)interval
{
    [myTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.myPageView.currentPage = fabs(self.myScrollView.contentOffset.x)/self.myScrollView.frame.size.width;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self afterInterval:3.0];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stop];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
