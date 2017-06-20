//
//  DLSegementStyle.h
//  DLBase
//
//  Created by lucaslu on 15/12/17.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLViewStyle.h"

#define DLSegementStyleMake(initCode)               DLStyleMake (initCode,  DLSegementStyle  )
#define DEF_SHARE_SEGMENT_STYLE(name , initCode)    DEF_SHARE_STYLE (name ,initCode,  DLSegementStyle)
#define AS_SHARE_SEGMENT_STYLE(name)            AS_SHARE_STYLE(name,  DLSegementStyle

@interface DLSegementStyle : DLViewStyle

@end
