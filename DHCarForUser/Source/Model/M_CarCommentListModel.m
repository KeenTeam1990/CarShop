//
//  M_CarCommentListModel.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarCommentListModel.h"

@implementation M_CarCommentItemModel

DEF_FACTORY(M_CarCommentItemModel);

DEF_MODEL(myCar_id);
DEF_MODEL(myEvaluate);
DEF_MODEL(myEvaluateCreatime);
DEF_MODEL(myOrder_ID);
DEF_MODEL(myOrder_Number);
DEF_MODEL(myUser_Bir);
DEF_MODEL(myUser_id);
DEF_MODEL(myUser_Name);
DEF_MODEL(myUser_Phone);
DEF_MODEL(myUser_Photo);
DEF_MODEL(myUser_Sex);

@end

@implementation M_CarCommentListModel

DEF_FACTORY(M_CarCommentListModel);

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
    NSDictionary* tempDic = [str hasItemAndBack:@"comment"];
    if (tempDic!=nil) {
//        self.totalCount = [[tempDic hasItemAndBack:@"count"] integerValue];
        
        NSArray* tempArray = [tempDic hasItemAndBack:@"item"];
        
        if (tempArray!=nil) {
            for (int i=0; i<[tempArray count]; i++) {
                NSDictionary* tempItemDic = [tempArray objectAtIndex:i];
                if (tempItemDic!=nil) {
                    M_CarCommentItemModel* tempItem = [M_CarCommentItemModel allocInstance];
                    
                    tempItem.myOrder_ID = [tempItemDic hasItemAndBack:@"order_id"];
                    tempItem.myOrder_Number = [tempItemDic hasItemAndBack:@"order_number"];
                    tempItem.myCar_id = [tempItemDic hasItemAndBack:@"car_id"];
                    tempItem.myEvaluate = [tempItemDic hasItemAndBack:@"evaluate"];
                    tempItem.myEvaluateCreatime = [tempItemDic hasItemAndBack:@"evaluate_createtime"];
                    
                    NSDictionary* tempuserDic = [tempItemDic hasItemAndBack:@"user"];
                    if (tempuserDic!=nil) {
                        tempItem.myUser_id = [tempuserDic hasItemAndBack:@"user_id"];
                        tempItem.myUser_Name = [tempuserDic hasItemAndBack:@"user_name"];
                        tempItem.myUser_Photo = [tempuserDic hasItemAndBack:@"user_photo"];
                        tempItem.myUser_Phone = [tempuserDic hasItemAndBack:@"user_phone"];
                        tempItem.myUser_Bir = [tempuserDic hasItemAndBack:@"user_birthday"];
                        tempItem.myUser_Sex = [tempuserDic hasItemAndBack:@"user_sex"];
                    }
                    
                    [self.myItemArray addObject:tempItem];
                }
            }
        }
    }
}


@end
