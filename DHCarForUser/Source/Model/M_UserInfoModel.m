//
//  M_UserInfoModel.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/10.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_UserInfoModel.h"

@implementation M_UserInfoModel
DEF_FACTORY(M_UserInfoModel)
@synthesize user_id,user_name,user_photo,user_birthday,user_sex,province_name,city_name,county_name,city_code,user_gold,user_order_gas,user_nick;


-(void)parseDataDic:(NSDictionary *)str
{
    NSDictionary* tempDic = str;
    if (tempDic!=nil) {
        
        NSDictionary *dataDic = [tempDic hasItemAndBack:@"result"];
        
        if (dataDic !=nil)
        {
            self.user_id        = [NSString fromString:[dataDic hasItemAndBack:@"id"]];
            self.user_name      = [NSString fromString:[dataDic hasItemAndBack:@"name"]];
            self.user_nick      = [NSString fromString:[dataDic hasItemAndBack:@"nick"]];
            self.user_photo     = [NSString fromString:[dataDic hasItemAndBack:@"avatar"]];
            self.user_phone     = [NSString fromString:[dataDic hasItemAndBack:@"phone"]];
            self.user_birthday  = [NSString fromString:[dataDic hasItemAndBack:@"birthday"]];
            self.user_sex       = [NSString fromString:[dataDic hasItemAndBack:@"sex"]];
            self.province_id  = [NSString fromString:[dataDic hasItemAndBack:@"province_id"]];
            self.province_name  = [NSString fromString:[dataDic hasItemAndBack:@"province_name"]];
            self.city_name      = [NSString fromString:[dataDic hasItemAndBack:@"city_name"]];
            self.county_name =  [NSString fromString:[dataDic hasItemAndBack:@"county_name"]];
            self.city_id      = [NSString fromString:[dataDic hasItemAndBack:@"city_id"]];
            self.user_gold      = [NSString fromString:[dataDic hasItemAndBack:@"points"]];
            self.user_order_gas = [NSString fromString:[dataDic hasItemAndBack:@"user_order_gas"]];
            
            self.myHas_Set_Password = [NSString fromString:[dataDic hasItemAndBack:@"has_set_password"]];
            
            self.user_has_sign =[NSString stringWithFormat:@"%@",[dataDic hasItemAndBack:@"has_sign"]];
            
            NSDictionary *tempDict1 = [dataDic hasItemAndBack:@"account"];
            
            if ([tempDict1 hasItemAndBack:@"balance"]) {
                self.user_balance =[NSString stringWithFormat:@"%@",[tempDict1 hasItemAndBack:@"balance"]];
            }
            
                if ([dataDic hasItemAndBack:@"city"]) {
                    
                    
                    NSDictionary *tempDict2 = [dataDic hasItemAndBack:@"city"];
                    if ([tempDict2 hasItemAndBack:@"name"]) {
                        self.city_name =[NSString stringWithFormat:@"%@",[tempDict2 hasItemAndBack:@"name"]];

                    }
             }
            
            if ([dataDic hasItemAndBack:@"province"]) {
                
                NSDictionary *tempDict2 = [dataDic hasItemAndBack:@"province"];
                if ([tempDict2 hasItemAndBack:@"name"]) {
                    
                    
                    self.province_name =[NSString stringWithFormat:@"%@",[tempDict2 hasItemAndBack:@"name"]];
                    
                }
            }
            
            
            
        }
        
    }
}


@end
