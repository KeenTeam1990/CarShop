//
//  M_SpikeListModel.h
//  DHCarForUser
//
//  Created by 陈斌 on 16/1/14.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_SpikeItemModel : DLBaseModel

AS_FACTORY(M_SpikeItemModel);

AS_MODEL_STRONG(NSIndexPath, myIndexPath);

AS_MODEL_STRONG(NSString, myCover);

AS_MODEL_STRONG(NSString, myUpDated_at);//时间
AS_MODEL_STRONG(NSString, myCreated_at);//时间
AS_MODEL_STRONG(NSString, myCar_Id);//汽车ID
AS_MODEL_STRONG(NSString, myBigBrand_Id);//大品牌ID
AS_MODEL_STRONG(NSString, myBigBrand_Name);//大品牌名称
AS_MODEL_STRONG(NSString, myBrand_Id);//品牌ID
AS_MODEL_STRONG(NSString, myBrand_Name);//品牌名称
AS_MODEL_STRONG(NSString, mySubbrand_Id);//车系ID
AS_MODEL_STRONG(NSString, mySubbrand_Name);//车系名称
AS_MODEL_STRONG(NSString, myCar_Name);//车型名称
AS_MODEL_STRONG(NSString, myCar_Price);//官方指导价 单位万元
AS_MODEL_STRONG(NSString, myLease_Price);//最低报价 租购使用
AS_MODEL_STRONG(NSString, myCar_Img);//图片
AS_MODEL_STRONG(NSString, myCar_Policy);//售后政策

AS_BOOL(myCar_Lease);//是否租购
AS_BOOL(myCar_Sales);//是否特价
AS_BOOL(myCar_New);//是否新车

AS_MODEL_STRONG(NSString, myCar_Code);//编码
AS_MODEL_STRONG(NSString, myCar_Year);//年份
AS_MODEL_STRONG(NSMutableArray, myCarImgArray);//图片
AS_MODEL_STRONG(NSString, myCar_Info);//介绍
AS_MODEL_STRONG(NSString, myCarUrl_Info);//介绍
AS_MODEL_STRONG(NSString, myCar_Deposit);//订金金额
AS_MODEL_STRONG(NSString, myDealer_Car_Id);//所属经销商唯一ID
AS_MODEL_STRONG(NSString, myDealer_Car_Price);//经销商最低报价 单位万元

AS_MODEL_STRONG(NSString, myCar_Collect);//是否收藏 Y／N

AS_MODEL_STRONG(NSString, has_Favorite);//是否收藏

AS_MODEL_STRONG(NSString, readID);//浏览id

//秒杀
AS_MODEL_STRONG(NSString, spike_id);//秒杀id
AS_MODEL_STRONG(NSString, spike_cid);//秒杀车型id
AS_MODEL_STRONG(NSString, spike_car_color_id);//秒杀车颜色id
AS_MODEL_STRONG(NSString, spike_city_id);//秒杀城市id
AS_MODEL_STRONG(NSString, spike_dealer_id);//秒杀经销商id
AS_MODEL_STRONG(NSString, spike_count);//库存

AS_MODEL_STRONG(NSString, spike_price);//秒杀价格
AS_MODEL_STRONG(NSString, spike_started_at);//秒杀开始时间
AS_MODEL_STRONG(NSString, spike_ended_at);//秒杀结束时间
AS_MODEL_STRONG(NSString, spike_created_at);//秒杀创建时间

AS_MODEL_STRONG(NSString, spike_isopened);//是否打开
AS_MODEL_STRONG(NSString, spike_has_order);//形成订单 0表示秒杀未成功 1表示秒杀成功

AS_MODEL_STRONG (NSString,timestamp);//服务器时间戳

@end

@interface M_SpikeListModel : DLBaseModel

AS_FACTORY(M_SpikeListModel);
AS_MODEL_STRONG (NSString,timestamp);
AS_MODEL_STRONG(NSMutableArray, myItemArray);
@end
