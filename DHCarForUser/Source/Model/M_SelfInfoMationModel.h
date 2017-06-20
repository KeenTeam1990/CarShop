//
//  M_SelfInfoMationModel.h
//  DHCarForSales
//
//  Created by leiyu on 15/11/5.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"
@class M_UserModel;
typedef void (^arrowBlockAction)();

@interface M_SelfInfoMationModel : DLBaseModel
AS_MODEL_STRONG(NSString,M_SelfInfoAttribute);
AS_MODEL_STRONG(NSString, M_SelfInfoAttributeValue);
AS_BLOCK(arrowBlockAction, M_arrBlockAction);
@end
