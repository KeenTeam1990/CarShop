//
//  DLCache.h
//  TickTock
//
//  Created by 卢迎志 on 14-12-5.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DLModel.h"
#import "DLSingleton.h"

@interface DLCache : NSObject

AS_SINGLETON(DLCache);

AS_MODEL_STRONG(NSString, cachePath);
AS_MODEL_STRONG(NSString, cacheUser);

+(NSString*)docToUserDir;
+(NSString*)libCachesToTemp;
+(NSString*)libCachesToUser;

+(BOOL)isFileExists:(NSString*)filePath;
+(BOOL)isDirExists:(NSString*)dirPath;
+(void)createNewDir:(NSString*)path;
+(BOOL)removeItem:(NSString*)path;

//document save
+(void)writeString:(NSString*)string toDocumentPath:(NSString*)path;
+(NSString*)getStringFromDocumentPath:(NSString*)path;

+(void)writeData:(NSData*)data toDocumentPath:(NSString*)path;
+(NSData*)getDataFromDocumentPath:(NSString*)path;

+(void)writeImage:(UIImage*)image toDocumentPath:(NSString*)path;
+(UIImage*)getImageFromDocumentPath:(NSString*)path;

+(void)writeArray:(NSMutableArray*)array toDocumentPath:(NSString*)path;
+(NSMutableArray*)getArrayFromDocumentPath:(NSString*)path;

+(void)writeDictionary:(NSMutableDictionary*)dictionary toDocumentPath:(NSString*)path;
+(NSMutableDictionary*)getDictionaryFromDocumentPath:(NSString*)path;

@end
