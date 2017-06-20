//
//  M_SalerInfoModel.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/12/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_SalerInfoModel.h"

@implementation M_SalerInfoModel

DEF_FACTORY(M_SalerInfoModel);
DEF_MODEL(sales_id);
DEF_MODEL(sales_name);
DEF_MODEL(sales_photo);
DEF_MODEL(sales_role);
DEF_MODEL(sales_sex);
DEF_MODEL(sales_sig);
DEF_MODEL(sales_star);
DEF_MODEL(sales_work_year);


-(void)parseDataDic:(NSDictionary *)str
{
    NSDictionary* tempDic = str;
    
    if (tempDic!=nil) {
        
        NSDictionary* tempUser = [tempDic hasItemAndBack:@"user"];
        
        if (tempUser!=nil) {
            
            self.sales_id = [tempUser hasItemAndBack:@"sales_id"];
            
            self.sales_name = [tempUser hasItemAndBack:@"sales_name"];
            
            self.sales_photo = [tempUser hasItemAndBack:@"sales_photo"];
            
            self.sales_role = [tempUser hasItemAndBack:@"sales_role"];
            
            self.sales_sex = [tempUser hasItemAndBack:@"sales_sex"];
            
            self.sales_sig = [tempUser hasItemAndBack:@"sales_sig"];
            
            self.sales_star = [tempUser hasItemAndBack:@"sales_star"];
            
            self.sales_work_year = [tempUser hasItemAndBack:@"sales_work_year"];
            
            
            M_DealerItemModel *tempDelerItemModel = [M_DealerItemModel allocInstance];
            self.dealer = tempDelerItemModel;
            
            self.dealer.dealer_id = [tempUser hasItemAndBack:@"dealer_id"];
            self.dealer.dealer_name = [tempUser hasItemAndBack:@"dealer_name"];
            self.dealer.dealer_sname = [tempUser hasItemAndBack:@"dealer_sname"];
            self.dealer.dealer_code = [tempUser hasItemAndBack:@"dealer_code"];
            self.dealer.province_name = [tempUser hasItemAndBack:@"province_name"];
            self.dealer.city_name = [tempUser hasItemAndBack:@"city_name"];
            self.dealer.county_name = [tempUser hasItemAndBack:@"county_name"];
            self.dealer.city_code = [tempUser hasItemAndBack:@"city_code"];
            self.dealer.dealer_address = [tempUser hasItemAndBack:@"dealer_address"];
            self.dealer.dealer_zip = [tempUser hasItemAndBack:@"dealer_zip"];
            self.dealer.dealer_tel = [tempUser hasItemAndBack:@"dealer_tel"];
            self.dealer.dealer_email = [tempUser hasItemAndBack:@"dealer_email"];
            self.dealer.dealer_lat = [NSString fromString:[tempUser hasItemAndBack:@"dealer_lat"]];
            self.dealer.dealer_lng = [NSString fromString:[tempUser hasItemAndBack:@"dealer_lng"]];
            self.dealer.dealer_distance = [tempUser hasItemAndBack:@"dealer_distance"];
            self.dealer.dealer_distance = [Unity stringToKmString:self.dealer.dealer_lat withLon:self.dealer.dealer_lng];
            self.dealer.distance = [self.dealer.dealer_distance floatValue];
            self.dealer.dealer_star = [tempUser hasItemAndBack:@"dealer_star"];
            self.dealer.dealer_car_price = [tempUser hasItemAndBack:@"dealer_car_price"];
            self.dealer.dealer_car_id = [tempUser hasItemAndBack:@"dealer_car_id"];

            
            
        }
    }
}

@end
