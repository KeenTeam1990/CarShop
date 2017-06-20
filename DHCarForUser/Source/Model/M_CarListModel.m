//
//  M_CarListModel.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/10.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarListModel.h"
#import "M_DealerItemModel.h"
#import "M_UserInfoModel.h"

@implementation M_CarParameterItemModel

DEF_FACTORY(M_CarParameterItemModel);

DEF_MODEL(myParameter_Id);
DEF_MODEL(myParameter_ItemArray);
DEF_MODEL(myParameter_Name);
DEF_MODEL(myParameter_Value);


-(instancetype)init
{
    self = [super init];
    if (self) {
        self.myParameter_ItemArray = [NSMutableArray allocInstance];
    }
    return self;
}

@end

@implementation M_CarPolicyItemModel

DEF_FACTORY(M_CarPolicyItemModel);

DEF_MODEL(myPolicy_Id);
DEF_MODEL(myPolicy_Title);
DEF_MODEL(myPolicy_Wap);

@end

@implementation M_CarLoanItemModel

DEF_FACTORY(M_CarLoanItemModel);

DEF_MODEL(myLoan_Id);
DEF_MODEL(myLoan_Title);
DEF_MODEL(myLoan_Wap);

@end


@implementation M_CarLeaseItemModel

DEF_FACTORY(M_CarLeaseItemModel);

DEF_MODEL(isSelete);
DEF_MODEL(myLease_Id);
DEF_MODEL(myLease_Loan);
DEF_MODEL(myLease_Panyment);
DEF_MODEL(myDealer_Car_id);
DEF_MODEL(myLease_Content);
DEF_MODEL(myLease_Title);


@end

@implementation M_CarColorItemModel

DEF_FACTORY(M_CarColorItemModel);

DEF_MODEL(myCar_Color_Id);
DEF_MODEL(myCar_Color_Img);
DEF_MODEL(myCar_Color_Name);
DEF_MODEL(myCar_Count);

@end

@implementation M_CarItemModel

DEF_FACTORY(M_CarItemModel);

DEF_MODEL(myUpDated_at);
DEF_MODEL(myIndexPath);
DEF_MODEL(myDealer_Car_Id);
DEF_MODEL(myDealer_Car_Price);
DEF_MODEL(myBigBrand_Id);
DEF_MODEL(myBigBrand_Name);
DEF_MODEL(myBrand_Id);
DEF_MODEL(myBrand_Name);
DEF_MODEL(myCar_Code);
DEF_MODEL(myCar_Deposit);
DEF_MODEL(myCar_Id);
DEF_MODEL(myCar_Img);
DEF_MODEL(myCar_Lease);
DEF_MODEL(myCar_Name);
DEF_MODEL(myCar_Price);
DEF_MODEL(myCar_Sales);
DEF_MODEL(myCar_Year);
DEF_MODEL(myCar_Info);
DEF_MODEL(myColorArray);
DEF_MODEL(myLease_Price);
DEF_MODEL(myDealersArray);
DEF_MODEL(mySubbrand_Id);
DEF_MODEL(mySubbrand_Name);
DEF_MODEL(myCar_Collect);
DEF_MODEL(myParameterArray);
DEF_MODEL(myCarImgArray);
DEF_MODEL(myCar_Policy);
DEF_MODEL(myLeaseArray);
DEF_MODEL(myCar_New);
DEF_MODEL(has_Favorite);
DEF_MODEL(readID);

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.myDealersArray = [NSMutableArray allocInstance];
        self.myColorArray = [NSMutableArray allocInstance];
        self.myParameterArray = [NSMutableArray allocInstance];
        self.myCarImgArray = [NSMutableArray allocInstance];
        self.myLeaseArray = [NSMutableArray allocInstance];
        self.mySelasArray = [NSMutableArray allocInstance];
    }
    
    return self;
}

-(void)parseDataDic:(NSDictionary *)str
{
    NSDictionary* tempDic = [str hasItemAndBack:@"result"];
    
    if (tempDic!=nil) {
        
        M_CarItemModel* tempItem  = self;
        
        tempItem.readID = [NSString fromString:[tempDic hasItemAndBack:@"id"]];
        
        if (self.showQRCodeData) {
            NSDictionary* tempCarDic = [tempDic hasItemAndBack:@"car"];
            if (tempCarDic!=nil) {
                tempItem.myCar_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"id"]];
                tempItem.myBigBrand_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"bbid"]];
                tempItem.myBrand_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"bid"]];
                tempItem.mySubbrand_Id = [NSString fromString:[tempCarDic hasItemAndBack:@"sid"]];
                tempItem.myCar_Name = [tempCarDic hasItemAndBack:@"name"];
                tempItem.myCar_Year = [NSString fromString:[tempCarDic hasItemAndBack:@"year"]];
                tempItem.myCar_Img = [tempCarDic hasItemAndBack:@"img"];
                tempItem.myCar_Info = [tempCarDic hasItemAndBack:@"info"];
                tempItem.myCar_Policy = [tempCarDic hasItemAndBack:@"policy"];
                tempItem.myCar_Price = [NSString fromString:[tempCarDic hasItemAndBack:@"price"]];
                
            }
            
            tempItem.myCar_Deposit = [NSString fromString:[tempDic hasItemAndBack:@"earnest"]];
        }else{
            tempItem.myCar_Id = [NSString fromString:[tempDic hasItemAndBack:@"id"]];
            tempItem.myBigBrand_Id = [NSString fromString:[tempDic hasItemAndBack:@"bbid"]];
            tempItem.myBrand_Id = [NSString fromString:[tempDic hasItemAndBack:@"bid"]];
            tempItem.mySubbrand_Id = [NSString fromString:[tempDic hasItemAndBack:@"sid"]];
            tempItem.myCar_Name = [tempDic hasItemAndBack:@"name"];
            
            tempItem.myCreated_at = [NSString fromString:[tempDic hasItemAndBack:@"created_at"]];
            tempItem.myCar_Policy = [tempDic hasItemAndBack:@"policy"];
            tempItem.myCar_Year = [NSString fromString:[tempDic hasItemAndBack:@"year"]];
            tempItem.myCar_Info = [tempDic hasItemAndBack:@"info"];
            tempItem.myCar_Price = [tempDic hasItemAndBack:@"price"];
            tempItem.myCar_Deposit = [NSString fromString:[tempDic hasItemAndBack:@"earnest"]];
            tempItem.myLease_Price = [tempDic hasItemAndBack:@"lowest_price"];
            tempItem.myDealer_Car_Price = [tempDic hasItemAndBack:@"dealer_car_price"];
            tempItem.myCar_Img = [tempDic hasItemAndBack:@"img"];

            tempItem.has_Favorite = [NSString fromString:[tempDic hasItemAndBack:@"has_favorite"]];
            tempItem.myCar_Collect = [NSString fromString:[tempDic hasItemAndBack:@"has_favorite"]];
        }
        NSDictionary* tempSeries = [tempDic hasItemAndBack:@"series"];
        if (tempSeries != nil) {
            tempItem.mySubbrand_Name = [tempSeries hasItemAndBack:@"name"];
        }
        
        NSDictionary* tempBrand = [tempDic hasItemAndBack:@"brand"];
        if (tempBrand != nil) {
            tempItem.myBrand_Name = [tempBrand hasItemAndBack:@"name"];
        }
        
        NSDictionary* tempBigbrand = [tempDic hasItemAndBack:@"bigbrand"];
        if (tempBigbrand != nil) {
            tempItem.myBigBrand_Name = [tempBigbrand hasItemAndBack:@"name"];
        }
        
        NSString* tempprivilege = [NSString fromString:[tempDic hasItemAndBack:@"privilege"]];
        if ([tempprivilege notEmpty]) {
            NSString* tempkdks = [Unity paddedBinaryString:tempprivilege];
            if ([tempkdks notEmpty]) {
                if ([tempkdks length]==3) {
                    tempItem.myCar_Sales = NO;
                    tempItem.myCar_Lease = NO;
                    tempItem.myCar_New = NO;
                    if ([[tempkdks substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]) {
                        tempItem.myCar_Sales = YES;
                    }
                    if ([[tempkdks substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"]) {
                        tempItem.myCar_Lease = YES;
                    }
                    if ([[tempkdks substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"]) {
                        tempItem.myCar_New = YES;
                    }
                }
            }
        }
        
        NSArray* tempImageArray = [tempDic hasItemAndBack:@"images"];
        if (tempImageArray!=nil) {
            for (int i=0; i<[tempImageArray count]; i++) {
                NSDictionary* tempImageDic = [tempImageArray objectAtIndex:i];
                if (tempImageDic!=nil) {
                    NSString* tempStr = [tempImageDic hasItemAndBack:@"img"];
                    if ([tempStr notEmpty]) {
                        [self.myCarImgArray addObject:tempStr];
                    }
                }
            }
        }
        
        NSArray* tempColorArray = [tempDic hasItemAndBack:@"color"];
        if (tempColorArray!=nil) {
            for (int j=0; j<[tempColorArray count]; j++) {
                NSDictionary* tempColorItemDic = [tempColorArray objectAtIndex:j];
                if (tempColorItemDic!=nil) {
                    M_CarColorItemModel* tempColorItem = [M_CarColorItemModel allocInstance];
                    
                     if (self.showQRCodeData) {
                         tempColorItem.myCar_Color_Id = [NSString fromString:[tempColorItemDic hasItemAndBack:@"car_color_id"]];
                     }else{
                    
                         tempColorItem.myCar_Color_Id = [NSString fromString:[tempColorItemDic hasItemAndBack:@"id"]];
                     }
                    tempColorItem.myCar_Color_Name = [tempColorItemDic hasItemAndBack:@"name"];
                    tempColorItem.myCar_Color_Img = [tempColorItemDic hasItemAndBack:@"value"];
                    
                    [tempItem.myColorArray addObject:tempColorItem];
                }
            }
        }
        
        NSArray* tempparameterArray = [tempDic hasItemAndBack:@"base_parameter"];
        if (tempparameterArray!=nil) {
            for (int j=0; j<[tempparameterArray count]; j++) {
                NSDictionary* tempparameterItemDic = [tempparameterArray objectAtIndex:j];
                if (tempparameterItemDic!=nil) {
                    
                    M_CarParameterItemModel* tempparameterItem = [M_CarParameterItemModel allocInstance];
                    
                    tempparameterItem.myParameter_Name = [tempparameterItemDic hasItemAndBack:@"name"];
                    tempparameterItem.myParameter_Value = [tempparameterItemDic hasItemAndBack:@"value"];
                    
                    [tempItem.myParameterArray addObject:tempparameterItem];
                }
            }
        }
        
        if (self.showQRCodeData) {
            
            NSArray* tempLeaseArray = [tempDic hasItemAndBack:@"lease"];
            
            if (tempLeaseArray!=nil) {
                for (int k=0; k<[tempLeaseArray count]; k++) {
                    NSDictionary* tempLeaseIDic = [tempLeaseArray objectAtIndex:k];
                    if (tempLeaseIDic!=nil) {
                        M_CarLeaseItemModel* tempLeaseItem = [M_CarLeaseItemModel allocInstance];
                        
                        tempLeaseItem.myLease_Id = [NSString fromString:[tempLeaseIDic hasItemAndBack:@"lease_plan_id"]];
                        tempLeaseItem.myDealer_Car_id = [NSString fromString:[tempLeaseIDic hasItemAndBack:@"dealer_car_id"]];
                        
//                        NSDictionary* tempLease2IDic = [tempLeaseIDic hasItemAndBack:@"lease"];
//                        if (tempLease2IDic!=nil) {
                            tempLeaseItem.myLease_Title = [tempLeaseIDic hasItemAndBack:@"title"];
                            
                            tempLeaseItem.myLease_Content = [tempLeaseIDic hasItemAndBack:@"content"];
                            
                            tempLeaseItem.myLease_Panyment = [tempLeaseIDic hasItemAndBack:@"downpayment"];
                            
                            tempLeaseItem.myLease_Loan = [NSString fromString:[tempLeaseIDic hasItemAndBack:@"installment"]];
//                        }
                        
                        [self.myLeaseArray addObject:tempLeaseItem];
                    }
                }
            }
            
            NSDictionary* tempDealerDic = [tempDic hasItemAndBack:@"dealer"];
            
            if (tempDealerDic!=nil) {
                M_DealerItemModel* tempDealerItem = [M_DealerItemModel allocInstance];
                
                NSString* tempprivilege = [NSString fromString:[tempDealerDic hasItemAndBack:@"privilege"]];
                if ([tempprivilege notEmpty]) {
                    NSString* tempkdks = [Unity paddedBinaryString:tempprivilege];
                    if ([tempkdks notEmpty]) {
                        if ([tempkdks length]==3) {
                            tempDealerItem.myCar_Sales = NO;
                            tempDealerItem.myCar_Lease = NO;
                            tempDealerItem.myCar_New = NO;
                            if ([[tempkdks substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]) {
                                tempDealerItem.myCar_Sales = YES;
                            }
                            if ([[tempkdks substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"]) {
                                tempDealerItem.myCar_Lease = YES;
                            }
                            if ([[tempkdks substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"]) {
                                tempDealerItem.myCar_New = YES;
                            }
                        }
                    }
                }
                
                tempDealerItem.dealer_id = [NSString fromString:[tempDealerDic hasItemAndBack:@"id"]];
                tempDealerItem.dealer_name = [tempDealerDic hasItemAndBack:@"fullname"];
                tempDealerItem.dealer_sname = [tempDealerDic hasItemAndBack:@"name"];
                
                tempDealerItem.province_id = [NSString fromString:[tempDealerDic hasItemAndBack:@"province_id"]];
                tempDealerItem.city_id = [NSString fromString:[tempDealerDic hasItemAndBack:@"city_id"]];
                
                tempDealerItem.dealer_address = [tempDealerDic hasItemAndBack:@"address"];
                tempDealerItem.dealer_zip = [tempDealerDic hasItemAndBack:@"zip"];
                tempDealerItem.dealer_tel = [tempDealerDic hasItemAndBack:@"tel"];
                
                tempDealerItem.dealer_email = [tempDealerDic hasItemAndBack:@"email"];
                
                tempDealerItem.dealer_lng = [NSString fromString:[tempDealerDic hasItemAndBack:@"lng"]];
                tempDealerItem.dealer_lat = [NSString fromString:[tempDealerDic hasItemAndBack:@"lat"]];
                
                tempDealerItem.city_code = [NSString fromString:[tempDealerDic hasItemAndBack:@"code"]];
                
                tempDealerItem.dealer_lease_price = [tempDealerDic hasItemAndBack:@"lowest_price"];
                tempDealerItem.dealer_car_price = [tempDealerDic hasItemAndBack:@"price"];
                tempDealerItem.price = [tempDealerItem.dealer_car_price floatValue];
                
                tempDealerItem.dealer_distance = [tempDealerDic hasItemAndBack:@"distance"];
                
                tempDealerItem.dealer_distance = [Unity stringToKmString:tempDealerItem.dealer_lat withLon:tempDealerItem.dealer_lng];
                tempDealerItem.distance = [tempDealerItem.dealer_distance floatValue];
                
                self.myDealerItemModel = tempDealerItem;
            }
            
            NSArray* tempSelasArray = [tempDic hasItemAndBack:@"sales"];
            if (tempSelasArray!=nil) {
                for (int i=0; i<[tempSelasArray count]; i++) {
                    NSDictionary* tempSelasDic = [tempSelasArray objectAtIndex:i];
                    if (tempSelasDic!=nil) {
                        M_UserInfoModel* tempInfo = [M_UserInfoModel allocInstance];
                        
                        tempInfo.user_id        = [NSString fromString:[tempSelasDic hasItemAndBack:@"id"]];
                        tempInfo.user_name      = [NSString fromString:[tempSelasDic hasItemAndBack:@"name"]];
                        tempInfo.user_nick      = [NSString fromString:[tempSelasDic hasItemAndBack:@"nick"]];
                        tempInfo.user_photo     = [NSString fromString:[tempSelasDic hasItemAndBack:@"avatar"]];
                        tempInfo.user_phone     = [NSString fromString:[tempSelasDic hasItemAndBack:@"phone"]];
                        tempInfo.user_birthday  = [NSString fromString:[tempSelasDic hasItemAndBack:@"birthday"]];
                        tempInfo.user_sex       = [NSString fromString:[tempSelasDic hasItemAndBack:@"sex"]];
                        tempInfo.province_id  = [NSString fromString:[tempSelasDic hasItemAndBack:@"province_id"]];
                        tempInfo.province_name  = [NSString fromString:[tempSelasDic hasItemAndBack:@"province_name"]];
                        tempInfo.city_name      = [NSString fromString:[tempSelasDic hasItemAndBack:@"city_name"]];
                        tempInfo.county_name =  [NSString fromString:[tempSelasDic hasItemAndBack:@"county_name"]];
                        tempInfo.city_id      = [NSString fromString:[tempSelasDic hasItemAndBack:@"city_id"]];
                        tempInfo.user_gold      = [NSString fromString:[tempSelasDic hasItemAndBack:@"points"]];
                        tempInfo.user_order_gas = [NSString fromString:[tempSelasDic hasItemAndBack:@"user_order_gas"]];
                        
                        tempInfo.myHas_Set_Password = [NSString fromString:[tempSelasDic hasItemAndBack:@"has_set_password"]];
                        
                        tempInfo.user_has_sign =[NSString stringWithFormat:@"%@",[tempSelasDic hasItemAndBack:@"has_sign"]];
                        
                        tempInfo.myStarted_at       = [NSString fromString:[tempSelasDic hasItemAndBack:@"started_at"]];
                        tempInfo.myWord       = [NSString fromString:[tempSelasDic hasItemAndBack:@"word"]];
                        tempInfo.myTitle       = [NSString fromString:[tempSelasDic hasItemAndBack:@"title"]];
                        
                        NSDictionary *tempDict1 = [tempSelasDic hasItemAndBack:@"account"];
                        
                        if ([tempDict1 hasItemAndBack:@"balance"]) {
                            tempInfo.user_balance =[NSString stringWithFormat:@"%@",[tempDict1 hasItemAndBack:@"balance"]];
                        }
                        
                        if ([tempSelasDic hasItemAndBack:@"city"]) {
                            
                            
                            NSDictionary *tempDict2 = [tempSelasDic hasItemAndBack:@"city"];
                            if ([tempDict2 hasItemAndBack:@"name"]) {
                                tempInfo.city_name =[NSString stringWithFormat:@"%@",[tempDict2 hasItemAndBack:@"name"]];
                                
                            }
                        }
                        
                        if ([tempSelasDic hasItemAndBack:@"province"]) {
                            
                            NSDictionary *tempDict2 = [tempSelasDic hasItemAndBack:@"province"];
                            if ([tempDict2 hasItemAndBack:@"name"]) {
                                
                                
                                tempInfo.province_name =[NSString stringWithFormat:@"%@",[tempDict2 hasItemAndBack:@"name"]];
                                
                            }
                        }
                        
                        [self.mySelasArray addObject:tempInfo];
                    }
                }
            }
            
        }else{
        
            NSArray* tempDealers = [tempDic hasItemAndBack:@"dealers"];
            if (tempDealers!=nil) {
                
                NSMutableArray* tempNewArray = [NSMutableArray allocInstance];
                NSMutableArray* tempRentalArray = [NSMutableArray allocInstance];
                NSMutableArray* tempSpecialArray = [NSMutableArray allocInstance];
                
                for (int i=0; i<[tempDealers count]; i++) {
                    NSDictionary* tempDealersDic = [tempDealers objectAtIndex:i];
                    if (tempDealersDic!=nil) {
                        
                        M_DealerItemModel* tempDealerItem = [M_DealerItemModel allocInstance];
                        
                        NSString* tempprivilege = [NSString fromString:[tempDealersDic hasItemAndBack:@"privilege"]];
                        if ([tempprivilege notEmpty]) {
                            NSString* tempkdks = [Unity paddedBinaryString:tempprivilege];
                            if ([tempkdks notEmpty]) {
                                if ([tempkdks length]==3) {
                                    tempDealerItem.myCar_Sales = NO;
                                    tempDealerItem.myCar_Lease = NO;
                                    tempDealerItem.myCar_New = NO;
                                    if ([[tempkdks substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]) {
                                        tempDealerItem.myCar_Sales = YES;
                                    }
                                    if ([[tempkdks substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"]) {
                                        tempDealerItem.myCar_Lease = YES;
                                    }
                                    if ([[tempkdks substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"]) {
                                        tempDealerItem.myCar_New = YES;
                                    }
                                }
                            }
                        }
                        
                        tempDealerItem.dealer_id = [NSString fromString:[tempDealersDic hasItemAndBack:@"id"]];
                        tempDealerItem.dealer_name = [tempDealersDic hasItemAndBack:@"fullname"];
                        tempDealerItem.dealer_sname = [tempDealersDic hasItemAndBack:@"name"];
                        
                        tempDealerItem.province_id = [NSString fromString:[tempDealersDic hasItemAndBack:@"province_id"]];
                        tempDealerItem.city_id = [NSString fromString:[tempDealersDic hasItemAndBack:@"city_id"]];
                        
                        tempDealerItem.dealer_address = [tempDealersDic hasItemAndBack:@"address"];
                        tempDealerItem.dealer_zip = [tempDealersDic hasItemAndBack:@"zip"];
                        tempDealerItem.dealer_tel = [tempDealersDic hasItemAndBack:@"tel"];
                        
                        tempDealerItem.dealer_email = [tempDealersDic hasItemAndBack:@"email"];
                        
                        tempDealerItem.dealer_lng = [NSString fromString:[tempDealersDic hasItemAndBack:@"lng"]];
                        tempDealerItem.dealer_lat = [NSString fromString:[tempDealersDic hasItemAndBack:@"lat"]];
                        
                        tempDealerItem.city_code = [NSString fromString:[tempDealersDic hasItemAndBack:@"code"]];
                        
                        tempDealerItem.dealer_lease_price = [tempDealersDic hasItemAndBack:@"lowest_price"];
                        tempDealerItem.dealer_car_price = [tempDealersDic hasItemAndBack:@"price"];
                        tempDealerItem.price = [tempDealerItem.dealer_car_price floatValue];
                        
                        tempDealerItem.dealer_distance = [tempDealersDic hasItemAndBack:@"distance"];
                        
                        tempDealerItem.dealer_distance = [Unity stringToKmString:tempDealerItem.dealer_lat withLon:tempDealerItem.dealer_lng];
                        tempDealerItem.distance = [tempDealerItem.dealer_distance floatValue];
                        
                        NSArray* tempLeaseArray = [tempDealersDic hasItemAndBack:@"lease"];
                        
                        if (tempLeaseArray!=nil) {
                            for (int k=0; k<[tempLeaseArray count]; k++) {
                                NSDictionary* tempLeaseIDic = [tempLeaseArray objectAtIndex:k];
                                if (tempLeaseIDic!=nil) {
                                    M_CarLeaseItemModel* tempLeaseItem = [M_CarLeaseItemModel allocInstance];
                                    
                                    tempLeaseItem.myLease_Id = [NSString fromString:[tempLeaseIDic hasItemAndBack:@"lease_plan_id"]];
                                    tempLeaseItem.myDealer_Car_id = [NSString fromString:[tempLeaseIDic hasItemAndBack:@"dealer_car_id"]];
                                    
                                    NSDictionary* tempLease2IDic = [tempLeaseIDic hasItemAndBack:@"lease"];
                                    if (tempLease2IDic!=nil) {
                                        tempLeaseItem.myLease_Title = [tempLease2IDic hasItemAndBack:@"title"];
                                        
                                        tempLeaseItem.myLease_Content = [tempLease2IDic hasItemAndBack:@"content"];
                                        
                                        tempLeaseItem.myLease_Panyment = [tempLease2IDic hasItemAndBack:@"downpayment"];
                                        
                                        tempLeaseItem.myLease_Loan = [NSString fromString:[tempLease2IDic hasItemAndBack:@"installment"]];
                                    }
                                    
                                    if (k==0) {
                                        tempLeaseItem.isSelete = YES;
                                    }
                                    
                                    [tempDealerItem.myLeaseArray addObject:tempLeaseItem];
                                }
                            }
                        }
                        
                        
                        NSArray* tempColorArray = [tempDealersDic hasItemAndBack:@"color"];
                        if (tempColorArray!=nil) {
                            for (int j=0; j<[tempColorArray count]; j++) {
                                NSDictionary* tempColorItemDic = [tempColorArray objectAtIndex:j];
                                if (tempColorItemDic!=nil) {
                                    M_CarColorItemModel* tempColorItem = [M_CarColorItemModel allocInstance];
                                    
                                    tempColorItem.myColor_Id = [NSString fromString:[tempColorItemDic hasItemAndBack:@"id"]];
                                    tempColorItem.myCar_Color_Id = [NSString fromString:[tempColorItemDic hasItemAndBack:@"car_color_id"]];
                                    tempColorItem.myCar_Color_Name = [tempColorItemDic hasItemAndBack:@"name"];
                                    tempColorItem.myCar_Color_Img = [tempColorItemDic hasItemAndBack:@"value"];
                                    tempColorItem.myCar_Count = [NSString fromString:[tempColorItemDic hasItemAndBack:@"count"]];
                                    
                                    [tempDealerItem.myColorArray addObject:tempColorItem];
                                }
                            }
                        }
                        
                        if (tempDealerItem.myCar_Sales) {
                            
                            M_DealerItemModel* tempsales = [M_DealerItemModel allocInstance];
                            [tempsales toData:tempDealerItem];
                            [tempSpecialArray addObject:tempsales];
                        }
                        if (tempDealerItem.myCar_Lease) {
                            
                            M_DealerItemModel* tempsales = [M_DealerItemModel allocInstance];
                            [tempsales toData:tempDealerItem];
                            [tempRentalArray addObject:tempsales];
                            
                            if ([tempRentalArray count]==1) {
                                tempsales.selete = YES;
                            }
                        }
                        if (tempDealerItem.myCar_New) {
                            M_DealerItemModel* tempsales = [M_DealerItemModel allocInstance];
                            [tempsales toData:tempDealerItem];
                            [tempNewArray addObject:tempsales];
                        }
                    }
                }
                
                [self.myDealersArray addObject:tempSpecialArray];
                [self.myDealersArray addObject:tempRentalArray];
                [self.myDealersArray addObject:tempNewArray];
            }
        }
    }
}

@end

@implementation M_CarListModel

DEF_FACTORY(M_CarListModel);

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
                    
                    M_CarItemModel* tempItem  = [M_CarItemModel allocInstance];
                    
                    NSString* tempprivilege = [NSString fromString:[tempItemDic hasItemAndBack:@"privilege"]];
                    if ([tempprivilege notEmpty]) {
                        NSString* tempkdks = [Unity paddedBinaryString:tempprivilege];
                        if ([tempkdks notEmpty]) {
                            if ([tempkdks length]==3) {
                                tempItem.myCar_Sales = NO;
                                tempItem.myCar_Lease = NO;
                                tempItem.myCar_New = NO;
                                if ([[tempkdks substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]) {
                                    tempItem.myCar_Sales = YES;
                                }
                                if ([[tempkdks substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"]) {
                                    tempItem.myCar_Lease = YES;
                                }
                                if ([[tempkdks substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"]) {
                                    tempItem.myCar_New = YES;
                                }
                            }
                        }
                    }
                    
                    tempItem.readID = [NSString fromString:[tempItemDic hasItemAndBack:@"id"]];
                    
                    tempItem.myUpDated_at = [NSString fromString:[tempItemDic hasItemAndBack:@"updated_at"]];
                   
                    tempItem.myCreated_at = [NSString fromString:[tempItemDic hasItemAndBack:@"created_at"]];
                    
                    tempItem.myCar_Id = [NSString fromString:[tempItemDic hasItemAndBack:@"cid"]];
                    tempItem.myBigBrand_Id = [NSString fromString:[tempItemDic hasItemAndBack:@"bbid"]];
                    tempItem.myBrand_Id = [NSString fromString:[tempItemDic hasItemAndBack:@"bid"]];
                    tempItem.mySubbrand_Id = [NSString fromString:[tempItemDic hasItemAndBack:@"sid"]];
                    tempItem.myLease_Price = [NSString fromString:[tempItemDic hasItemAndBack:@"price"]];
                    tempItem.has_Favorite = [NSString fromString:[tempItemDic hasItemAndBack:@"has_favorite"]];
                    NSString* tempLease = [tempItemDic hasItemAndBack:@"lease"];
                    if ([tempLease notEmpty]) {
                        NSArray* tempLeaseArray = [tempLease componentsSeparatedByString:@","];
                        [tempItem.myLeaseArray addObjectsFromArray:tempLeaseArray];
                    }
                    tempItem.myDealer_Car_Price = [NSString fromString:[tempItemDic hasItemAndBack:@"min_price"]];
                    
                    NSDictionary* tempCarDic = [tempItemDic hasItemAndBack:@"car"];
                    if (tempCarDic!=nil) {
                        tempItem.myCar_Name = [tempCarDic hasItemAndBack:@"name"];
                        tempItem.myCar_Year = [NSString fromString:[tempCarDic hasItemAndBack:@"year"]];
                        tempItem.myCar_Img = [tempCarDic hasItemAndBack:@"img"];
                        tempItem.myCar_Info = [tempCarDic hasItemAndBack:@"info"];
                        tempItem.myCar_Policy = [tempCarDic hasItemAndBack:@"policy"];
                        tempItem.myCar_Price = [NSString fromString:[tempCarDic hasItemAndBack:@"price"]];
                    }
                    
                    NSDictionary* tempSeries = [tempItemDic hasItemAndBack:@"series"];
                    if (tempSeries != nil) {
                        tempItem.mySubbrand_Name = [tempSeries hasItemAndBack:@"name"];
                    }
                    
                    NSDictionary* tempBrand = [tempItemDic hasItemAndBack:@"brand"];
                    if (tempBrand != nil) {
                        tempItem.myBrand_Name = [tempBrand hasItemAndBack:@"name"];
                    }
                    
                    NSDictionary* tempBigbrand = [tempItemDic hasItemAndBack:@"bigbrand"];
                    if (tempBigbrand != nil) {
                        tempItem.myBigBrand_Name = [tempBigbrand hasItemAndBack:@"name"];
                    }
                    
                    [self.myItemArray addObject:tempItem];
                }
            }
        }
        
    }
}

@end
