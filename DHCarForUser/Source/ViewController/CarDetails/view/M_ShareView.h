//
//  M_ShareView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/28.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"

typedef void (^TShareViewBlock)(NSInteger tag);

@interface M_ShareView : DLView

AS_FACTORY_FRAME(M_ShareView);

AS_BLOCK(TShareViewBlock, block);

-(void)addIconItem:(NSString*)name withIcon:(NSString*)icon;

-(void)updateData;

@end
