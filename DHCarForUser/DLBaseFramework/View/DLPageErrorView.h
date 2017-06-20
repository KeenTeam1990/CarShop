//
//  DLPageErrorView.h
//  DHCarForUser
//
//  Created by lucaslu on 16/1/2.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLView.h"

typedef void (^TPageErrorViewBlock)(NSInteger tag);

@interface DLPageErrorView : DLView

AS_FACTORY_FRAME(DLPageErrorView);

AS_BLOCK(TPageErrorViewBlock, block);

AS_MODEL_STRONG(UIImage, myIcon);
AS_MODEL_STRONG(UILabel, myTitleLable);
AS_MODEL_STRONG(UILabel, myMessLable);
AS_BOOL(isError);
@end
