//
//  M_CarDistributorItemView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/3.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"
#import "M_DealerItemModel.h"

typedef void (^TCarDistributorItemViewBlock)();

@interface M_CarDistributorItemView : DLView

AS_FACTORY_FRAME(M_CarDistributorItemView);

AS_BLOCK(TCarDistributorItemViewBlock,block);

AS_BOOL(showLine);
AS_BOOL(showPrice);
AS_BOOL(showDistance);
AS_BOOL(showSelete);
AS_BOOL(showFirstSelete);

AS_SIZE(updateNameSize);

-(void)updateData:(M_DealerItemModel*)data;

@end
