//
//  DLPickerView.h
//  Traderoute
//
//  Created by 卢迎志 on 15-1-27.
//  Copyright (c) 2015年 卢迎志. All rights reserved.
//

#import "DLView.h"

#define PopSubArray         @"subarray"
#define PopText             @"text"
#define PopResultFirst      @"first"
#define PopResultSecond     @"second"
#define PopResultThree      @"three"

#define KPICKER_FIRST       @"default_first"
#define KPICKER_SECOND      @"default_second"
#define KPICKER_THREE       @"default_three"

@protocol DLPickerViewDelegate <NSObject>

-(void)pickerSureBtnPressed:(NSString*)seleteValue;
-(void)pickerCancelBtnPressed;

@end

@interface DLPickerView : DLView<UIPickerViewDelegate,UIPickerViewDataSource>

AS_FACTORY_FRAME(DLPickerView);

AS_DELEGATE(id<DLPickerViewDelegate>, delegate);

AS_MODEL_STRONG(NSDictionary, myDefaultDic);

AS_MODEL_STRONG(DLPickerDataSource, myDataSource);
AS_MODEL_STRONG(UILabel, myTitleLabel);
AS_MODEL_STRONG(UIButton, mySureBtn);
AS_MODEL_STRONG(UIButton, myCancelBtn);
AS_MODEL_STRONG(UIPickerView, myPickerView);
AS_MODEL_STRONG(UIImageView, myTitleBackView);
AS_MODEL_STRONG(UIView, myView);

-(void)updateViewData:(NSString*)title withData:(DLPickerDataSource*)data withDefault:(NSDictionary*)dic;

-(void)startAnimation;
-(void)stopAnimation;

@end
