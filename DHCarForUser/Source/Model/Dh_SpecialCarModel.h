//
//  Dh_SpecialCarModel.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/3.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface Dh_SpecialCarModel : DLBaseModel


AS_FACTORY(M_PhoneSendModel);

//AS_MODEL_STRONG(NSString, rentalImageViewStr);
//AS_MODEL_STRONG(NSString, discountStr);
//AS_MODEL_STRONG(NSString, carName);
//AS_MODEL_STRONG(NSString, originalPrice);

@property(nonatomic,retain) NSString *iconImageStr;
@property(nonatomic,retain) NSString *discountImageStr;
@property(nonatomic,retain) NSString *label1;
@property(nonatomic,retain) NSString *label2;
@property(nonatomic,retain) NSString *label3;
@property(nonatomic,retain) NSString *label4;
@property(nonatomic,retain) NSString *label5;

@property(nonatomic,retain) NSString *CarId;
@property(nonatomic,retain) NSString *dateStr;
@end
