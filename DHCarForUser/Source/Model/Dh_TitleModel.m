//
//  Dh_TitleModel.m
//  DHCarForUser
//
//  Created by 张海亮 on 16/4/3.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "Dh_TitleModel.h"

@implementation Dh_TitleModel


-(void)parseDataDic:(NSDictionary *)str
{

    NSDictionary* tempItemDic = [str hasItemAndBack:@"result"];
    
    if (tempItemDic!=nil) {
        self.myPageModel.count = [NSString fromString:[tempItemDic hasItemAndBack:@"count"]];
        self.myPageModel.limit = [NSString fromString:[tempItemDic hasItemAndBack:@"limit"]];
        self.myPageModel.hasMore = [[tempItemDic hasItemAndBack:@"has_more"] boolValue];
        if ([Unity isBlank:[tempItemDic hasItemAndBack:@"next_max"]]) {
            self.myPageModel.nextMax = nil;
        }else{
            self.myPageModel.nextMax = [NSString fromString:[tempItemDic hasItemAndBack:@"next_max"]];
        }
        
        self.allTitle = [tempItemDic hasItemAndBack:@"data"];
    }
}

@end
