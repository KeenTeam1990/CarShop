//
//  M_CarInsuranceListModel.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarInsuranceListModel.h"

@implementation M_CarInsuranceItemModel

DEF_FACTORY(M_CarInsuranceItemModel);

DEF_MODEL(insuranceCommpany);
DEF_MODEL(insuranceCreateTime);
DEF_MODEL(insuranceId);
DEF_MODEL(carNumber);
DEF_MODEL(carShelfNumber);

@end

@implementation M_CarInsuranceListModel

DEF_FACTORY(M_CarInsuranceListModel);

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
    NSDictionary* tempDic =[str hasItemAndBack:@"insurance"];
    if (tempDic!=nil) {
//        self.totalCount = [[tempDic hasItemAndBack:@"count"] integerValue];
        
        NSArray* tempArray = [tempDic hasItemAndBack:@"item"];
        if (tempArray !=nil) {
            for (int i=0; i<[tempArray count]; i++) {
                NSDictionary* tempItemDic = [tempArray objectAtIndex:i];
                if (tempItemDic!=nil) {
                    
                    M_CarInsuranceItemModel* tempItem = [M_CarInsuranceItemModel allocInstance];
                    
                    tempItem.insuranceId = [tempItemDic hasItemAndBack:@"insurance_id"];
                    tempItem.carNumber = [tempItemDic hasItemAndBack:@"car_number"];
                    tempItem.carShelfNumber = [tempItemDic hasItemAndBack:@"car_shelf_number"];
                    tempItem.insuranceCommpany = [tempItemDic hasItemAndBack:@"insurance_commpany"];
                    tempItem.insuranceCreateTime = [tempItemDic hasItemAndBack:@"insurance_createtime"];
                    
                    [self.myItemArray addObject:tempItem];
                }
            }
        }
    }
}

@end
