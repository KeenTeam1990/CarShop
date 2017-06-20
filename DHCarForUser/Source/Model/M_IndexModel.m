//
//  M_IndexModel.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/12.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_IndexModel.h"
#import "M_CarListModel.h"

@implementation M_IndexCoverModel

DEF_FACTORY(M_IndexCoverModel);

DEF_MODEL(myContent);
DEF_MODEL(myCover);
DEF_MODEL(myId);
DEF_MODEL(myTitle);

@end

@implementation M_IndexLineItemModel

DEF_FACTORY(M_IndexLineItemModel);

DEF_MODEL(myType);
DEF_MODEL(myCarModel);
DEF_MODEL(myCoverModel);

@end

@implementation M_IndexItemModel

DEF_FACTORY(M_IndexItemModel);

DEF_MODEL(myIndexArray);

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.myIndexArray = [NSMutableArray allocInstance];
    }
    return self;
}

@end

@implementation M_IndexModel

DEF_FACTORY(M_IndexModel);

DEF_MODEL(myIndexArray);

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.myIndexArray  = [NSMutableArray allocInstance];
    }
    return self;
}

-(void)parseDataDic:(NSDictionary *)str
{
    NSArray* tempArray = [str hasItemAndBack:@"result"];
    if (tempArray!=nil) {
        for (int i=0; i<[tempArray count]; i++) {
            NSArray* tempItemArray = [tempArray objectAtIndex:i];
            if (tempItemArray!=nil) {
                
                M_IndexItemModel* tempItem = [M_IndexItemModel allocInstance];
                
                NSMutableArray* tempItemArray2 = [NSMutableArray allocInstance];
                
                for (int j=0; j<[tempItemArray count]; j++) {
                    NSDictionary* tempItemDic = [tempItemArray objectAtIndex:j];
                    if (tempItemDic!=nil) {
                        
                        M_IndexLineItemModel* tempLineItem = [M_IndexLineItemModel allocInstance];
                        
                        NSString* tempType = [NSString fromString:[tempItemDic hasItemAndBack:@"type"]];
                        if ([tempType notEmpty]) {
                            if ([tempType isEqualToString:@"1"]) {//活动
                                
                                tempLineItem.myCoverModel = [M_IndexCoverModel allocInstance];
                                tempLineItem.myCoverModel.myId = [NSString fromString:[tempItemDic hasItemAndBack:@"id"]];
                                tempLineItem.myCoverModel.myTitle = [tempItemDic hasItemAndBack:@"title"];
                                tempLineItem.myCoverModel.myContent = [tempItemDic hasItemAndBack:@"content"];
                                tempLineItem.myCoverModel.myCover = [tempItemDic hasItemAndBack:@"cover"];
                                tempLineItem.myCoverModel.myUrl = [tempItemDic hasItemAndBack:@"url"];
                                
                            }else if ([tempType isEqualToString:@"2"]){//汽车
                                tempLineItem.myCarModel = [M_CarItemModel allocInstance];
                                
                                tempLineItem.myCarModel.myCar_Id = [NSString fromString:[tempItemDic hasItemAndBack:@"id"]];
                                tempLineItem.myCarModel.myBigBrand_Id = [NSString fromString:[tempItemDic hasItemAndBack:@"bbid"]];
                                tempLineItem.myCarModel.myBrand_Id = [NSString fromString:[tempItemDic hasItemAndBack:@"bid"]];
                                tempLineItem.myCarModel.mySubbrand_Id = [NSString fromString:[tempItemDic hasItemAndBack:@"sid"]];
                                tempLineItem.myCarModel.myCar_Name = [tempItemDic hasItemAndBack:@"name"];
                                tempLineItem.myCarModel.myCar_Img = [tempItemDic hasItemAndBack:@"img"];
                                tempLineItem.myCarModel.myCar_Price = [NSString fromString:[tempItemDic hasItemAndBack:@"price"]];
                                tempLineItem.myCarModel.myLease_Price = [NSString fromString:[tempItemDic hasItemAndBack:@"out"]];
                                tempLineItem.myCarModel.myDealer_Car_Price = [NSString fromString:[tempItemDic hasItemAndBack:@"min_price"]];
                                tempLineItem.myCarModel.myCar_Info = [tempItemDic hasItemAndBack:@"info"];
                                tempLineItem.myCarModel.myCar_Info = [tempItemDic hasItemAndBack:@"policy"];
                                tempLineItem.myCarModel.myCar_Year = [NSString fromString:[tempItemDic hasItemAndBack:@"year"]];
                                
                                NSInteger tempcatype = [[tempItemDic hasItemAndBack:@"car_type"] integerValue];
                                 //1特价 2租购 3优选
                                if (tempcatype == 1) {
                                    tempLineItem.myCarModel.myCar_Sales = YES;
                                }else if (tempcatype == 2){
                                    tempLineItem.myCarModel.myCar_Lease = YES;
                                }else if (tempcatype == 3){
                                    tempLineItem.myCarModel.myCar_New = YES;
                                }
                                
                                NSDictionary* tempSeries = [tempItemDic hasItemAndBack:@"series"];
                                if (tempSeries != nil) {
                                    tempLineItem.myCarModel.mySubbrand_Name = [tempSeries hasItemAndBack:@"name"];
                                }
                                
                                NSDictionary* tempBrand = [tempItemDic hasItemAndBack:@"brand"];
                                if (tempBrand != nil) {
                                    tempLineItem.myCarModel.myBrand_Name = [tempBrand hasItemAndBack:@"name"];
                                }
                                
                                NSDictionary* tempBigbrand = [tempItemDic hasItemAndBack:@"bigbrand"];
                                if (tempBigbrand != nil) {
                                    tempLineItem.myCarModel.myBigBrand_Name = [tempBigbrand hasItemAndBack:@"name"];
                                }
                            }
                            tempLineItem.myType = tempType;
                        }
                        
                        [tempItemArray2 addObject:tempLineItem];
                    }
                }
                
                if ([tempItemArray2 count] == 1) {
                    [tempItem.myIndexArray addObjectsFromArray:tempItemArray2];
                    [self.myIndexArray addObject:tempItem];
                }else if ([tempItemArray2 count] == 2) {
                    [tempItem.myIndexArray addObjectsFromArray:tempItemArray2];
                    [self.myIndexArray addObject:tempItem];
                }else if ([tempItemArray2 count ] == 4){
                    [tempItem.myIndexArray addObjectsFromArray:tempItemArray2];
                    [self.myIndexArray addObject:tempItem];
                }else{
                    
                    for (int k = 0; k<[tempItemArray2 count]; k++) {
                        M_IndexLineItemModel* tempLineItem2 = [tempItemArray2 objectAtIndex:k];
                        if (tempLineItem2!=nil) {
                            M_IndexItemModel* tempItem2 = [M_IndexItemModel allocInstance];
                            [tempItem2.myIndexArray addObject:tempLineItem2];
                            [self.myIndexArray addObject:tempItem2];
                        }
                    }
                }
            }
        }
    }
}

@end
