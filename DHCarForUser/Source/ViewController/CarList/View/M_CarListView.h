//
//  M_CarListView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableView.h"
#import "AppPublicData.h"
#import "DLPageModel.h"
//tag
//0 getdata
typedef void (^TCarListViewBlock)(NSInteger tag);

@interface M_CarListView : DLTableView

AS_FACTORY_FRAME(M_CarListView);

AS_BLOCK(TCarItemViewBlock, block);
AS_BLOCK(TCarListViewBlock, getDataBlock);

AS_MODEL(TCarBottomType, carType);

AS_MODEL_STRONG(DLPageModel, myPageModel);

-(void)getData;

-(void)updateData:(NSMutableArray*)data;

-(void)updateListState:(BOOL)success;

@end
