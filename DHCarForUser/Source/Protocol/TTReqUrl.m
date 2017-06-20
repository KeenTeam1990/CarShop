//
//  TTReqUrl.m
//  TickTock
//
//  Created by 卢迎志 on 14-11-28.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import "TTReqUrl.h"

@implementation TTReqUrl

+(NSString*) HandleHostAndPro
{
    return [NSString stringWithFormat:@"%@%@",KHost,KProtocolVistion];
}

+(NSString*)HaneleGetUrlString:(NSString*)url
{
    NSString* result = [NSString stringWithFormat:@"%@%@",[TTReqUrl HandleHostAndPro],url];
    
    NSLog(@"req url:%@",result);
    
    return result;
}

#pragma mark  -  用户接口(user)

//获取普通用户
+(NSString*)C_ReqUser_GetUrl
{
    return [self HaneleGetUrlString:C_KA_User_GetUrl];
}

//登录
+(NSString*)C_ReqUser_LoginUrl
{
    return [self HaneleGetUrlString:C_KA_User_LoginUrl];
}

//密码登录_密码方式
+(NSString *)C_reqUser_LoginPasswordUrl
{
    return [self HaneleGetUrlString:C_KA_Password_PostLogin];
}
//用户注册
+(NSString *)C_reqUser_RegisterUrl
{
    return [self HaneleGetUrlString:C_KA_User_PostRegister];
}

//设置用户密码
+(NSString *)C_reqUser_SetPasswordUrl
{
    return [self HaneleGetUrlString:C_KA_User_SetPossword];
}
//修改密码
+(NSString *)C_reqUser_ModifyPasswordUrl
{
    return [self HaneleGetUrlString:C_KA_User_ModifyPassword];
}

//用户更新接口
+(NSString *)C_ReqUser_UpdateUrl
{
    return [self HaneleGetUrlString:C_KA_User_UpdateUrl];
}

//获取验证接口
+(NSString *)C_ReqCode_GetphonecodeUrl
{
    return [self HaneleGetUrlString:C_KA_Code_GetphonecodeUrl];
}

//获取经销商
+(NSString *)C_ReqDealer_GetUrl
{
    return [self HaneleGetUrlString:C_KA_Dealer_getUrl];
}

//获取经销商列表
+(NSString *)C_ReqDealer_ListUrl
{
    return [self HaneleGetUrlString:C_KA_Dealer_ListUrl];
}

//获取经销商车型详情
+(NSString *)C_ReqCar_DealercarUrl
{
    return [self HaneleGetUrlString:C_KA_Car_DealerCarUrl];
}

//获取经销商车型列表
+(NSString *)C_ReqCar_DealercarlistUrl
{
    return [self HaneleGetUrlString:C_KA_Car_DealerCarListUrl];
}
//获取首页信息

+(NSString *)C_Reqrecommend_App_IndexUrl
{
    return [self HaneleGetUrlString:C_KA_Recommend_App_IndexUrl];
}

//获取banner信息
+(NSString *)C_Reqrecommend_BannerUrl
{
    return [self HaneleGetUrlString:C_KA_Recommend_BannerUrl];
}

//获取城市列表
+(NSString *)C_ReqCity_ListUrl
{
    return [self HaneleGetUrlString:C_KA_City_list];
}
//获取所有城市列表
+(NSString *)C_ReqCity_AllUrl
{
    return [self HaneleGetUrlString:C_KA_City_AllUrl];
}

//城市定位
+(NSString *)C_ReqCity_locationUrl
{
    return [self HaneleGetUrlString:C_KA_City_Location];
}
//订单列表
+(NSString *)C_ReqOrderMylistUrl
{
    return [self HaneleGetUrlString:C_KA_Order_MylistUrl];
}

//订单详情
+(NSString *)C_ReqOrderGetUrl
{
    return [self HaneleGetUrlString:C_KA_Order_GetUrl];
}

//配置项数据获取
+(NSString *)C_ReqConfig_GetUrl
{
     return [self HaneleGetUrlString:C_KA_Config_GetUrl];
}

//上传订单完成凭证
+(NSString *)C_ReqOrder_Upload_CertificateUrl
{
    return [self HaneleGetUrlString:C_KA_Order_Upload_CertificateUrl];
}

//收藏列表
+(NSString *)C_ReqFavorite_ListUrl
{
    return [self HaneleGetUrlString:C_KA_Favorite_ListUrl];
}
//收藏

+(NSString *)C_ReqFavorite_AddUrl
{
    return [self HaneleGetUrlString:C_KA_Favorite_AddUrl];
}

//取消收藏
+(NSString *)C_ReqFavorite_DelUrl;

{
    return [self HaneleGetUrlString:C_KA_Favorite_DelUrl];
}


//浏览过的记录列表

+(NSString *)C_ReqView_ListUrl
{
    return [self HaneleGetUrlString:C_KA_View_ListUrl];
}

//删除浏览记录

+(NSString *)C_ReqView_ListDelUrl
{
    return [self HaneleGetUrlString:C_KA_View_ListDelUrl];
}

//获取车系列表
+(NSString *)C_ReqSeries_ListUrl
{
    return [self HaneleGetUrlString:C_KA_Series_ListUrl];
}


//询价单列表
+(NSString *)C_ReqInquiry_ListUrl
{
    return [self HaneleGetUrlString:C_KA_Inquiry_ListUrl];
}


//获取消息列表
+(NSString *)C_ReqIm_ListUrl
{
    return [self HaneleGetUrlString:C_KA_Im_ListUrl];
}

//获取系统消息列表
+(NSString *)C_ReqIm_SystemUrl
{
    return [self HaneleGetUrlString:C_KA_Im_SystemListUrl];
}
//发送消息
+(NSString *)C_ReqIm_SendUrl
{
    return [self HaneleGetUrlString:C_KA_Im_SendUrl];
}

//获取消息组列表
+(NSString *)C_ReqIm_GrouplistUrl
{
    return [self HaneleGetUrlString:C_KA_Im_GrouplistUrl];
}

//获取试乘试驾列表
+(NSString *)C_ReqTrydriving_List
{
    return [self HaneleGetUrlString:C_KA_Trydriving_ListUrl];
}

//添加试乘试驾
+(NSString *)C_ReqTrydriving_AddUrl
{
    return [self HaneleGetUrlString:C_KA_Trydriving_AddUrl];
}

//删除试乘试驾
+(NSString *)C_ReqTrydriving_DelUrl
{
    return [self HaneleGetUrlString:C_KA_Trydriving_DelUrl];
}

//创建询价单
+(NSString *)C_ReqInquiry_CreateUrl
{
    return [self HaneleGetUrlString:C_KA_Inquiry_CreateUrl];
}

//询价单详情
+(NSString *)C_ReqInquiry_GetUrl
{
    return [self HaneleGetUrlString:C_KA_Inquiry_GetUrl];
}

//创建订单
+(NSString *)C_ReqOrder_CreateUrl
{
    return [self HaneleGetUrlString:C_KA_Order_CreateUrl];
}

//签到
+(NSString *)C_ReqPoints_SignUrl
{
    return [self HaneleGetUrlString:C_KA_Points_SignUrl];

}

//获取已记录保险单列表
+(NSString *)C_ReqInsurerrecord_ListUrl
{
    return [self HaneleGetUrlString:C_KA_Insurerrecord_ListUrl];
}

//订单支付
+(NSString *)C_ReqOrder_PayUrl
{
    return [self HaneleGetUrlString:C_KA_Order_PayUrl];
}

//订单删除
+(NSString *)C_ReqOrder_DeleteUrl
{
    return [self HaneleGetUrlString:C_KA_Order_DeleteUrl];
}

//第三方用户登录
+(NSString *)C_ReqUser_ThirdloginUrl
{
    return [self HaneleGetUrlString:C_KA_User_ThirdloginUrl];
}

//第三方用户绑定手机
+(NSString *)C_ReqUser_BindphoneUrl
{
    return [self HaneleGetUrlString:C_KA_User_BindphoneUrl];
}

//秒杀列表
+(NSString *)C_ReqSpike_ListUrl
{
    return [self HaneleGetUrlString:C_KA_Spike_ListUrl];
}
//秒杀详情
+(NSString *)C_ReqSpike_InfoUrl
{
     return [self HaneleGetUrlString:C_KA_Spike_InfoUrl];
}

//参与秒杀
+(NSString *)C_ReqSpike_RushUrl
{
    return [self HaneleGetUrlString:C_KA_Spike_RushUrl];
}

//发送消费码
+(NSString *)C_ReqCode_SendUrl
{
    return [self HaneleGetUrlString:C_KA_Code_SendUrl];
}

//报价单详情
+(NSString *)C_ReqQuoted_GetUrl
{
    return [self HaneleGetUrlString:C_KA_Quoted_GetUrl];
}
//获取文章列表接口
+(NSString *)C_ReqArticleList_GetUrl
{
    return [self HaneleGetUrlString:C_KA_Article_List_GetUrl];
}

//获取文章详情
+(NSString *)C_ReqArticleDetail_GetUrl
{
    return [self HaneleGetUrlString:C_KA_Article_Detail_GetUrl];
}
//获取的扫描详情的Url
+(NSString *)C_ReqScanDetail_GetUrl
{
    return [self HaneleGetUrlString:C_KA_UrlToScanDetailUrl];
}
@end
