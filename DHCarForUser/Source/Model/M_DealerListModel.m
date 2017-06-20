//
//  M_DealerListModel.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_DealerListModel.h"
#import "M_DealerItemModel.h"

@implementation M_DealerListModel

DEF_FACTORY(M_DealerListModel);

DEF_MODEL(myDealerListArray);

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.myDealerListArray = [NSMutableArray allocInstance];
    }
    return self;
}

-(void)parseDataDic:(NSDictionary *)str
{
    NSDictionary* tempDic = [str hasItemAndBack:@"result"];
    
    if (tempDic!=nil) {

        self.myPageModel.count = [NSString fromString:[tempDic hasItemAndBack:@"count"]];
        self.myPageModel.limit = [NSString fromString:[tempDic hasItemAndBack:@"limit"]];
        self.myPageModel.hasMore = [[tempDic hasItemAndBack:@"has_more"] boolValue];
        if ([Unity isBlank:[tempDic hasItemAndBack:@"next_max"]]) {
            self.myPageModel.nextMax = nil;
        }else{
            self.myPageModel.nextMax = [NSString fromString:[tempDic hasItemAndBack:@"next_max"]];
        }
        NSArray* tempArray = [tempDic hasItemAndBack:@"data"];
        if (tempArray!=nil) {
            for (int i=0; i<[tempArray count]; i++) {
                NSDictionary* tempItemDic = [tempArray objectAtIndex:i];
                if (tempItemDic!=nil) {
                    M_DealerItemModel* tempItem = [M_DealerItemModel allocInstance];
                    
                    tempItem.dealer_id = [NSString fromString:[tempItemDic hasItemAndBack:@"id"]];
                    tempItem.dealer_name = [tempItemDic hasItemAndBack:@"fullname"];
                    tempItem.dealer_sname = [tempItemDic hasItemAndBack:@"name"];
                    tempItem.dealer_code = [tempItemDic hasItemAndBack:@"code"];
                    
                    tempItem.province_id = [NSString fromString:[tempItemDic hasItemAndBack:@"province_id"]];
                    tempItem.city_id = [NSString fromString:[tempItemDic hasItemAndBack:@"city_id"]];
                    
                    tempItem.dealer_address = [tempItemDic hasItemAndBack:@"address"];
                    tempItem.dealer_zip = [tempItemDic hasItemAndBack:@"zip"];
                    tempItem.dealer_tel = [tempItemDic hasItemAndBack:@"tel"];
                    tempItem.dealer_email = [tempItemDic hasItemAndBack:@"email"];
                    tempItem.dealer_lat = [NSString fromString:[tempItemDic hasItemAndBack:@"lat"]];
                    tempItem.dealer_lng = [NSString fromString:[tempItemDic hasItemAndBack:@"lng"]];
                    tempItem.dealer_distance = [tempItemDic hasItemAndBack:@"distance"];
                    
                    tempItem.dealer_distance = [Unity stringToKmString:tempItem.dealer_lat withLon:tempItem.dealer_lng];
                    tempItem.distance = [tempItem.dealer_distance floatValue];
                    
                    NSDictionary* tempCity = [tempItemDic hasItemAndBack:@"city"];
                    if (tempCity!=nil) {
                        tempItem.city_name = [tempCity hasItemAndBack:@"name"];
                        NSDictionary* tempprovince = [tempItemDic hasItemAndBack:@"province"];
                        if (tempprovince!=nil) {
                            tempItem.province_name = [tempCity hasItemAndBack:@"name"];
                        }
                    }
                    
                    [self.myDealerListArray addObject:tempItem];
                }
            }
        }
    }
}

@end
