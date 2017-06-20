//
//  D_InquiryFinishViewController.h
//  DHCarForUser
//
//  Created by lucaslu on 16/1/15.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLBaseViewController.h"
#import "M_CarListModel.h"

@interface D_InquiryFinishViewController : DLBaseViewController

AS_FACTORY(D_InquiryFinishViewController);

AS_MODEL_STRONG(M_CarItemModel, myCarModel);

AS_BOOL(showPay);

AS_MODEL_STRONG(NSString, orderId);

@end
