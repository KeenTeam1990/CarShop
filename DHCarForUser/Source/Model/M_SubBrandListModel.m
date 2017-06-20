//
//  M_SubBrandListModel.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_SubBrandListModel.h"

@implementation M_SubBrandItemModel

DEF_FACTORY(M_SubBrandItemModel);

DEF_MODEL(subbrand_code);
DEF_MODEL(subbrand_id);
DEF_MODEL(subbrand_logo);
DEF_MODEL(subbrand_name);
DEF_MODEL(subbrand_type);

DEF_MODEL(seleted);

@end

@implementation M_SubBrandListModel

DEF_FACTORY(M_SubBrandListModel);

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
    NSDictionary* tempDic = [str hasItemAndBack:@"subbrand"];
    if (tempDic!=nil) {
        
//        self.totalCount = [[tempDic hasItemAndBack:@"count"] integerValue];
        
        NSArray* tempArray = [tempDic hasItemAndBack:@"item"];
        if (tempArray!=nil) {
            for (int i=0; i<[tempArray count]; i++) {
                NSDictionary* tempItemDic = [tempArray objectAtIndex:i];
                if (tempItemDic!=nil) {
                    M_SubBrandItemModel* tempItem = [M_SubBrandItemModel allocInstance];
                    
                    tempItem.subbrand_id = [tempItemDic hasItemAndBack:@"subbrand_id"];
                    tempItem.subbrand_name = [tempItemDic hasItemAndBack:@"subbrand_name"];
                    tempItem.subbrand_code = [tempItemDic hasItemAndBack:@"subbrand_code"];
                    tempItem.subbrand_logo = [tempItemDic hasItemAndBack:@"subbrand_logo"];
                    tempItem.subbrand_type = [tempItemDic hasItemAndBack:@"subbrand_type"];
                    
                    [self.myItemArray addObject:tempItem];
                }
            }
        }
    }
}

@end
