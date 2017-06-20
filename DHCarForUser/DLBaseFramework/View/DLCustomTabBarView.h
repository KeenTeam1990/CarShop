//
//  DLCustomTabBarView.h
//  TickTock
//
//  Created by 卢迎志 on 14-11-26.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DLCustomTabBarViewDelegate <NSObject>

-(void)seleteTabBar:(NSInteger)tag;

@end

@interface DLCustomTabBarView : UIView

AS_FACTORY_FRAME(DLCustomTabBarView);

AS_DELEGATE(id<DLCustomTabBarViewDelegate>,delegate);

AS_MODEL_STRONG(NSMutableArray, itemArray);
AS_MODEL_STRONG(UIImageView, seleteImageView);
AS_MODEL_STRONG(NSString, seleteImage);
AS_MODEL_STRONG(NSString, backImage);
AS_MODEL_STRONG(NSMutableArray, tabItemArray);

-(void)seleteTabIndex:(int)tag;
-(void)addTabItem:(NSString*)title withIcon:(NSString*)icon withIcon_H:(NSString*)icon_h;
-(void)addTabItem:(DLTabItemModel*)item;
-(void)updateData;

@end
