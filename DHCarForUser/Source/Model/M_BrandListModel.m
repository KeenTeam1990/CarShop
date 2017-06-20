//
//  M_BrandListModel.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_BrandListModel.h"

@implementation M_BrandItemModel

DEF_FACTORY(M_BrandItemModel);

DEF_MODEL(myBrand_code);
DEF_MODEL(myBrand_first);
DEF_MODEL(myBrand_id);
DEF_MODEL(myBrand_img);
DEF_MODEL(myBrand_name);
DEF_MODEL(myBigItemModel);
DEF_MODEL(seleted);

@end

@implementation M_BrandBigItemModel

DEF_FACTORY(M_BrandBigItemModel);

DEF_MODEL(myBigBrand_code);
DEF_MODEL(myBigBrand_first);
DEF_MODEL(myBigBrand_id);
DEF_MODEL(myBigBrand_img);
DEF_MODEL(myBigBrand_name);
DEF_MODEL(myBrandArray);
DEF_MODEL(seleted);

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        self.myBrandArray = [NSMutableArray allocInstance];
    }
    
    return self;
}

@end

@implementation M_BrandListModel

DEF_FACTORY(M_BrandListModel);

DEF_MODEL(myBigBrandArray);
DEF_MODEL(myBrandArray);

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        self.myBigBrandArray = [NSMutableArray allocInstance];
        self.myBrandArray = [NSMutableArray allocInstance];
    }
    
    return self;
}

-(void)parseDataDic:(NSDictionary *)str
{
    NSArray* tempArray = [str hasItemAndBack:@"bigbrand"];
    if (tempArray!=nil) {
        for (int i=0; i<[tempArray count]; i++) {
            NSDictionary* tempItemDic = [tempArray objectAtIndex:i];
            if (tempItemDic!=nil) {
                M_BrandBigItemModel* tempBigItem = [M_BrandBigItemModel allocInstance];
                
                tempBigItem.myBigBrand_id = [tempItemDic hasItemAndBack:@"bigbrand_id"];
                tempBigItem.myBigBrand_name = [tempItemDic hasItemAndBack:@"bigbrand_name"];
                tempBigItem.myBigBrand_code = [tempItemDic hasItemAndBack:@"bigbrand_code"];
                tempBigItem.myBigBrand_img = [tempItemDic hasItemAndBack:@"bigbrand_img"];
                tempBigItem.myBigBrand_first = [tempItemDic hasItemAndBack:@"bigbrand_py"];
                
                NSArray* tempbrandArray = [tempItemDic hasItemAndBack:@"brand"];
                if (tempbrandArray!=nil) {
                    for (int i=0; i<[tempbrandArray count]; i++) {
                        NSDictionary* tempBrandItemDic = [tempbrandArray objectAtIndex:i];
                        if (tempBrandItemDic!=nil) {
                            M_BrandItemModel* tempBIModel = [M_BrandItemModel allocInstance];
                            
                            tempBIModel.myBrand_id = [tempBrandItemDic hasItemAndBack:@"brand_id"];
                            tempBIModel.myBrand_name = [tempBrandItemDic hasItemAndBack:@"brand_name"];
                            tempBIModel.myBrand_code = [tempBrandItemDic hasItemAndBack:@"brand_code"];
                            tempBIModel.myBrand_img = [tempBrandItemDic hasItemAndBack:@"brand_img"];
                            tempBIModel.myBrand_first = [tempBrandItemDic hasItemAndBack:@"brand_py"];
                            
                            [tempBigItem.myBrandArray addObject:tempBIModel];
                            
                            tempBIModel.myBigItemModel = tempBigItem;
                            
                            [self.myBrandArray addObject:tempBIModel];
                        }
                    }
                }
                
                [self.myBigBrandArray addObject:tempBigItem];
            }
        }
    }
}
 

@end
