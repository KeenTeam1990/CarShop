//
//  M_RentalShaixuanView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/22.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"

typedef void (^TRentalShaixuanViewBlock)(NSInteger tag,id data);

@interface M_RentalShaixuanView : DLView

AS_FACTORY_FRAME(M_RentalShaixuanView);

AS_BLOCK(TRentalShaixuanViewBlock, block);

AS_MODEL_STRONG(NSString, leftText);
AS_MODEL_STRONG(NSString, rightText);

-(void)resetData;
-(void)updateBtnData;

@end
