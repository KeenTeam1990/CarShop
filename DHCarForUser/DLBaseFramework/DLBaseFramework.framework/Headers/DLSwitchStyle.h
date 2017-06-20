//
//  DLSwitchStyle.h
//  DLBase
//
//  Created by lucaslu on 15/12/17.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLViewStyle.h"

#define DLSwitchStyleMake(initCode)               DLStyleMake       (initCode,  DLSwitchStyle )
#define DEF_SHARE_SWITCH_STYLE(name , initCode)   DEF_SHARE_STYLE   (name , initCode, DLSwitchStyle)
#define AS_SHARE_SWITCH_STYLE(name)               AS_SHARE_STYLE    (name, DLSwitchStyle  );

@interface DLSwitchStyle : DLViewStyle

AS_MODEL_STRONG(UIColor, onTintColor);
AS_MODEL_STRONG(UIColor, tintColor);
AS_MODEL_STRONG(UIColor, thumbTintColor);

@end
