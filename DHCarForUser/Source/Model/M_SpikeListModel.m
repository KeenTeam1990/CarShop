//
//  M_SpikeListModel.m
//  DHCarForUser
//
//  Created by 陈斌 on 16/1/14.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "M_SpikeListModel.h"

@implementation M_SpikeItemModel

DEF_FACTORY(M_SpikeItemModel);

-(void)parseDataDic:(NSDictionary *)str
{
    
    self.timestamp = [NSString fromString:[str hasItemAndBack:@"timestamp"]];
    
    NSDictionary* tempItemDic = [str hasItemAndBack:@"result"];
    
    if (tempItemDic!=nil) {
        
        M_SpikeItemModel* tempItem  = self;
        
        tempItem.myUpDated_at = [NSString fromString:[tempItemDic hasItemAndBack:@"updated_at"]];
        tempItem.myCreated_at = [NSString fromString:[tempItemDic hasItemAndBack:@"created_at"]];
        tempItem.myCar_Id = [NSString fromString:[tempItemDic hasItemAndBack:@"cid"]];
        tempItem.myCarUrl_Info =[NSString fromString:[tempItemDic hasItemAndBack:@"url"]];
        tempItem.spike_id = [NSString fromString:[tempItemDic hasItemAndBack:@"id"]];
        
        tempItem.spike_cid = [NSString fromString:[tempItemDic hasItemAndBack:@"cid"]];
        tempItem.spike_car_color_id = [NSString fromString:[tempItemDic hasItemAndBack:@"car_color_id"]];
        tempItem.spike_city_id = [NSString fromString:[tempItemDic hasItemAndBack:@"city_id"]];
        tempItem.spike_dealer_id = [NSString fromString:[tempItemDic hasItemAndBack:@"dealer_id"]];
        tempItem.spike_count = [NSString fromString:[tempItemDic hasItemAndBack:@"count"]];
        tempItem.spike_price = [NSString fromString:[tempItemDic hasItemAndBack:@"price"]];
        tempItem.spike_started_at = [NSString fromString:[tempItemDic hasItemAndBack:@"started_at"]];
        
        tempItem.myCover = [NSString fromString:[tempItemDic hasItemAndBack:@"cover"]];
        tempItem.spike_ended_at = [NSString fromString:[tempItemDic hasItemAndBack:@"ended_at"]];
        tempItem.spike_created_at = [NSString fromString:[tempItemDic hasItemAndBack:@"created_at"]];
        
        tempItem.myCar_Deposit = [NSString fromString:[tempItemDic hasItemAndBack:@"earnest"]];
        tempItem.spike_isopened = [NSString fromString:[tempItemDic hasItemAndBack:@"is_opened"]];
        tempItem.spike_has_order = [NSString fromString:[tempItemDic hasItemAndBack:@"has_order"]];
        
        NSDictionary* tempCarDic = [tempItemDic hasItemAndBack:@"car"];
        if (tempCarDic!=nil) {
            
            tempItem.myCar_Name = [NSString fromString:[tempCarDic hasItemAndBack:@"name"]];
            tempItem.myCar_Year = [NSString fromString:[tempCarDic hasItemAndBack:@"year"]];
            tempItem.myCar_Img = [NSString fromString:[tempCarDic hasItemAndBack:@"img"]];
            tempItem.myCar_Info = [NSString fromString:[tempCarDic hasItemAndBack:@"info"]];
            tempItem.myCar_Policy = [NSString fromString:[tempCarDic hasItemAndBack:@"policy"]];
            tempItem.myCar_Price = [NSString fromString:[tempCarDic hasItemAndBack:@"price"]];
            tempItem.myDealer_Car_Price = [NSString fromString:[tempCarDic hasItemAndBack:@"out"]];
        }
        
        NSDictionary* tempSeries = [tempCarDic hasItemAndBack:@"series"];
        if (tempSeries != nil) {
            tempItem.mySubbrand_Name = [NSString fromString:[tempSeries hasItemAndBack:@"name"]];
        }
        
        NSDictionary* tempBrand = [tempCarDic hasItemAndBack:@"brand"];
        if (tempBrand != nil) {
            tempItem.myBrand_Name = [NSString fromString:[tempBrand hasItemAndBack:@"name"]];
        }
        
        NSDictionary* tempBigbrand = [tempCarDic hasItemAndBack:@"bigbrand"];
        if (tempBigbrand != nil) {
            tempItem.myBigBrand_Name = [NSString fromString:[tempBigbrand hasItemAndBack:@"name"]];
        }
    }
}

@end

@implementation M_SpikeListModel

DEF_FACTORY(M_SpikeListModel);

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        self.myItemArray = [NSMutableArray allocInstance];
    }
    return self;
}

-(void)parseDataDic:(NSDictionary *)str
{
    self.timestamp = [NSString fromString:[str hasItemAndBack:@"timestamp"]];
    
    NSArray* tempArray = [str hasItemAndBack:@"result"];
    
        if (tempArray!=nil) {
            for (int i=0; i<[tempArray count]; i++) {
                NSDictionary* tempItemDic = [tempArray objectAtIndex:i];
                if (tempItemDic!=nil) {
                    
                    M_SpikeItemModel* tempItem  = [M_SpikeItemModel allocInstance];
                    
                    tempItem.timestamp = self.timestamp;
                    
                    tempItem.myCover = [tempItemDic hasItemAndBack:@"cover"];
                    
                    tempItem.myCar_Id = [NSString fromString:[tempItemDic hasItemAndBack:@"cid"]];
                    tempItem.spike_id = [NSString fromString:[tempItemDic hasItemAndBack:@"id"]];
                    
                    tempItem.spike_cid = [NSString fromString:[tempItemDic hasItemAndBack:@"cid"]];
                    tempItem.spike_car_color_id = [NSString fromString:[tempItemDic hasItemAndBack:@"car_color_id"]];
                    tempItem.spike_city_id = [NSString fromString:[tempItemDic hasItemAndBack:@"city_id"]];
                    tempItem.spike_dealer_id = [NSString fromString:[tempItemDic hasItemAndBack:@"dealer_id"]];
                    tempItem.spike_count = [NSString fromString:[tempItemDic hasItemAndBack:@"count"]];
                    tempItem.spike_price = [NSString fromString:[tempItemDic hasItemAndBack:@"price"]];
                    tempItem.spike_started_at = [NSString fromString:[tempItemDic hasItemAndBack:@"started_at"]];
                    tempItem.spike_ended_at = [NSString fromString:[tempItemDic hasItemAndBack:@"ended_at"]];
                    tempItem.spike_created_at = [NSString fromString:[tempItemDic hasItemAndBack:@"created_at"]];
                    
                    tempItem.myCar_Deposit = [NSString fromString:[tempItemDic hasItemAndBack:@"earnest"]];
                    tempItem.spike_isopened = [NSString fromString:[tempItemDic hasItemAndBack:@"is_opened"]];
                    tempItem.spike_has_order = [NSString fromString:[tempItemDic hasItemAndBack:@"has_order"]];
                    
                    NSDictionary* tempCarDic = [tempItemDic hasItemAndBack:@"car"];
                    if (tempCarDic!=nil) {
                        
                        tempItem.myCar_Name = [NSString fromString:[tempCarDic hasItemAndBack:@"name"]];
                        tempItem.myCar_Year = [NSString fromString:[tempCarDic hasItemAndBack:@"year"]];
                        tempItem.myCar_Img = [NSString fromString:[tempCarDic hasItemAndBack:@"img"]];
                        tempItem.myCar_Info = [NSString fromString:[tempCarDic hasItemAndBack:@"info"]];
                        tempItem.myCar_Policy = [NSString fromString:[tempCarDic hasItemAndBack:@"policy"]];
                        tempItem.myCar_Price = [NSString fromString:[tempCarDic hasItemAndBack:@"price"]];
                        tempItem.myDealer_Car_Price = [NSString fromString:[tempCarDic hasItemAndBack:@"out"]];
                    }
                    
                    NSDictionary* tempSeries = [tempCarDic hasItemAndBack:@"series"];
                    if (tempSeries != nil) {
                        tempItem.mySubbrand_Name = [NSString fromString:[tempSeries hasItemAndBack:@"name"]];
                    }
                    
                    NSDictionary* tempBrand = [tempCarDic hasItemAndBack:@"brand"];
                    if (tempBrand != nil) {
                        tempItem.myBrand_Name = [NSString fromString:[tempBrand hasItemAndBack:@"name"]];
                    }
                    
                    NSDictionary* tempBigbrand = [tempCarDic hasItemAndBack:@"bigbrand"];
                    if (tempBigbrand != nil) {
                        tempItem.myBigBrand_Name = [NSString fromString:[tempBigbrand hasItemAndBack:@"name"]];
                    }
                    
                    [self.myItemArray addObject:tempItem];
                }
            }
        }
    
}


@end
