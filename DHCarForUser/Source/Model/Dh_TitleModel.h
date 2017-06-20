//
//  Dh_TitleModel.h
//  DHCarForUser
//
//  Created by 张海亮 on 16/4/3.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface Dh_TitleModel : DLBaseModel

AS_MODEL_STRONG(NSString, has_more);//文章ID
AS_MODEL_STRONG(NSNumber, next_max);//文章标题


AS_MODEL_STRONG(NSArray, allTitle);//所有文章


@end
