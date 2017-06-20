//
//  M_ReserveFooterView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/16.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"

#import "M_CarListModel.h"
#import "AppPublicData.h"
#import "M_DealerItemModel.h"

//tag
//4 city
//5 code
//8 surebtn
typedef void (^TReserveFooterViewBlock)(NSInteger tag,id data);

@interface M_ReserveFooterView : DLView

AS_FACTORY_FRAME(M_ReserveFooterView);

AS_BLOCK(TReserveFooterViewBlock, block);

-(void)updateData:(M_CarItemModel*)model withCarType:(TCarBottomType)type;

-(void)updateContent:(id)data withTag:(NSInteger)tag;

-(void)getCodeFinish;

@end
