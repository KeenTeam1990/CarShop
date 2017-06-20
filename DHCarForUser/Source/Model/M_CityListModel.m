//
//  M_CityListModel.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CityListModel.h"

@implementation M_ProvinceItemModel

DEF_FACTORY(M_ProvinceItemModel)

DEF_MODEL(myProvince_id);
DEF_MODEL(myProvince_Name);
DEF_MODEL(myCityArray1);

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.myCityArray1  = [NSMutableArray allocInstance];
    }
    return self;
}
@end

@implementation M_CityItemModel

DEF_FACTORY(M_CityItemModel);

DEF_MODEL(myProvince_Id);
DEF_MODEL(myCity_Code);
DEF_MODEL(myCity_Id);
DEF_MODEL(myCity_Name);
DEF_MODEL(myCity_First);

DEF_MODEL(myCityArray);

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        self.myCityArray = [NSMutableArray allocInstance];
        
    }
    return self;
}

-(void)parseDataDic:(NSDictionary *)str
{
    NSDictionary* tempDic = [str hasItemAndBack:@"result"];
    if (tempDic!=nil) {
        
        self.myCity_Id = [NSString fromString:[tempDic hasItemAndBack:@"id"]];
        self.myCity_Code = [NSString fromString:[tempDic hasItemAndBack:@"code"]];
        self.myCity_Name = [tempDic hasItemAndBack:@"name"];
        self.myCity_First = [tempDic hasItemAndBack:@"first"];
        self.myCity_Status = [NSString fromString:[tempDic hasItemAndBack:@"status"]];
    }
}

@end

@implementation M_CityListModel

DEF_FACTORY(M_CityListModel);

DEF_MODEL(myAllCityArray);

-(instancetype)init
{
    self = [super init];
    if (self)
    {
            self.myAllCityArray = [NSMutableArray allocInstance];
    }
    return self;
}

-(void)parseDataDic:(NSDictionary *)str
{
    NSArray* tempDic = [str hasItemAndBack:@"result"];
    
    if (tempDic!=nil) {
        
        for (int i=0; i<[tempDic count]; i++) {
            NSDictionary* tempItemDic = [tempDic objectAtIndex:i];
            if (tempItemDic!=nil) {
                
                M_ProvinceItemModel* tempItem = [M_ProvinceItemModel allocInstance];
                
                tempItem.myProvince_id = [NSString stringWithFormat:@"%@",[tempItemDic hasItemAndBack:@"id"]];
                
                   tempItem.myProvince_Name = [NSString stringWithFormat:@"%@",[tempItemDic hasItemAndBack:@"name"]];
     
                
                NSArray* tempArray = [tempItemDic hasItemAndBack:@"citys"];
                
                if (tempArray!=nil) {
                    for (int j=0; j<[tempArray count]; j++) {
                        NSDictionary* tempCityItemDic = [tempArray objectAtIndex:j];
                        if (tempCityItemDic!=nil) {
                            M_CityItemModel* tempCityItem = [M_CityItemModel allocInstance];
                            
                            tempCityItem.myProvince_Id =[NSString stringWithFormat:@"%@",[tempItemDic hasItemAndBack:@"proinvce_id"]];
                            
                            tempCityItem.myCity_Name = [NSString stringWithFormat:@"%@",[tempCityItemDic hasItemAndBack:@"name"]];
                            
                            tempCityItem.myCity_Id = [NSString stringWithFormat:@"%@",[tempCityItemDic hasItemAndBack:@"id"]];
                            
                            [tempItem.myCityArray1 addObject:tempCityItem];
                            
                        }
                    }
                }
                 [self.myAllCityArray addObject:tempItem];
            }
           
        }
    }
}

@end


@implementation M_CityList2Model

DEF_FACTORY(M_CityList2Model);

DEF_MODEL(myAllCityArray);

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.myAllCityArray = [NSMutableArray allocInstance];
    }
    return self;
}

-(void)parseDataDic:(NSDictionary *)str
{
    NSArray* tempDic = [str hasItemAndBack:@"result"];
    
    if (tempDic!=nil) {
        
        for (int i=0; i<[tempDic count]; i++) {
            
            NSDictionary* tempItemDic = [tempDic objectAtIndex:i];
            if (tempItemDic!=nil) {
                
                M_CityItemModel* tempItem = [M_CityItemModel allocInstance];
                
                tempItem.myCity_Id = [NSString stringWithFormat:@"%@",[tempItemDic hasItemAndBack:@"id"]];
                
                tempItem.myCity_Name = [NSString stringWithFormat:@"%@",[tempItemDic hasItemAndBack:@"name"]];
                
                tempItem.myCity_Code = [NSString stringWithFormat:@"%@",[tempItemDic hasItemAndBack:@"code"]];
                
                tempItem.myCity_First = [NSString stringWithFormat:@"%@",[tempItemDic hasItemAndBack:@"first"]];
                
//                if ([tempItem.myCity_First length] == 0 || tempItem.myCity_First ==nil) {
//                    tempItem.myCity_First = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([tempItem.myCity_Name characterAtIndex:0])]uppercaseString];
//                }
                
                [self.myAllCityArray addObject:tempItem];
            }
            
        }
    }
}

@end


