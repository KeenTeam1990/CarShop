//
//  LL_BuyCarStyle.h
//  DHCarForUser
//
//  Created by leiyu on 16/4/1.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MyClickAction)(NSInteger tag);

@interface LL_BuyCarStyle : UIView
AS_BLOCK(MyClickAction, myAction);
-(void)upDataWithType:(NSString *)type;
@end


typedef void(^MyClickAction)(NSInteger tag);
@interface LL_ButtonView : UIView
AS_BLOCK(MyClickAction, myAction);
-(void)upButtonTitle:(NSString *)title;
@end