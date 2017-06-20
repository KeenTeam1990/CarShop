//
//  DLUpYunHelper.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/29.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TDLUpYunHelperBlock)(BOOL success,NSString* fileUrl,NSError* error);

@interface DLUpYunHelper : NSObject

AS_SINGLETON(DLUpYunHelper);

+(void)uploadFile:(id)file withBlock:(TDLUpYunHelperBlock)block;

@end
