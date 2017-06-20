//
//  M_MymessageListModel.m
//  DHCarForSales
//
//  Created by leiyu on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_MymessageListModel.h"

@implementation M_MymessageLast_infoModel
DEF_FACTORY(M_MymessageLast_infoModel);
DEF_MODEL(message_id);
DEF_MODEL(message_time);
DEF_MODEL(message_txt);
-(void)parseDataDic:(NSDictionary *)str
{
    if(str!=nil ) {
        NSDictionary *tempLastInfoDic=[str hasItemAndBack:@"last_info"];
        if (tempLastInfoDic) {
            self.message_txt=[tempLastInfoDic hasItemAndBack:@"message_txt"];
            self.message_id=[tempLastInfoDic hasItemAndBack:@"message_id"];
            self.message_time=[tempLastInfoDic hasItemAndBack:@"message_time"];
        }
        
    }
}

@end
@implementation M_MymessageListItemModel
DEF_FACTORY(M_MymessageListItemModel);
DEF_MODEL(order_id);
DEF_MODEL(order_number);
DEF_MODEL(user);
DEF_MODEL(last_info)
DEF_MODEL(read_no_number);
-(id)init
{
    if (self=[super init]) {
        self.user=[[M_UserInfoModel alloc]init];
        self.last_info=[M_MymessageLast_infoModel allocInstance];
    }
    return self;
}
-(void)parseDataDic:(NSDictionary *)str
{
    if (str!=nil) {
        
        self.order_id=[NSString fromString:[str hasItemAndBack:@"order_id"]];
        self.order_number=[NSString fromString:[str hasItemAndBack:@"order_number"]];
        
        M_UserInfoModel *tempUserModel=[M_UserInfoModel allocInstance];
        [tempUserModel parseDataDic:str];
        self.user=tempUserModel;
        
        M_MymessageLast_infoModel *last_InfoModel=[M_MymessageLast_infoModel allocInstance];
        [last_InfoModel parseDataDic:str];
        self.last_info=last_InfoModel;
        
        self.read_no_number=[NSString fromString:[str hasItemAndBack:@"read_no_number"]];
    }
}
@end

@implementation M_MymessageListModel
DEF_FACTORY(M_MymessageListModel)
DEF_MODEL(count);
DEF_MODEL(no_read_count);
DEF_MODEL(item);
-(id)init
{
    if (self=[super init]) {
        self.item=[NSMutableArray allocInstance];
    }
    return self;
}
-(void)parseDataDic:(NSDictionary *)str
{
    
    if (str!=nil) {
        NSDictionary *tempMessageListDic=[str hasItemAndBack:@"message"];
        if(tempMessageListDic !=nil)
        {
//            self.totalCount = [[tempMessageListDic hasItemAndBack:@"count"] integerValue];
            self.no_read_count=[NSString fromString:[tempMessageListDic hasItemAndBack:@"no_read_count"]];
            
            NSArray *tempMessageItemDicArr=[tempMessageListDic hasItemAndBack:@"item"];
            
            for (NSDictionary *itemDic in tempMessageItemDicArr) {
                
                M_MymessageListItemModel *model=[M_MymessageListItemModel allocInstance];
                [model parseDataDic:itemDic];
                [self.item addObject:model];
            }

        }
       
    }
}
@end

