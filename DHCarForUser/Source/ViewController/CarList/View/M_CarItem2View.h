//
//  M_CarItem2View.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/20.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"
#import "AppPublicData.h"
#import "M_CarListModel.h"

@interface M_CarItem2View : DLView

AS_FACTORY_FRAME(M_CarItem2View);

AS_MODEL(TCarBottomType, carType);

AS_BOOL(showIcon);

-(void)updateData:(M_CarItemModel*)model;


@end
