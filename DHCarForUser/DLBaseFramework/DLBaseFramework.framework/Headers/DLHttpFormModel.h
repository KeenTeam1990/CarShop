//
//  DLHttpFormModel.h
//  TickTock
//
//  Created by 卢迎志 on 14-12-6.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLFactory.h"
#import "DLModel.h"

@interface DLHttpFormModel : NSObject

AS_FACTORY(DLHttpFormModel);

AS_MODEL_STRONG(NSString, filepath);
AS_MODEL_STRONG(NSString, filekey);

AS_MODEL_STRONG(NSURL, fileUrl);

@end
