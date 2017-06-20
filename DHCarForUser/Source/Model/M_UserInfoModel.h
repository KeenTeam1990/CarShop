//
//  M_UserInfoModel.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/10.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_UserInfoModel : DLBaseModel

AS_FACTORY(M_UserInfoModel)
@property(nonatomic,strong) NSString *user_id;
@property(nonatomic,strong) NSString *user_name;
@property(nonatomic,strong) NSString *user_nick;
@property(nonatomic,strong) NSString *user_photo;
@property(nonatomic,strong) NSString *user_phone;
@property(nonatomic,strong) NSString *user_birthday;
@property(nonatomic,strong) NSString *user_sex;
@property(nonatomic,strong) NSString *province_name;//省
@property(nonatomic,strong) NSString *city_name;//市
@property(nonatomic,strong) NSString *province_id;//省
@property(nonatomic,strong) NSString *city_id;//市
@property(nonatomic,strong) NSString *county_name;//区县
@property(nonatomic,strong) NSString *city_code;
@property(nonatomic,strong) NSString *user_gold;//积分
@property(nonatomic,strong) NSString *user_order_gas;//ß可充值加油卡次数
AS_MODEL_STRONG(NSString, user_has_sign);//是否签到
AS_MODEL_STRONG(NSString, user_balance);//返现金额

AS_MODEL_STRONG(NSString, myType);//-- 用户类别 0普通用户,1销售

AS_MODEL_STRONG(NSString, myTitle);//-- 职称
AS_MODEL_STRONG(NSString, myWord);//-- 一句话描述
AS_MODEL_STRONG(NSString, myDealerId);//-- 当前所属经销商id 注:离职时应将此字段置为0
AS_MODEL_STRONG(NSString, myIncumbencyStatus);//-- 在职状态 0为离职,1为在职 注:只有离职情况下可以被经销商添加
AS_MODEL_STRONG(NSString, myStarted_at);//-- 开始从业时间
AS_MODEL_STRONG(NSString, myHas_Set_Password);//是否设置密码

@end
