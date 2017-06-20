//
//  M_CarGasListModel.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarGasListModel.h"

@implementation M_CarGasItemModel

DEF_FACTORY(M_CarGasItemModel);

DEF_MODEL(order_gas_createtime);
DEF_MODEL(order_gas_enquiry_pay);
DEF_MODEL(order_gas_enquiry_pay_number);
DEF_MODEL(order_gas_enquiry_pay_state);
DEF_MODEL(order_gas_enquiry_pay_time);
DEF_MODEL(order_gas_id);
DEF_MODEL(order_gas_number);
DEF_MODEL(order_gas_price);
DEF_MODEL(order_gas_state);


@end

@implementation M_CarGasListModel

DEF_FACTORY(M_CarGasListModel);
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
    NSDictionary* tempDic =[str hasItemAndBack:@"gas"];
    if (tempDic!=nil) {
        //self.totalCount = [[tempDic hasItemAndBack:@"count"] integerValue];
        
        NSArray* tempArray = [tempDic hasItemAndBack:@"item"];
        if (tempArray !=nil) {
            for (int i=0; i<[tempArray count]; i++) {
                NSDictionary* tempItemDic = [tempArray objectAtIndex:i];
                if (tempItemDic!=nil) {
                    
                    M_CarGasItemModel* tempItem = [M_CarGasItemModel allocInstance];
                    
                    tempItem.order_gas_id = [tempItemDic hasItemAndBack:@"order_gas_id"];
                    tempItem.order_gas_number = [tempItemDic hasItemAndBack:@"order_gas_number"];
                    tempItem.order_gas_price = [tempItemDic hasItemAndBack:@"order_gas_price"];
                    tempItem.order_gas_state = [tempItemDic hasItemAndBack:@"order_gas_state"];
                    tempItem.order_gas_createtime = [tempItemDic hasItemAndBack:@"order_gas_createtime"];
                    tempItem.order_gas_enquiry_pay = [tempItemDic hasItemAndBack:@"order_enquiry_pay"];
                    tempItem.order_gas_enquiry_pay_number = [tempItemDic hasItemAndBack:@"order_enquiry_pay_number"];
                    tempItem.order_gas_enquiry_pay_time = [tempItemDic hasItemAndBack:@"order_enquiry_pay_time"];
                    tempItem.order_gas_enquiry_pay_state = [tempItemDic hasItemAndBack:@"order_enquiry_pay_state"];
                    
                    [self.myItemArray addObject:tempItem];
                }
            }
        }
    }
}

@end
