//
//  DLViewStyle.h
//  DLBase
//
//  Created by lucaslu on 15/12/17.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLStyle.h"

#define DLStyleMake(initCode , cla) \
^{ \
    cla * style = [[cla alloc] init]; \
    {initCode} \
    return style; \
}(); \

#define DLViewStyleMake(initCode)               DLStyleMake(initCode, DLViewStyle)
#define DEF_SHARE_VIEW_STYLE(name , initCode)   DEF_SHARE_STYLE(name , initCode, DLViewStyle)
#define AS_SHARE_VIEW_STYLE(name)           AS_SHARE_STYLE(name, DLViewStyle);

@interface DLViewStyle : DLStyle

AS_FLOAT_ASSIGN(cornerRedius);
AS_FLOAT_ASSIGN(borderWidth);
AS_MODEL_STRONG(UIColor, borderColor);
AS_MODEL_STRONG(UIColor, backgroundColor);
AS_FLOAT_ASSIGN(alpha);
AS_BOOL_ASSIGN(clipsToBounds);
AS_BOOL_ASSIGN(clearsContextBeforeDrawing);
AS_MODEL_STRONG(UIImage, styleBackgroundImage);

@end
