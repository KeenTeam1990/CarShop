//
//  DLInfinitePageScrollViewController.h
//  Traderoute
//
//  Created by 卢迎志 on 15-3-10.
//  Copyright (c) 2015年 卢迎志. All rights reserved.
//  循环滚动条

#import <UIKit/UIKit.h>

/*
 活动滚动页面
 实现循环的页面滚动
 */

@protocol DLInfinitePageScrollViewControllerDelegate;

@interface DLInfinitePageScrollViewController : UIViewController<UIScrollViewDelegate>

AS_FACTORY(DLInfinitePageScrollViewController);

AS_MODEL_STRONG(NSArray, pageViewControllers);//存取循环滚动页面数组
AS_MODEL_STRONG(UIScrollView, scrollView); //存取循环滚动页面滚动条

AS_BOOL(isScrolling);

@property (weak, nonatomic) NSObject <DLInfinitePageScrollViewControllerDelegate> *delegate; //点击滚动界面的代理

- (id)initWithViewControllers:(NSArray *)viewControllers;         //初始化循环页面数组
- (void)addViewConstraints:(NSArray *)viewConteollers;
- (void)clearControllers;
- (void)setCurrentPageIndex:(NSUInteger)index;                    //设置当前页面位置索引
- (void)scrollByRawIndex:(CGFloat)rawIndex;                       //滚动到索引位置
- (void)nextPage;                                                 //滚动页面上一页
- (void)prevPage;                                                 //滚动页面下一页


@end


/*
 滚动时的相关处理方法
 1.开始滚动的回掉
 2.结束滚动的回掉
 3.滚动到偏移量回掉
 4.滚动到目标索引位置回掉
 */
@protocol DLInfinitePageScrollViewControllerDelegate
@optional
- (void)infiniteScrollViewDidBeginScrolling:(DLInfinitePageScrollViewController *)scrollViewController;
- (void)infiniteScrollViewDidEndScrolling:(DLInfinitePageScrollViewController *)scrollViewController;
- (void)infiniteScrollView:(DLInfinitePageScrollViewController *)scrollViewController didScrollToContentOffset:(CGPoint)offset;
- (void)infiniteScrollView:(DLInfinitePageScrollViewController *)scrollViewController didScrollToIndex:(NSUInteger)index;
- (void)infiniteScrollView:(DLInfinitePageScrollViewController *)scrollViewController didScrollToRawIndex:(CGFloat)index; // decimal value of the position of the view.
@end
