//
//  M_CarPriceListModel.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarPriceListModel.h"

@implementation M_CarPriceItemModel

DEF_FACTORY(M_CarPriceItemModel);

DEF_MODEL(myCarPriceId);
DEF_MODEL(myCarPriceName);

DEF_MODEL(seleted);

@end

@implementation M_CarPriceListModel

DEF_FACTORY(M_CarPriceListModel);

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
    NSArray* tempArray =[str hasItemAndBack:@"car_price"];
    if (tempArray!=nil) {
        for (int i=0; i<[tempArray count]; i++) {
            NSDictionary* tempItemDic = [tempArray objectAtIndex:i];
            if (tempItemDic!=nil) {
                M_CarPriceItemModel* tempItem = [M_CarPriceItemModel allocInstance];
                
                tempItem.myCarPriceId = [tempItemDic hasItemAndBack:@"car_price_id"];
                tempItem.myCarPriceName = [tempItemDic hasItemAndBack:@"car_price_name"];
                
                [self.myItemArray addObject:tempItem];
            }
        }
    }
}

@end
