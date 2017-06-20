//
//  DH_ADModel.m
//  DHCarForUser
//
//  Created by 张海亮 on 16/4/5.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DH_ADModel.h"

@implementation DH_ADModel

-(void)parseDataDic:(NSDictionary *)str
{
    NSDictionary* tempItemDic = [str hasItemAndBack:@"result"];
    if (tempItemDic != nil) {
        self.imageUrl = [tempItemDic hasItemAndBack:@"pic"];
        NSString *webUrl = [tempItemDic hasItemAndBack:@"url"];
        if (webUrl !=nil) {
            [[NSUserDefaults standardUserDefaults] setObject:webUrl forKey:@"web_url"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

@end
