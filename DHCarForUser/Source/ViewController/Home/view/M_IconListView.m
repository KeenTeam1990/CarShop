//
//  M_IconListView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/18.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_IconListView.h"
#import "M_IconView.h"
#import "DLPageView.h"

@interface M_IconListView ()<UIScrollViewDelegate>

AS_MODEL_STRONG(UIScrollView, myScrollView);
AS_MODEL_STRONG(DLPageView, myPageView);

AS_MODEL_STRONG(NSMutableArray, myViewArray);
AS_MODEL_STRONG(NSMutableArray, myDataArray);

AS_MODEL_STRONG(UILabel, integralLabel);

@end

@implementation M_IconListView

DEF_FACTORY_FRAME(M_IconListView);
DEF_MODEL(myScrollView);
DEF_MODEL(block);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.myViewArray = [NSMutableArray allocInstance];
        self.myDataArray = [NSMutableArray allocInstance];
        
        self.myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-10)];
        self.myScrollView.delegate = self;
        self.myScrollView.pagingEnabled = YES;
        [self.myScrollView setShowsVerticalScrollIndicator:NO];
        [self.myScrollView setShowsHorizontalScrollIndicator:NO];
        [self addSubview:self.myScrollView];
        
        self.myPageView = [DLPageView allocInstanceFrame:CGRectMake(0, frame.size.height - 15, frame.size.width, 10)];
        self.myPageView.hidesForSinglePage = YES;
        [self addSubview:self.myPageView];
        
    }
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.myPageView.currentPage = fabs(self.myScrollView.contentOffset.x)/self.myScrollView.frame.size.width;
}

-(void)updateViewArray:(NSMutableArray*)data
{
    [self.myDataArray removeAllObjects];
    [self.myDataArray addObjectsFromArray:data];
    
    NSInteger pageNum = data.count;
    NSInteger page_HangNum = 3;
    NSInteger page_LieNum = data.count/page_HangNum;
    
    NSInteger x = 0;
    NSInteger y = 0;
    NSInteger w = self.myScrollView.frame.size.width/page_HangNum;
    NSInteger h = self.myScrollView.frame.size.height/page_LieNum;
    
    for (int i=0; i<[self.myViewArray count]; i++) {
        UIView* tempView = [self.myViewArray objectAtIndex:i];
        if (tempView!=nil) {
            [tempView removeFromSuperview];
        }
    }
    
    [self.myViewArray removeAllObjects];
    
    NSInteger count = [data count];
    
    NSInteger pageCount = count%pageNum==0?count/pageNum:(count/pageNum)+1;
    NSInteger pageIndex = 0;
    
    for (int i=0; i<count; i++) {
        M_BannerItemModel* item = [data objectAtIndex:i];
        if (item!=nil) {
            
            M_IconView* tempView = [[M_IconView alloc]initWithFrame:CGRectMake(x, y, w, h)];
            tempView.showNum = NO;
            tempView.tag = 1000+i;

            [tempView updateModel:item.itemImage withText:item.itemName];
            
            tempView.block = ^(NSInteger tag){
                
                M_BannerItemModel* tempItem = [self.myDataArray objectAtIndex:tag-1000];
                if (self.block!=nil && tempItem!=nil) {
                    self.block(tag,tempItem);
                }
            };
            
            if (i == 0) {
                self.integralLabel = [[UILabel alloc]initWithFrame:CGRectMake(x+(w-30)/2, 5, 30, 24)];
                self.integralLabel.tag = 1005;
                self.integralLabel.text = @"+5";
                self.integralLabel.textColor = RGBCOLOR(252, 41, 42);
                self.integralLabel.alpha = 0;
                self.integralLabel.font = [UIFont boldSystemFontOfSize:14];
                self.integralLabel.textAlignment = NSTextAlignmentCenter;
                [self.myScrollView addSubview:self.integralLabel];
            }
            
            [self.myScrollView addSubview:tempView];
            [self.myViewArray addObject:tempView];
            
            NSInteger tempIndex = i;
            
            if (tempIndex!=0 && (tempIndex+1)%page_HangNum==0) {
                if (tempIndex!=0 && (tempIndex+1)%pageNum==0) {
                    pageIndex++;
                    x=self.myScrollView.frame.size.width*pageIndex;
                    y=0;
                }else{
                    x=self.myScrollView.frame.size.width*pageIndex;
                    y+=h;
                }
            }else{
                x+=w;
            }
        }
    }
    
    self.myScrollView.contentSize = CGSizeMake(self.myScrollView.frame.size.width*pageCount, self.myScrollView.frame.size.height);
    self.myPageView.numberOfPages = pageCount;
    self.myPageView.currentPage = 0;
}

-(void)showAniw
{
    self.integralLabel.alpha = 100;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.integralLabel.alpha = 0;
                         CGRect tempFrame = self.integralLabel.frame;
                         tempFrame.origin.y = -5;
                         self.integralLabel.frame = tempFrame;
                     } completion:^(BOOL finished) {
                         CGRect tempFrame = self.integralLabel.frame;
                         tempFrame.origin.y = 5;
                         self.integralLabel.frame = tempFrame;
                     }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
