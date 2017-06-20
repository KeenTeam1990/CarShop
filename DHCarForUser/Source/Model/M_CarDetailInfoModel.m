
//
//  M_CarDetailInfoModel.m
//  DHCarForSales
//
//  Created by leiyu on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarDetailInfoModel.h"

@implementation M_CarDetailInfoModel
DEF_FACTORY(M_CarDetailInfoModel);
DEF_MODEL(count);
DEF_MODEL(item);
-(id)init
{
    if (self= [super init]) {
          self.item=[NSMutableArray allocInstance];
    }
    return self;
}
-(void)parseDataDic:(NSDictionary *)str
{
    if (str!=nil) {
        NSDictionary *carDic=[str hasItemAndBack:@"car"];
        self.count=[carDic hasItemAndBack:@"count"];
        NSArray *itemDicArr=[carDic hasItemAndBack:@"item"];
        for (NSDictionary *carItemDic in itemDicArr) {
            M_carItemDetailInfoModel *itemModel=[M_carItemDetailInfoModel allocInstance];
            [itemModel parseDataDic:carItemDic];
            [self.item addObject:itemModel];
        }
        
    }
}
@end

@implementation M_carItemDetailInfoModel
DEF_FACTORY(M_carItemDetailInfoModel);
DEF_MODEL( car_id);
DEF_MODEL( bigbrand_id);
DEF_MODEL( bigbrand_name);
DEF_MODEL( brand_id);
DEF_MODEL( brand_name);
DEF_MODEL( subbrand_id);
DEF_MODEL( subbrand_name);
DEF_MODEL( car_name);
DEF_MODEL( car_code);
DEF_MODEL( car_year);
DEF_MODEL( car_img);
DEF_MODEL( car_info);
DEF_MODEL( car_drive);
DEF_MODEL( car_amt);
DEF_MODEL( car_out);
DEF_MODEL( car_oil);
DEF_MODEL( car_price);
DEF_MODEL( dealer_car_id);
DEF_MODEL( car_deposit);
DEF_MODEL( car_type);
DEF_MODEL( car_type_name);
DEF_MODEL( dealer_car_price);
DEF_MODEL( car_lease);
DEF_MODEL( car_sales);
DEF_MODEL(car_color);
DEF_MODEL( color);


DEF_MODEL( lease_price);
DEF_MODEL( lease);
-(id)init
{
    self = [super init];
    if (self) {
        self.color = [NSMutableArray allocInstance];
        self.lease=[NSMutableArray allocInstance];
        self.parameter=[NSMutableArray allocInstance];
        self.loan=[NSMutableArray allocInstance];
        self.policy=[NSMutableArray allocInstance];
    }
    return self;
}
-(void)parseDataDic:(NSDictionary *)str
{

        NSDictionary *carDic=str ;
        if (carDic !=nil) {
            self.car_id=[NSString fromString:[carDic hasItemAndBack:@"car_id"]];
            self.bigbrand_id=[NSString fromString:[carDic hasItemAndBack:@"bigbrand_id"]];
            self.bigbrand_name=[NSString fromString:[carDic hasItemAndBack:@"bigbrand_name"]];
            self.brand_id=[NSString fromString:[carDic hasItemAndBack:@"brand_id"]];
            self.brand_name=[NSString fromString:[carDic hasItemAndBack:@"brand_name"]];
            self.subbrand_id=[NSString fromString:[carDic hasItemAndBack:@"subbrand_id"]];
            self.subbrand_name=[NSString fromString:[carDic hasItemAndBack:@"subbrand_name"]];
            self.car_name=[NSString fromString:[carDic hasItemAndBack:@"car_name"]];
            self.car_code=[NSString fromString:[carDic hasItemAndBack:@"car_code"]];
            self.car_year=[NSString fromString:[carDic hasItemAndBack:@"car_year"]];
            self.car_img=[NSString fromString:[carDic hasItemAndBack:@"car_img"]];
            self.car_info=[NSString fromString:[carDic hasItemAndBack:@"car_info"]];
            self.car_drive=[NSString fromString:[carDic hasItemAndBack:@"car_drive"]];
            self.car_amt=[NSString fromString:[carDic hasItemAndBack:@"car_amt"]];
            self.car_out=[NSString fromString:[carDic hasItemAndBack:@"car_out"]];
            self.car_oil=[NSString fromString:[carDic hasItemAndBack:@"car_oil"]];
            self.car_price=[NSString fromString:[carDic hasItemAndBack:@"car_price"]];
            self.dealer_car_id=[NSString fromString:[carDic hasItemAndBack:@"dealer_car_id"]];
            self.car_deposit=[NSString fromString:[carDic hasItemAndBack:@"car_deposit"]];
            self.car_type=[NSString fromString:[carDic hasItemAndBack:@"car_type"]];
            self.car_type_name=[NSString fromString:[carDic hasItemAndBack:@"car_type_name"]];
            self.dealer_car_price=[NSString fromString:[carDic hasItemAndBack:@"dealer_car_price"]];
            self.car_lease=[NSString fromString:[carDic hasItemAndBack:@"car_lease"]];
            self.car_sales=[NSString fromString:[carDic hasItemAndBack:@"car_sales"]];
            self.lease_price=[NSString fromString:[carDic hasItemAndBack:@"lease_price"]];
           
//            NSDictionary *colorDicArr=[carDic hasItemAndBack:@"color"];
            M_CarColorArrModel *colorModel=[M_CarColorArrModel allocInstance];
//            [colorModel parseDataDic:colorDicArr];
//            self.color=colorModel.color;
            self.car_color=[NSString stringWithFormat:@"%@",[str hasItemAndBack:@"car_color"]];
            
            NSDictionary *leaseArrDic=[carDic hasItemAndBack:@"lease"];
            M_CarLeaseArrModel *leaseModel=[M_CarLeaseArrModel allocInstance];
            [leaseModel parseDataDic:leaseArrDic];
            self.lease=leaseModel.lease;
            
            NSArray *parameterDicArr=[carDic hasItemAndBack:@"parameter" ];
            for (NSDictionary *parameterDic in parameterDicArr) {
                M_CarParameterModel *parameterModel=[[M_CarParameterModel alloc]init];
                [parameterModel parseDataDic:parameterDic];
                [self.parameter addObject:parameterModel];
            }
            
            NSArray *loanDicArr=[carDic hasItemAndBack:@"loan"];
            for (NSDictionary *loanDic in loanDicArr) {
                M_CarLoanModel *loanModel=[M_CarLoanModel allocInstance];
                [loanModel parseDataDic:loanDic];
                [self.loan addObject:loanModel];
            }
            
            NSArray *policyDicArr=[carDic hasItemAndBack:@"policy"];
            for (NSDictionary *policyDic in policyDicArr) {
                M_CarPolicyModel *carPoilcyModel=[M_CarPolicyModel allocInstance];
                [carPoilcyModel parseDataDic:policyDic];
                [self.policy addObject:carPoilcyModel];
            }
            

        }
    }


@end


//**********************************carParameterModel
@implementation M_LLCarParameterItemModel
DEF_FACTORY(M_LLCarParameterItemModel);
DEF_MODEL(item_id);
DEF_MODEL(item_name);
DEF_MODEL(item_value);
-(void)parseDataDic:(NSDictionary *)str
{
    if (str!=nil) {
        self.item_id=[str hasItemAndBack:@"item_id"];
        self.item_name=[str hasItemAndBack:@"item_name"];
        self.item_value=[str hasItemAndBack:@"item_value"];
    }
}
@end

@implementation M_CarParameterModel
DEF_FACTORY(M_CarParameterModel);
DEF_MODEL( parameter_id);
DEF_MODEL( parameter_name);
DEF_MODEL(parametaer_item);
-(id)init
{
    if (self=[super init]) {
        self.parametaer_item=[NSMutableArray allocInstance];
    }
    return self;
}
-(void)parseDataDic:(NSDictionary *)str
{
    if (str!=nil) {
        self.parameter_id=[str hasItemAndBack:@"parameter_id"];
         self.parameter_name=[str hasItemAndBack:@"parameter_name"];
        NSArray *parameter_itemArrDic=[str hasItemAndBack:@"parameter_item"];
        for (NSDictionary *parameter_itemDic in parameter_itemArrDic) {
            M_LLCarParameterItemModel *itemModel=[M_LLCarParameterItemModel allocInstance];
            [itemModel parseDataDic:parameter_itemDic];
            [self.parametaer_item  addObject:itemModel];
        }
        
    }
}
@end

//***********************金融贷款
@implementation M_CarLoanModel
DEF_FACTORY(M_CarLoanModel);
DEF_MODEL( loan_id);
DEF_MODEL( loan_title);
DEF_MODEL( loan_wap);
-(void)parseDataDic:(NSDictionary *)str
{
    if (str!=nil) {
        self.loan_id=[str hasItemAndBack:@"loan_id"];
        self.loan_title=[str hasItemAndBack:@"loan_title"];
        self.loan_wap=[str hasItemAndBack:@"loan_wap"];
    }
}
@end

//***************************售后政策
@implementation M_CarPolicyModel
DEF_FACTORY(M_CarPolicyModel);
DEF_MODEL( policy_id);
DEF_MODEL(policy_title);
DEF_MODEL(policy_wap);
-(void)parseDataDic:(NSDictionary *)str
{
    if (str!=nil) {
        self.policy_id=[str hasItemAndBack:@"policy_id"];
        self.policy_title=[str hasItemAndBack:@"policy_title"];
        self.policy_wap=[str hasItemAndBack:@"policy_wap"];
    }
}
@end






@implementation M_CarColorArrModel
DEF_FACTORY(M_CarColorArrModel);
DEF_MODEL(color);
-(id)init
{
    if (self=[super init]) {
        self.color=[NSMutableArray allocInstance];
    }
    return self;
}
-(void)parseDataDic:(NSDictionary *)str
{
    if (str!=nil) {
        NSArray *arr=[str hasItemAndBack:@"color"];
        for (NSDictionary *dic in arr) {
            M_CarColorModel *model=[M_CarColorModel allocInstance];
            [model parseDataDic:dic];
            [self.color addObject:model];
        }
    }
}


@end

@implementation M_CarColorModel
DEF_FACTORY(M_CarColorModel);
DEF_MODEL(car_color_id);
DEF_MODEL(car_color_img);
DEF_MODEL(car_color_name);
-(void)parseDataDic:(NSDictionary *)str
{
    if (str!=nil) {
        self.car_color_id=[NSString fromString:[str hasItemAndBack:@"car_color_id"]];
        self.car_color_img=[NSString fromString:[str hasItemAndBack:@"car_color_img"]];
        self.car_color_name=[NSString fromString:[str hasItemAndBack:@"car_color_name"]];
        
    }
}


@end

@implementation M_CarLeaseArrModel
DEF_FACTORY(M_CarLeaseArrModel);
DEF_MODEL(lease);
-(id)init
{
    if (self=[super init]) {
        self.lease=[NSMutableArray allocInstance];
    }
    return self;
}
-(void)parseDataDic:(NSDictionary *)str
{
    if (str!=nil) {
        NSArray *arr=[str hasItemAndBack:@"lease"];
        for (NSDictionary *dic in arr) {
            M_CarLeaseModel *model=[M_CarLeaseModel allocInstance];
            [model parseDataDic:dic];
            [self.lease addObject:model];
        }
    }
}
@end

@implementation M_CarLeaseModel
DEF_FACTORY(M_CarLeaseModel);
DEF_MODEL(lease_id);
DEF_MODEL(lease_loan);
DEF_MODEL(lease_panyment);
-(void)parseDataDic:(NSDictionary *)str
{
    if (str!=nil) {
        self.lease_id=[NSString fromString:[str hasItemAndBack:@"lease_id"]];
         self.lease_loan=[NSString fromString:[str hasItemAndBack:@"lease_loan"]];
         self.lease_panyment=[NSString fromString:[str hasItemAndBack:@"lease_panyment"]];
        
    }
}

@end