//
//  D_LLDetailOrderHeadView.h
//  DHCarForSales
//
//  Created by leiyu on 15/11/15.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"
#import "M_MyOrderModel.h"

typedef void (^TDetailOrderHeadViewBlock)(NSInteger tag,id data);

@interface D_LLDetailOrderHeadView : DLView

AS_BLOCK(TDetailOrderHeadViewBlock, block);

AS_FACTORY(D_LLDetailOrderHeadView)

-(void)updataData:(M_MyOrderTtemModel*)data;

@end
