//
//  DLTextStyle.h
//  DLBase
//
//  Created by lucaslu on 15/12/17.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLStyle.h"

#define DLTextStyleMake(initCode)               DLStyleMake(initCode,  DLTextStyle  )
#define DEF_SHARE_TEXT_STYLE(name , initCode)   DEF_SHARE_STYLE(name , initCode,  DLTextStyle)
#define AS_SHARE_TEXT_STYLE(name)               AS_SHARE_STYLE(name, DLTextStyle   );

@interface DLTextStyle : DLStyle

AS_MODEL_STRONG(UIFont, font);
AS_MODEL_STRONG(UIColor, textColor);

@end
