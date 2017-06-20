//
//  M_SeleteColorView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/24.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"

typedef void (^TSeleteColorViewBlock)(id data);

@interface M_SeleteColorView : DLView

AS_FACTORY_FRAME(M_SeleteColorView);

AS_BLOCK(TSeleteColorViewBlock, block);

-(void)updateData:(NSMutableArray*)data;

-(void)showBack:(BOOL)show;

@end
