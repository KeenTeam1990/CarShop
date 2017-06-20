//
//  M_CarItemView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"
#import "M_CarListModel.h"
#import "AppPublicData.h"

@interface M_CarItemView : DLView

AS_FACTORY_FRAME(M_CarItemView);

AS_BOOL(showLine);

-(void)updateData:(M_CarItemModel*)model;

@end
