//
//  TTReqEngine.h
//  TickTock
//
//  Created by 卢迎志 on 14-12-4.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TTBaseModelBlock)(BOOL success,id dataModel);

@interface TTReqEngine : NSObject

#pragma mark  -  用户接口
/**
    获取应用广告页面
 */
+(void)C_GetConfig_AD:(NSString *)type  withBlock:(TTBaseModelBlock)block;


//获取普通用户
+(void)C_GetUser_GetSetUid:(NSString *)uid withBlock:(TTBaseModelBlock)block;


//登录
+(void)C_PostUser_LoginPhone:(NSString*)phone
                  withCode:(NSString *)code
                 withBlock:(TTBaseModelBlock)block;

/**
 *  以密码登录接口
 *
 *  @param phone    用户手机号
 *  @param password 用户的密码
 *  @param block    登录成功的执行的代码块
 */
+(void)C_PostUser_LoginPhone:(NSString *)phone withPassword:(NSString *)password
                   withBlock:(TTBaseModelBlock)block;
/**
 *  用户注册
 *
 *  @param phone    手机号
 *  @param code     验证码
 *  @param password 密码
 */
+(void)C_PostUser_RegisterPhone:(NSString *)phone andWithCode:(NSString *)code andWithPassword:(NSString *)password withBlock:(TTBaseModelBlock)block;

/**
 *  普通用户修改密码
 *
 *  @param password 用户新密码
 *  @param uid      用户id
 */
+(void)C_PostUser_SetPassword:(NSString *)password andWith:(NSString *)uid withBlock:(TTBaseModelBlock)block;
/**
 *  用户修改密码
 *
 *  @param uid         用户id
 *  @param password    原始密码
 *  @param newPassword 新密码
 *  @param block       执行成功后的代码块
 */
+(void)C_PostUser_ModifyPassword:(NSString *)uid andWithOldPassword:(NSString *)password andWithNewPassword:(NSString *)newPassword andWithBlock:(TTBaseModelBlock )block;
/**
 *  获取系统消息列表
 *
 *  @param uid   用户id
 *  @param limit 获取条数
 *  @param page  分页页数
 *  @param max   下拉分页最大排序号
 */
+(void)C_PostUser_GetSystemImList:(NSString *)uid andWithLimit:(NSString *)limit andWithpage:(NSString *)page andWithMax:(NSString *)max andWithBlock:(TTBaseModelBlock )block;
//更新用户信息
+(void)C_PostUser_UpdateSetUid:(NSString *)uid
                     withSex:(NSString *)sex
                    withNick:(NSString *)nick
                   withEmail:(NSString *)email
                withBirthday:(NSString *)birthday
                  withAvatar:(NSString *)avatar
                 withCity_id:(NSString *)city_id
                      withQQ:(NSString *)qq
                   withBlock:(TTBaseModelBlock)block;

//获取验证码
+(void)C_GetCodeSetPhone:(NSString *)phone
                 withType:(NSString *)type
       withBlock:(TTBaseModelBlock)block;



//获取经销商
+(void)C_PostDealerID:(NSString *)ID
          withBlock:(TTBaseModelBlock)block;
//获取经销商列表

+(void)C_PostDealerListForCity_id:(NSString *)city_id
                     withCar_id:(NSString *)car_id
                       withType:(NSString *)type
                withBigbrand_id:(NSString *)bagbrand_id
                withbrand_id:(NSString *)brand_id
                withseries_id:(NSString *)series_id
                withBlock:(TTBaseModelBlock)block;
//获取经销商车型详情
+(void)C_Getcar_dealerSetCity_id:(NSString *)city_id
                                withCar_id:(NSString *)car_id
                                    withID:(NSString *)ID
                             withDealer_id:(NSString *)dealer_id
                                   withLng:(NSString *)lng
                                   withLat:(NSString *)lat
                                    withBlock:(TTBaseModelBlock)block;

//获取经销商车型列表
+(void)C_Getcar_dealerlistSetCity_id:(NSString *)city_id
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
                            withBlock:(TTBaseModelBlock)block;
//首页信息
+(void)C_GetRecommend_App_IndexCity_id:(NSString *)city_id
                           withBlock:(TTBaseModelBlock)block;
//首页banner信息
+(void)C_GetRecommend_BannerCity_id:(NSString *)city_id
                             withBlock:(TTBaseModelBlock)block;


//城市定位
+(void)C_GetCity_locationLng:(NSString *)lng
                     withLat:(NSString *)lat
                   withBlock:(TTBaseModelBlock)block;

//获取所有城市列表
+(void)C_GetCity_AllwithBlock:(TTBaseModelBlock)block;


//获取经销商

+(void)C_Getdealer_Dealer_id:(NSString *)dealer_id withBlock:(TTBaseModelBlock)block;

//获取经销商列表
+(void)C_GetdealerList_SetCity_id:(NSString *)city_id
                       withCar_id:(NSString *)car_id
                         withType:(NSString *)type
                  withBigbrand_id:(NSString *)bigbrand_id
                     withBrand_id:(NSString *)brand_id
                    withSeries_id:(NSString *)series_id
                       withLimitd:(NSString *)limit
                         withPage:(NSString *)page
                          withMax:(NSString *)max
                        withBlock:(TTBaseModelBlock)block;



//获取经城市
+(void)C_GetCity_listprovince_id:(NSString *)ID withStatus:(NSString *)status withBlock:(TTBaseModelBlock)block;

//获取订单列表
+(void)C_GetOrderMylistSetUid:(NSString *)uid
                               withStep:(NSString *)step
                             withLimitd:(NSString *)limit
                               withPage:(NSString *)page
                                withMax:(NSString *)max
                              withBlock:(TTBaseModelBlock)block;
//获取订单详情
+(void)C_GetOrderMylistSetID:(NSString *)ID  withBlock:(TTBaseModelBlock)block;


//配置项数据获取
+(void)C_GetConfig_GetType:(NSString *)type withBlock:(TTBaseModelBlock)block;

//收藏列表
+(void)C_GetFavorite_ListSetUid:(NSString *)uid withLimit:(NSString *)limit withPage:(NSString *)page withMax:(NSString *)max withBlock:(TTBaseModelBlock)block;

//收藏
+(void)C_PostFavorite_AddSetUid:(NSString *)uid withCar_id:(NSString *)car_id withCity_id:(NSString *)city_id withBlock:(TTBaseModelBlock)block;


//取消收藏
+(void)C_PostFavorite_DelSetID:(NSString *)ID Uid:(NSString *)uid withCar_id:(NSString *)car_id withCity_id:(NSString *)city_id withBlock:(TTBaseModelBlock)block;

//浏览过的记录列表

+(void)C_GetView_ListSetUid:(NSString *) uid withLimit:(NSString *)limit withPage:(NSString *)page withMax:(NSString *)max withBlock:(TTBaseModelBlock)block;

//删除浏览记录

+(void)C_PostView_ListDelSetID:(NSString *)ID withBlock:(TTBaseModelBlock)block;

//获取车系列表
+(void)C_GetSeries_ListSetBigbrand_id:(NSString *)bigbrand_id withStatus:(NSString *)status withBlock:(TTBaseModelBlock)block;


//询价单列表
+(void)C_GetInquiry_ListSetUid:(NSString *) uid withLimit:(NSString *)limit withPage:(NSString *)page withMax:(NSString *)max withBlock:(TTBaseModelBlock)block;

//获取消息列表
+(void)C_GetIm_ListSetUid:(NSString *) uid withTarget_uid:(NSString *)target_uid withInquiry_quoted_id:(NSString *)inquiry_quoted_id withLimit:(NSString *)limit withMin:(NSString *)min withMax:(NSString *)max withBlock:(TTBaseModelBlock)block;

//发送消息
+(void)C_PostIm_SendSetfrom:(NSString *) from withTo:(NSString *)to withInquiry_quoted_id:(NSString *)inquiry_quoted_id withContent:(NSString *)content withType:(NSString *)type withBlock:(TTBaseModelBlock)block;

//获取消息组列表
+(void)C_GetIm_GrouplistSetUid:(NSString *) uid withBlock:(TTBaseModelBlock)block;


//获取试乘试驾列表
+(void)C_GetTrydriving_ListSetUid:(NSString *) uid withBlock:(TTBaseModelBlock)block;


//添加试乘试驾
+(void)C_PostTrydriving_AddSetUid:(NSString *) uid withCar_id:(NSString *)car_id withDealer_id:(NSString *)dealer_id withPhone:(NSString *)phone withRealname:(NSString *)realname withMem:(NSString *)mem  withTime:(NSString*)time withBlock:(TTBaseModelBlock)block;

//删除试乘试驾
+(void)C_PostTrydriving_DelSetID:(NSString *)ID withBlock:(TTBaseModelBlock)block;

//创建询价单
+(void)C_PostInquiry_CreateSetUid:(NSString *) uid
                                 withCar_id:(NSString *)car_id
                                withCity_id:(NSString *)city_id
                           withCar_color_id:(NSString *)car_color_id
                             withDealer_ids:(NSString *)dealer_ids
                                  withBlock:(TTBaseModelBlock)block;

//询价单详情
+(void)C_GetInquiry_GetSetUid:(NSString *) uid withID:(NSString *)ID                                   withBlock:(TTBaseModelBlock)block;

//创建订单
+(void)C_PostOrder_CreatePostInquiry_CreateSetUid:(NSString *) uid
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
                                                 withBlock:(TTBaseModelBlock)block;


//签到
+(void)C_GetPoints_SignSetUid:(NSString *)uid withBlock:(TTBaseModelBlock)block;


//获取已记录保险单列表
+(void)C_GetInsurerrecord_ListSetUid:(NSString *)uid withBlock:(TTBaseModelBlock)block;

//上传订单完成凭证
+(void)C_PostOrder_Upload_CertificateSetUid:(NSString *)uid
                               withOrder_id:(NSString *)order_id
                                 withImages:(NSString *)images
                                  withBlock:(TTBaseModelBlock)block;

//订单支付
+(void)C_PostOrder_PayUid:(NSString*)uid withOrderId:(NSString*)orderid withStatus:(NSString*)status  withBlock:(TTBaseModelBlock)block;


//订单删除
+(void )C_PostOrder_DeleteUid:(NSString*)uid withOrderId:(NSString*)ID withBlock:(TTBaseModelBlock)block;

//第三方用户登录
+(void)C_PostUser_ThirdloginSetSource_from:(NSString *)source_from
                                      withSource_uid:(NSString *)source_uid
                                    withAccess_token:(NSString *)access_token
                                   wtihRefresh_token:(NSString *)refresh_token
                                       witHunique_id:(NSString *)unique_id
                                           withBlock:(TTBaseModelBlock)block;

//第三方用户绑定手机
+(void)C_PostUser_BindphoneSetUid:(NSString *)uid
                                  withPhone:(NSString *)phone
                                   withCode:(NSString *)code withBlock:(TTBaseModelBlock)block;

//秒杀列表
+(void)C_GetSpike_ListSetCity_id:(NSString *)city_id withBlock:(TTBaseModelBlock)block;

//秒杀详情
+(void)C_GetSpike_InfoSetID:(NSString *)ID  withSetUid:(NSString*)uid withBlock:(TTBaseModelBlock)block;

//参与秒杀
+(void)C_GetSpike_RushSetID:(NSString *)ID
                              withUid:(NSString *)uid
                        withTimestamp:(NSString *)timestamp withBlock:(TTBaseModelBlock)block;

//发送消费码
+(void)C_GetCode_Send:(NSString*)ID withType:(NSString*)type withRelated_id:(NSString*)related_id withBlock:(TTBaseModelBlock)block;

//报价单详情
+(void)C_GetQuoted_Get:(NSString*)ID withBlock:(TTBaseModelBlock)block;

/**
 *  获取文章列表
 *
 *  @param limit  获取分页条数
 *  @param page   获取页数
 *  @param max    下拉分页最大排序号
 *  @param cityId 城市iD
 *  @param type   0 原创 1 本地经销商
 */
+(void)C_GetArticle_List_Get:(NSString *)limit withPage:(NSString *)page  withMax:(NSString *)max withCityId:(NSString *)cityId withType:(NSString *)type withBlock:(TTBaseModelBlock)block;
/**
 *  获取文章详情
 *
 *  @param articleId 文章ID
 *  @param block     成功执行的代码块
 */
+(void)C_GetArticle_Detail_Get:(NSString *)articleId withBlock:(TTBaseModelBlock)block;
+(void)C_GetScanDetail_Get:(NSString *)scanUrl withBlock:(TTBaseModelBlock)block;
@end
