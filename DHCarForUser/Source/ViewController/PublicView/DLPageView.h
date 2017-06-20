//
//  DLPageView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/20.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"

typedef enum {
    EPageAlignmentDefault,
    EPageAlignmentLeft,
    EPageAlignmentRight,
    EPageAlignmentCenter
    
}TPageAlignment;

@interface DLPageView : DLView

AS_FACTORY_FRAME(DLPageView);

AS_INT(numberOfPages);
AS_INT(currentPage);

AS_MODEL(TPageAlignment, pageAlignment);

AS_BOOL(hidesForSinglePage);

AS_MODEL_STRONG(UIColor, currColor);
AS_MODEL_STRONG(UIColor, otherColor);

@end
