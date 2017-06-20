//
//  DLTextFieldStyle.h
//  DLBase
//
//  Created by lucaslu on 15/12/17.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLViewStyle.h"
#import "DLTextStyle.h"

#define DLTextFiledStyleMake(initCode)               DLStyleMake(initCode, DLTextFieldStyle)
#define DEF_SHARE_TEXTFIELD_STYLE(name , initCode)   DEF_SHARE_STYLE(name , initCode, DLTextFieldStyle)
#define AS_SHARE_TEXTFIELD_STYLE(name)               AS_SHARE_STYLE(name, DLTextFieldStyle);


@interface DLTextFieldStyle : DLViewStyle

AS_MODEL_COPY(DLTextStyle, textStyle);

@end
