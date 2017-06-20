//
//  Dh_MyCollectModel.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/12.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "Dh_MyCollectModel.h"

@implementation Dh_MyCollectItemModel

DEF_FACTORY(Dh_MyCollectItemModel)

DEF_MODEL(collect_id);
DEF_MODEL(collect_time);

DEF_MODEL(car);


@end

@implementation Dh_MyCollectModel

DEF_FACTORY(Dh_MyCollectModel);

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
        NSDictionary *newDic = [tempDic hasItemAndBack:@"collect"];
//        self.totalCount = [[newDic hasItemAndBack:@"count"]integerValue];
        NSArray *tempArray = [newDic hasItemAndBack:@"item"];
        if (tempArray !=nil) {
            

            for (int i = 0; i<[tempArray count]; i++) {
                NSDictionary *tempItemDic = [tempArray objectAtIndex:i];
                if (tempItemDic !=nil) {
                    
                    Dh_MyCollectItemModel *collectitemModel = [Dh_MyCollectItemModel allocInstance];
                    collectitemModel.collect_id = [tempItemDic hasItemAndBack:@"collect_id"];
                    collectitemModel.collect_time = [tempItemDic hasItemAndBack:@"collect_time"];
                    
                    collectitemModel.car = [M_CarItemModel allocInstance];
                    
                    collectitemModel.car.myCar_Id = [tempItemDic hasItemAndBack:@"car_id"];
                    collectitemModel.car.myBigBrand_Id= [tempItemDic hasItemAndBack:@"bigbrand_id"];
                    collectitemModel.car.myBigBrand_Name = [tempItemDic hasItemAndBack:@"bigbrand_name"];
                    collectitemModel.car.myBrand_Id = [tempItemDic hasItemAndBack:@"brand_id"];
                     collectitemModel.car.myBrand_Name = [tempItemDic hasItemAndBack:@"brand_name"];
                    
                    collectitemModel.car.mySubbrand_Id = [tempItemDic hasItemAndBack:@"subbrand_id"];
                    collectitemModel.car.mySubbrand_Name =[tempItemDic hasItemAndBack:@"subbrand_name"];
                    collectitemModel.car.myCar_Name= [tempItemDic hasItemAndBack:@"car_name"];
                    collectitemModel.car.myCar_Code = [tempItemDic hasItemAndBack:@"car_code"];
                    collectitemModel.car.myCar_Year = [tempItemDic hasItemAndBack:@"car_year"];
                    collectitemModel.car.myCar_Img = [tempItemDic hasItemAndBack:@"car_img"];
                    collectitemModel.car.myCar_Info =[tempItemDic hasItemAndBack:@"car_info"];
                    collectitemModel.car.myCar_Price = [tempItemDic hasItemAndBack:@"car_price"];
                    collectitemModel.car.myDealer_Car_Price = [tempItemDic hasItemAndBack:@"dealer_car_price"];
                    [self.itemArray addObject:collectitemModel];
                }
            }
        }
       
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
