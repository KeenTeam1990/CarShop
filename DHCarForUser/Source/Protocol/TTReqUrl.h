//
//  TTReqUrl.h
//  TickTock
//
//  Created by 卢迎志 on 14-11-28.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KProtocolVistion @"/2.0"

#pragma mark  -  用户接口

//获取普通用户
#define C_KA_User_GetUrl @"/user/get"

//用户登录
#define C_KA_User_LoginUrl @"/user/login"

//密码登录方式
#define C_KA_Password_PostLogin @"/user/login_by_password"


//用户注册
#define C_KA_User_PostRegister @"/user/register"

//设置密码
#define C_KA_User_SetPossword @"/user/setpassword"

// 修改密码
#define C_KA_User_ModifyPassword @"/user/modifypassword"

//设置用户详细信息接口
#define C_KA_User_UpdateUrl @"/user/update"

//获取验证码－－get
#define C_KA_Code_GetphonecodeUrl @"/code/getphonecode"

//获取经销商－－get
#define C_KA_Dealer_getUrl @"/dealer/get"

//经销商列表－－get
#define C_KA_Dealer_ListUrl @"/dealer/list"

//获取经销商车型详情－－get
#define C_KA_Car_DealerCarUrl @"/car/dealercar"

//获取经销商车型列表－－get
#define C_KA_Car_DealerCarListUrl @"/car/dealercarlist"

//获取首页－－get
#define C_KA_Recommend_App_IndexUrl @"/recommend/app_index"

//获取banner－－get
#define C_KA_Recommend_BannerUrl @"/recommend/banner"

//获取城市--get
#define C_KA_City_AllUrl @"/city/all"

//获取城市列表--GET
#define C_KA_City_list @"/city/list"

//城市定位--GET
#define C_KA_City_Location @"/city/location"


//获取验证码
#define C_KA_Code_Getphonecode @"/code/getphonecode"



//订单列表
#define C_KA_Order_MylistUrl @"/order/list"


//订单详情
#define C_KA_Order_GetUrl @"/order/get"

//配置项数据获取
#define C_KA_Config_GetUrl @"/config/get"

//上传订单完成凭证
#define C_KA_Order_Upload_CertificateUrl @"/order/upload_certificate"

//收藏列表
#define C_KA_Favorite_ListUrl @"/favorite/list"

//收藏
#define C_KA_Favorite_AddUrl @"/favorite/add"
//取消收藏
#define C_KA_Favorite_DelUrl @"/favorite/del"

//获取车系列表
#define C_KA_Series_ListUrl @"/series/list"


//浏览过的记录列表
#define C_KA_View_ListUrl @"/view/list"

//删除浏览记录
#define C_KA_View_ListDelUrl @"/view/del"

//询价单列表
#define C_KA_Inquiry_ListUrl @"/inquiry/list"

//获取消息列表
#define C_KA_Im_ListUrl @"/im/list"

//获取系统下
#define C_KA_Im_SystemListUrl @"/notice/list"

//发送消息
#define C_KA_Im_SendUrl @"/im/send"

//获取消息组列表
#define C_KA_Im_GrouplistUrl @"/im/grouplist"

//获取试乘试驾列表
#define C_KA_Trydriving_ListUrl @"/trydriving/list"


//添加试乘试驾
#define C_KA_Trydriving_AddUrl @"/trydriving/add"


//删除试乘试驾
#define C_KA_Trydriving_DelUrl @"/trydriving/del"

//创建询价单
#define C_KA_Inquiry_CreateUrl @"/inquiry/create"


//询价单详情
#define C_KA_Inquiry_GetUrl @"/inquiry/get"

//创建订单
#define C_KA_Order_CreateUrl @"/order/create"


//签到
#define C_KA_Points_SignUrl @"/points/sign"


//获取已记录保险单列表
#define C_KA_Insurerrecord_ListUrl @"/insurerrecord/list"

//订单支付
#define C_KA_Order_PayUrl @"/order/pay"

//订单删除
#define C_KA_Order_DeleteUrl @"/order/delete"

//第三方用户登录
#define C_KA_User_ThirdloginUrl @"/user/thirdlogin"

//第三方用户绑定手机
#define C_KA_User_BindphoneUrl @"/user/bindphone"


//秒杀列表
#define C_KA_Spike_ListUrl @"/spike/list"

//秒杀详情
#define C_KA_Spike_InfoUrl @"/spike/info"

//参与秒杀
#define C_KA_Spike_RushUrl @"/spike/rush"

//发送消费码
#define C_KA_Code_SendUrl @"/code/send"

//报价单详情
#define C_KA_Quoted_GetUrl @"/quoted/get"

//获取文章列表
#define C_KA_Article_List_GetUrl @"/article/list"

//获取文章详情
#define C_KA_Article_Detail_GetUrl @"/article/detail"

//获取扫描后的链接
#define C_KA_UrlToScanDetailUrl @"/tolongurl"
@interface TTReqUrl : NSObject

#pragma mark  -  用户接口

+(NSString *)HandleHostAndPro;
//获取普通用户
+(NSString*)C_ReqUser_GetUrl;

//登录
+(NSString*)C_ReqUser_LoginUrl;

//密码登录方式
+(NSString *)C_reqUser_LoginPasswordUrl;

//用户注册
+(NSString *)C_reqUser_RegisterUrl;

//用户更新接口
+(NSString *)C_ReqUser_UpdateUrl;

//获取验证接口
+(NSString *)C_ReqCode_GetphonecodeUrl;

//设置用户密码
+(NSString *)C_reqUser_SetPasswordUrl;

//修改密码
+(NSString *)C_reqUser_ModifyPasswordUrl;
//获取经销商
+(NSString *)C_ReqDealer_GetUrl;

//获取经销商列表
+(NSString *)C_ReqDealer_ListUrl;

//获取经销商车型详情
+(NSString *)C_ReqCar_DealercarUrl;

//获取经销商车型列表
+(NSString *)C_ReqCar_DealercarlistUrl;

//获取首页信息
+(NSString *)C_Reqrecommend_App_IndexUrl;

//获取banner信息
+(NSString *)C_Reqrecommend_BannerUrl;



//获取城市列表
+(NSString *)C_ReqCity_ListUrl;

//获取所有城市列表
+(NSString *)C_ReqCity_AllUrl;

//城市定位
+(NSString *)C_ReqCity_locationUrl;

//订单列表
+(NSString *)C_ReqOrderMylistUrl;
//订单详情
+(NSString *)C_ReqOrderGetUrl;

//配置项数据获取
+(NSString *)C_ReqConfig_GetUrl;


//上传订单完成凭证
+(NSString *)C_ReqOrder_Upload_CertificateUrl;

//收藏列表
+(NSString *)C_ReqFavorite_ListUrl;
//收藏

+(NSString *)C_ReqFavorite_AddUrl;

//取消收藏

+(NSString *)C_ReqFavorite_DelUrl;



//浏览过的记录列表

+(NSString *)C_ReqView_ListUrl;

//删除浏览记录

+(NSString *)C_ReqView_ListDelUrl;

//获取车系列表
+(NSString *)C_ReqSeries_ListUrl;


//获取消息列表
+(NSString *)C_ReqIm_ListUrl;

//获取系统消息列表
+(NSString *)C_ReqIm_SystemUrl;

//发送消息
+(NSString *)C_ReqIm_SendUrl;


//获取消息组列表
+(NSString *)C_ReqIm_GrouplistUrl;

//获取试乘试驾列表
+(NSString *)C_ReqTrydriving_List;

//添加试乘试驾
+(NSString *)C_ReqTrydriving_AddUrl;

//删除试乘试驾
+(NSString *)C_ReqTrydriving_DelUrl;

//创建询价单
+(NSString *)C_ReqInquiry_CreateUrl;

//询价单列表
+(NSString *)C_ReqInquiry_ListUrl;

//询价单详情
+(NSString *)C_ReqInquiry_GetUrl;


//创建订单
+(NSString *)C_ReqOrder_CreateUrl;


//签到
+(NSString *)C_ReqPoints_SignUrl;

//获取已记录保险单列表
+(NSString *)C_ReqInsurerrecord_ListUrl;

//订单支付
+(NSString *)C_ReqOrder_PayUrl;


//订单删除
+(NSString *)C_ReqOrder_DeleteUrl;

//第三方用户登录
+(NSString *)C_ReqUser_ThirdloginUrl;

//第三方用户绑定手机
+(NSString *)C_ReqUser_BindphoneUrl;

//秒杀列表
+(NSString *)C_ReqSpike_ListUrl;



//秒杀详情
+(NSString *)C_ReqSpike_InfoUrl;


//参与秒杀
+(NSString *)C_ReqSpike_RushUrl;

//发送消费码
+(NSString *)C_ReqCode_SendUrl;

//报价单详情
+(NSString *)C_ReqQuoted_GetUrl;

//获取文章列表接口
+(NSString *)C_ReqArticleList_GetUrl;

//获取文章详情
+(NSString *)C_ReqArticleDetail_GetUrl;

//获取的扫描详情的Url
+(NSString *)C_ReqScanDetail_GetUrl;

@end

