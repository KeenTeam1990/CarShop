//
//  TTReqProtocol.m
//  TickTock
//
//  Created by 卢迎志 on 14-11-28.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import "TTReqProtocol.h"

@implementation TTReqProtocol

//添加图片到form
+(void)addImageToFormArray:(NSMutableArray*)array
                 withImage:(NSString*)imagepath
                   withKey:(NSString*)key
{
    if ([imagepath notEmpty] && [key notEmpty]) {
        DLHttpFormModel* tempModel = [DLHttpFormModel allocInstance];
        tempModel.filepath = imagepath;
        tempModel.filekey = key;
        [array addObject:tempModel];
    }
}

#pragma mark  -  用户接口
//获取公共参数
+(void)GetPublicData:(NSMutableDictionary *)dic
{
    [dic setObject:@"ios" forKey:@"source"];
    
    [dic setObject:[DLSystemInfo deviceUUID] forKey:@"udid"];
    [dic setObject:APPDELEGATE.viewController.myCityModel.myCity_Id forKey:@"city_id"];
    
    if ([APPDELEGATE.viewController.myLat notEmpty]) {
        [dic setObject:APPDELEGATE.viewController.myLat forKey:@"lat"];
    }else{
        [dic setObject:@"0.0" forKey:@"lat"];
    }
    
    if ([APPDELEGATE.viewController.myLng notEmpty]) {
        [dic setObject:APPDELEGATE.viewController.myLng forKey:@"lng"];
    }else{
        [dic setObject:@"0.0" forKey:@"lng"];
    }
    
    NSString *userID = [DLAppData sharedInstance].myUserKey;
    if ([userID notEmpty]) {
        [dic setObject:userID forKey:@"uid"];
    }
    
}

+(void)haneleToken:(NSMutableDictionary*)dic
{
    NSString* tempStr = @"";
   
    NSArray *keys = [dic allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    for (int i=0; i<[dic.allKeys count]; i++) {
        
        NSString* tempkey = [sortedArray objectAtIndex:i];
        NSString* tempValue = [dic objectForKey:tempkey];
        
        if ([tempkey notEmpty] && [tempValue notEmpty]) {
            if (tempStr.length == 0) {
                tempStr = [NSString stringWithFormat:@"%@=%@",tempkey,tempValue];
            }else{
                tempStr = [NSString stringWithFormat:@"%@%@=%@",tempStr,tempkey,tempValue];
            }
        }
    }
    
    tempStr = [NSString stringWithFormat:@"%@%@",tempStr,@"3u5xs2h$3q3&@b"];
    
    tempStr = [tempStr toMD5_Small];
    
    tempStr = [Unity hexStringFromString:tempStr];
    
    tempStr = [tempStr toSHA1];
    //测试token
//    tempStr = @"eb8dd0098ddf36320601bb8ff856ec439d13449e";
    [dic setObject:tempStr forKey:@"token"];
}

//获取普通用户
+(NSDictionary*)C_GetUser_GetSetUid:(NSString *)uid
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    
    [self GetPublicData:tempDic];
    
    if ([uid notEmpty])
    {
        [tempDic setObject:uid  forKey:@"uid"];
    }
   
    [self haneleToken:tempDic];
    
    return tempDic;
}

//登录
+(NSDictionary *)C_PostUserLoginPhone:(NSString *)phone withCode:(NSString *)code
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([phone notEmpty])
    {
        [tempDic setObject:phone  forKey:@"phone"];
    }
    if ([code notEmpty])
    {
        [tempDic setObject:code  forKey:@"code"];
    }
    [self haneleToken:tempDic];
    return tempDic;

}
//用户注册
+(NSDictionary *)C_PostUserRegister:(NSString *)phone withPassword:(NSString *)password withCode:(NSString *)code
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([phone notEmpty])
    {
        [tempDic setObject:phone  forKey:@"phone"];
    }
    if ([code notEmpty])
    {
        [tempDic setObject:code  forKey:@"code"];
    }
    if ([password notEmpty]) {
        [tempDic setObject:password forKey:@"password"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}

//用户设置密码
+(NSDictionary *)C_PostUserSetPassword:(NSString *)password andWithUserId:(NSString *)uid
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([password notEmpty])
    {
        [tempDic setObject:password  forKey:@"password"];
    }
    if ([uid notEmpty])
    {
        [tempDic setObject:uid  forKey:@"uid"];
    }
   
    [self haneleToken:tempDic];
   
    return tempDic;
}
//用户修改密码
+(NSDictionary *)C_PostUserModifyPassWord:(NSString *)uid andWithOldPassword:(NSString *)oldPassword andWithNewPassword:(NSString *)newPassword
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([uid notEmpty])
    {
        [tempDic setObject:uid  forKey:@"uid"];
    }
    if ([oldPassword notEmpty])
    {
        [tempDic setObject:oldPassword forKey:@"password"];
    }
    if ([newPassword notEmpty])
    {
        [tempDic setObject:newPassword forKey:@"new_password"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}

//获取验证接口
+(NSDictionary *)C_GetCode_SetPhone:(NSString *)phone withType:(NSString *)type
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([phone notEmpty])
    {
        [tempDic setObject:phone  forKey:@"phone"];
    }
    if ([type notEmpty])
    {
        [tempDic setObject:type forKey:@"type"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}
//密码登陆方式
+(NSDictionary *)C_PostUserLoginPasswordPhone:(NSString *)phone withPassword:(NSString *)password
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([phone notEmpty])
    {
        [tempDic setObject:phone  forKey:@"phone"];
    }
    if ([password notEmpty])
    {
        [tempDic setObject:password forKey:@"password"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}
//获取所有城市列表
+(void )C_GetCity_all
{
    
}

//获取首页
+(NSDictionary *)C_Getqrecommend_App_IndexCity_id:(NSString *)city_id
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([city_id notEmpty])
    {
        [tempDic setObject:city_id  forKey:@"city_id"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}

//获取banner首页信息
+(NSDictionary *)C_Getqrecommend_BannerCity_id:(NSString *)city_id

{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([city_id notEmpty])
    {
        [tempDic setObject:city_id  forKey:@"city_id"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}
//获取城市列表
+(NSDictionary *)C_GetCity_ListProvince_id:(NSString *)ID withStatus:(NSString *)status
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([ID notEmpty]) {
        [tempDic setObject:ID forKey:@"province_id"];
    }
    if ([status notEmpty]) {
        [tempDic setObject:status forKey:@"status"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}
//城市定位
+(NSDictionary *)C_GetCity_locationLng:(NSString *)lng withLat:(NSString *)lat
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([lng notEmpty]) {
        [tempDic setObject:lng forKey:@"lng"];
    }
    if ([lat notEmpty]) {
        [tempDic setObject:lat forKey:@"lat"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}


//用户信息更新
+(NSDictionary *)C_PostUser_UpdateSetUid:(NSString *)uid
                                withSex:(NSString *)sex
                               withNick:(NSString *)nick
                              withEmail:(NSString *)email
                           withBirthday:(NSString *)birthday
                             withAvatar:(NSString *)avatar
                            withCity_id:(NSString *)city_id
                                 withQQ:(NSString *)qq
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    
    [self GetPublicData:tempDic];
    
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    if ([sex notEmpty]) {
        [tempDic setObject:sex forKey:@"sex"];
    }
    if ([nick notEmpty]) {
        [tempDic setObject:nick forKey:@"nick"];
    }
    if ([email notEmpty]) {
        [tempDic setObject:email forKey:@"email"];
    }
    
    if ([birthday notEmpty]) {
        [tempDic setObject:birthday forKey:@"birthday"];
    }
    if ([avatar notEmpty]) {
        [tempDic setObject:avatar forKey:@"avatar"];
    }
    if ([city_id notEmpty]) {
        [tempDic setObject:city_id forKey:@"city_id"];
    }
    if ([qq notEmpty]) {
        [tempDic setObject:qq forKey:@"qq"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}

//获取经销商信息
+(NSDictionary *)C_Getdealer_Dealer_id:(NSString *)dealer_id
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([dealer_id notEmpty]) {
        [tempDic setObject:dealer_id forKey:@"dealer_id"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}

//获取经销商列表信息
+(NSDictionary *)C_GetdealerListSetCity_id:(NSString *)city_id
                                withCar_id:(NSString *)car_id
                                  withType:(NSString *)type
                           withBigbrand_id:(NSString *)bigbrand_id
                              withBrand_id:(NSString *)brand_id
                             withSeries_id:(NSString *)series_id
                                withLimitd:(NSString *)limit
                                  withPage:(NSString *)page
                                   withMax:(NSString *)max
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([city_id notEmpty]) {
        [tempDic setObject:city_id forKey:@"city_id"];
    }
    if ([car_id notEmpty]) {
        [tempDic setObject:car_id forKey:@"car_id"];
    }
    if ([type notEmpty]) {
        [tempDic setObject:type forKey:@"type"];
    }
    if ([bigbrand_id notEmpty]) {
        [tempDic setObject:bigbrand_id forKey:@"bigbrand_id"];
    }
    
    if ([brand_id notEmpty]) {
        [tempDic setObject:brand_id forKey:@"brand_id"];
    }
    if ([series_id notEmpty]) {
        [tempDic setObject:series_id forKey:@"series_id"];
    }
    
    if ([limit notEmpty]) {
        [tempDic setObject:limit forKey:@"limit"];
    }
    if ([page notEmpty]) {
        [tempDic setObject:page forKey:@"page"];
    }
    if ([max notEmpty]) {
        [tempDic setObject:max forKey:@"max"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}

//获取经销商车型详情
+(NSDictionary *)C_Getcar_dealerSetCity_id:(NSString *)city_id
                                withCar_id:(NSString *)car_id
                                    withID:(NSString *)ID
                             withDealer_id:(NSString *)dealer_id
                                   withLng:(NSString *)lng
                                   withUid:(NSString *)uid
                                   withLat:(NSString *)lat

{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([city_id notEmpty]) {
        [tempDic setObject:city_id forKey:@"city_id"];
    }
    if ([car_id notEmpty]) {
        [tempDic setObject:car_id forKey:@"car_id"];
    }
    if ([ID notEmpty]) {
        [tempDic setObject:ID forKey:@"id"];
    }
    if ([dealer_id notEmpty]) {
        [tempDic setObject:dealer_id forKey:@"dealer_id"];
    }
    
    if ([lng notEmpty]) {
        [tempDic setObject:lng forKey:@"lng"];
    }
    if ([lat notEmpty]) {
        [tempDic setObject:lat forKey:@"lat"];
    }
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}

//获取经销商车型列表
+(NSDictionary *)C_Getcar_dealerlistSetCity_id:(NSString *)city_id
                                 withDealer_id:(NSString *)dealer_id
                                       withLng:(NSString *)lng
                                       withLat:(NSString *)lat
                                      withType:(NSString *)type
                                    withLimitd:(NSString *)limit
                                      withPage:(NSString *)page
                                       withMax:(NSString *)max
                                  withcar_Type:(NSString *)car_type
                               withPrice_range:(NSString *)price_range
                               withInstallment:(NSString *)installment
                     withcar_Downpayment_range:(NSString *)downpayment_range
                               withBigbrand_id:(NSString *)bigbrand_id
                                  withBrand_id:(NSString *)brand_id
                                 withSeries_id:(NSString *)series_id
{
     NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([city_id notEmpty]) {
        [tempDic setObject:city_id forKey:@"city_id"];
    }
    if ([dealer_id notEmpty]) {
        [tempDic setObject:dealer_id forKey:@"dealer_id"];
    }
    if ([type notEmpty]) {
        [tempDic setObject:type forKey:@"type"];
    }
    if ([lng notEmpty]) {
        [tempDic setObject:lng forKey:@"lng"];
    }
    
    if ([lat notEmpty]) {
        [tempDic setObject:lat forKey:@"lat"];
    }
 
    if ([limit notEmpty]) {
        [tempDic setObject:limit forKey:@"limit"];
    }
    if ([page notEmpty]) {
        [tempDic setObject:page forKey:@"page"];
    }
    if ([max notEmpty]) {
        [tempDic setObject:max forKey:@"max"];
    }
    
    if ([car_type notEmpty]) {
        [tempDic setObject:car_type forKey:@"car_type"];
    }
    if ([price_range notEmpty]) {
        [tempDic setObject:price_range forKey:@"price_range"];
    }
    
    if ([installment notEmpty]) {
        [tempDic setObject:installment forKey:@"installment"];
    }
    
    if ([downpayment_range notEmpty]) {
        [tempDic setObject:downpayment_range forKey:@"downpayment_range"];
    }
    if ([bigbrand_id notEmpty]) {
        [tempDic setObject:bigbrand_id forKey:@"bigbrand_id"];
    }
    if ([brand_id notEmpty]) {
        [tempDic setObject:brand_id forKey:@"brand_id"];
    }
    if ([series_id notEmpty]) {
        [tempDic setObject:series_id forKey:@"series_id"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}

//获取订单列表
+(NSDictionary *)C_GetOrderMylistSetUid:(NSString *)uid
                               withStep:(NSString *)step
                             withLimitd:(NSString *)limit
                               withPage:(NSString *)page
                                withMax:(NSString *)max
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    if ([step notEmpty]) {
        [tempDic setObject:step forKey:@"step"];
    }
    if ([limit notEmpty]) {
        [tempDic setObject:limit forKey:@"limit"];
    }
    if ([page notEmpty]) {
        [tempDic setObject:page forKey:@"page"];
    }
    if ([max notEmpty]) {
        [tempDic setObject:max forKey:@"max"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}

//获取订单详情
+(NSDictionary *)C_GetOrderMylistSetID:(NSString *)ID
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([ID notEmpty]) {
        [tempDic setObject:ID forKey:@"id"];
    }
    [self haneleToken:tempDic];
    
    return tempDic;
}

//配置项数据获取
+(NSDictionary *)C_GetConfig_GetType:(NSString *)type
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([type notEmpty]) {
        [tempDic setObject:type forKey:@"type"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}


//上传订单完成凭证
+(NSDictionary *)C_PostOrder_Upload_CertificateSetUid:(NSString *)uid
                                         withOrder_id:(NSString *)order_id withImages:(NSString *)images
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    if ([order_id notEmpty]) {
        [tempDic setObject:order_id forKey:@"order_id"];
    }
    if ([images notEmpty]) {
        [tempDic setObject:images forKey:@"images"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}

//收藏列表
+(NSDictionary *)C_GetFavorite_ListSetUid:(NSString *)uid withLimit:(NSString *)limit withPage:(NSString *)page withMax:(NSString *)max
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    
    [TTReqProtocol GetPublicData:tempDic];
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    if ([limit notEmpty]) {
        [tempDic setObject:limit forKey:@"limit"];
    }
    if ([page notEmpty]) {
        [tempDic setObject:page forKey:@"page"];
    }
    if ([max notEmpty]) {
        [tempDic setObject:max forKey:@"max"];
    }
    [self haneleToken:tempDic];
    return tempDic;

}

//收藏
+(NSDictionary *)C_PostFavorite_AddSetUid:(NSString *)uid withCar_id:(NSString *)car_id withCity_id:(NSString *)city_id
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    
    [TTReqProtocol GetPublicData:tempDic];
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    if ([car_id notEmpty]) {
        [tempDic setObject:car_id forKey:@"car_id"];
    }
    if ([city_id notEmpty]) {
        [tempDic setObject:city_id forKey:@"city_id"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}


//取消收藏
+(NSDictionary *)C_PostFavorite_DelSetID:(NSString *)ID withUid:(NSString *)uid withCar_id:(NSString *)car_id withCity_id:(NSString *)city_id
{
    
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([ID notEmpty]) {
        [tempDic setObject:ID forKey:@"id"];
    }
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    if ([car_id notEmpty]) {
        [tempDic setObject:car_id forKey:@"car_id"];
    }
    if ([city_id notEmpty]) {
        [tempDic setObject:city_id forKey:@"city_id"];
    }
    [self haneleToken:tempDic];
    return tempDic;

}

//浏览过的记录列表

+(NSDictionary *)C_GetView_ListSetUid:(NSString *) uid
                            withLimit:(NSString *)limit
                             withPage:(NSString *)page
                              withMax:(NSString *)max
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    if ([limit notEmpty]) {
        [tempDic setObject:limit forKey:@"limit"];
    }
    if ([page notEmpty]) {
        [tempDic setObject:page forKey:@"page"];
    }
    if ([max notEmpty]) {
        [tempDic setObject:max forKey:@"max"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}

//删除浏览记录

+(NSDictionary *)C_PostView_ListDelSetID:(NSString *)ID
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([ID notEmpty]) {
        [tempDic setObject:ID forKey:@"id"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}

//获取车系列表
+(NSDictionary *)C_GetSeries_ListSetBigbrand_id:(NSString *)bigbrand_id withStatus:(NSString *)status
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([bigbrand_id notEmpty]) {
        [tempDic setObject:bigbrand_id forKey:@"bigbrand_id"];
    }
    if ([status notEmpty]) {
        [tempDic setObject:status forKey:@"status"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}


//询价单列表
+(NSDictionary *)C_GetInquiry_ListSetUid:(NSString *) uid withLimit:(NSString *)limit withPage:(NSString *)page withMax:(NSString *)max
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    if ([limit notEmpty]) {
        [tempDic setObject:limit forKey:@"limit"];
    }
    if ([page notEmpty]) {
        [tempDic setObject:page forKey:@"page"];
    }
    if ([max notEmpty]) {
        [tempDic setObject:max forKey:@"max"];
    }
    [self haneleToken:tempDic];
    return tempDic;

}


//获取消息列表
+(NSDictionary *)C_GetIm_ListSetUid:(NSString *) uid withTarget_uid:(NSString *)target_uid withInquiry_quoted_id:(NSString *)inquiry_quoted_id withLimit:(NSString *)limit withMin:(NSString *)min withMax:(NSString *)max
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    if ([target_uid notEmpty]) {
        [tempDic setObject:target_uid forKey:@"target_uid"];
    }
    if ([inquiry_quoted_id notEmpty]) {
        [tempDic setObject:inquiry_quoted_id forKey:@"inquiry_quoted_id"];
    }
    if ([limit notEmpty]) {
        [tempDic setObject:limit forKey:@"limit"];
    }
    if ([min notEmpty]) {
        [tempDic setObject:min forKey:@"min"];
    }
    if ([max notEmpty]) {
        [tempDic setObject:max forKey:@"max"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}
//获取系统消息列表
+(NSDictionary *)C_GetSystemIM_ListSetUid:(NSString *)uid andWithLimit:(NSString*)limit andWithPage:(NSString *)page andWithMax:(NSString *)max
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    if ([limit notEmpty]) {
        [tempDic setObject:limit forKey:@"limit"];
    }
    if ([page notEmpty]) {
        [tempDic setObject:page forKey:@"page"];
    }
    if ([max notEmpty]) {
        [tempDic setObject:max forKey:@"max"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}
//发送消息
+(NSDictionary *)C_PostIm_SendSetfrom:(NSString *) from withTo:(NSString *)to withInquiry_quoted_id:(NSString *)inquiry_quoted_id withContent:(NSString *)content withType:(NSString *)type
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([from notEmpty]) {
        [tempDic setObject:from forKey:@"from"];
    }
    if ([to notEmpty]) {
        [tempDic setObject:to forKey:@"to"];
    }
    if ([inquiry_quoted_id notEmpty]) {
        [tempDic setObject:inquiry_quoted_id forKey:@"inquiry_quoted_id"];
    }
    if ([content notEmpty]) {
        [tempDic setObject:content forKey:@"content"];
    }
    if ([type notEmpty]) {
        [tempDic setObject:type forKey:@"type"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}

//获取消息组列表
+(NSDictionary *)C_GetIm_GrouplistSetUid:(NSString *) uid
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}

//获取试乘试驾列表
+(NSDictionary *)C_GetTrydriving_ListSetUid:(NSString *) uid
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}

//添加试乘试驾
+(NSDictionary *)C_PostTrydriving_AddSetUid:(NSString *) uid withCar_id:(NSString *)car_id withDealer_id:(NSString *)dealer_id withPhone:(NSString *)phone withRealname:(NSString *)realname withMem:(NSString *)mem withTime:(NSString*)time
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    if ([car_id notEmpty]) {
        [tempDic setObject:car_id forKey:@"car_id"];
    }
    if ([dealer_id notEmpty]) {
        [tempDic setObject:dealer_id forKey:@"dealer_id"];
    }
    if ([phone notEmpty]) {
        [tempDic setObject:phone forKey:@"phone"];
    }
    if ([realname notEmpty]) {
        [tempDic setObject:realname forKey:@"realname"];
    }
    if ([time notEmpty]) {
        [tempDic setObject:time forKey:@"time"];
    }
    if ([mem notEmpty]) {
        [tempDic setObject:mem forKey:@"memo"];
    }
    [self haneleToken:tempDic];
    return tempDic;

}

//删除试乘试驾
+(NSDictionary *)C_PostTrydriving_DelSetID:(NSString *)ID
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([ID notEmpty])
    {
        [tempDic setObject:ID forKey:@"id"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}

//创建询价单
+(NSDictionary *)C_PostInquiry_CreateSetUid:(NSString *) uid
                             withCar_id:(NSString *)car_id
                            withCity_id:(NSString *)city_id
                       withCar_color_id:(NSString *)car_color_id
                         withDealer_ids:(NSString *)dealer_ids
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    if ([car_id notEmpty]) {
        [tempDic setObject:car_id forKey:@"car_id"];
    }
    if ([city_id notEmpty]) {
        [tempDic setObject:city_id forKey:@"city_id"];
    }
    if ([car_color_id notEmpty]) {
        [tempDic setObject:car_color_id forKey:@"car_color_id"];
    }
    if ([dealer_ids notEmpty]) {
        [tempDic setObject:dealer_ids forKey:@"dealer_ids"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}

//询价单详情
+(NSDictionary *)C_GetInquiry_GetSetUid:(NSString *) uid withID:(NSString *)ID
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    if ([ID notEmpty]) {
        [tempDic setObject:ID forKey:@"id"];
    }
    [self haneleToken:tempDic];
    
    return tempDic;
}

//创建订单
+(NSDictionary *)C_PostOrder_CreatePostInquiry_CreateSetUid:(NSString *) uid
                                         Inquiry_quoted_id:(NSString *)inquiry_quoted_id
                                                      type:(NSString *)type
                                                    car_id:(NSString *)car_id
                                                 dealer_id:(NSString *)dealer_id
                                                   city_id:(NSString *)city_id
                                                   earnest:(NSString *)earnest
                                                      memo:(NSString *)memo
                                              car_color_id:(NSString *)car_color_id
                                                     phone:(NSString *)phone
                                             inviter_phone:(NSString *)inviter_phone
                                                  realname:(NSString *)realname
                                               installment:(NSString *)installment
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    if ([car_id notEmpty]) {
        [tempDic setObject:car_id forKey:@"car_id"];
    }
    if ([city_id notEmpty]) {
        [tempDic setObject:city_id forKey:@"city_id"];
    }
    if ([car_color_id notEmpty]) {
        [tempDic setObject:car_color_id forKey:@"car_color_id"];
    }
    if ([inquiry_quoted_id notEmpty]) {
        [tempDic setObject:inquiry_quoted_id forKey:@"inquiry_quoted_id"];
    }
    if ([type notEmpty]) {
        [tempDic setObject:type forKey:@"type"];
    }
    if ([dealer_id notEmpty]) {
        [tempDic setObject:dealer_id forKey:@"dealer_id"];
    }
    if ([earnest notEmpty]) {
        [tempDic setObject:earnest forKey:@"earnest"];
    }
    if ([memo notEmpty]) {
        [tempDic setObject:memo forKey:@"memo"];
    }
    if ([phone notEmpty]) {
        [tempDic setObject:phone forKey:@"phone"];
    }
    
    if ([inviter_phone notEmpty]) {
        [tempDic setObject:inviter_phone forKey:@"inviter_phone"];
    }
    if ([realname notEmpty]) {
        [tempDic setObject:realname forKey:@"realname"];
    }
    if ([installment notEmpty]) {
        [tempDic setObject:installment forKey:@"installment"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}

//签到
+(NSDictionary *)C_GetPoints_SignSetUid:(NSString *)uid
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}

//获取已记录保险单列表
+(NSDictionary *)C_GetInsurerrecord_ListSetUid:(NSString *)uid
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}

//订单支付
+(NSDictionary *)C_PostOrder_PayUid:(NSString*)uid withOrderId:(NSString*)orderid withStatus:(NSString*)status
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    if ([orderid notEmpty]) {
        [tempDic setObject:orderid forKey:@"order_id"];
    }
    if ([status notEmpty]) {
        [tempDic setObject:status forKey:@"status"];
    }
    [self haneleToken:tempDic];
    return tempDic;
}

//订单删除
+(NSDictionary *)C_PostOrder_DeleteUid:(NSString*)uid withOrderId:(NSString*)ID
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    if ([ID notEmpty]) {
        [tempDic setObject:ID forKey:@"id"];
    }
    
    [self haneleToken:tempDic];
    
    return tempDic;
}

//第三方用户登录
+(NSDictionary *)C_PostUser_ThirdloginSetSource_from:(NSString *)source_from
                                      withSource_uid:(NSString *)source_uid
                                    withAccess_token:(NSString *)access_token
                                   wtihRefresh_token:(NSString *)refresh_token
                                       witHunique_id:(NSString *)unique_id
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if ([source_from notEmpty]) {
        [tempDic setObject:source_from forKey:@"source_from"];
    }
    if ([source_uid notEmpty]) {
        [tempDic setObject:source_uid forKey:@"source_uid"];
    }
    if ([access_token notEmpty]) {
        [tempDic setObject:access_token forKey:@"access_token"];
    }
    if ([refresh_token notEmpty]) {
        [tempDic setObject:refresh_token forKey:@"refresh_token"];
    }
    if ([unique_id notEmpty]) {
        [tempDic setObject:unique_id forKey:@"unique_id"];
    }
    [self haneleToken:tempDic];
    return tempDic;

}

//第三方用户绑定手机
+(NSDictionary *)C_PostUser_BindphoneSetUid:(NSString *)uid withPhone:(NSString *)phone withCode:(NSString *)code
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    if ([phone notEmpty]) {
        [tempDic setObject:phone forKey:@"phone"];
    }
    if ([code notEmpty]) {
        [tempDic setObject:code forKey:@"code"];
    }
    
    [self haneleToken:tempDic];
    
    return tempDic;

}
//秒杀列表
+(NSDictionary *)C_GetSpike_ListSetCity_id:(NSString *)city_id 
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    if (![[DLAppData sharedInstance].myUserName notEmpty]) {
        //[tempDic setObject:userID forKey:@"uid"];
        [tempDic removeObjectForKey:@"uid"];
    }
    if ([city_id notEmpty]) {
        [tempDic setObject:city_id forKey:@"city_id"];
    }
    
    [self haneleToken:tempDic];
    
    return tempDic;
}

//秒杀详情
+(NSDictionary *)C_GetSpike_InfoSetID:(NSString *)ID  withSetUid:(NSString*)uid
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    
    if ([ID notEmpty]) {
        [tempDic setObject:ID forKey:@"id"];
    }
    
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }

    [self haneleToken:tempDic];
    
    return tempDic;
}

//参与秒杀
+(NSDictionary *)C_GetSpike_RushSetID:(NSString *)ID
                          withUid:(NSString *)uid
                    withTimestamp:(NSString *)timestamp

{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    [TTReqProtocol GetPublicData:tempDic];
    
    if ([ID notEmpty]) {
        [tempDic setObject:ID forKey:@"id"];
    }
    
    if ([uid notEmpty]) {
        [tempDic setObject:uid forKey:@"uid"];
    }
    if ([timestamp notEmpty]) {
        [tempDic setObject:timestamp forKey:@"timestamp"];
    }
  
    [tempDic setObject:@"70433" forKey:@"ak"];
    
    [self haneleToken:tempDic];
    
    return tempDic;
}

//发送消费码
+(NSDictionary *)C_GetCode_Send:(NSString*)ID withType:(NSString*)type withRelated_id:(NSString*)related_id
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    
    [TTReqProtocol GetPublicData:tempDic];
    
    if ([ID notEmpty]) {
        [tempDic setObject:ID forKey:@"uid"];
    }
    
    if ([type notEmpty]) {
        [tempDic setObject:type forKey:@"type"];
    }
    
    if ([related_id notEmpty]) {
        [tempDic setObject:related_id forKey:@"related_id"];
    }
    
    [self haneleToken:tempDic];
    
    return tempDic;
}

//报价单详情
+(NSDictionary *)C_GetQuoted_Get:(NSString*)ID
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    
    [TTReqProtocol GetPublicData:tempDic];
    
    if ([ID notEmpty]) {
        [tempDic setObject:ID forKey:@"id"];
    }
    
    [self haneleToken:tempDic];
    
    return tempDic;
}

//获取城市
+(NSDictionary*)C_GetCity_AllUrl
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    
    [TTReqProtocol GetPublicData:tempDic];
    
    [self haneleToken:tempDic];
    
    return tempDic;
}
+(NSDictionary *)C_GetArticle_List:(NSString *)limit withPage:(NSString *)page withMax:(NSString *)max withCityId:(NSString *)cityId withType:(NSString *)type
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    
    [TTReqProtocol GetPublicData:tempDic];
    
    if ([limit notEmpty]) {
        [tempDic setObject:limit forKey:@"limit"];
    }
    if ([page notEmpty]) {
        [tempDic setObject:page forKey:@"page"];
    }
    if ([max notEmpty]) {
        [tempDic setObject:max forKey:@"max"];
    }
    if ([cityId notEmpty]) {
        [tempDic setObject:cityId forKey:@"city_id"];
    }
    if ([type notEmpty]) {
        [tempDic setObject:type forKey:@"type"];
    }
    
    [self haneleToken:tempDic];
    
    return tempDic;
}
+(NSDictionary *)C_GetArticle_Detail:(NSString *)p_id
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    
    [TTReqProtocol GetPublicData:tempDic];
    if([p_id notEmpty])
    {
        [tempDic setObject:p_id forKey:@"id"];
    }
    [self haneleToken:tempDic];
    
    return tempDic;
}
+(NSDictionary *)C_GetScan_Deatil:(NSString *)getUrl
{
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    
    [TTReqProtocol GetPublicData:tempDic];
    if([getUrl notEmpty])
    {
        [tempDic setObject:getUrl forKey:@"url"];
    }
    [self haneleToken:tempDic];
    
    return tempDic;
}
@end
