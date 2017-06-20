//
//  M_CarTypeListModel.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarTypeListModel.h"

@implementation M_CarTypeItemModel

DEF_FACTORY(M_CarTypeItemModel);

DEF_MODEL(myCarType);
DEF_MODEL(myCarTypeName);

DEF_MODEL(seleted);

@end

@implementation M_CarTypeListModel

DEF_FACTORY(M_CarTypeListModel);

DEF_MODEL(myItemArray);


-(instancetype)init
{
    self = [super init];
    
    if (self) {
        self.myItemArray =[NSMutableArray allocInstance];
    }
    
    return self;
}

-(void)parseDataDic:(NSDictionary *)str
{
    NSArray* tempArray = [str hasItemAndBack:@"car_type"];
    if (tempArray!=nil) {
        for (int i=0; i<[tempArray count]; i++) {
            NSDictionary* tempItemDic = [tempArray objectAtIndex:i];
            if (tempItemDic!=nil) {
                M_CarTypeItemModel* tempItem = [M_CarTypeItemModel allocInstance];
                
                tempItem.myCarType = [NSString fromString:[tempItemDic hasItemAndBack:@"car_type_id"]];
                tempItem.myCarTypeName = [tempItemDic hasItemAndBack:@"car_type_name"];
                
                [self.myItemArray addObject:tempItem];
            }
        }
    }
}

@end
