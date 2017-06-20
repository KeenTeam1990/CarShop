//
//  M_ConfigDataModel.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/22.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_ConfigDataModel.h"

@implementation M_ConfigDataItemModel

DEF_FACTORY(M_ConfigDataItemModel);

DEF_MODEL(myImg);
DEF_MODEL(myName);
DEF_MODEL(myUrl);
DEF_MODEL(isSelete);

@end

@implementation M_ConfigDataModel

DEF_FACTORY(M_ConfigDataModel);

DEF_MODEL(type);
DEF_MODEL(myItemArray);

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.myItemArray  = [NSMutableArray allocInstance];
    }
    return self;
}

-(void)parseDataDic:(NSDictionary *)str
{
    NSArray* tempArray = [str hasItemAndBack:@"result"];
    if (tempArray!=nil) {
        
        if ([self.type notEmpty]) {
            //1首页推荐块
            if ([self.type isEqualToString:@"1"]) {
                for (int i=0; i<[tempArray count]; i++) {
                    NSDictionary* tempDic = [tempArray objectAtIndex:i];
                    if (tempDic!=nil) {
                        M_ConfigDataItemModel* tempItem = [M_ConfigDataItemModel allocInstance];
                        
                        tempItem.myUrl = [tempDic hasItemAndBack:@"url"];
                        tempItem.myImg = [tempDic hasItemAndBack:@"img"];
                        tempItem.myName = [tempDic hasItemAndBack:@"title"];
                        
                        [self.myItemArray addObject:tempItem];
                    }
                }
            }else{
                //2车型类型数据
                //3车型价格范围
                //4首付价格范围
                //5租期范围
                for (int i=0; i<[tempArray count]; i++) {
                    NSString* tempStr=  [tempArray objectAtIndex:i];
                    if ([tempStr notEmpty]) {
                        M_ConfigDataItemModel* temItem = [M_ConfigDataItemModel allocInstance];
                        
                        temItem.myName = tempStr;
                        
                        [self.myItemArray addObject:temItem];
                    }
                }
            }
        }
        
        
    }
}

@end
