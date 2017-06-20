//
//  DH_DealerMessageView.h
//  DHCarForUser
//
//  Created by 张海亮 on 16/4/4.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLTableView.h"

typedef void (^deaerMessageViewBlock)(NSInteger tag,id data);

@interface DH_DealerMessageView : DLTableView

AS_FACTORY_FRAME(DH_DealerMessageView);

AS_BLOCK(deaerMessageViewBlock, block);
AS_MODEL_STRONG(DLPageModel, myPageModel);

-(void)updateData:(NSArray *)dataArr;
-(void)updateListState:(BOOL)success;

@end
