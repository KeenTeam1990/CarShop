//
//  M_PhoneSendModel.m
//  Auction
//
//  Created by 卢迎志 on 15-3-2.
//
//

#import "M_PhoneSendModel.h"

@implementation M_PhoneSendModel

DEF_FACTORY(M_PhoneSendModel);

DEF_MODEL(sms_Code);
DEF_MODEL(sms_State);

-(void)parseDataDic:(NSDictionary *)str
{
    NSDictionary* tempDic = str;
    if (tempDic!=nil) {
        
        self.sms_Code = [tempDic hasItemAndBack:@"sms_code"];
        self.sms_State = [tempDic hasItemAndBack:@"sms_state"];
    }
}

@end
