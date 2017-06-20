//
//  DLPlaceHolderTextView.h
//  TickTock
//
//  Created by 卢迎志 on 14-12-3.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLPlaceHolderTextView : UITextView

AS_FACTORY_FRAME(DLPlaceHolderTextView);

AS_MODEL_STRONG(NSString, placeholder);
AS_MODEL_STRONG(UIColor, placeholderColor);

-(void)textChanged:(NSNotification *)notification;
-(void)dealloc;

@end
