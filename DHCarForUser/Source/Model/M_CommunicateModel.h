//
//  M_CommunicateModel.h
//  DHCarForSales
//
//  Created by leiyu on 15/11/3.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_CommunicateModel : DLBaseModel
AS_MODEL_STRONG(NSString, memessagePosterId);
AS_MODEL_STRONG(NSString, messagePosterHeadImageView);
AS_MODEL_STRONG(NSString, messageText);
AS_MODEL_STRONG(NSDate, messageDate);
AS_MODEL(BOOL , timeButtonShowOrNot);
@end
