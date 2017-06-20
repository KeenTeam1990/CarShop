
//
//  LL_GetScanUrlModel.m
//  DHCarForUser
//
//  Created by leiyu on 16/4/18.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "LL_GetScanUrlModel.h"

@implementation LL_GetScanUrlModel
-(void)parseDataDic:(NSDictionary *)str
{
    self.myResult = [str hasItemAndBack:@"result"];
    
}

@end
