//
//  M_CarDetailTabItemModel.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/3.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface M_CarDetailTabItemModel : NSObject

AS_FACTORY(M_CarDetailTabItemModel);

AS_MODEL_STRONG(NSString, myName);
AS_BOOL(isSelete);

@end
