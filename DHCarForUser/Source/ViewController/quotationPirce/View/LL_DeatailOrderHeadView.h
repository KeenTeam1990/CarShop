//
//  LL_DeatailOrderHeadView.h
//  DHCarForSales
//
//  Created by leiyu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"

@class M_QuoteItemModel;

typedef void (^TDeatailOrderHeadViewBlock)(NSInteger tag,id data);

@interface LL_DeatailOrderHeadView : DLView

@property(nonatomic,strong)M_QuoteItemModel *model;

AS_BLOCK(TDeatailOrderHeadViewBlock, block);

-(void)upDateWithMyOrdelDeatailModel:(M_QuoteItemModel *)model;

@end
