//
//  LL_CarHeadView.h
//  DHCarForSales
//
//  Created by leiyu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"
#import "M_MyOrderModel.h"

typedef void(^MyGoToSendPriceBlock)(id data);


@interface LL_CarHeadView : DLView

AS_BLOCK(MyGoToSendPriceBlock, myBlock);

AS_MODEL_STRONG(M_QuoteItemModel, myItemModel);

-(void)updateData:(M_QuoteItemModel*)data;
-(void)upDataCarName:(NSString *)carname  andCarDescription:(NSString *)carDescription andCarFirstPrice:(NSString *)carFirstPrice andCarColor:(NSString *)carColor  andCarLogImageName:(NSString *)carLogeImageName;
@end
