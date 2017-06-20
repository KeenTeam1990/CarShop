//
//  M_SpikeRushModel.m
//  DHCarForUser
//
//  Created by 陈斌 on 16/1/14.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "M_SpikeRushModel.h"

@implementation M_SpikeRushModel






-(void)parseDataDic:(NSDictionary *)str
{
    
    self.spikeRush_timestamp =[NSString fromString:[str hasItemAndBack:@"timestamp"]];
    
    NSDictionary* tempItemDic = [str hasItemAndBack:@"result"];
    
    if (tempItemDic!=nil) {
        
        M_SpikeRushModel* tempItem  = self;
        tempItem.spikeRush_no = [NSString fromString:[tempItemDic hasItemAndBack:@"no"]];
        
        tempItem.spikeRush_type = [NSString fromString:[tempItemDic hasItemAndBack:@"type"]];
        
        tempItem.spikeRush_cid = [NSString fromString:[tempItemDic hasItemAndBack:@"cid"]];
        tempItem.spikeRush_uid = [NSString fromString:[tempItemDic hasItemAndBack:@"uid"]];
        tempItem.spikeRush_car_color_id = [NSString fromString:[tempItemDic hasItemAndBack:@"car_color_id"]];
        tempItem.spikeRush_city_id = [NSString fromString:[tempItemDic hasItemAndBack:@"city_id"]];
        tempItem.spikeRush_dealer_id = [NSString fromString:[tempItemDic hasItemAndBack:@"dealer_id"]];
        tempItem.spikeRush_price = [NSString fromString:[tempItemDic hasItemAndBack:@"price"]];
        tempItem.spikeRush_earnest = [NSString fromString:[tempItemDic hasItemAndBack:@"earnest"]];
        
        tempItem.spikeRush_phone = [NSString fromString:[tempItemDic hasItemAndBack:@"phone"]];
        tempItem.spikeRush_created_at = [NSString fromString:[tempItemDic hasItemAndBack:@"created_at"]];
        tempItem.spikeRush_id = [NSString fromString:[tempItemDic hasItemAndBack:@"id"]];
        
    }
}


@end
