//
//  H_HomeHeaderView.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/6.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"
#import "MBannerView.h"
#import "DLPageModel.h"
#import "M_IconListView.h"
#import "LL_HomeListView.h"
@protocol HeaderDelegate <NSObject>

-(void)selectIconForTag:(NSInteger)tag withModel:(id)data;

-(void)tapBannerModel:(M_BannerItemModel*)model;

@end

@interface H_HomeHeaderView : DLView<MBannerViewDelegate>

AS_FACTORY_FRAME(H_HomeHeaderView);

AS_MODEL_STRONG(MBannerView,myBannerView);
AS_MODEL_STRONG(M_IconListView, myIconListView);
AS_MODEL_STRONG(LL_HomeListView, myLLIconListView);
@property(nonatomic, assign) id<HeaderDelegate>delegate;

AS_MODEL_STRONG(NSArray ,myImage);
AS_MODEL_STRONG(NSArray ,myTitle);

-(void)updateBannerData:(NSMutableArray*)array;
-(void)updateIconData:(NSMutableArray*)array;

-(void)updatePoints_Sign;

-(void)showAniw;

@end
