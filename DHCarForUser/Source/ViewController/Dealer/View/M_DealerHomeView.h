//
//  M_DealerHomeView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableView.h"
#import "M_CarListModel.h"
#import "M_CarListView.h"

typedef void (^TDealerHomeViewBlock)(M_CarItemModel* model);

@interface M_DealerHomeView : DLTableView

AS_FACTORY_FRAME(M_DealerHomeView);

AS_BLOCK(TDealerHomeViewBlock, block);
AS_BLOCK(TCarListViewBlock, getDataBlock);

AS_MODEL_STRONG(DLPageModel, myPageModel);

AS_MODEL(TCarBottomType, carType);

-(void)getData;

-(void)updateData:(NSMutableArray*)data;

-(void)updateListState:(BOOL)success;

@end
