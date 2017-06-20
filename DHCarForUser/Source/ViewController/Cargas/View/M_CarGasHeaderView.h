//
//  M_CarGasHeaderView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"

typedef void (^TCarGasHeaderViewBlock)();

@interface M_CarGasHeaderView : DLView

AS_FACTORY_FRAME(M_CarGasHeaderView);

AS_BLOCK(TCarGasHeaderViewBlock, block);

-(void)updateData;

@end
