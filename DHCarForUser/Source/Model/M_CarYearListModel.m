//
//  M_CarYearListModel.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarYearListModel.h"

@implementation M_CarYearItemModel

DEF_FACTORY(M_CarYearItemModel);

DEF_MODEL(myYear);

DEF_MODEL(seleted);

@end

@implementation M_CarYearListModel

DEF_FACTORY(M_CarYearListModel);

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
    NSArray* tempArray = [str hasItemAndBack:@"car_year"];
    
    if (tempArray!=nil) {
        
        for (int i=0; i<[tempArray count]; i++) {
            NSDictionary* tempDic = [tempArray objectAtIndex:i];
            if (tempDic!=nil) {
                M_CarYearItemModel* tempItem = [M_CarYearItemModel allocInstance];
                
                tempItem.myYear = [tempDic hasItemAndBack:@"year"];
                
                [self.myItemArray addObject:tempItem];
            }
        }
    }
}

@end
