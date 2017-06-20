//
//  M_SeriesListModel.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/22.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_SeriesListModel.h"

@implementation M_SeriesItemModel

DEF_FACTORY(M_SeriesItemModel);

DEF_MODEL(myName);
DEF_MODEL(myId);
DEF_MODEL(myBBid);
DEF_MODEL(myBid);

@end

@implementation M_SeriesBrandModel

DEF_FACTORY(M_SeriesBrandModel);

DEF_MODEL(myCode);
DEF_MODEL(myFirst);
DEF_MODEL(myId);
DEF_MODEL(myImg);
DEF_MODEL(myName);

DEF_MODEL(mySeriesArray);

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        self.mySeriesArray = [NSMutableArray allocInstance];
    }
    return self;
}

@end

@implementation M_SeriesListModel

DEF_FACTORY(M_SeriesListModel);

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
    NSArray* tempArray = [str hasItemAndBack:@"result"];
    if (tempArray!=nil) {
        for (int i=0; i<[tempArray count]; i++) {
            NSDictionary* tempDic = [tempArray objectAtIndex:i];
            if (tempDic!=nil) {
                M_SeriesBrandModel* tempItem = [M_SeriesBrandModel allocInstance];
                
                tempItem.myId = [NSString fromString:[tempDic hasItemAndBack:@"id"]];
                tempItem.myName = [tempDic hasItemAndBack:@"name"];
                tempItem.myCode = [tempDic hasItemAndBack:@"code"];
                tempItem.myImg = [tempDic hasItemAndBack:@"img"];
                tempItem.myFirst = [tempDic hasItemAndBack:@"first"];
                
                NSArray* tempSeriesArray = [tempDic hasItemAndBack:@"series"];
                
                if (tempSeriesArray!=nil) {
                    for (int j=0; j<[tempSeriesArray count]; j++) {
                        NSDictionary* tempItemDic = [tempSeriesArray objectAtIndex:j];
                        if (tempItemDic!=nil) {
                            M_SeriesItemModel* tempSeriesItem = [M_SeriesItemModel allocInstance];
                            
                            tempSeriesItem.myId = [NSString fromString:[tempItemDic hasItemAndBack:@"id"]];
                            tempSeriesItem.myBid = [NSString fromString:[tempItemDic hasItemAndBack:@"bid"]];
                            tempSeriesItem.myBBid = [NSString fromString:[tempItemDic hasItemAndBack:@"bbid"]];
                            tempSeriesItem.myName = [tempItemDic hasItemAndBack:@"name"];
                            
                            [tempItem.mySeriesArray addObject:tempSeriesItem];
                        }
                    }
                }
                
                [self.myItemArray addObject:tempItem];
            }
        }
    }
}

@end
