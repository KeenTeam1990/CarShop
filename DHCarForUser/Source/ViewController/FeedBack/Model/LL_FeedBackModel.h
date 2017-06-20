//
//  LL_FeedBackModel.h
//  DHCarForUser
//
//  Created by leiyu on 15/12/27.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface LL_FeedBackModel : DLBaseModel
AS_MODEL_STRONG(NSString, content);
AS_MODEL_STRONG(NSString, created_at);
AS_MODEL_STRONG(NSString, is_failed);
AS_MODEL_STRONG(NSString, reply_id);
AS_MODEL_STRONG(NSString, type);
AS_MODEL_STRONG(NSString, audio);
AS_MODEL_STRONG(NSString, audio_length)
AS_MODEL_STRONG(NSString, pic_id);
@end
