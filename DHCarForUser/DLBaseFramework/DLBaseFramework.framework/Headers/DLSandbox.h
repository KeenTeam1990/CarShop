//
//  DLSandbox.h
//  TickTock
//
//  Created by 卢迎志 on 14-11-28.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLModel.h"
#import "DLSingleton.h"

@interface DLSandbox : NSObject

AS_SINGLETON(DLSandbox);

AS_MODEL_READONLY(NSString, appPath);
AS_MODEL_READONLY(NSString, docPath);
AS_MODEL_READONLY(NSString, libPrefPath);
AS_MODEL_READONLY(NSString, libCachePath);
AS_MODEL_READONLY(NSString, tmpPath);

+ (NSString *)appPath;		// 程序目录，不能存任何东西
+ (NSString *)docPath;		// 文档目录，需要ITUNES同步备份的数据存这里
+ (NSString *)libPrefPath;	// 配置目录，配置文件存这里
+ (NSString *)libCachePath;	// 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)tmpPath;		// 缓存目录，APP退出后，系统可能会删除这里的内容

@end
