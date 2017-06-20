//
//  H_HomeItemView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/24.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"
#import "M_IndexModel.h"

@interface H_HomeItemView : DLView

AS_FACTORY_FRAME(H_HomeItemView);

-(void)updateData:(M_IndexLineItemModel*)data;

@end
