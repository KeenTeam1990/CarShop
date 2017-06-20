//
//  M_OrderAddModel.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/15.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_OrderAddModel : DLBaseModel

AS_FACTORY(M_OrderAddModel);

AS_MODEL_STRONG(NSString, order_num);
AS_MODEL_STRONG(NSString, order_id);
AS_MODEL_STRONG(NSString, order_price);

-(void)parseGasData:(NSString*)data;

@end
