//
//  M_SeleteLeaseView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/24.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"

typedef void (^TSeleteLeaseViewBlock)(id data);

@interface M_SeleteLeaseView : DLView

AS_FACTORY_FRAME(M_SeleteColorView);

AS_BLOCK(TSeleteLeaseViewBlock, block);

-(void)updateData:(NSMutableArray*)data;

-(void)showBack:(BOOL)show;

@end
