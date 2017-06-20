//
//  M_LoginView.h
//  DHCarForSales
//
//  Created by lucaslu on 15/10/31.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"

//tag
// 0 get code
// 1 login
typedef void (^TLoginViewBlock)(NSInteger tag,NSString* phone,NSString* code);

@interface M_LoginView : DLView<UITextFieldDelegate>

AS_FACTORY_FRAME(M_LoginView);

AS_BLOCK(TLoginViewBlock, block);

AS_BOOL(isLogin);

-(void)getCodeFinish;

@end
