//
//  M_ShaixuanTableView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableView.h"

typedef void (^TShaixuanTableViewBlock)(NSInteger tabIndex,id data);

@interface M_ShaixuanTableView : DLTableView

AS_FACTORY_FRAME(M_ShaixuanTableView);

AS_BLOCK(TShaixuanTableViewBlock, block);

-(void)updateData:(NSMutableArray*)data withType:(NSInteger)showTab;

@end
