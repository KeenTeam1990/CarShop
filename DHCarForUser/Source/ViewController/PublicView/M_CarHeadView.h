//
//  LL_CarHeadView.h
//  DHCarForSales
//
//  Created by leiyu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"
//#import "LL_TestCommunicatHeadViewModel.h"

typedef void(^MyGoToSendPriceBlock)();
@class M_CarItemDetailInfoModel;

@interface M_CarHeadView : DLView

@property(nonatomic,strong)M_CarItemDetailInfoModel *carItemDetailModel;

AS_BLOCK(MyGoToSendPriceBlock, myBlock);

-(void)upDataCarName:(NSString *)carname  andCarDescription:(NSString *)carDescription andCarFirstPrice:(NSString *)carFirstPrice andCarColor:(NSString *)carColor  andCarLogImageName:(NSString *)carLogeImageName andWithHeadViewType:(MyCarHeadViewType )type;
@end
