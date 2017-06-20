//
//  M_DealerItemModel.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_DealerItemModel.h"


@implementation M_DealerItemModel

DEF_FACTORY(M_DealerItemModel);

DEF_MODEL(dealer_address);
DEF_MODEL(dealer_zip);
DEF_MODEL(dealer_tel);
DEF_MODEL(dealer_star);
DEF_MODEL(dealer_sname);
DEF_MODEL(dealer_name);
DEF_MODEL(dealer_lng);
DEF_MODEL(dealer_lat);
DEF_MODEL(dealer_id);
DEF_MODEL(dealer_email);
DEF_MODEL(dealer_distance);
DEF_MODEL(dealer_code);
DEF_MODEL(dealer_car_price);
DEF_MODEL(dealer_car_id);
DEF_MODEL(province_name);
DEF_MODEL(city_name);
DEF_MODEL(city_code);
DEF_MODEL(county_name);
DEF_MODEL(myIndexPath);

DEF_MODEL(selete);

DEF_MODEL(myLeaseArray);
DEF_MODEL(myCar_Lease);
DEF_MODEL(myCar_New);
DEF_MODEL(myCar_Sales);
DEF_MODEL(myColorArray);

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.myLeaseArray = [NSMutableArray allocInstance];
        self.myColorArray = [NSMutableArray allocInstance];
    }
    
    return self;
}

-(void)toData:(M_DealerItemModel*)data
{
    self.dealer_zip = data.dealer_zip;
    self.dealer_tel = data.dealer_tel;
    self.dealer_star = data.dealer_star;
    self.dealer_sname = data.dealer_sname;
    self.dealer_name = data.dealer_name;
    self.dealer_lng = data.dealer_lng;
    self.dealer_lease_price = data.dealer_lease_price;
    self.dealer_lat = data.dealer_lat;
    self.dealer_id = data.dealer_id;
    
    self.dealer_email = data.dealer_email;
    
    self.dealer_distance = data.dealer_distance;
    self.dealer_distance =[Unity stringToKmString:self.dealer_lat withLon:self.dealer_lng];
    self.dealer_code = data.dealer_code;
    self.dealer_car_price = data.dealer_car_price;
    self.dealer_car_id = data.dealer_car_id;
    self.dealer_address = data.dealer_address;
    self.myCar_Lease = data.myCar_Lease;
    self.myCar_New = data.myCar_New;
    self.myCar_Sales = data.myCar_Sales;
    self.myIndexPath = data.myIndexPath;
    [self.myPageModel toData:self.myPageModel];
    self.selete = data.selete;
    self.distance =data.distance;
    self.price = data.price;
    [self.myLeaseArray removeAllObjects];
    [self.myLeaseArray addObjectsFromArray:data.myLeaseArray];
    [self.myColorArray removeAllObjects];
    [self.myColorArray addObjectsFromArray:data.myColorArray];
}

@end
