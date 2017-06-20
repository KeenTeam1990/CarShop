//
//  DLLabelStyle.h
//  DLBase
//
//  Created by lucaslu on 15/12/17.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLViewStyle.h"
#import "DLTextStyle.h"

#define DLLabelStyleMake(initCode)               DLStyleMake(initCode, DLLabelStyle)
#define DEF_SHARE_LABEL_STYLE(name , initCode)   DEF_SHARE_STYLE(name , initCode, DLLabelStyle)
#define AS_SHARE_LABEL_STYLE(name)               AS_SHARE_STYLE(name, DLLabelStyle);

@interface DLLabelStyle : DLViewStyle

AS_MODEL_COPY(DLTextStyle, textStyle);
AS_MODEL_STRONG(UIColor, highlightedTextColor);
AS_MODEL_STRONG(UIColor, shadowColor);
AS_SIZE_ASSIGN(shadowOffset);
AS_FLOAT(adjustsFontSizeToFitWidth);
AS_MODEL_ASSIGN(NSTextAlignment,textAlignment);

@end
