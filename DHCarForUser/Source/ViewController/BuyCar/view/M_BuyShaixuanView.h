//
//  M_BuyShaixuanView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/22.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"

typedef void (^TBuyShaixuanViewBlock)(NSInteger tag,id data);

@interface M_BuyShaixuanView : DLView

AS_FACTORY_FRAME(M_BuyShaixuanView);

AS_BLOCK(TBuyShaixuanViewBlock, block);

AS_MODEL_STRONG(NSString, leftText);
AS_MODEL_STRONG(NSString, centerText);
AS_MODEL_STRONG(NSString, rightText);

-(void)resetData;
-(void)updateBtnData;

@end
