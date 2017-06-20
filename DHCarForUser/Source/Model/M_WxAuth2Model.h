//
//  M_WxAuth2Model.h
//  DHCarForUser
//
//  Created by lucaslu on 16/1/10.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface M_WbAuth2Model : NSObject

AS_FACTORY(M_WbAuth2Model);

AS_MODEL_STRONG(NSString, access_token);
AS_MODEL_STRONG(NSString, refresh_token);
AS_MODEL_STRONG(NSString, currentUserID);

@end


@interface M_WxAuth2Model : NSObject

AS_FACTORY(M_WxAuth2Model);

AS_MODEL_STRONG(NSString, access_token);
AS_MODEL_STRONG(NSString, refresh_token);
AS_MODEL_STRONG(NSString, unionid);
AS_MODEL_STRONG(NSString, openid);

@end
