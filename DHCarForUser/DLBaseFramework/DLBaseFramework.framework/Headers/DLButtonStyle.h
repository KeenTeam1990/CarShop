//
//  DLButtonStyle.h
//  DLBase
//
//  Created by lucaslu on 15/12/17.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLViewStyle.h"
#import "DLButtonStateStyle.h"

#define DLButtonStyleMake(initCode)                 DLStyleMake(initCode, DLButtonStyle)
#define DEF_SHARE_BUTTON_STYLE(name , initCode)     DEF_SHARE_STYLE(name , initCode, DLButtonStyle)
#define AS_SHARE_BUTTON_STYLE(name)                 AS_SHARE_STYLE(name, DLButtonStyle);


@interface DLButtonStyle : DLViewStyle

AS_MODEL_COPY(DLButtonStateStyle, normalStyle);
AS_MODEL_COPY(DLButtonStateStyle, disabledStyle);
AS_MODEL_COPY(DLButtonStateStyle, hightlightedStyle);

@end
