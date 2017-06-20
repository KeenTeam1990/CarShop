//
//  M_ShaixuanLeftView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"

typedef void (^TShaixuanLeftViewBlock)(NSInteger tag);

@interface M_ShaixuanLeftView : DLTableView

AS_FACTORY_FRAME(M_ShaixuanLeftView);

AS_BLOCK(TShaixuanLeftViewBlock, block);

-(void)updateData:(NSMutableArray*)array;

-(void)updateTabIndex:(NSInteger)tabIndex;

@end
