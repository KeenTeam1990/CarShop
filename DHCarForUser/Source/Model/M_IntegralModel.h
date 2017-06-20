//
//  M_IntegralModel.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/12.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"


@interface M_IntegralTtemModel : DLBaseModel
AS_FACTORY(M_IntegralTtemModel);

@property(nonatomic,strong) NSString *gold_id;//ID
@property(nonatomic,strong) NSString *gold_type;//类型，1 增加，2 消费
@property(nonatomic,strong) NSString *gold_number;//数量
@property(nonatomic,strong) NSString *gold_name;//名称
@property(nonatomic,strong) NSString *gold_memo;//附加项
@property(nonatomic,strong) NSString *gold_time;//时间

@end

@interface M_IntegralModel : DLBaseModel

AS_FACTORY(M_IntegralModel);

AS_MODEL_STRONG(NSMutableArray, itemArray);


@end
