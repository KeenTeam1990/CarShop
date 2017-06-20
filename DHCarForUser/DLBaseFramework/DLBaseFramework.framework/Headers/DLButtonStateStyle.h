//
//  DLButtonStateStyle.h
//  DLBase
//
//  Created by lucaslu on 15/12/17.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLStyle.h"

#define DLButtonStateStyleMake(initCode)               DLStyleMake(initCode, DLButtonStateStyle)
#define DEF_SHARE_BUTTON_STATE_STYLE(name , initCode)  DEF_SHARE_STYLE(name , initCode, DLButtonStateStyle)
#define AS_SHARE_BUTTON_STATE_STYLE(name)              AS_SHARE_STYLE(name, DLButtonStateStyle);

@interface DLButtonStateStyle : DLStyle

AS_MODEL_ASSIGN(UIControlState, state);
AS_MODEL_STRONG(UIColor, titleColor);
AS_MODEL_STRONG(UIColor, titleShadowColor);
AS_MODEL_STRONG(UIImage, backgroundImage);

@end
