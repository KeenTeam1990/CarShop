

//
//  M_MyOrdelListModel.m
//  DHCarForSales
//
//  Created by leiyu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_MyOrdelListModel.h"

@implementation  M_MyOrdelListModel
DEF_FACTORY(M_MyOrdelListModel);
DEF_MODEL( count);
DEF_MODEL( order_buy);
DEF_MODEL( order_no_buy);
DEF_MODEL( item );
-(id)init
{
    if (self=[super init ]) {
        self.item=[NSMutableArray allocInstance];
    }
    return self;
}
-(void)parseDataDic:(NSDictionary *)str
{
    if (str!=nil) {
        NSDictionary *orderDic=[str hasItemAndBack:@"order"];
        self.count=[orderDic hasItemAndBack:@"count"];
        self.order_buy=[orderDic hasItemAndBack:@"order_buy"];
        self.order_no_buy=[orderDic hasItemAndBack:@"order_no_buy"];
        NSArray *itemDicArr=[orderDic hasItemAndBack:@"item"];
        
        for (NSDictionary *itemDic in itemDicArr) {
            M_MyOrderItemModel *itemmodel=[M_MyOrderItemModel allocInstance];
            [itemmodel parseDataDic:itemDic];
            [self.item addObject:itemmodel];
        }
    }
}
@end

@implementation M_MyOrderItemModel
DEF_FACTORY(M_MyOrderItemModel);
DEF_MODEL( order_id);
DEF_MODEL( order_number);
DEF_MODEL( order_state);
DEF_MODEL( order_type);
DEF_MODEL( order_enquiry_offer);
DEF_MODEL( order_time);
DEF_MODEL(order_price);
DEF_MODEL( order_enquiry_offer_end);
DEF_MODEL( order_enquiry_memo1)
DEF_MODEL( order_enquiry_memo2);
DEF_MODEL( order_enquiry_memo3)
DEF_MODEL( car);
DEF_MODEL( user);
-(id)init
{
    if (self=[super init]) {
        self.user=[M_UserInfoModel allocInstance];
        self.car=[M_carItemDetailInfoModel allocInstance];
    }
    return self;
}
-(void)parseDataDic:(NSDictionary *)str
{
    if (str!=nil) {
        self.order_id=[str hasItemAndBack:@"order_id"];
        self.order_number=[str hasItemAndBack:@"order_number"];
        self.order_state=[str hasItemAndBack:@"order_state"];
        self.order_type=[str hasItemAndBack:@"order_type"];
        self.order_time=[str hasItemAndBack:@"order_time"];
        self.order_state=[str hasItemAndBack:@"order_state"];
        self.order_enquiry_offer=[str hasItemAndBack:@"order_enquiry_offer"];
        self.order_enquiry_offer_end=[str hasItemAndBack:@"order_enquiry_offer_end"];
        self.order_enquiry_memo1=[str hasItemAndBack:@"order_enquiry_memo1"];
        self.order_enquiry_memo2=[str hasItemAndBack:@"order_enquiry_memo2"];
        self.order_enquiry_memo3=[str hasItemAndBack:@"order_enquiry_memo3"];
       
        NSDictionary *carDic=[str hasItemAndBack:@"car"];
        M_carItemDetailInfoModel *carModel=[M_carItemDetailInfoModel allocInstance];
        [carModel parseDataDic:carDic];
        self.car=carModel;
        
       ;
        M_UserInfoModel *userModel=[M_UserInfoModel allocInstance];
        [userModel parseDataDic:str];
        self.user=userModel;
    }
}

@end
