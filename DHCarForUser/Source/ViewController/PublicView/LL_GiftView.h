//
//  LL_GiftVieww.h
//  DHCarForSales
//
//  Created by leiyu on 16/1/12.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLView.h"
#import "M_MyOrderModel.h"

typedef void (^MyClickAction)(M_QuoteComboItemModel *model);

@interface LL_GiftView : DLView

AS_BLOCK(MyClickAction, myClickAction);

-(void)upDataWithDataArray:(NSArray *)arr;

@end
