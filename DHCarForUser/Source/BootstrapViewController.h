//
//  BootstrapViewController.h
//  TickTock
//
//  Created by 卢迎志 on 14-11-26.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BootstrapViewController : UIViewController<UIScrollViewDelegate>

AS_FACTORY(BootstrapViewController);

AS_MODEL_STRONG(UIScrollView, myScrollView);

AS_MODEL_STRONG(UIPageControl, myPageView);

@end
