//
//  M_BannerItemModel.m
//  Auction
//
//  Created by 卢迎志 on 14-12-9.
//
//

#import "M_BannerItemModel.h"

@implementation M_BannerItemModel

DEF_FACTORY(M_BannerItemModel);

DEF_MODEL(itemId);
DEF_MODEL(itemImage);
DEF_MODEL(itemName);
DEF_MODEL(itemUrl);
DEF_MODEL(itemCity_Id);
DEF_MODEL(itemStatus);
DEF_MODEL(itemSource);

@end

@implementation M_BannerModel

DEF_FACTORY(M_BannerModel);

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
            NSDictionary* tempItemDic = [tempArray objectAtIndex:i];
            if (tempItemDic!=nil) {
                M_BannerItemModel* tempItem = [M_BannerItemModel allocInstance];
                
                tempItem.itemId = [NSString fromString:[tempItemDic hasItemAndBack:@"id"]];
                tempItem.itemName = [tempItemDic hasItemAndBack:@"title"];
                tempItem.itemSource = [NSString fromString:[tempItemDic hasItemAndBack:@"source"]];
                tempItem.itemUrl = [tempItemDic hasItemAndBack:@"url"];
                tempItem.itemImage = [tempItemDic hasItemAndBack:@"img"];
                tempItem.itemStatus = [NSString fromString:[tempItemDic hasItemAndBack:@"status"]];
                tempItem.itemCity_Id = [NSString fromString:[tempItemDic hasItemAndBack:@"city_id"]];
                
                [self.myItemArray addObject:tempItem];
            }
        }
    }
}

@end