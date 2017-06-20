//
//  M_NameView.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"
#import "M_UserInfoModel.h"
#import "CB_Button.h"

typedef void (^NameViewBlock)(NSString* phone);

@interface M_NameView : DLView<UITextFieldDelegate>


@property(nonatomic ,strong) M_UserInfoModel *model;
@property(nonatomic ,strong) UITextField *nameTF;
@property(nonatomic ,strong) CB_Button *cb_Btn;

AS_BLOCK(NameViewBlock, block);

@end
