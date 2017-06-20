//
//  M_CarInsuranceHeaderView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"

//tag
//0 提交
//1 选择
typedef void (^TCarInsuranceHeaderBlock)(NSInteger tag,id data);

@interface M_CarInsuranceHeaderView : DLView<UITextFieldDelegate>

AS_FACTORY_FRAME(M_CarInsuranceHeaderView);

AS_BLOCK(TCarInsuranceHeaderBlock, block);

-(void)updateData:(NSString*)data;

@end
