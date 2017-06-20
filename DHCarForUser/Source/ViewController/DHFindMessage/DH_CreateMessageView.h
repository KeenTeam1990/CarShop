//
//  DH_CreateMessageView.h
//  DHCarForUser
//
//  Created by 张海亮 on 16/4/4.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLTableView.h"

typedef void (^createMessageViewBlock)(NSInteger tag,id data);


@interface DH_CreateMessageView : DLTableView

AS_FACTORY_FRAME(DH_CreateMessageView);

AS_BLOCK(createMessageViewBlock, block);
AS_MODEL_STRONG(DLPageModel, myPageModel);
-(void)updateListState:(BOOL)success;

-(void)updateData:(NSArray *)dataArr;

@end
