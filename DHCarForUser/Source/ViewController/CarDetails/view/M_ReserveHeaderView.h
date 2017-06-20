//
//  M_ReserveHeaderView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"
#import "M_CarListModel.h"
#import "AppPublicData.h"
#import "M_DealerItemModel.h"

//tag
//7 pocily
typedef void (^TReserveHeaderViewBlock)(NSInteger tag,id data);

@interface M_ReserveHeaderView : DLView

AS_FACTORY_FRAME(M_ReserveHeaderView);

AS_BLOCK(TReserveHeaderViewBlock, block);

-(void)updateData:(M_CarItemModel*)model withCarType:(TCarBottomType)type;

-(void)updateContent:(id)data withTag:(NSInteger)tag;

@end
