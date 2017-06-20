//
//  RentalCarView.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/7.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"
#import "M_CarListModel.h"

@interface RentalCarView : DLView

AS_FACTORY_FRAME(RentalCarView);

-(void)updateData:(M_CarItemModel*)model;

@end
