//
//  M_CarRemoteHeaderView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"

//tag
//0 提交
//1 选择
typedef void (^TCarRemoteHeaderBlock)(NSInteger tag,id data);

@interface M_CarRemoteHeaderView : DLView

AS_FACTORY_FRAME(M_CarRemoteHeaderView);

AS_BLOCK(TCarRemoteHeaderBlock, block);

-(void)updateData:(NSString*)data withTag:(NSInteger)tag;

@end
