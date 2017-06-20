//
//  LL_SendFirstAndSecondBaojiaView.h
//  DHCarForSales
//
//  Created by leiyu on 15/12/20.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "M_CarMessageDetailModel.h"

typedef void(^lookDetailBlock)();

@interface LL_SendFirstAndSecondBaojiaView : UIView

AS_MODEL_STRONG(M_MyMessageItemModel, myModel);

AS_BLOCK(lookDetailBlock, myLookDetailBlock);

-(instancetype)initWithFrame:(CGRect)frame;

-(void)updataModel:(M_MyMessageItemModel *)model;

@end
