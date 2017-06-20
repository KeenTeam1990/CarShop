//
//  M_DealerCarItemView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/10.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"
#import "AppPublicData.h"
#import "M_CarListModel.h"

@interface M_DealerCarItemView : DLView

AS_FACTORY_FRAME(M_DealerCarItemView);

AS_MODEL(TCarBottomType, carType);

-(void)updateData:(M_CarItemModel*)model;

@end
