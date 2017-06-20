//
//  DLHttpHelper.h
//  TickTock
//
//  Created by 卢迎志 on 14-12-5.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DLHttpHelper : NSObject

+(BOOL)isNetworkReachable;

+(void)GetData:(NSString*)url
withParameters:(NSDictionary*)params
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSString *error))failure;

+(void)PostData:(NSString*)url
 withParameters:(NSDictionary*)params
        success:(void (^)(id responseObject))success
        failure:(void (^)(NSString *error))failure;

+(void)PostFormData:(NSString*)url
     withParameters:(NSDictionary*)params
       withFormData:(NSMutableArray*)formdata
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSString *error))failure;

+(void)PostJsonData:(NSString*)url
     withParameters:(NSDictionary*)params
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSString *error))failure;

@end
