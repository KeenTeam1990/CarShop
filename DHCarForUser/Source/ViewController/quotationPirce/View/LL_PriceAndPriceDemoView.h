//
//  LL_PriceAndPriceDemoView.h
//  DHCarForSales
//
//  Created by leiyu on 15/12/23.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"

@interface LL_PriceAndPriceDemoView : DLView
-(void)updataWithPrice:(NSString *)price priceDemo:(NSString *)priceDemo andType:(BOOL)endPrice andWithGiftArr:(NSMutableArray *)arr;
@end
