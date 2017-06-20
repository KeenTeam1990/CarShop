//
//  Dh_UserModel.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/10/28.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "Dh_UserModel.h"

@implementation Dh_UserModel
DEF_FACTORY(Dh_UserModel);

DEF_MODEL(user_name);
DEF_MODEL(user_id);
DEF_MODEL(user_photo);
DEF_MODEL(user_phone);
DEF_MODEL(user_birthday);
DEF_MODEL(user_sex);
DEF_MODEL(province_name);
DEF_MODEL(city_name);
DEF_MODEL(county_name);

DEF_MODEL(city_code);
DEF_MODEL(user_gold);
DEF_MODEL(user_order_gas);

-(void)parseDataDic:(NSDictionary *)str
{
    NSDictionary* tempDic = str;
    
    if (tempDic!=nil) {
        
        NSDictionary* tempUser = [tempDic hasItemAndBack:@"result"];
        
        if (tempUser!=nil) {
            
            self.user_name =[NSString stringWithFormat:@"%@",[tempUser hasItemAndBack:@"name"]];
            
            self.user_id = [NSString stringWithFormat:@"%@",[tempUser hasItemAndBack:@"id"]];
            
            self.user_photo = [NSString stringWithFormat:@"%@",[tempUser hasItemAndBack:@"user_photo"]];
            
            self.user_phone = [NSString stringWithFormat:@"%@",[tempUser hasItemAndBack:@"phone"]];
            
            self.user_birthday = [NSString stringWithFormat:@"%@",[tempUser hasItemAndBack:@"birthday"]];
            
            self.user_sex = [NSString stringWithFormat:@"%@",[tempUser hasItemAndBack:@"sex"]];
            
            self.province_name = [NSString stringWithFormat:@"%@",[tempUser hasItemAndBack:@"province_id"]];
            
            self.city_name = [NSString stringWithFormat:@"%@",[tempUser hasItemAndBack:@"city_id"]];
            
            self.user_gold = [NSString stringWithFormat:@"%@",[tempUser hasItemAndBack:@"avatar"]];
            
             self.user_order_gas = [NSString stringWithFormat:@"%@",[tempUser hasItemAndBack:@"identity_img"]];
            
            
        }
    }
}

@end
