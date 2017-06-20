//
//  M_PayHeaderView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/16.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"
#import "M_CarListModel.h"

@interface M_PayHeaderView : DLView

AS_FACTORY_FRAME(M_PayHeaderView);

-(void)updateData:(NSString*)orderId withPrice:(NSString*)price withModel:(M_CarItemModel*)model;

@end
