//
//  M_PhoneSendModel.h
//  Auction
//
//  Created by 卢迎志 on 15-3-2.
//
//

#import "DLBaseModel.h"

@interface M_PhoneSendModel : DLBaseModel

AS_FACTORY(M_PhoneSendModel);

AS_MODEL_STRONG(NSString, sms_Code);
AS_MODEL_STRONG(NSString, sms_State);

@end
