//
//  M_CarDetailHeaderView.h
//  DHCarForSales
//
//  Created by lucaslu on 15/11/1.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"
#import "M_CarListModel.h"
typedef void (^MyBlock)(NSInteger tag );
@interface M_CarDetailHeaderView : DLView

AS_FACTORY_FRAME(M_CarDetailHeaderView);
AS_BLOCK(MyBlock, myBlock);
-(void)updateData:(M_CarItemModel*)data;

@end
