//
//  M_AdvModel.m
//  Auction
//
//  Created by 卢迎志 on 15-1-4.
//
//

#import "M_AdvModel.h"
#import "M_BannerItemModel.h"

@implementation M_AdvModel

DEF_FACTORY(M_AdvModel);

DEF_MODEL(itemArray);

-(id)init
{
    self = [super init];
    if (self) {
        self.itemArray = [NSMutableArray allocInstance];
    }
    return self;
}

-(void)parseDataDic:(NSDictionary *)str
{
    NSDictionary* tempDic = str;
    
    if (tempDic!=nil) {
        NSArray* tempAdv = [tempDic hasItemAndBack:@"adv"];
        if (tempAdv!=nil) {
            for (int i=0; i<[tempAdv count]; i++) {
                NSDictionary* tempItemDic = [tempAdv objectAtIndex:i];
                if (tempItemDic!=nil) {
                    M_BannerItemModel* tempItem = [M_BannerItemModel allocInstance];
                    
                    tempItem.itemId = [NSString fromString:[tempItemDic hasItemAndBack:@"adv_id"]];
                    tempItem.itemName = [tempItemDic hasItemAndBack:@"adv_name"];
                    tempItem.itemImage = [tempItemDic hasItemAndBack:@"adv_photo"];
                    tempItem.itemUrl = [tempItemDic hasItemAndBack:@"adv_url"];
                    
                    [self.itemArray addObject:tempItem];
                }
            }
        }
    }
}

@end
