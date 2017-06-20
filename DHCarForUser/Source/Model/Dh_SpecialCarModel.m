//
//  Dh_SpecialCarModel.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/3.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "Dh_SpecialCarModel.h"

@implementation Dh_SpecialCarModel


DEF_FACTORY(Dh_SpecialCarModel);

DEF_MODEL(iconImageStr);
DEF_MODEL(discountImageStr);
DEF_MODEL(label1);
DEF_MODEL(label2);
DEF_MODEL(label3);
DEF_MODEL(label4);
DEF_MODEL(label5);


-(void)parseDataDic:(NSDictionary *)str
{
    NSDictionary* tempDic = str;
    if (tempDic!=nil) {
//        self.iconImageStr = [tempDic hasItemAndBack:@"sms_code"];
//        self.discountImageStr = [tempDic hasItemAndBack:@"sms_state"];
    }
}

@end
