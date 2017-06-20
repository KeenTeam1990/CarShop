//
//  MBannerView.h
//  Auction
//
//  Created by 卢迎志 on 14-12-9.
//
//

#import "M_BannerItemModel.h"
#import "DLPageView.h"

@protocol MBannerViewDelegate <NSObject>

-(void)bannerItem:(M_BannerItemModel*)data;

@end

@interface MBannerView : UIView<UIScrollViewDelegate>

AS_FACTORY_FRAME(MBannerView);

AS_DELEGATE(id<MBannerViewDelegate>, delegate);

AS_MODEL_STRONG(UIScrollView, myScrollView);
AS_MODEL_STRONG(DLPageView, myPageView);
AS_MODEL_STRONG(NSMutableArray, myDataArray);
AS_MODEL_STRONG(NSMutableArray, myViewArray);
AS_MODEL_STRONG(NSTimer, myTimer);

-(void)updateViewArray:(NSMutableArray*)data;

-(void)start;
-(void)stop;

@end
