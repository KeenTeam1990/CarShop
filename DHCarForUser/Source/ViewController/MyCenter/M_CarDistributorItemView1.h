//
//  M_CarDistributorItemView1.h
//  DHCarForUser
//
//  Created by 陈斌 on 16/1/2.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLView.h"
#import "M_DealerItemModel.h"

typedef void (^TCarDistributorItemView1Block)();


@interface M_CarDistributorItemView1 : DLView

AS_FACTORY_FRAME(M_CarDistributorItemView1);

AS_BLOCK(TCarDistributorItemView1Block,block);

AS_BOOL(showLine);
AS_BOOL(showPrice);
AS_BOOL(showDistance);
AS_BOOL(showSelete);
AS_BOOL(showCellPhone);

-(void)updateData:(M_DealerItemModel*)data;
@end
