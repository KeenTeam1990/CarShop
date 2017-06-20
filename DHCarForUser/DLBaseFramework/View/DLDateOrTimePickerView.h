//
//  DLDateOrTimePickerView.h
//  jintaitravel
//
//  Created by 卢迎志 on 15-4-21.
//  Copyright (c) 2015年 卢迎志. All rights reserved.
//

#import "DLView.h"

//tag
//0 cancel
//1 sure
typedef void (^TDateOrTimePickerViewBlock)(int tag,id data);

@interface DLDateOrTimePickerView : DLView

AS_FACTORY_FRAME(DLDateOrTimePickerView);

AS_BLOCK(TDateOrTimePickerViewBlock, block);

AS_MODEL_STRONG(UILabel, myTitleLabel);
AS_MODEL_STRONG(UIButton, mySureBtn);
AS_MODEL_STRONG(UIButton, myCancelBtn);
AS_MODEL_STRONG(UIDatePicker, myPickerView);
AS_MODEL_STRONG(UIImageView, myTitleBackView);
AS_MODEL_STRONG(UIView, myView);

AS_MODEL_STRONG(NSDate, currDate);

AS_BOOL(showIsDate);

-(void)updateViewData:(NSString*)title withData:(NSDate*)date withMode:(BOOL)showDate;

-(void)setMaxTime:(NSDate*)maxDate withMinTime:(NSDate*)minDate;

-(void)startAnimation;
-(void)stopAnimation;

@end
