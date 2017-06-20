//
//  LL_MessageView.h
//  DHCarForUser
//
//  Created by leiyu on 15/12/24.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

typedef void (^TMessageBaseViewBlock)(NSInteger tag,id data);

@interface LL_MessageView : DLTableView

AS_FACTORY_FRAME(LL_MessageView);

AS_BLOCK(TMessageBaseViewBlock, block);

-(void)updateData:(NSMutableArray *)dataArr;

@end
