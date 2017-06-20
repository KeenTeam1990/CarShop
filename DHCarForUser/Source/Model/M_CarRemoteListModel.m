//
//  M_CarRemoteListModel.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarRemoteListModel.h"

@implementation M_CarRemoteItemModel

DEF_FACTORY(M_CarRemoteItemModel);

DEF_MODEL(rentalCar_CreateTime);
DEF_MODEL(rentalCar_MakeTime);
DEF_MODEL(rentalCar_Person);
DEF_MODEL(rentalCar_PersonName);
DEF_MODEL(rentalCar_Type);
DEF_MODEL(rentalCar_TypeName);
DEF_MODEL(rentalCarId);
DEF_MODEL(provinceName);
DEF_MODEL(cityCode);
DEF_MODEL(cityName);
DEF_MODEL(countyName);

@end

@implementation M_CarRemoteListModel

DEF_FACTORY(M_CarRemoteListModel);

DEF_MODEL(myItemArray);

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
    NSDictionary* tempDic =[str hasItemAndBack:@"rental_car"];
    if (tempDic!=nil) {
//        self.totalCount = [[tempDic hasItemAndBack:@"count"] integerValue];
        
        NSArray* tempArray = [tempDic hasItemAndBack:@"item"];
        if (tempArray !=nil) {
            for (int i=0; i<[tempArray count]; i++) {
                NSDictionary* tempItemDic = [tempArray objectAtIndex:i];
                if (tempItemDic!=nil) {
                    
                    M_CarRemoteItemModel* tempItem = [M_CarRemoteItemModel allocInstance];
                    
                    tempItem.rentalCarId = [tempItemDic hasItemAndBack:@"rental_car_id"];
                    tempItem.provinceName = [tempItemDic hasItemAndBack:@"province_name"];
                    tempItem.cityName = [tempItemDic hasItemAndBack:@"city_name"];
                    tempItem.countyName = [tempItemDic hasItemAndBack:@"county_name"];
                    tempItem.cityCode = [tempItemDic hasItemAndBack:@"city_code"];
                    tempItem.rentalCar_Person = [tempItemDic hasItemAndBack:@"rental_car_person"];
                    tempItem.rentalCar_PersonName = [tempItemDic hasItemAndBack:@"rental_car_person_name"];
                    tempItem.rentalCar_Type = [tempItemDic hasItemAndBack:@"rental_car_type"];
                    tempItem.rentalCar_TypeName = [tempItemDic hasItemAndBack:@"rental_car_type_name"];
                    tempItem.rentalCar_MakeTime = [tempItemDic hasItemAndBack:@"rental_car_make_time"];
                    tempItem.rentalCar_CreateTime = [tempItemDic hasItemAndBack:@"rental_car_createtime"];
                    
                    [self.myItemArray addObject:tempItem];
                }
            }
        }
    }
}

@end
