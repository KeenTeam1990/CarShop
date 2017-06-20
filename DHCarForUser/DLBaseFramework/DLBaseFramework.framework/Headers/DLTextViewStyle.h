//
//  DLTextViewStyle.h
//  DLBase
//
//  Created by lucaslu on 15/12/17.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLViewStyle.h"

#define DLTextViewStyleMake(initCode)               DLStyleMake(initCode, DLTextViewStyle)
#define DEF_SHARE_TEXTVIEW_STYLE(name , initCode)   DEF_SHARE_STYLE(name , initCode, DLTextViewStyle)
#define AS_SHARE_TEXTVIEW_STYLE(name)               AS_SHARE_STYLE(name, DLTextViewStyle);

@interface DLTextViewStyle : DLViewStyle



@end
