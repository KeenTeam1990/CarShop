//
//  DLBaseModel.h
//  TickTock
//
//  Created by 卢迎志 on 14-11-26.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLPageModel.h"

#pragma mark -

@interface DLBaseModel : NSObject

AS_INT(run_number);
AS_MODEL_STRONG(NSString, run_mess);
AS_MODEL_STRONG(NSString, run_timestamp);
AS_MODEL_STRONG(NSDictionary,data);

AS_MODEL_STRONG(NSString,httpBackData);

AS_MODEL_STRONG(DLPageModel, myPageModel);

-(void)parseData:(NSString*)str;
-(void)parseDataDic:(NSDictionary*)str;

@end
