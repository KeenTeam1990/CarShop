//
//  LL_SystemMessageVIew.h
//  DHCarForUser
//
//  Created by leiyu on 15/12/24.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

//tat
//0 getdata
typedef void (^TSystemMessageViewBlock)(NSInteger tag,id data);

@interface LL_SystemMessageView : DLTableView

AS_FACTORY_FRAME(LL_SystemMessageView);

AS_BLOCK(TSystemMessageViewBlock, block);

AS_BOOL(isRefresh);
AS_BOOL(isLoading);

AS_MODEL_STRONG(DLPageModel, myPageModel);

-(void)resetGetData;

-(void)updateData:(NSMutableArray *)dataArr;

-(void)updateListState:(BOOL)success;

@end
