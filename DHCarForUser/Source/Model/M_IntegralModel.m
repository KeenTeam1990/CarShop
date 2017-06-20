//
//  M_IntegralModel.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/12.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_IntegralModel.h"

@implementation M_IntegralTtemModel

DEF_FACTORY(M_IntegralTtemModel)

@synthesize gold_id;//ID
@synthesize gold_type;//类型，1 增加，2 消费
@synthesize gold_number;//数量
@synthesize gold_name;//名称
@synthesize gold_memo;//附加项
@synthesize gold_time;//时间

@end

@implementation M_IntegralModel

DEF_FACTORY(M_IntegralModel);
DEF_MODEL(itemArray);

-(id)init
{
    self = [super init];
    if (self) {
        self.itemArray = [NSMutableArray allocInstance];
    }
    return self;
}

-(void)parseDataDic:(NSDictionary *)str
{
    NSDictionary* tempDic = str;
    if (tempDic!=nil) {
        NSDictionary *newDic = [tempDic hasItemAndBack:@"gold"];
//        self.totalCount = [[newDic hasItemAndBack:@"count"]integerValue];
        NSArray *tempArray = [newDic hasItemAndBack:@"item"];
        if (tempArray !=nil) {
            
            for (int i = 0; i<[tempArray count]; i++) {
                NSDictionary *tempItemDic = [tempArray objectAtIndex:i];
                if (tempItemDic !=nil) {
                    
                    M_IntegralTtemModel *integralTtemModel = [M_IntegralTtemModel allocInstance];
                    
                    integralTtemModel.gold_id = [tempItemDic hasItemAndBack:@"gold_id"];
                    integralTtemModel.gold_type = [tempItemDic hasItemAndBack:@"gold_type"];
                    integralTtemModel.gold_number= [tempItemDic hasItemAndBack:@"gold_number"];
                    integralTtemModel.gold_name = [tempItemDic hasItemAndBack:@"gold_name"];
                    integralTtemModel.gold_memo = [tempItemDic hasItemAndBack:@"gold_memo"];
                    integralTtemModel.gold_time = [tempItemDic hasItemAndBack:@"gold_time"];
                    
                    [self.itemArray addObject:integralTtemModel];
                }
            }
        }
        
    }
}

@end
