//
//  TTReqProtocol.h
//  TickTock
//
//  Created by 卢迎志 on 14-11-28.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTReqProtocol : NSObject

#pragma mark  -  用户接口(user)

//添加图片到form
+(void)addImageToFormArray:(NSMutableArray*)array
                 withImage:(NSString*)imagepath
                   withKey:(NSString*)key;

#pragma mark  -  用户接口


//获取公共参数
+(void)GetPublicData:(NSMutableDictionary *)dic;

//获取普通用户
+(NSDictionary*)C_GetUser_GetSetUid:(NSString *)uid;
//登录
+(NSDictionary *)C_PostUserLoginPhone:(NSString *)phone withCode:(NSString *)code;

//密码登陆方式
+(NSDictionary *)C_PostUserLoginPasswordPhone:(NSString *)phone withPassword:(NSString *)password;

//用户注册
+(NSDictionary *)C_PostUserRegister:(NSString *)phone withPassword:(NSString *)password withCode:(NSString *)code;

//用户设置密码
+(NSDictionary *)C_PostUserSetPassword:(NSString *)password andWithUserId:(NSString *)uid;

//用户修改密码
+(NSDictionary *)C_PostUserModifyPassWord:(NSString *)uid andWithOldPassword:(NSString *)oldPassword andWithNewPassword:(NSString *)newPassword;

//获取验证码接口
+(NSDictionary *)C_GetCode_SetPhone:(NSString *)phone withType:(NSString *)type;

//获取首页信息
+(NSDictionary *)C_Getqrecommend_App_IndexCity_id:(NSString *)city_id;

//获取banner首页信息
+(NSDictionary *)C_Getqrecommend_BannerCity_id:(NSString *)city_id;

//用户信息更新
+(NSDictionary *)C_PostUser_UpdateSetUid:(NSString *)uid
                                withSex:(NSString *)sex
                               withNick:(NSString *)nick
                              withEmail:(NSString *)email
                           withBirthday:(NSString *)birthday
                             withAvatar:(NSString *)avatar
                            withCity_id:(NSString *)city_id
                                 withQQ:(NSString *)qq;

//获取经销商信息
+(NSDictionary *)C_Getdealer_Dealer_id:(NSString *)dealer_id;


//获取经销商列表信息
+(NSDictionary *)C_GetdealerListSetCity_id:(NSString *)city_id
                                withCar_id:(NSString *)car_id
                               withType:(NSString *)type
                              withBigbrand_id:(NSString *)bigbrand_id
                           withBrand_id:(NSString *)brand_id
                             withSeries_id:(NSString *)series_id
                            withLimitd:(NSString *)limit
                                 withPage:(NSString *)page
                                withMax:(NSString *)max;

//获取经销商车型详情
+(NSDictionary *)C_Getcar_dealerSetCity_id:(NSString *)city_id
                                withCar_id:(NSString *)car_id
                                  withID:(NSString *)ID
                           withDealer_id:(NSString *)dealer_id
                              withLng:(NSString *)lng
                                   withUid:(NSString *)uid
                                   withLat:(NSString *)lat;
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
                                 withSeries_id:(NSString *)series_id;





//获取所有城市
+(void)C_GetCity_all;

//获取城市列表
+(NSDictionary *)C_GetCity_ListProvince_id:(NSString *)ID withStatus:(NSString *)status;
//城市定位
+(NSDictionary *)C_GetCity_locationLng:(NSString *)lng withLat:(NSString *)lat;


//获取订单列表
+(NSDictionary *)C_GetOrderMylistSetUid:(NSString *)uid
                                 withStep:(NSString *)step
                                    withLimitd:(NSString *)limit
                                      withPage:(NSString *)page
                                       withMax:(NSString *)max;

//获取订单详情
+(NSDictionary *)C_GetOrderMylistSetID:(NSString *)ID;



//配置项数据获取
+(NSDictionary *)C_GetConfig_GetType:(NSString *)type;

//上传订单完成凭证
+(NSDictionary *)C_PostOrder_Upload_CertificateSetUid:(NSString *)uid
                                         withOrder_id:(NSString *)order_id withImages:(NSString *)images;

//收藏列表
+(NSDictionary *)C_GetFavorite_ListSetUid:(NSString *)uid withLimit:(NSString *)limit withPage:(NSString *)page withMax:(NSString *)max ;

//收藏
+(NSDictionary *)C_PostFavorite_AddSetUid:(NSString *)uid withCar_id:(NSString *)car_id withCity_id:(NSString *)city_id;



//取消收藏
+(NSDictionary *)C_PostFavorite_DelSetID:(NSString *)ID withUid:(NSString *)uid withCar_id:(NSString *)car_id withCity_id:(NSString *)city_id;




//获取车系列表
+(NSDictionary *)C_GetSeries_ListSetBigbrand_id:(NSString *)bigbrand_id withStatus:(NSString *)status;



//浏览过的记录列表

+(NSDictionary *)C_GetView_ListSetUid:(NSString *) uid withLimit:(NSString *)limit withPage:(NSString *)page withMax:(NSString *)max;

//删除浏览记录

+(NSDictionary *)C_PostView_ListDelSetID:(NSString *)ID;


//询价单列表
+(NSDictionary *)C_GetInquiry_ListSetUid:(NSString *) uid withLimit:(NSString *)limit withPage:(NSString *)page withMax:(NSString *)max;


//获取消息列表
+(NSDictionary *)C_GetIm_ListSetUid:(NSString *) uid withTarget_uid:(NSString *)target_uid withInquiry_quoted_id:(NSString *)inquiry_quoted_id withLimit:(NSString *)limit withMin:(NSString *)min withMax:(NSString *)max;

//获取系统消息列表
+(NSDictionary *)C_GetSystemIM_ListSetUid:(NSString *)uid andWithLimit:(NSString*)limit andWithPage:(NSString *)page andWithMax:(NSString *)max;

//发送消息
+(NSDictionary *)C_PostIm_SendSetfrom:(NSString *) from withTo:(NSString *)to withInquiry_quoted_id:(NSString *)inquiry_quoted_id withContent:(NSString *)content withType:(NSString *)type;

//获取消息组列表
+(NSDictionary *)C_GetIm_GrouplistSetUid:(NSString *) uid;

//获取试乘试驾列表
+(NSDictionary *)C_GetTrydriving_ListSetUid:(NSString *) uid;


//添加试乘试驾
+(NSDictionary *)C_PostTrydriving_AddSetUid:(NSString *) uid withCar_id:(NSString *)car_id withDealer_id:(NSString *)dealer_id withPhone:(NSString *)phone withRealname:(NSString *)realname withMem:(NSString *)mem  withTime:(NSString*)time;

//删除试乘试驾
+(NSDictionary *)C_PostTrydriving_DelSetID:(NSString *)ID;

//创建询价单
+(NSDictionary *)C_PostInquiry_CreateSetUid:(NSString *) uid
                             withCar_id:(NSString *)car_id
                            withCity_id:(NSString *)city_id
                       withCar_color_id:(NSString *)car_color_id
                         withDealer_ids:(NSString *)dealer_ids ;

//询价单详情
+(NSDictionary *)C_GetInquiry_GetSetUid:(NSString *) uid withID:(NSString *)ID;

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

;

//签到
+(NSDictionary *)C_GetPoints_SignSetUid:(NSString *)uid;

//获取已记录保险单列表
+(NSDictionary *)C_GetInsurerrecord_ListSetUid:(NSString *)uid;

//订单支付
+(NSDictionary *)C_PostOrder_PayUid:(NSString*)uid withOrderId:(NSString*)orderid withStatus:(NSString*)status;

//订单删除
+(NSDictionary *)C_PostOrder_DeleteUid:(NSString*)uid withOrderId:(NSString*)ID;

//第三方用户登录
+(NSDictionary *)C_PostUser_ThirdloginSetSource_from:(NSString *)source_from
                                      withSource_uid:(NSString *)source_uid
                                    withAccess_token:(NSString *)access_token
                                   wtihRefresh_token:(NSString *)refresh_token
                                       witHunique_id:(NSString *)unique_id;

//第三方用户绑定手机
+(NSDictionary *)C_PostUser_BindphoneSetUid:(NSString *)uid withPhone:(NSString *)phone withCode:(NSString *)code;


//秒杀列表
+(NSDictionary *)C_GetSpike_ListSetCity_id:(NSString *)city_id;
//秒杀详情
+(NSDictionary *)C_GetSpike_InfoSetID:(NSString *)ID withSetUid:(NSString*)uid;

//参与秒杀
+(NSDictionary *)C_GetSpike_RushSetID:(NSString *)ID withUid:(NSString *)uid withTimestamp:(NSString *)timestamp ;

//发送消费码
+(NSDictionary *)C_GetCode_Send:(NSString*)ID withType:(NSString*)type withRelated_id:(NSString*)related_id;

//报价单详情
+(NSDictionary *)C_GetQuoted_Get:(NSString*)ID;

//获取城市
+(NSDictionary*)C_GetCity_AllUrl;
/**
 *  获取文章列表
 *
 *  @param limit  获取条数
 *  @param page   获取页数
 *  @param max    下拉分页最大排序号
 *  @param cityId 城市id
 *  @param type   0 原创 1 本地经销商
 *
 */
+(NSDictionary *)C_GetArticle_List:(NSString *)limit withPage:(NSString *)page withMax:(NSString *)max withCityId:(NSString *)cityId withType:(NSString *)type;

/**
 *  获取文章详情
 *
 *  @param id 文章的iD
 *

 */
+(NSDictionary *)C_GetArticle_Detail:(NSString *)p_id;
+(NSDictionary *)C_GetScan_Deatil:(NSString *)getUrl;
@end
