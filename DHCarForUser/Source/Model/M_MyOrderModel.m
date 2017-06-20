//
//  M_MyOrderModel.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/12.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_MyOrderModel.h"

@implementation M_OrderCodeModel

DEF_FACTORY(M_OrderCodeModel);


@end

@implementation M_WxPayModel

DEF_FACTORY(M_WxPayModel);


@end

@implementation M_QuoteComboItemModel

DEF_FACTORY(M_QuoteComboItemModel);

@end

@implementation M_QuoteItemModel

DEF_FACTORY(M_QuoteItemModel);

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        self.myFirstComboArray = [NSMutableArray allocInstance];
        self.myLastComboArray = [NSMutableArray allocInstance];
    }
    return self;
}

-(void)parseDataDic:(NSDictionary *)str
{
    NSDictionary* tempDic = [str hasItemAndBack:@"result"];
    
    if (tempDic!=nil) {
        
        M_QuoteItemModel* tempQuoteModel = self;
        
        tempQuoteModel.myQuoteId = [NSString fromString:[tempDic hasItemAndBack:@"id"]];
        tempQuoteModel.myFirstPrice = [NSString fromString:[tempDic hasItemAndBack:@"first_price"]];
        tempQuoteModel.myFirstInfo = [NSString fromString:[tempDic hasItemAndBack:@"first_price_info"]];
        tempQuoteModel.myLastInfo = [NSString fromString:[tempDic hasItemAndBack:@"last_price_info"]];
        tempQuoteModel.myLastPrice = [NSString fromString:[tempDic hasItemAndBack:@"last_price"]];
        tempQuoteModel.myHasConverted = [NSString fromString:[tempDic hasItemAndBack:@"has_converted"]];
        
        tempQuoteModel.myUid = [NSString fromString:[tempDic hasItemAndBack:@"uid"]];
        tempQuoteModel.mySalesUid = [NSString fromString:[tempDic hasItemAndBack:@"sales_uid"]];
        tempQuoteModel.myExpectSalesUid = [NSString fromString:[tempDic hasItemAndBack:@"expect_sales_uid"]];
        tempQuoteModel.myInquiryId = [NSString fromString:[tempDic hasItemAndBack:@"inquiry_id"]];
        
        tempQuoteModel.myEarnest = [NSString fromString:[tempDic hasItemAndBack:@"earnest"]];
        
        NSArray* tempFirstComboArray = [tempDic hasItemAndBack:@"first_price_combo"];
        if (tempFirstComboArray!=nil) {
            for (int j=0; j<[tempFirstComboArray count]; j++) {
                NSDictionary* tempComboDic = [tempFirstComboArray objectAtIndex:j];
                if (tempComboDic!=nil) {
                    M_QuoteComboItemModel* tempComboItem = [M_QuoteComboItemModel allocInstance];
                    
                    tempComboItem.myComboId = [NSString fromString:[tempComboDic hasItemAndBack:@"id"]];
                    tempComboItem.myComboTitle = [NSString fromString:[tempComboDic hasItemAndBack:@"title"]];
                    tempComboItem.myComboContent = [NSString fromString:[tempComboDic hasItemAndBack:@"content"]];
                    tempComboItem.myDealerId = [NSString fromString:[tempComboDic hasItemAndBack:@"dealer_id"]];
                    
                    [tempQuoteModel.myFirstComboArray addObject:tempComboItem];
                }
            }
        }
        
        NSArray* tempLastComboArray = [tempDic hasItemAndBack:@"last_price_combo"];
        if (tempLastComboArray!=nil) {
            for (int j=0; j<[tempLastComboArray count]; j++) {
                NSDictionary* tempComboDic = [tempLastComboArray objectAtIndex:j];
                if (tempComboDic!=nil) {
                    M_QuoteComboItemModel* tempComboItem = [M_QuoteComboItemModel allocInstance];
                    
                    tempComboItem.myComboId = [NSString fromString:[tempComboDic hasItemAndBack:@"id"]];
                    tempComboItem.myComboTitle = [NSString fromString:[tempComboDic hasItemAndBack:@"title"]];
                    tempComboItem.myComboContent = [NSString fromString:[tempComboDic hasItemAndBack:@"content"]];
                    tempComboItem.myDealerId = [NSString fromString:[tempComboDic hasItemAndBack:@"dealer_id"]];
                    
                    [tempQuoteModel.myLastComboArray addObject:tempComboItem];
                }
            }
        }
        
        NSDictionary* tempOrderDic = [tempDic hasItemAndBack:@"order"];
        if (tempOrderDic!=nil) {
            tempQuoteModel.myOrderModel = [M_MyOrderTtemModel allocInstance];
            
            tempQuoteModel.myOrderModel.order_id = [NSString fromString:[tempOrderDic hasItemAndBack:@"id"]];
            tempQuoteModel.myOrderModel.order_no = [NSString fromString:[tempOrderDic hasItemAndBack:@"no"]];
            tempQuoteModel.myOrderModel.order_step = [NSString fromString:[tempOrderDic hasItemAndBack:@"step"]];
        }
        
        NSDictionary* tempQDeaDic =[tempDic hasItemAndBack:@"dealer"];
        if (tempQDeaDic!=nil) {
            tempQuoteModel.myDealerModel = [M_DealerItemModel allocInstance];
            
            tempQuoteModel.myDealerModel.dealer_id = [NSString fromString:[tempQDeaDic hasItemAndBack:@"id"]];
            tempQuoteModel.myDealerModel.dealer_name = [tempQDeaDic hasItemAndBack:@"fullname"];
            tempQuoteModel.myDealerModel.dealer_sname = [tempQDeaDic hasItemAndBack:@"name"];
            tempQuoteModel.myDealerModel.dealer_code = [tempQDeaDic hasItemAndBack:@"code"];
            
            tempQuoteModel.myDealerModel.province_id = [NSString fromString:[tempQDeaDic hasItemAndBack:@"province_id"]];
            tempQuoteModel.myDealerModel.city_id = [NSString fromString:[tempQDeaDic hasItemAndBack:@"city_id"]];
            
            tempQuoteModel.myDealerModel.dealer_address = [tempQDeaDic hasItemAndBack:@"address"];
            tempQuoteModel.myDealerModel.dealer_zip = [tempQDeaDic hasItemAndBack:@"zip"];
            tempQuoteModel.myDealerModel.dealer_tel = [tempQDeaDic hasItemAndBack:@"tel"];
            tempQuoteModel.myDealerModel.dealer_email = [tempQDeaDic hasItemAndBack:@"email"];
            tempQuoteModel.myDealerModel.dealer_lat = [NSString fromString:[tempQDeaDic hasItemAndBack:@"lat"]];
            tempQuoteModel.myDealerModel.dealer_lng = [NSString fromString:[tempQDeaDic hasItemAndBack:@"lng"]];
            tempQuoteModel.myDealerModel.dealer_distance = [tempQDeaDic hasItemAndBack:@"distance"];
            
            tempQuoteModel.myDealerModel.dealer_distance = [Unity stringToKmString:tempQuoteModel.myDealerModel.dealer_lat withLon:tempQuoteModel.myDealerModel.dealer_lng];
            tempQuoteModel.myDealerModel.distance = [tempQuoteModel.myDealerModel.dealer_distance floatValue];
        }
        
        NSDictionary* tempItemDic = [tempDic hasItemAndBack:@"inquiry"];
        
        if (tempItemDic!=nil) {
            
            tempQuoteModel.myInquiryModel = [M_MyOrderTtemModel allocInstance];
            
            tempQuoteModel.myInquiryModel.order_id = [NSString fromString:[tempItemDic hasItemAndBack:@"id"]];
            tempQuoteModel.myInquiryModel.order_no = [NSString fromString:[tempItemDic hasItemAndBack:@"no"]];
            tempQuoteModel.myInquiryModel.order_step = [NSString fromString:[tempItemDic hasItemAndBack:@"step"]];
            tempQuoteModel.myInquiryModel.order_time = [NSString fromString:[tempItemDic hasItemAndBack:@"updated_at"]];
            
            tempQuoteModel.myInquiryModel.myQuoted_at = [NSString fromString:[tempItemDic hasItemAndBack:@"created_at"]];
            tempQuoteModel.myInquiryModel.myQuoted_count = [NSString fromString:[tempItemDic hasItemAndBack:@"quoted_count"]];
            tempQuoteModel.myInquiryModel.myDealer_count = [NSString fromString:[tempItemDic hasItemAndBack:@"dealer_count"]];
            
            tempQuoteModel.myInquiryModel.car = [M_CarItemModel allocInstance];
            
            NSDictionary* tempCarDic = [tempItemDic hasItemAndBack:@"car"];
            if (tempCarDic!=nil) {
                
                tempQuoteModel.myInquiryModel.car.myCar_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"id"]];
                tempQuoteModel.myInquiryModel.car.myBigBrand_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"bbid"]];
                tempQuoteModel.myInquiryModel.car.myBrand_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"bid"]];
                tempQuoteModel.myInquiryModel.car.mySubbrand_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"sid"]];
                tempQuoteModel.myInquiryModel.car.myCar_Name = [tempCarDic hasItemAndBack:@"name"];
                tempQuoteModel.myInquiryModel.car.myCar_Year = [NSString fromString:[tempCarDic hasItemAndBack:@"year"]];
                tempQuoteModel.myInquiryModel.car.myCar_Img = [tempCarDic hasItemAndBack:@"img"];
                tempQuoteModel.myInquiryModel.car.myCar_Info = [tempCarDic hasItemAndBack:@"info"];
                tempQuoteModel.myInquiryModel.car.myCar_Policy = [tempCarDic hasItemAndBack:@"policy"];
                tempQuoteModel.myInquiryModel.car.myCar_Price = [NSString fromString:[tempCarDic hasItemAndBack:@"price"]];
                
                NSArray* tempparameterArray = [tempCarDic hasItemAndBack:@"base_parameter"];
                if (tempparameterArray!=nil) {
                    for (int j=0; j<[tempparameterArray count]; j++) {
                        NSDictionary* tempparameterItemDic = [tempparameterArray objectAtIndex:j];
                        if (tempparameterItemDic!=nil) {
                            
                            M_CarParameterItemModel* tempparameterItem = [M_CarParameterItemModel allocInstance];
                            
                            tempparameterItem.myParameter_Name = [tempparameterItemDic hasItemAndBack:@"name"];
                            tempparameterItem.myParameter_Value = [tempparameterItemDic hasItemAndBack:@"value"];
                            
                            [tempQuoteModel.myInquiryModel.car.myParameterArray addObject:tempparameterItem];
                        }
                    }
                }
            }
            
            NSDictionary* tempSeries = [tempItemDic hasItemAndBack:@"series"];
            if (tempSeries != nil) {
                tempQuoteModel.myInquiryModel.car.mySubbrand_Name = [tempSeries hasItemAndBack:@"name"];
            }
            
            NSDictionary* tempBrand = [tempItemDic hasItemAndBack:@"brand"];
            if (tempBrand != nil) {
                tempQuoteModel.myInquiryModel.car.myBrand_Name = [tempBrand hasItemAndBack:@"name"];
            }
            
            NSDictionary* tempBigbrand = [tempItemDic hasItemAndBack:@"bigbrand"];
            if (tempBigbrand != nil) {
                tempQuoteModel.myInquiryModel.car.myBigBrand_Name = [tempBigbrand hasItemAndBack:@"name"];
            }
            
            NSDictionary* tempColor = [tempItemDic hasItemAndBack:@"color"];
            if (tempColor != nil) {
                tempQuoteModel.myInquiryModel.car.myItemColorModel = [M_CarColorItemModel allocInstance];
                tempQuoteModel.myInquiryModel.car.myItemColorModel.myCar_Color_Id = [NSString fromString:[tempColor hasItemAndBack:@"id"]];
                tempQuoteModel.myInquiryModel.car.myItemColorModel.myCar_Color_Name = [NSString fromString:[tempColor hasItemAndBack:@"name"]];
                tempQuoteModel.myInquiryModel.car.myItemColorModel.myCar_Color_Img = [NSString fromString:[tempColor hasItemAndBack:@"value"]];
            }
        }
        
    }
}

@end

@implementation M_MyOrderTtemModel

DEF_FACTORY(M_MyOrderTtemModel)

DEF_MODEL(order_id);
DEF_MODEL(order_no);
DEF_MODEL(order_time);
DEF_MODEL(order_price);
DEF_MODEL(order_step);
DEF_MODEL(car);
DEF_MODEL(user);
DEF_MODEL(myDealerModel);

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.myQuoteArray = [NSMutableArray allocInstance];
        self.myDealerArray = [NSMutableArray allocInstance];
        self.myCertificateArray = [NSMutableArray allocInstance];
    }
    return self;
}

-(void)parseDataDic:(NSDictionary *)str
{
    NSDictionary* tempDic = [str hasItemAndBack:@"result"];
    
    if (tempDic!=nil) {
        
        NSDictionary* tempItemDic = [tempDic hasItemAndBack:@"inquiry"];
        
        if (tempItemDic!=nil) {
            
            self.order_id = [NSString fromString:[tempItemDic hasItemAndBack:@"id"]];
            self.order_no = [NSString fromString:[tempItemDic hasItemAndBack:@"no"]];
            self.order_step = [NSString fromString:[tempItemDic hasItemAndBack:@"step"]];
            self.order_time = [NSString fromString:[tempItemDic hasItemAndBack:@"updated_at"]];
            self.myQuoted_at = [NSString fromString:[tempItemDic hasItemAndBack:@"created_at"]];
            self.myQuoted_count = [NSString fromString:[tempItemDic hasItemAndBack:@"quoted_count"]];
            self.myDealer_count = [NSString fromString:[tempItemDic hasItemAndBack:@"dealer_count"]];
            
            self.car = [M_CarItemModel allocInstance];
            
            NSDictionary* tempCarDic = [tempItemDic hasItemAndBack:@"car"];
            if (tempCarDic!=nil) {
                
                self.car.myCar_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"id"]];
                self.car.myBigBrand_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"bbid"]];
                self.car.myBrand_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"bid"]];
                self.car.mySubbrand_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"sid"]];
                self.car.myCar_Name = [tempCarDic hasItemAndBack:@"name"];
                self.car.myCar_Year = [NSString fromString:[tempCarDic hasItemAndBack:@"year"]];
                self.car.myCar_Img = [tempCarDic hasItemAndBack:@"img"];
                self.car.myCar_Info = [tempCarDic hasItemAndBack:@"info"];
                self.car.myCar_Policy = [tempCarDic hasItemAndBack:@"policy"];
                self.car.myCar_Price = [NSString fromString:[tempCarDic hasItemAndBack:@"price"]];
                
                NSArray* tempparameterArray = [tempCarDic hasItemAndBack:@"base_parameter"];
                if (tempparameterArray!=nil) {
                    for (int j=0; j<[tempparameterArray count]; j++) {
                        NSDictionary* tempparameterItemDic = [tempparameterArray objectAtIndex:j];
                        if (tempparameterItemDic!=nil) {
                            
                            M_CarParameterItemModel* tempparameterItem = [M_CarParameterItemModel allocInstance];
                            
                            tempparameterItem.myParameter_Name = [tempparameterItemDic hasItemAndBack:@"name"];
                            tempparameterItem.myParameter_Value = [tempparameterItemDic hasItemAndBack:@"value"];
                            
                            [self.car.myParameterArray addObject:tempparameterItem];
                        }
                    }
                }
            }
            
            NSDictionary* tempSeries = [tempItemDic hasItemAndBack:@"series"];
            if (tempSeries != nil) {
                self.car.mySubbrand_Name = [tempSeries hasItemAndBack:@"name"];
            }
            
            NSDictionary* tempBrand = [tempItemDic hasItemAndBack:@"brand"];
            if (tempBrand != nil) {
                self.car.myBrand_Name = [tempBrand hasItemAndBack:@"name"];
            }
            
            NSDictionary* tempBigbrand = [tempItemDic hasItemAndBack:@"bigbrand"];
            if (tempBigbrand != nil) {
                self.car.myBigBrand_Name = [tempBigbrand hasItemAndBack:@"name"];
            }
            
            NSDictionary* tempColor = [tempItemDic hasItemAndBack:@"color"];
            if (tempColor != nil) {
                self.car.myItemColorModel = [M_CarColorItemModel allocInstance];
                self.car.myItemColorModel.myCar_Color_Id = [NSString fromString:[tempColor hasItemAndBack:@"id"]];
                self.car.myItemColorModel.myCar_Color_Name = [NSString fromString:[tempColor hasItemAndBack:@"name"]];
                self.car.myItemColorModel.myCar_Color_Img = [NSString fromString:[tempColor hasItemAndBack:@"value"]];
            }
            
            NSArray* tempQuoteArray = [tempDic hasItemAndBack:@"quote"];
            
            if (tempQuoteArray!=nil) {
                for (int i=0; i<[tempQuoteArray count]; i++) {
                    NSDictionary* tempQuoteDic = [tempQuoteArray objectAtIndex:i];
                    if (tempQuoteDic!=nil) {
                        M_QuoteItemModel* tempQuoteModel = [M_QuoteItemModel allocInstance];
                        
                        tempQuoteModel.myQuoteId = [NSString fromString:[tempQuoteDic hasItemAndBack:@"id"]];
                        tempQuoteModel.myFirstPrice = [NSString fromString:[tempQuoteDic hasItemAndBack:@"first_price"]];
                        tempQuoteModel.myFirstInfo = [NSString fromString:[tempQuoteDic hasItemAndBack:@"first_price_info"]];
                        tempQuoteModel.myLastInfo = [NSString fromString:[tempQuoteDic hasItemAndBack:@"last_price_info"]];
                        tempQuoteModel.myLastPrice = [NSString fromString:[tempQuoteDic hasItemAndBack:@"last_price"]];
                        tempQuoteModel.myHasConverted = [NSString fromString:[tempQuoteDic hasItemAndBack:@"has_converted"]];
                        
                        tempQuoteModel.myUid = [NSString fromString:[tempQuoteDic hasItemAndBack:@"uid"]];
                        tempQuoteModel.mySalesUid = [NSString fromString:[tempQuoteDic hasItemAndBack:@"sales_uid"]];
                        tempQuoteModel.myExpectSalesUid = [NSString fromString:[tempQuoteDic hasItemAndBack:@"expect_sales_uid"]];
                        tempQuoteModel.myInquiryId = [NSString fromString:[tempQuoteDic hasItemAndBack:@"inquiry_id"]];
                        
                        tempQuoteModel.myEarnest = [NSString fromString:[tempQuoteDic hasItemAndBack:@"earnest"]];
                        
                        NSArray* tempFirstComboArray = [tempQuoteDic hasItemAndBack:@"first_price_combo"];
                        if (tempFirstComboArray!=nil) {
                            for (int j=0; j<[tempFirstComboArray count]; j++) {
                                NSDictionary* tempComboDic = [tempFirstComboArray objectAtIndex:j];
                                if (tempComboDic!=nil) {
                                    M_QuoteComboItemModel* tempComboItem = [M_QuoteComboItemModel allocInstance];
                                    
                                    tempComboItem.myComboId = [NSString fromString:[tempComboDic hasItemAndBack:@"id"]];
                                    tempComboItem.myComboTitle = [NSString fromString:[tempComboDic hasItemAndBack:@"title"]];
                                    tempComboItem.myComboContent = [NSString fromString:[tempComboDic hasItemAndBack:@"content"]];
                                    tempComboItem.myDealerId = [NSString fromString:[tempComboDic hasItemAndBack:@"dealer_id"]];
                                    
                                    [tempQuoteModel.myFirstComboArray addObject:tempComboItem];
                                }
                            }
                        }
                        
                        NSArray* tempLastComboArray = [tempQuoteDic hasItemAndBack:@"last_price_combo"];
                        if (tempLastComboArray!=nil) {
                            for (int j=0; j<[tempLastComboArray count]; j++) {
                                NSDictionary* tempComboDic = [tempLastComboArray objectAtIndex:j];
                                if (tempComboDic!=nil) {
                                    M_QuoteComboItemModel* tempComboItem = [M_QuoteComboItemModel allocInstance];
                                    
                                    tempComboItem.myComboId = [NSString fromString:[tempComboDic hasItemAndBack:@"id"]];
                                    tempComboItem.myComboTitle = [NSString fromString:[tempComboDic hasItemAndBack:@"title"]];
                                    tempComboItem.myComboContent = [NSString fromString:[tempComboDic hasItemAndBack:@"content"]];
                                    tempComboItem.myDealerId = [NSString fromString:[tempComboDic hasItemAndBack:@"dealer_id"]];
                                    
                                    [tempQuoteModel.myLastComboArray addObject:tempComboItem];
                                }
                            }
                        }

                        
                        NSDictionary* tempQDeaDic =[tempQuoteDic hasItemAndBack:@"dealer"];
                        if (tempQDeaDic!=nil) {
                            tempQuoteModel.myDealerModel = [M_DealerItemModel allocInstance];
                            
                            tempQuoteModel.myDealerModel.dealer_id = [NSString fromString:[tempQDeaDic hasItemAndBack:@"id"]];
                            tempQuoteModel.myDealerModel.dealer_name = [tempQDeaDic hasItemAndBack:@"fullname"];
                            tempQuoteModel.myDealerModel.dealer_sname = [tempQDeaDic hasItemAndBack:@"name"];
                            tempQuoteModel.myDealerModel.dealer_code = [tempQDeaDic hasItemAndBack:@"code"];
                            
                            tempQuoteModel.myDealerModel.province_id = [NSString fromString:[tempQDeaDic hasItemAndBack:@"province_id"]];
                            tempQuoteModel.myDealerModel.city_id = [NSString fromString:[tempQDeaDic hasItemAndBack:@"city_id"]];
                            
                            tempQuoteModel.myDealerModel.dealer_address = [tempQDeaDic hasItemAndBack:@"address"];
                            tempQuoteModel.myDealerModel.dealer_zip = [tempQDeaDic hasItemAndBack:@"zip"];
                            tempQuoteModel.myDealerModel.dealer_tel = [tempQDeaDic hasItemAndBack:@"tel"];
                            tempQuoteModel.myDealerModel.dealer_email = [tempQDeaDic hasItemAndBack:@"email"];
                            tempQuoteModel.myDealerModel.dealer_lat = [NSString fromString:[tempQDeaDic hasItemAndBack:@"lat"]];
                            tempQuoteModel.myDealerModel.dealer_lng = [NSString fromString:[tempQDeaDic hasItemAndBack:@"lng"]];
                            tempQuoteModel.myDealerModel.dealer_distance = [tempQDeaDic hasItemAndBack:@"distance"];
                            
                            tempQuoteModel.myDealerModel.dealer_distance = [Unity stringToKmString:tempQuoteModel.myDealerModel.dealer_lat withLon:tempQuoteModel.myDealerModel.dealer_lng];
                            tempQuoteModel.myDealerModel.distance = [tempQuoteModel.myDealerModel.dealer_distance floatValue];
                            
                            NSDictionary* tempCity = [tempQDeaDic hasItemAndBack:@"city"];
                            if (tempCity!=nil) {
                                tempQuoteModel.myDealerModel.city_name = [tempCity hasItemAndBack:@"name"];
                                NSDictionary* tempprovince = [tempItemDic hasItemAndBack:@"province"];
                                if (tempprovince!=nil) {
                                    tempQuoteModel.myDealerModel.province_name = [tempCity hasItemAndBack:@"name"];
                                }
                            }
                            
                        }
                        
                        [self.myQuoteArray addObject:tempQuoteModel];
                    }
                }
            }
            
        }else{
            
            self.order_id = [NSString fromString:[tempDic hasItemAndBack:@"id"]];
            self.order_no = [NSString fromString:[tempDic hasItemAndBack:@"no"]];
            self.order_time = [NSString fromString:[tempDic hasItemAndBack:@"updated_at"]];
            
            self.order_create_time = [NSString fromString:[tempDic hasItemAndBack:@"created_at"]];
            
            self.myQuoted_at = [NSString fromString:[tempDic hasItemAndBack:@"quoted_at"]];
            self.order_step = [NSString fromString:[tempDic hasItemAndBack:@"step"]];
            self.myAlipayStr = [tempDic hasItemAndBack:@"alipaystr"];
            
            self.order_update_time = [NSString fromString:[tempDic hasItemAndBack:@"updated_at"]];
            
            self.car = [M_CarItemModel allocInstance];
            
            NSString* car_type = [NSString fromString:[tempDic hasItemAndBack:@"type"]];
            
            if ([car_type notEmpty]) {
                if ([car_type isEqualToString:@"1"]) {
                    self.car.myCar_Sales = YES;
                }else if ([car_type isEqualToString:@"2"]) {
                    self.car.myCar_Lease = YES;
                }else if ([car_type isEqualToString:@"3"]) {
                    self.car.myCar_New = YES;
                }
            }
            
            self.car.myCar_Deposit = [NSString fromString:[tempDic hasItemAndBack:@"earnest"]];
            
            self.car.myDealer_Car_Price = [NSString fromString:[tempDic hasItemAndBack:@"price"]];
            
            NSDictionary* tempCode = [tempDic hasItemAndBack:@"code"];
            if (tempCode!=nil) {
                self.myCodeModel = [M_OrderCodeModel allocInstance];
                
                self.myCodeModel.myCodeId = [NSString fromString:[tempCode hasItemAndBack:@"id"]];
                self.myCodeModel.myCodeStr = [NSString fromString:[tempCode hasItemAndBack:@"code"]];
                self.myCodeModel.myType = [NSString fromString:[tempCode hasItemAndBack:@"type"]];
                self.myCodeModel.myPhone = [NSString fromString:[tempCode hasItemAndBack:@"phone"]];
            }
            
            NSDictionary* tempWxPayDic = [tempDic hasItemAndBack:@"wxpaystr"];
            if (tempWxPayDic!=nil) {
                self.myWxPayModel = [M_WxPayModel allocInstance];
                
                self.myWxPayModel.appid = [NSString fromString:[tempWxPayDic hasItemAndBack:@"appid"]];
                self.myWxPayModel.partnerid = [NSString fromString:[tempWxPayDic hasItemAndBack:@"partnerid"]];
                self.myWxPayModel.noncestr = [NSString fromString:[tempWxPayDic hasItemAndBack:@"noncestr"]];
                self.myWxPayModel.prepayid = [NSString fromString:[tempWxPayDic hasItemAndBack:@"prepayid"]];
                self.myWxPayModel.timestamp = [NSString fromString:[tempWxPayDic hasItemAndBack:@"timestamp"]];
                self.myWxPayModel.sign = [NSString fromString:[tempWxPayDic hasItemAndBack:@"sign"]];
                self.myWxPayModel.packagevalue = [NSString fromString:[tempWxPayDic hasItemAndBack:@"packagevalue"]];
            }
            
            NSArray* tempcertificateArray = [tempDic hasItemAndBack:@"certificate"];
            if (tempcertificateArray!=nil) {
                for (int i=0; i<[tempcertificateArray count]; i++) {
                    NSDictionary* tempcertificateDic = [tempcertificateArray objectAtIndex:i];
                    if (tempcertificateDic!=nil) {
                        
                        NSString* tempImages = [tempcertificateDic hasItemAndBack:@"img"];
                        
                        if ([tempImages notEmpty]) {
                            [self.myCertificateArray addObject:tempImages];
                        }
                        
                    }
                }
            }
            
            NSDictionary* tempCarDic = [tempDic hasItemAndBack:@"car"];
            if (tempCarDic!=nil) {
                
                self.car.myCar_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"id"]];
                self.car.myBigBrand_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"bbid"]];
                self.car.myBrand_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"bid"]];
                self.car.mySubbrand_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"sid"]];
                self.car.myCar_Name = [tempCarDic hasItemAndBack:@"name"];
                self.car.myCar_Year = [NSString fromString:[tempCarDic hasItemAndBack:@"year"]];
                
                self.car.myCar_Img = [tempCarDic hasItemAndBack:@"img"];
                self.car.myCar_Info = [tempCarDic hasItemAndBack:@"info"];
                self.car.myCar_Policy = [tempCarDic hasItemAndBack:@"policy"];
                self.car.myCar_Price = [NSString fromString:[tempCarDic hasItemAndBack:@"price"]];
                
                NSDictionary* tempSeries = [tempCarDic hasItemAndBack:@"series"];
                if (tempSeries != nil) {
                    self.car.mySubbrand_Name = [tempSeries hasItemAndBack:@"name"];
                }
                
                NSDictionary* tempBrand = [tempCarDic hasItemAndBack:@"brand"];
                if (tempBrand != nil) {
                    self.car.myBrand_Name = [tempBrand hasItemAndBack:@"name"];
                }
                
                NSDictionary* tempBigbrand = [tempCarDic hasItemAndBack:@"bigbrand"];
                if (tempBigbrand != nil) {
                    self.car.myBigBrand_Name = [tempBigbrand hasItemAndBack:@"name"];
                }
                
                NSDictionary* tempColor = [tempCarDic hasItemAndBack:@"color"];
                if (tempColor != nil) {
                    self.car.myItemColorModel = [M_CarColorItemModel allocInstance];
                    self.car.myItemColorModel.myCar_Color_Id = [NSString fromString:[tempColor hasItemAndBack:@"id"]];
                    self.car.myItemColorModel.myCar_Color_Name = [NSString fromString:[tempColor hasItemAndBack:@"name"]];
                    self.car.myItemColorModel.myCar_Color_Img = [NSString fromString:[tempColor hasItemAndBack:@"value"]];
                }
            }
            
            NSDictionary* tempColor = [tempDic hasItemAndBack:@"color"];
            if (tempColor != nil) {
                if (self.car==nil) {
                    self.car = [M_CarItemModel allocInstance];
                }
                self.car.myItemColorModel = [M_CarColorItemModel allocInstance];
                self.car.myItemColorModel.myCar_Color_Id = [NSString fromString:[tempColor hasItemAndBack:@"id"]];
                self.car.myItemColorModel.myCar_Color_Name = [NSString fromString:[tempColor hasItemAndBack:@"name"]];
                self.car.myItemColorModel.myCar_Color_Img = [NSString fromString:[tempColor hasItemAndBack:@"value"]];
            }
            
            NSDictionary* tempQDeaDic = [tempDic hasItemAndBack:@"dealer"];
            if (tempQDeaDic!=nil) {
                self.myDealerModel = [M_DealerItemModel allocInstance];
                
                self.myDealerModel.dealer_id = [NSString fromString:[tempQDeaDic hasItemAndBack:@"id"]];
                self.myDealerModel.dealer_name = [tempQDeaDic hasItemAndBack:@"fullname"];
                self.myDealerModel.dealer_sname = [tempQDeaDic hasItemAndBack:@"name"];
                self.myDealerModel.dealer_code = [tempQDeaDic hasItemAndBack:@"code"];
                
                self.myDealerModel.province_id = [NSString fromString:[tempQDeaDic hasItemAndBack:@"province_id"]];
                self.myDealerModel.city_id = [NSString fromString:[tempQDeaDic hasItemAndBack:@"city_id"]];
                
                self.myDealerModel.dealer_address = [tempQDeaDic hasItemAndBack:@"address"];
                self.myDealerModel.dealer_zip = [tempQDeaDic hasItemAndBack:@"zip"];
                self.myDealerModel.dealer_tel = [tempQDeaDic hasItemAndBack:@"tel"];
                self.myDealerModel.dealer_email = [tempQDeaDic hasItemAndBack:@"email"];
                self.myDealerModel.dealer_lat = [NSString fromString:[tempQDeaDic hasItemAndBack:@"lat"]];
                self.myDealerModel.dealer_lng = [NSString fromString:[tempQDeaDic hasItemAndBack:@"lng"]];
                self.myDealerModel.dealer_distance = [tempQDeaDic hasItemAndBack:@"distance"];
                
                self.myDealerModel.dealer_distance = [Unity stringToKmString:self.myDealerModel.dealer_lat withLon:self.myDealerModel.dealer_lng];
                self.myDealerModel.distance = [self.myDealerModel.dealer_distance floatValue];
            }
            
            NSDictionary* tempQuoteDic = [tempDic hasItemAndBack:@"quoted"];
            if (tempQuoteDic!= nil) {
                self.myQuoteModel = [M_QuoteItemModel allocInstance];
                
                self.myQuoteModel.myInquiryId = [NSString fromString:[tempQuoteDic hasItemAndBack:@"inquiry_id"]];
                self.myQuoteModel.myQuoteId = [NSString fromString:[tempQuoteDic hasItemAndBack:@"id"]];
                
                self.myQuoteModel.myFirstPrice = [NSString fromString:[tempQuoteDic hasItemAndBack:@"first_price"]];
                self.myQuoteModel.myFirstInfo = [NSString fromString:[tempQuoteDic hasItemAndBack:@"first_price_info"]];
                self.myQuoteModel.myLastInfo = [NSString fromString:[tempQuoteDic hasItemAndBack:@"last_price_info"]];
                self.myQuoteModel.myLastPrice = [NSString fromString:[tempQuoteDic hasItemAndBack:@"last_price"]];
                self.myQuoteModel.myHasConverted = [NSString fromString:[tempQuoteDic hasItemAndBack:@"has_converted"]];
                
                self.myQuoteModel.myUid = [NSString fromString:[tempQuoteDic hasItemAndBack:@"uid"]];
                self.myQuoteModel.mySalesUid = [NSString fromString:[tempQuoteDic hasItemAndBack:@"sales_uid"]];
                self.myQuoteModel.myExpectSalesUid = [NSString fromString:[tempQuoteDic hasItemAndBack:@"expect_sales_uid"]];
                
                NSArray* tempFirstComboArray = [tempQuoteDic hasItemAndBack:@"first_price_combo"];
                if (tempFirstComboArray!=nil) {
                    for (int j=0; j<[tempFirstComboArray count]; j++) {
                        NSDictionary* tempComboDic = [tempFirstComboArray objectAtIndex:j];
                        if (tempComboDic!=nil) {
                            M_QuoteComboItemModel* tempComboItem = [M_QuoteComboItemModel allocInstance];
                            
                            tempComboItem.myComboId = [NSString fromString:[tempComboDic hasItemAndBack:@"id"]];
                            tempComboItem.myComboTitle = [NSString fromString:[tempComboDic hasItemAndBack:@"title"]];
                            tempComboItem.myComboContent = [NSString fromString:[tempComboDic hasItemAndBack:@"content"]];
                            tempComboItem.myDealerId = [NSString fromString:[tempComboDic hasItemAndBack:@"dealer_id"]];
                            
                            [self.myQuoteModel.myFirstComboArray addObject:tempComboItem];
                        }
                    }
                }
                
                NSArray* tempLastComboArray = [tempQuoteDic hasItemAndBack:@"last_price_combo"];
                if (tempLastComboArray!=nil) {
                    for (int j=0; j<[tempLastComboArray count]; j++) {
                        NSDictionary* tempComboDic = [tempLastComboArray objectAtIndex:j];
                        if (tempComboDic!=nil) {
                            M_QuoteComboItemModel* tempComboItem = [M_QuoteComboItemModel allocInstance];
                            
                            tempComboItem.myComboId = [NSString fromString:[tempComboDic hasItemAndBack:@"id"]];
                            tempComboItem.myComboTitle = [NSString fromString:[tempComboDic hasItemAndBack:@"title"]];
                            tempComboItem.myComboContent = [NSString fromString:[tempComboDic hasItemAndBack:@"content"]];
                            tempComboItem.myDealerId = [NSString fromString:[tempComboDic hasItemAndBack:@"dealer_id"]];
                            
                            [self.myQuoteModel.myLastComboArray addObject:tempComboItem];
                        }
                    }
                }
            }
        }
    }
}

@end

@implementation M_MyOrderModel

DEF_FACTORY(M_MyOrderModel)
DEF_MODEL(myItemArray);

-(id)init
{
    self = [super init];
    if (self) {
        self.myItemArray = [NSMutableArray allocInstance];
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
                    
                    M_MyOrderTtemModel* tempItem  = [M_MyOrderTtemModel allocInstance];
                    
                    tempItem.order_id = [NSString fromString:[tempItemDic hasItemAndBack:@"id"]];
                    tempItem.order_no = [NSString fromString:[tempItemDic hasItemAndBack:@"no"]];
                    tempItem.order_step = [NSString fromString:[tempItemDic hasItemAndBack:@"step"]];
                    
                    tempItem.myQuoted_at = [NSString fromString:[tempItemDic hasItemAndBack:@"quoted_at"]];
                    tempItem.myQuoted_count = [NSString fromString:[tempItemDic hasItemAndBack:@"quoted_count"]];
                    tempItem.myDealer_count = [NSString fromString:[tempItemDic hasItemAndBack:@"dealer_count"]];
                    
                    tempItem.car = [M_CarItemModel allocInstance];
                    
                    tempItem.car.myCar_Deposit = [NSString fromString:[tempItemDic hasItemAndBack:@"earnest"]];
                    
                    tempItem.car.myDealer_Car_Price = [NSString fromString:[tempItemDic hasItemAndBack:@"price"]];
                    
                    NSDictionary* tempCarDic = [tempItemDic hasItemAndBack:@"car"];
                    if (tempCarDic!=nil) {
                        
                        tempItem.car.myCar_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"id"]];
                        tempItem.car.myBigBrand_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"bbid"]];
                        tempItem.car.myBrand_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"bid"]];
                        tempItem.car.mySubbrand_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"sid"]];
                        tempItem.car.myCar_Name = [tempCarDic hasItemAndBack:@"name"];
                        tempItem.car.myCar_Year = [NSString fromString:[tempCarDic hasItemAndBack:@"year"]];
                        tempItem.car.myCar_Img = [tempCarDic hasItemAndBack:@"img"];
                        tempItem.car.myCar_Info = [tempCarDic hasItemAndBack:@"info"];
                        tempItem.car.myCar_Policy = [tempCarDic hasItemAndBack:@"policy"];
                        tempItem.car.myCar_Price = [NSString fromString:[tempCarDic hasItemAndBack:@"price"]];
                        
                        NSDictionary* tempSeries = [tempCarDic hasItemAndBack:@"series"];
                        if (tempSeries != nil) {
                            tempItem.car.mySubbrand_Name = [tempSeries hasItemAndBack:@"name"];
                        }
                        
                        NSDictionary* tempBrand = [tempCarDic hasItemAndBack:@"brand"];
                        if (tempBrand != nil) {
                            tempItem.car.myBrand_Name = [tempBrand hasItemAndBack:@"name"];
                        }
                        
                        NSDictionary* tempBigbrand = [tempCarDic hasItemAndBack:@"bigbrand"];
                        if (tempBigbrand != nil) {
                            tempItem.car.myBigBrand_Name = [tempBigbrand hasItemAndBack:@"name"];
                        }
                        
                        NSDictionary* tempColor = [tempCarDic hasItemAndBack:@"color"];
                        if (tempColor != nil) {
                            tempItem.car.myItemColorModel = [M_CarColorItemModel allocInstance];
                            tempItem.car.myItemColorModel.myCar_Color_Id = [NSString fromString:[tempColor hasItemAndBack:@"id"]];
                            tempItem.car.myItemColorModel.myCar_Color_Name = [NSString fromString:[tempColor hasItemAndBack:@"name"]];
                            tempItem.car.myItemColorModel.myCar_Color_Img = [NSString fromString:[tempColor hasItemAndBack:@"value"]];
                        }
                    }
                    
                    NSDictionary* tempSeries = [tempItemDic hasItemAndBack:@"series"];
                    if (tempSeries != nil) {
                        tempItem.car.mySubbrand_Name = [tempSeries hasItemAndBack:@"name"];
                    }
                    
                    NSDictionary* tempBrand = [tempItemDic hasItemAndBack:@"brand"];
                    if (tempBrand != nil) {
                        tempItem.car.myBrand_Name = [tempBrand hasItemAndBack:@"name"];
                    }
                    
                    NSDictionary* tempBigbrand = [tempItemDic hasItemAndBack:@"bigbrand"];
                    if (tempBigbrand != nil) {
                        tempItem.car.myBigBrand_Name = [tempBigbrand hasItemAndBack:@"name"];
                    }
                    
                    NSDictionary* tempColor = [tempItemDic hasItemAndBack:@"color"];
                    if (tempColor != nil) {
                        tempItem.car.myItemColorModel = [M_CarColorItemModel allocInstance];
                        tempItem.car.myItemColorModel.myCar_Color_Id = [NSString fromString:[tempColor hasItemAndBack:@"id"]];
                        tempItem.car.myItemColorModel.myCar_Color_Name = [NSString fromString:[tempColor hasItemAndBack:@"name"]];
                        tempItem.car.myItemColorModel.myCar_Color_Img = [NSString fromString:[tempColor hasItemAndBack:@"value"]];
                    }
                    
                    
                    [self.myItemArray addObject:tempItem];
                }
            }
        }
        
    }
}



@end
