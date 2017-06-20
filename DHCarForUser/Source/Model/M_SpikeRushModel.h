//
//  M_SpikeRushModel.h
//  DHCarForUser
//
//  Created by 陈斌 on 16/1/14.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_SpikeRushModel : DLBaseModel

AS_MODEL_STRONG(NSString, spikeRush_timestamp);//时间
AS_MODEL_STRONG(NSString, spikeRush_process);//时间
AS_MODEL_STRONG(NSString, spikeRush_no);//汽车ID
AS_MODEL_STRONG(NSString, spikeRush_type);//大品牌ID
AS_MODEL_STRONG(NSString, spikeRush_uid);//大品牌名称
AS_MODEL_STRONG(NSString, spikeRush_cid);//品牌ID
AS_MODEL_STRONG(NSString, spikeRush_car_color_id);//品牌名称
AS_MODEL_STRONG(NSString, spikeRush_city_id);//车系ID
AS_MODEL_STRONG(NSString, spikeRush_dealer_id);//车系名称
AS_MODEL_STRONG(NSString, spikeRush_price);//车型名称
AS_MODEL_STRONG(NSString, spikeRush_earnest);//官方指导价 单位万元
AS_MODEL_STRONG(NSString, spikeRush_phone);//最低报价 租购使用
AS_MODEL_STRONG(NSString, spikeRush_created_at);//图片
AS_MODEL_STRONG(NSString, spikeRush_id);//

@end
