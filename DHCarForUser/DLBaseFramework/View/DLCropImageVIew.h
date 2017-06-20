//
//  DLCropImageVIew.h
//  TickTock
//
//  Created by 卢迎志 on 14-12-12.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLCropImageVIew : UIView<UIGestureRecognizerDelegate,UIScrollViewDelegate>

AS_FACTORY_FRAME(DLCropImageVIew);

AS_MODEL_STRONG(UIScrollView, myScrollview);
AS_MODEL_STRONG(UIImageView, myCropRectView);
AS_MODEL_STRONG(UIImage, myImage);
AS_MODEL_STRONG(UIImageView, myImageView);
AS_MODEL_STRONG(UIView, myZoomView);

AS_RECT(myCropRect);

-(UIImage*)CropImage;

@end
