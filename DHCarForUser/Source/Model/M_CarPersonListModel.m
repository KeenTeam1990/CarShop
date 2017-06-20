//
//  M_CarPersonListModel.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarPersonListModel.h"

@implementation M_CarPersonItemModel

DEF_FACTORY(M_CarPersonItemModel);

DEF_MODEL(myCarPersonId);
DEF_MODEL(myCarPersonName);

@end

@implementation M_CarPersonListModel

DEF_FACTORY(M_CarPersonListModel);

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
    NSArray* tempArray = [str hasItemAndBack:@"car_person"];
    if (tempArray!=nil) {
        
        for (int i=0; i<[tempArray count]; i++) {
        
            NSDictionary* tempItemDic = [tempArray objectAtIndex:i];
            if (tempItemDic!=nil) {
                
                M_CarPersonItemModel* tempItem = [M_CarPersonItemModel allocInstance];
                
                tempItem.myCarPersonId = [NSString fromString:[tempItemDic hasItemAndBack:@"car_person_id"]];
                tempItem.myCarPersonName = [tempItemDic hasItemAndBack:@"car_person_name"];
                
                [self.myItemArray addObject:tempItem];
            }
        }
    }
}

@end
