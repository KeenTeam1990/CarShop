//
//  DLBaseModel.m
//  TickTock
//
//  Created by 卢迎志 on 14-11-26.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import "DLBaseModel.h"

@implementation DLBaseModel

DEF_MODEL(run_mess);
DEF_MODEL(run_number);
DEF_MODEL(data);
DEF_MODEL(httpBackData);
DEF_MODEL(run_timestamp);

-(id)init
{
    self = [super init];
    if (self) {
        self.run_number = 0;
        self.run_mess = nil;
        self.run_timestamp = nil;
        self.myPageModel = [DLPageModel allocInstance];
    }
    return self;
}

-(void)parseData:(NSString*)str
{
    NSDictionary* tempData = [str JSONValue];
    if (tempData !=nil) {
        
        self.data = tempData;
        self.httpBackData = str;
        
        self.run_number = [[tempData hasItemAndBack:@"code"] integerValue];
        self.run_mess = [tempData hasItemAndBack:@"message"];
        self.run_timestamp = [tempData hasItemAndBack:@"timestamp"];
        
            
        if (self.run_number == 0) {
            [self parseDataDic:tempData];
        }
    }
}

-(void)parseDataDic:(NSDictionary*)str
{
    
}

@end
