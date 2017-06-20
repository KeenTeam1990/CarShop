//
//  Dh_LoginModel.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/10/28.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "Dh_LoginModel.h"

@implementation Dh_LoginModel


DEF_FACTORY(Dh_LoginModel);

-(void)parseDataDic:(NSDictionary *)str
{
    NSDictionary* tempDic = str;
    
    if (tempDic!=nil) {
        
        NSDictionary* tempUser = [tempDic hasItemAndBack:@"user"];
        if (tempUser!=nil) {
            
            [DLAppData sharedInstance].myUserKey = [tempUser hasItemAndBack:@"user_key"];
            [[DLUserDefaults sharedInstance] setObject:[DLAppData sharedInstance].myUserKey forKey:@"uid"];
        }
    }
}

@end
