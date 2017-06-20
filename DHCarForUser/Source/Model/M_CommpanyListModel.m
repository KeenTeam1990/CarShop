//
//  M_CommpanyListModel.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/15.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CommpanyListModel.h"

@implementation M_CommpanyItemModel

DEF_FACTORY(M_CommpanyItemModel);

DEF_MODEL(insurance_commpany_id);
DEF_MODEL(insurance_commpany_name);

@end

@implementation M_CommpanyListModel

DEF_FACTORY(M_CommpanyListModel);

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
    NSArray* tempArray = [str hasItemAndBack:@"insurance_commpany"];
    if (tempArray!=nil) {
        for (int i=0; i<[tempArray count]; i++) {
            NSDictionary* tempItemDic= [tempArray objectAtIndex:i];
            if (tempItemDic!=nil) {
                M_CommpanyItemModel* tempItem = [M_CommpanyItemModel allocInstance];
                
                tempItem.insurance_commpany_id = [NSString fromString:[tempItemDic hasItemAndBack:@"insurance_commpany_id"]];
                    tempItem.insurance_commpany_name = [tempItemDic hasItemAndBack:@"insurance_commpany_name"];
                
                [self.myItemArray addObject:tempItem];
            }
        }
    }
}

@end
