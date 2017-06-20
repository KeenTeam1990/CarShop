//
//  M_CarDetailTabView.h
//  DHCarForSales
//
//  Created by lucaslu on 15/11/1.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"
#import "M_CarDetailTabItemModel.h"

typedef void (^TCarDetailTabViewBlock)(NSInteger tabIndex);

@interface M_CarDetailTabView : DLView

AS_FACTORY_FRAME(M_CarDetailTabView);

AS_BLOCK(TCarDetailTabViewBlock, block);

-(void)addTabItem:(M_CarDetailTabItemModel*)tabModel;

-(void)defaultShow;

-(void)updateData;

-(NSInteger)count;

@end
