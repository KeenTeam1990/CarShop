//
//  M_TestDriverModel.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_TestDriverModel.h"

@implementation M_TestDriverItemModel
DEF_FACTORY(M_TestDriverItemModel);
DEF_MODEL(test_drive_id);
DEF_MODEL(test_drive_username);
DEF_MODEL(test_drive_user_phone);
DEF_MODEL(test_drive_make_time);
DEF_MODEL(test_drive_createtime);
DEF_MODEL(province_name);
DEF_MODEL(city_name);
DEF_MODEL(county_name);
DEF_MODEL(city_code);


@end

@implementation M_TestDriverModel
DEF_FACTORY(M_TestDriverModel)
DEF_MODEL(rentalImageViewStr);
DEF_MODEL(discountStr);
DEF_MODEL(carName);


-(id)init
{
    self = [super init];
    if (self) {
        self.myItemArray = [NSMutableArray allocInstance];
    }
    return self;
}

-(void)parseDataDic:(NSDictionary *)str
{
   NSArray* tempArray = [str hasItemAndBack:@"result"];
    
        if (tempArray!=nil) {
            for (int i=0; i<[tempArray count]; i++) {
                NSDictionary* tempItemDic = [tempArray objectAtIndex:i];
                if (tempItemDic!=nil) {
                    
                    M_TestDriverItemModel* tempItem  = [M_TestDriverItemModel allocInstance];
            
                    tempItem.myGreated_at = [NSString fromString:[tempItemDic hasItemAndBack:@"created_at"]];
                    
                    tempItem.myGreated_at = [Unity getTimeFromTimer:tempItem.myGreated_at];
                    
                    tempItem.test_drive_id = [NSString fromString:[tempItemDic hasItemAndBack:@"id"]];
                    
                    tempItem.test_drive_make_time =[NSString fromString:[tempItemDic hasItemAndBack:@"time"]];
                    
                     tempItem.test_drive_make_time = [Unity getTimeFromTimer:tempItem.test_drive_make_time];
                
                    NSDictionary *tempDealerDic = [tempItemDic hasItemAndBack:@"dealer"];
                    if (tempDealerDic !=nil) {
                        tempItem.dealer_address = [NSString fromString:[tempDealerDic hasItemAndBack:@"address"]];
                        tempItem.dealer_name = [NSString fromString:[tempDealerDic hasItemAndBack:@"name"]];
                        tempItem.dealer_tel = [NSString fromString:[tempDealerDic hasItemAndBack:@"tel"]];
                    }
                    
                    NSDictionary* tempCarDic = [tempItemDic hasItemAndBack:@"car"];
                    if (tempCarDic!=nil) {
                        tempItem.myCar_Name = [tempCarDic hasItemAndBack:@"name"];
                        tempItem.myCar_Year = [NSString fromString:[tempCarDic hasItemAndBack:@"year"]];
                        tempItem.myCar_Img = [tempCarDic hasItemAndBack:@"img"];
                    }
                    
                    NSDictionary* tempSeries = [tempCarDic hasItemAndBack:@"series"];
                    if (tempSeries != nil) {
                        tempItem.mySubbrand_Name = [tempSeries hasItemAndBack:@"name"];
                    }
                    
                    NSDictionary* tempBrand = [tempCarDic hasItemAndBack:@"brand"];
                    if (tempBrand != nil) {
                        tempItem.myBrand_Name = [tempBrand hasItemAndBack:@"name"];
                    }
                    
                    NSDictionary* tempBigbrand = [tempCarDic hasItemAndBack:@"bigbrand"];
                    if (tempBigbrand != nil) {
                        tempItem.myBigBrand_Name = [tempBigbrand hasItemAndBack:@"name"];
                    }
                    
                    [self.myItemArray addObject:tempItem];
                }
            }
        }
        
    
}

@end
