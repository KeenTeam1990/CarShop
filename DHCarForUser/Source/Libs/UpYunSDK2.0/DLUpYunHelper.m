//
//  DLUpYunHelper.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/29.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLUpYunHelper.h"
#import "UpYun.h"

@implementation DLUpYunHelper

DEF_SINGLETON(DLUpYunHelper);

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

+(void)uploadFile:(id)file withBlock:(TDLUpYunHelperBlock)block
{
    [SVProgressHUD showWithStatus:@"请等待..."];
    
    UpYun *uy = [[UpYun alloc] init];
    uy.successBlocker = ^(id data)
    {
        [SVProgressHUD dismiss];
        NSLog(@"%@",data);
        
        NSDictionary* tempDic = data;
        if (tempDic!=nil) {
            
            NSString* tempUrl = [NSString stringWithFormat:@"%@",[tempDic hasItemAndBack:@"url"]];
            NSLog(@"upload return url:%@",tempUrl);
            if ([tempUrl notEmpty]) {
                if (block!=nil) {
                    block(YES,tempUrl,nil);
                }
            }
        }
    };
    uy.failBlocker = ^(NSError * error)
    {
        [SVProgressHUD dismiss];
        NSLog(@"%@",error);
        if (block!=nil) {
            block(NO,nil,error);
        }
    };
    
    [uy uploadFile:file saveKey:[self getSaveKey]];
}

+(NSString * )getSaveKey {
    /**
     *	@brief	方式1 由开发者生成saveKey
     */
    NSDate *d = [NSDate date];
    return [NSString stringWithFormat:@"/upload/dhqc_user/%ld/%ld/%.0f.png",[self getYear:d],[self getMonth:d],[[NSDate date] timeIntervalSince1970]];
}

+ (NSInteger)getYear:(NSDate *) date{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    NSInteger year=[comps year];
    return year;
}

+ (NSInteger)getMonth:(NSDate *) date{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    NSInteger month = [comps month];
    return month;
}

@end
