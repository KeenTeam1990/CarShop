//
//  M_OrderAddModel.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/15.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_OrderAddModel.h"


@implementation M_OrderAddModel

DEF_FACTORY(M_OrderAddModel);

DEF_MODEL(order_id);
DEF_MODEL(order_num);
DEF_MODEL(order_price);

-(void)parseDataDic:(NSDictionary *)str
{
    self.order_id  = [str hasItemAndBack:@"order_id"];
    self.order_num  = [str hasItemAndBack:@"order_num"];
}

-(void)parseGasData:(NSString*)data
{
    NSDictionary* tempData = [data JSONValue];
    if (tempData !=nil) {
        
        self.data = tempData;
        self.httpBackData = data;
        
        NSDictionary* tempDic = [tempData hasItemAndBack:@"query"];
        
        if (tempDic!=nil) {
            self.run_number = [[tempDic hasItemAndBack:@"run_number"] integerValue];
            self.run_mess = [tempDic hasItemAndBack:@"run_mess"];
        }
        
        if (self.run_number == 1) {
            NSDictionary* tempOrder = [tempData hasItemAndBack:@"order"];
            if (tempOrder!=nil) {
                self.order_num  = [tempOrder hasItemAndBack:@"order_num"];
                self.order_price  = [tempOrder hasItemAndBack:@"order_price"];
            }
        }
    }
}

@end
