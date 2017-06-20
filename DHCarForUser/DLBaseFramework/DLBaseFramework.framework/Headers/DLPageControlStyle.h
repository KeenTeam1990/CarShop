//
//  DLPageControlStyle.h
//  DLBase
//
//  Created by lucaslu on 15/12/17.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLViewStyle.h"

#define DLPageControlStyleMake(initCode)                DLStyleMake           (initCode,  DLPageControlStyle                      )
#define DEF_SHARE_PAGE_CONTROL_STYLE(name , initCode)   DEF_SHARE_STYLE       (name ,     initCode,             DLPageControlStyle)
#define AS_SHARE_PAGE_CONTROL_STYLE(name)               AS_SHARE_STYLE    (name,      DLPageControlStyle                    );

@interface DLPageControlStyle : DLViewStyle

@end
