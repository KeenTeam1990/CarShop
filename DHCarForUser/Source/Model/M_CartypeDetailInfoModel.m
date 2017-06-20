

//
//  M_CartypeDetailInfoModel.m
//  DHCarForSales
//
//  Created by leiyu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CartypeDetailInfoModel.h"

//***************************车的代理人
@implementation M_CarDealerModel
DEF_FACTORY (M_CarDealerModel);
DEF_MODEL( dealer_id);
DEF_MODEL( dealer_name);
DEF_MODEL( dealer_sname);
DEF_MODEL( dealer_code);
DEF_MODEL( province_name);
DEF_MODEL( city_name);
DEF_MODEL( county_name);
DEF_MODEL( city_code);
DEF_MODEL( dealer_address);
DEF_MODEL( dealer_zip);
DEF_MODEL( dealer_tel);
DEF_MODEL( dealer_email);
DEF_MODEL( dealer_lat);
DEF_MODEL( dealer_lng);
DEF_MODEL( dealer_distance);
DEF_MODEL( dealer_star);
DEF_MODEL( dealer_car_price);
DEF_MODEL( dealer_car_id);
-(void)parseDataDic:(NSDictionary *)str
{
    if (str!=nil) {
        self.dealer_id=[NSString fromString:[str hasItemAndBack:@"dealer_id"]];
        self.dealer_name=[NSString fromString:[str hasItemAndBack:@"dealer_name"]];
        self.dealer_sname=[NSString fromString:[str hasItemAndBack:@"dealer_sname"]];
        self.dealer_code=[NSString fromString:[str hasItemAndBack:@"dealer_code"]];
        self.province_name=[NSString fromString:[str hasItemAndBack:@"province_name"]];
        self.city_name=[NSString fromString:[str hasItemAndBack:@"city_name"]];
        self.city_code=[NSString fromString:[str hasItemAndBack:@"city_code"]];
        self.dealer_address=[NSString fromString:[str hasItemAndBack:@"dealer_address"]];
        self.dealer_zip=[NSString fromString:[str hasItemAndBack:@"dealer_zip"]];
        self.dealer_tel=[NSString fromString:[str hasItemAndBack:@"dealer_tel"]];
        self.dealer_email=[NSString fromString:[str hasItemAndBack:@"dealer_email"]];
        self.dealer_lat=[NSString fromString:[str hasItemAndBack:@"dealer_lat"]];
        self.dealer_lng=[NSString fromString:[str hasItemAndBack:@"dealer_lng"]];
        self.dealer_distance=[NSString fromString:[str hasItemAndBack:@"dealer_distance"]];
        self.dealer_distance = [Unity stringToKmString:self.dealer_lat withLon:self.dealer_lng];
//        self.distance = [self.dealer_distance floatValue];
        self.dealer_star=[NSString fromString:[str hasItemAndBack:@"dealer_star"]];
        self.dealer_car_price=[NSString fromString:[str hasItemAndBack:@"dealer_car_price"]];
        self.dealer_car_id=[NSString fromString:[str hasItemAndBack:@"dealer_car_id"]];
        
    }
}

@end

@implementation M_CartypeDetailInfoModel
DEF_FACTORY(M_CartypeDetailInfoModel) ;
DEF_MODEL( car);
DEF_MODEL(dealer)
-(id)init
{
    if (self=[super init]) {
        self.car=[M_carItemDetailInfoModel allocInstance];
        self.dealer=[M_CarDealerModel allocInstance];
    }
    return self;
}
-(void)parseDataDic:(NSDictionary *)str
{
    if (str!=nil) {
        NSDictionary *carDic=[str hasItemAndBack:@"car"];
        M_carItemDetailInfoModel *carDetailModel=[M_carItemDetailInfoModel allocInstance];
        [carDetailModel parseDataDic:carDic];
        self.car=carDetailModel;
        
        NSDictionary *dealerModelDic=[str hasItemAndBack:@"dealer"];
        M_CarDealerModel *dealermodel=[M_CarDealerModel allocInstance];
        [dealermodel parseDataDic:dealerModelDic];
        self.dealer=dealermodel;
    }
}
@end