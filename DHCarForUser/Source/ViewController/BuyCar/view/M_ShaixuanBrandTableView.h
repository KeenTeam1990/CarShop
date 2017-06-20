//
//  M_ShaixuanBrandTableView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/22.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableView.h"

typedef void (^TShaixuanBrandTableViewBlock)(NSInteger tabIndex,id data);

@interface M_ShaixuanBrandTableView : DLTableView

AS_FACTORY_FRAME(M_ShaixuanBrandTableView);

AS_BLOCK(TShaixuanBrandTableViewBlock, block);

-(void)updateData:(NSMutableArray*)data withType:(NSInteger)showTab;


@end
