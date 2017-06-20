//
//  LL_MyHeadViewAndNameAndCellPhoneView.h
//  DHCarForSales
//
//  Created by leiyu on 15/12/21.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"

//#import "LL_TestUsreInfoModel.h"
@interface LL_MyHeadViewAndNameAndCellPhoneView : DLView


-(void)upDataUserHeaderUrl:(NSString *)headUrl
               andUserName:(NSString *)userName
              andCellPhone:(NSString *)userCellphone
                   andDate:(NSString *)date
               andWithType:(MyUserNameAndPhoneType )type;
@end
