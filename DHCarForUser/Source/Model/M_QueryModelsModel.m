//
//  M_QueryModelsModel.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/12.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_QueryModelsModel.h"
#import "M_MyOrderModel.h"
@implementation M_QueryModelsModel
DEF_FACTORY(M_QueryModelsModel)

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
        NSDictionary *newDic = [tempDic hasItemAndBack:@"car"];
//        self.totalCount = [[newDic hasItemAndBack:@"count"]integerValue];
        NSArray *tempArray = [newDic hasItemAndBack:@"item"];
        if (tempArray !=nil) {
            
            
            for (int i = 0; i<[tempArray count]; i++) {
                NSDictionary *tempItemDic = [tempArray objectAtIndex:i];
                if (tempItemDic !=nil) {
                    
                    M_MyOrderTtemModel *myOrderTtemModel = [M_MyOrderTtemModel allocInstance];
                    
                    myOrderTtemModel.car = [M_CarItemModel allocInstance];
                    
                    myOrderTtemModel.car.myCar_Id = [tempItemDic hasItemAndBack:@"car_id"];
                    myOrderTtemModel.car.myCar_Img = [tempItemDic hasItemAndBack:@"car_img"];
                    myOrderTtemModel.car.myBigBrand_Name = [tempItemDic hasItemAndBack:@"bigbrand_name"];
                    myOrderTtemModel.car.myBrand_Name = [tempItemDic hasItemAndBack:@"brand_name"];
                    myOrderTtemModel.car.mySubbrand_Name = [tempItemDic hasItemAndBack:@"subbrand_name"];
                    myOrderTtemModel.car.myCar_Name = [tempItemDic hasItemAndBack:@"car_name"];
                    myOrderTtemModel.car.myCar_Year = [tempItemDic hasItemAndBack:@"car_year"];
                    myOrderTtemModel.car.myCar_Price = [tempItemDic hasItemAndBack:@"car_price"];
                    myOrderTtemModel.car.myCar_Deposit = [tempItemDic hasItemAndBack:@"car_deposit"];
//                    myOrderTtemModel.car.myCar_Color_id = [tempItemDic hasItemAndBack:@"myCar_Color_id"];
//                    myOrderTtemModel.car.myCar_Color = [tempItemDic hasItemAndBack:@"myCar_Color"];

//                    myOrderTtemModel.order_count = [tempItemDic hasItemAndBack:@"order_count"];
//                    myOrderTtemModel.order_price_count = [tempItemDic hasItemAndBack:@"bj_order_count"];
//                    myOrderTtemModel.order_lasttime = [tempItemDic hasItemAndBack:@"order_lasttime"];
                    
                    [self.itemArray addObject:myOrderTtemModel];
                }
            }
        }
        
    }
}

@end
