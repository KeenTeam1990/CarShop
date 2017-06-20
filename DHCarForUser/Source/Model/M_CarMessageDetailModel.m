
//
//  M_CarMessageDetailModel.m
//  DHCarForSales
//
//  Created by leiyu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarMessageDetailModel.h"

@implementation  M_MyMessageModel

DEF_FACTORY(M_MyMessageModel);

-(id)init
{
    if (self=[super init]) {
        
        self.myItemArray=[NSMutableArray allocInstance];
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
                M_MyMessageItemModel* tempItem = [M_MyMessageItemModel allocInstance];
                
                tempItem.myMessage_id = [NSString fromString:[tempItemDic hasItemAndBack:@"id"]];
                
                NSDictionary* tempFromDic=  [tempItemDic hasItemAndBack:@"from"];
                if (tempFromDic !=nil) {
                    tempItem.myFromModel = [M_UserInfoModel allocInstance];
                    
                    tempItem.myFromModel.user_id        = [NSString fromString:[tempFromDic hasItemAndBack:@"id"]];
                    tempItem.myFromModel.user_name      = [NSString fromString:[tempFromDic hasItemAndBack:@"name"]];
                    tempItem.myFromModel.user_nick      = [NSString fromString:[tempFromDic hasItemAndBack:@"nick"]];
                    tempItem.myFromModel.user_photo     = [NSString fromString:[tempFromDic hasItemAndBack:@"avatar"]];
                    tempItem.myFromModel.user_phone     = [NSString fromString:[tempFromDic hasItemAndBack:@"phone"]];
                    tempItem.myFromModel.user_birthday  = [NSString fromString:[tempFromDic hasItemAndBack:@"birthday"]];
                    tempItem.myFromModel.user_sex       = [NSString fromString:[tempFromDic hasItemAndBack:@"sex"]];
                    tempItem.myFromModel.province_name  = [NSString fromString:[tempFromDic hasItemAndBack:@"province_name"]];
                    tempItem.myFromModel.city_name      = [NSString fromString:[tempFromDic hasItemAndBack:@"city_name"]];
                    tempItem.myFromModel.county_name =  [NSString fromString:[tempFromDic hasItemAndBack:@"county_name"]];
                    tempItem.myFromModel.city_code      = [NSString fromString:[tempFromDic hasItemAndBack:@"city_id"]];
                }
                
                NSDictionary* tempToDic=  [tempItemDic hasItemAndBack:@"to"];
                if (tempToDic !=nil) {
                    tempItem.myToModel = [M_UserInfoModel allocInstance];
                    
                    tempItem.myToModel.user_id        = [NSString fromString:[tempToDic hasItemAndBack:@"id"]];
                    tempItem.myToModel.user_name      = [NSString fromString:[tempToDic hasItemAndBack:@"name"]];
                    tempItem.myToModel.user_nick      = [NSString fromString:[tempToDic hasItemAndBack:@"nick"]];
                    tempItem.myToModel.user_photo     = [NSString fromString:[tempToDic hasItemAndBack:@"avatar"]];
                    tempItem.myToModel.user_phone     = [NSString fromString:[tempToDic hasItemAndBack:@"phone"]];
                    tempItem.myToModel.user_birthday  = [NSString fromString:[tempToDic hasItemAndBack:@"birthday"]];
                    tempItem.myToModel.user_sex       = [NSString fromString:[tempToDic hasItemAndBack:@"sex"]];
                    
                    tempItem.myToModel.myStarted_at       = [NSString fromString:[tempToDic hasItemAndBack:@"started_at"]];
                    tempItem.myToModel.myWord       = [NSString fromString:[tempToDic hasItemAndBack:@"word"]];
                }
                
                tempItem.myContent = [tempItemDic hasItemAndBack:@"content"];
                tempItem.myType = [NSString fromString:[tempItemDic hasItemAndBack:@"type"]];
                tempItem.myIsRead = [NSString fromString:[tempItemDic hasItemAndBack:@"is_read"]];
                
                tempItem.myTimer = [NSString fromString:[tempItemDic hasItemAndBack:@"created_at"]];
                tempItem.myGroup = [NSString fromString:[tempItemDic hasItemAndBack:@"group"]];
                
                [self.myItemArray addObject:tempItem];
            }
        }
    }
}

@end

@implementation M_MyMessageItemModel

DEF_FACTORY(M_MyMessageItemModel);

@end

@implementation M_CarMessageDetailModel

DEF_FACTORY(M_CarMessageDetailModel);

-(id)init
{
    if (self=[super init]) {
       self.myItemArray=[NSMutableArray allocInstance];
    }
    return self;
}

-(void)parseDataDic:(NSDictionary *)str
{
    NSDictionary* tempDic = [str hasItemAndBack:@"result"];
    if (tempDic!=nil) {
        
        NSDictionary* tempQuotedDic = [tempDic hasItemAndBack:@"quoted"];
        if (tempQuotedDic!=nil) {
            
            self.myQuoteModel = [M_QuoteItemModel allocInstance];
            
            self.myQuoteModel.myQuoteId = [NSString fromString:[tempQuotedDic hasItemAndBack:@"id"]];
            self.myQuoteModel.myFirstInfo = [tempQuotedDic hasItemAndBack:@"first_price_info"];
            self.myQuoteModel.myFirstPrice = [NSString fromString:[tempQuotedDic hasItemAndBack:@"first_price"]];
            
            self.myQuoteModel.myLastPrice = [NSString fromString:[tempQuotedDic hasItemAndBack:@"last_price"]];
            self.myQuoteModel.myLastInfo = [tempQuotedDic hasItemAndBack:@"last_price_info"];
            
            self.myQuoteModel.myHasConverted = [NSString fromString:[tempQuotedDic hasItemAndBack:@"has_converted"]];
            
            NSString* tempCar_earnest = [NSString fromString:[tempQuotedDic hasItemAndBack:@"earnest"]];

            NSArray *firstComboDicArr = [tempQuotedDic hasItemAndBack:@"first_price_combo"];
            [firstComboDicArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *tempGiftDic = (NSDictionary *)obj;
                M_QuoteComboItemModel *tempGiftItemModel = [M_QuoteComboItemModel allocInstance];
                tempGiftItemModel.myComboId = [NSString fromString:[tempGiftDic hasItemAndBack:@"id"]];
                tempGiftItemModel.myDealerId = [NSString fromString:[tempGiftDic hasItemAndBack:@"dealer_id"]];
                tempGiftItemModel.myComboTitle = [NSString fromString:[tempGiftDic hasItemAndBack:@"title"]];
                tempGiftItemModel.myComboContent = [NSString fromString:[tempGiftDic hasItemAndBack:@"content"]];
//                tempGiftItemModel.created_at = [NSString fromString:[tempGiftDic hasItemAndBack:@"created_at"]];
                [self.myQuoteModel.myFirstComboArray addObject:tempGiftItemModel];
            }];
            
            NSArray *lastComboDicArr = [tempQuotedDic hasItemAndBack:@"last_price_combo"];
            [lastComboDicArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *tempGiftDic = (NSDictionary *)obj;
                M_QuoteComboItemModel *tempGiftItemModel = [M_QuoteComboItemModel allocInstance];
                tempGiftItemModel.myComboId = [NSString fromString:[tempGiftDic hasItemAndBack:@"id"]];
                tempGiftItemModel.myDealerId = [NSString fromString:[tempGiftDic hasItemAndBack:@"dealer_id"]];
                tempGiftItemModel.myComboTitle = [NSString fromString:[tempGiftDic hasItemAndBack:@"title"]];
                tempGiftItemModel.myComboContent = [NSString fromString:[tempGiftDic hasItemAndBack:@"content"]];
//                tempGiftItemModel.myc = [NSString fromString:[tempGiftDic hasItemAndBack:@"created_at"]];
                [self.myQuoteModel.myLastComboArray addObject:tempGiftItemModel];
            }];
            NSDictionary* tempOrderDic = [tempQuotedDic hasItemAndBack:@"order"];
            if (tempOrderDic!=nil) {
                self.myQuoteModel.myOrderModel = [M_MyOrderTtemModel allocInstance];
                
                self.myQuoteModel.myOrderModel.order_id = [NSString fromString:[tempOrderDic hasItemAndBack:@"id"]];
                self.myQuoteModel.myOrderModel.order_no = [NSString fromString:[tempOrderDic hasItemAndBack:@"no"]];
                self.myQuoteModel.myOrderModel.order_step = [NSString fromString:[tempOrderDic hasItemAndBack:@"step"]];
            }
            
            NSDictionary* tempInquiryDic = [tempQuotedDic hasItemAndBack:@"inquiry"];
            
            if (tempInquiryDic!=nil) {
            
                self.myQuoteModel.myInquiryModel = [M_MyOrderTtemModel allocInstance];
                
                self.myQuoteModel.myInquiryModel.order_id = [NSString fromString:[tempInquiryDic hasItemAndBack:@"id"]];
                
                self.myQuoteModel.myInquiryModel.myQuoted_count = [NSString fromString:[tempInquiryDic hasItemAndBack:@"quoted_count"]];
                
                self.myQuoteModel.myInquiryModel.myDealer_count = [NSString fromString:[tempInquiryDic hasItemAndBack:@"dealer_count"]];
                
                NSDictionary* tempCarDic = [tempInquiryDic hasItemAndBack:@"car"];
                if (tempCarDic!=nil) {
                    self.myQuoteModel.myInquiryModel.car = [M_CarItemModel allocInstance];
                    
                    if ([tempCar_earnest notEmpty]) {
                        self.myQuoteModel.myInquiryModel.car.myCar_Deposit = tempCar_earnest;
                    }
                    
                    self.myQuoteModel.myInquiryModel.car.myCar_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"id"]];
                    self.myQuoteModel.myInquiryModel.car.myBigBrand_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"bbid"]];
                    self.myQuoteModel.myInquiryModel.car.myBrand_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"bid"]];
                    self.myQuoteModel.myInquiryModel.car.mySubbrand_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"sid"]];
                    self.myQuoteModel.myInquiryModel.car.myCar_Name = [tempCarDic hasItemAndBack:@"name"];
                    self.myQuoteModel.myInquiryModel.car.myCar_Year = [NSString fromString:[tempCarDic hasItemAndBack:@"year"]];
                    self.myQuoteModel.myInquiryModel.car.myCar_Img = [tempCarDic hasItemAndBack:@"img"];
                    self.myQuoteModel.myInquiryModel.car.myCar_Info = [tempCarDic hasItemAndBack:@"info"];
                    self.myQuoteModel.myInquiryModel.car.myCar_Policy = [tempCarDic hasItemAndBack:@"policy"];
                    self.myQuoteModel.myInquiryModel.car.myCar_Price = [NSString fromString:[tempCarDic hasItemAndBack:@"price"]];
                    
                    NSDictionary* tempSeries = [tempInquiryDic hasItemAndBack:@"series"];
                    if (tempSeries != nil) {
                        self.myQuoteModel.myInquiryModel.car.mySubbrand_Name = [tempSeries hasItemAndBack:@"name"];
                    }
                    
                    NSDictionary* tempBrand = [tempInquiryDic hasItemAndBack:@"brand"];
                    if (tempBrand != nil) {
                        self.myQuoteModel.myInquiryModel.car.myBrand_Name = [tempBrand hasItemAndBack:@"name"];
                    }
                    
                    NSDictionary* tempBigbrand = [tempInquiryDic hasItemAndBack:@"bigbrand"];
                    if (tempBigbrand != nil) {
                        self.myQuoteModel.myInquiryModel.car.myBigBrand_Name = [tempBigbrand hasItemAndBack:@"name"];
                    }
                    
                    NSDictionary* tempColor = [tempInquiryDic hasItemAndBack:@"color"];
                    if (tempColor != nil) {
                        self.myQuoteModel.myInquiryModel.car.myItemColorModel = [M_CarColorItemModel allocInstance];
                        self.myQuoteModel.myInquiryModel.car.myItemColorModel.myCar_Color_Id = [NSString fromString:[tempColor hasItemAndBack:@"id"]];
                        self.myQuoteModel.myInquiryModel.car.myItemColorModel.myCar_Color_Name = [NSString fromString:[tempColor hasItemAndBack:@"name"]];
                        self.myQuoteModel.myInquiryModel.car.myItemColorModel.myCar_Color_Img = [NSString fromString:[tempColor hasItemAndBack:@"value"]];
                    }
                }
            }
            
            NSDictionary* tempDealerDic = [tempQuotedDic hasItemAndBack:@"dealer"];
            
            if (tempDealerDic!=nil) {
                
                self.myQuoteModel.myDealerModel = [M_DealerItemModel allocInstance];
                
                self.myQuoteModel.myDealerModel.dealer_id = [NSString fromString:[tempDealerDic hasItemAndBack:@"id"]];
                self.myQuoteModel.myDealerModel.dealer_name = [tempDealerDic hasItemAndBack:@"fullname"];
                self.myQuoteModel.myDealerModel.dealer_sname = [tempDealerDic hasItemAndBack:@"name"];
                self.myQuoteModel.myDealerModel.dealer_code = [tempDealerDic hasItemAndBack:@"code"];
                
                self.myQuoteModel.myDealerModel.province_id = [NSString fromString:[tempDealerDic hasItemAndBack:@"province_id"]];
                self.myQuoteModel.myDealerModel.city_id = [NSString fromString:[tempDealerDic hasItemAndBack:@"city_id"]];
                
                self.myQuoteModel.myDealerModel.dealer_address = [tempDealerDic hasItemAndBack:@"address"];
                self.myQuoteModel.myDealerModel.dealer_zip = [tempDealerDic hasItemAndBack:@"zip"];
                self.myQuoteModel.myDealerModel.dealer_tel = [tempDealerDic hasItemAndBack:@"tel"];
                self.myQuoteModel.myDealerModel.dealer_email = [tempDealerDic hasItemAndBack:@"email"];
                self.myQuoteModel.myDealerModel.dealer_lat = [NSString fromString:[tempDealerDic hasItemAndBack:@"lat"]];
                self.myQuoteModel.myDealerModel.dealer_lng = [NSString fromString:[tempDealerDic hasItemAndBack:@"lng"]];
                self.myQuoteModel.myDealerModel.dealer_distance = [tempDealerDic hasItemAndBack:@"distance"];
                
                self.myQuoteModel.myDealerModel.dealer_distance = [Unity stringToKmString:self.myQuoteModel.myDealerModel.dealer_lat withLon:self.myQuoteModel.myDealerModel.dealer_lng];
                
                self.myQuoteModel.myDealerModel.distance = [self.myQuoteModel.myDealerModel.dealer_distance floatValue];
                
                NSDictionary* tempCity = [tempDealerDic hasItemAndBack:@"city"];
                if (tempCity!=nil) {
                    self.myQuoteModel.myDealerModel.city_name = [tempCity hasItemAndBack:@"name"];
                    NSDictionary* tempprovince = [tempDealerDic hasItemAndBack:@"province"];
                    if (tempprovince!=nil) {
                        self.myQuoteModel.myDealerModel.province_name = [tempCity hasItemAndBack:@"name"];
                    }
                }
            }
        }
        
        NSArray* tempDataArray = [tempDic hasItemAndBack:@"data"];
        if (tempDataArray!=nil) {
            
            if ([tempDataArray count]>0) {
                
                if ([Unity isBlank:[tempDic hasItemAndBack:@"next_max"]]) {
                    self.myPageModel.nextMax = nil;
                }else{
                    self.myPageModel.nextMax = [NSString fromString:[tempDic hasItemAndBack:@"next_max"]];
                }
                
                if ([Unity isBlank:[tempDic hasItemAndBack:@"last_max"]]) {
                    self.myPageModel.lastMax = nil;
                }else{
                    self.myPageModel.lastMax = [NSString fromString:[tempDic hasItemAndBack:@"last_max"]];
                }
            }
            
            for (int i=0; i<[tempDataArray count]; i++) {
                NSDictionary* tempItemDic = [tempDataArray objectAtIndex:i];
                if (tempItemDic!=nil) {
                    
                    M_MyMessageItemModel* tempItem = [M_MyMessageItemModel allocInstance];
                    
                    tempItem.myMessage_id = [NSString fromString:[tempItemDic hasItemAndBack:@"id"]];
                    
                    tempItem.myUserType = @"";
                    
                    NSDictionary* tempFromDic=  [tempItemDic hasItemAndBack:@"from"];
                    if (tempFromDic !=nil) {
                        
                        tempItem.myFromModel = [M_UserInfoModel allocInstance];
                        
                        tempItem.myFromModel.user_id        = [NSString fromString:[tempFromDic hasItemAndBack:@"id"]];
                        NSLog(@"user_id = %@",  tempItem.myFromModel.user_id);
                        tempItem.myFromModel.user_name      = [NSString fromString:[tempFromDic hasItemAndBack:@"name"]];
                        tempItem.myFromModel.user_nick      = [NSString fromString:[tempFromDic hasItemAndBack:@"nick"]];
                        tempItem.myFromModel.user_photo     = [NSString fromString:[tempFromDic hasItemAndBack:@"avatar"]];
                        tempItem.myFromModel.user_phone     = [NSString fromString:[tempFromDic hasItemAndBack:@"phone"]];
                        tempItem.myFromModel.user_birthday  = [NSString fromString:[tempFromDic hasItemAndBack:@"birthday"]];
                        tempItem.myFromModel.user_sex       = [NSString fromString:[tempFromDic hasItemAndBack:@"sex"]];
                        tempItem.myFromModel.province_name  = [NSString fromString:[tempFromDic hasItemAndBack:@"province_name"]];
                        tempItem.myFromModel.city_name      = [NSString fromString:[tempFromDic hasItemAndBack:@"city_name"]];
                        tempItem.myFromModel.county_name =  [NSString fromString:[tempFromDic hasItemAndBack:@"county_name"]];
                        tempItem.myFromModel.city_code      = [NSString fromString:[tempFromDic hasItemAndBack:@"city_id"]];
                        
                        tempItem.myFromModel.myStarted_at       = [NSString fromString:[tempFromDic hasItemAndBack:@"started_at"]];
                        tempItem.myFromModel.myWord       = [NSString fromString:[tempFromDic hasItemAndBack:@"word"]];
                        tempItem.myFromModel.myTitle       = [NSString fromString:[tempFromDic hasItemAndBack:@"title"]];

                    }
                    
                    NSDictionary* tempToDic=  [tempItemDic hasItemAndBack:@"to"];
                    if (tempToDic !=nil) {
                        
                        tempItem.myToModel = [M_UserInfoModel allocInstance];
                        
                        tempItem.myToModel.user_id        = [NSString fromString:[tempToDic hasItemAndBack:@"id"]];
                        tempItem.myToModel.user_name      = [NSString fromString:[tempToDic hasItemAndBack:@"name"]];
                        tempItem.myToModel.user_nick      = [NSString fromString:[tempToDic hasItemAndBack:@"nick"]];
                        tempItem.myToModel.user_photo     = [NSString fromString:[tempToDic hasItemAndBack:@"avatar"]];
                        tempItem.myToModel.user_phone     = [NSString fromString:[tempToDic hasItemAndBack:@"phone"]];
                        tempItem.myToModel.user_birthday  = [NSString fromString:[tempToDic hasItemAndBack:@"birthday"]];
                        tempItem.myToModel.user_sex       = [NSString fromString:[tempToDic hasItemAndBack:@"sex"]];
                        
                        tempItem.myToModel.myStarted_at       = [NSString fromString:[tempToDic hasItemAndBack:@"started_at"]];
                        tempItem.myToModel.myWord       = [NSString fromString:[tempToDic hasItemAndBack:@"word"]];
                        tempItem.myToModel.myTitle       = [NSString fromString:[tempToDic hasItemAndBack:@"title"]];
                        
                        tempItem.myToModel.province_name  = [NSString fromString:[tempToDic hasItemAndBack:@"province_name"]];
                        tempItem.myToModel.city_name      = [NSString fromString:[tempToDic hasItemAndBack:@"city_name"]];
                        tempItem.myToModel.county_name =  [NSString fromString:[tempToDic hasItemAndBack:@"county_name"]];
                        tempItem.myToModel.city_code      = [NSString fromString:[tempToDic hasItemAndBack:@"city_id"]];
                    }
                    
                    if (tempItem.myFromModel!=nil) {
                        if ([tempItem.myFromModel.user_id notEmpty]) {
                            if ([tempItem.myFromModel.user_id isEqualToString:APPDELEGATE.viewController.myUserModel.user_id]) {
                                tempItem.myUserType = @"1";
                            }else{
                                tempItem.myUserType = @"0";                                
                            }
                        }
                    }
                    
                    tempItem.myContent = [tempItemDic hasItemAndBack:@"content"];
                    tempItem.myType = [NSString fromString:[tempItemDic hasItemAndBack:@"type"]];
                    tempItem.myIsRead = [NSString fromString:[tempItemDic hasItemAndBack:@"is_read"]];
                    
                    tempItem.myTimer = [NSString fromString:[tempItemDic hasItemAndBack:@"updated_at"]];
                    tempItem.myGroup = [NSString fromString:[tempItemDic hasItemAndBack:@"group"]];
                    
                    NSDictionary* tempCardDic = [tempItemDic hasItemAndBack:@"card"];
                    if (tempCardDic!=nil) {
                        tempItem.myCardId = [NSString fromString:[tempCardDic hasItemAndBack:@"id"]];
                        tempItem.myCardDesc = [NSString fromString:[tempCardDic hasItemAndBack:@"desc"]];
                        tempItem.myCardInfo = [NSString fromString:[tempCardDic hasItemAndBack:@"info"]];
                        tempItem.myCardSales = [NSString fromString:[tempCardDic hasItemAndBack:@"sales"]];
                        tempItem.myCardCarImg = [NSString fromString:[tempCardDic hasItemAndBack:@"car_img"]];
                    }
                    
                    [self.myItemArray addObject:tempItem];
                }
            }
        }
    }
}
@end
