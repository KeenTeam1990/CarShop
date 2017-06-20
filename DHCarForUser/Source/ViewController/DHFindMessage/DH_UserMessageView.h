//
//  DH_UserMessageView.h
//  DHCarForUser
//
//  Created by 张海亮 on 16/4/4.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLTableView.h"

typedef void (^userMessageViewBlock)(NSInteger tag,id data);


@interface DH_UserMessageView : DLTableView

AS_FACTORY_FRAME(DH_UserMessageView);

AS_BLOCK(userMessageViewBlock, block);
AS_MODEL_STRONG(DLPageModel, myPageModel);

-(void)updateListState:(BOOL)success;
-(void)updateData:(NSArray *)dataArr;

@end
