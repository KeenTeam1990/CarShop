//
//  M_MessageMode.h
//  DHCarForSales
//
//  Created by leiyu on 15/11/2.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_MessageMode : DLBaseModel
AS_MODEL_STRONG(NSString ,custom_Id);
AS_MODEL_STRONG(NSString , custom_Name);
AS_MODEL_STRONG(NSString , custom_headImageUrl);
AS_MODEL_STRONG(NSString, message_Date);
AS_MODEL_STRONG(NSString, message_Text);
AS_MODEL_STRONG(NSString, message_Budg);
AS_MODEL_STRONG(NSString, message_CustomerId);
AS_MODEL_STRONG(NSString, custom_CellphoneNumber);
AS_MODEL_STRONG(NSString, message_CustomerWant);

@end
