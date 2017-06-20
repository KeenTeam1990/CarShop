//
//  M_CarDAndResFooterView.h
//  DHCarForUser
//
//  Created by lucaslu on 16/4/6.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLView.h"

#import "M_CarListModel.h"
#import "AppPublicData.h"
#import "M_DealerItemModel.h"

//tag
//4 city
//5 code
//8 surebtn
typedef void (^M_CarDAndResFooterViewBlock)(NSInteger tag,id data);

@interface M_CarDAndResFooterView : DLView

AS_FACTORY_FRAME(M_CarDAndResFooterView);

AS_BLOCK(M_CarDAndResFooterViewBlock, block);

-(void)updateData:(M_CarItemModel*)model withCarType:(TCarBottomType)type;

-(void)updateContent:(id)data withTag:(NSInteger)tag;

-(void)getCodeFinish;

@end
