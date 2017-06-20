//
//  M_CarDetailHeaderView1.h
//  DHCarForUser
//
//  Created by 陈斌 on 16/1/14.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLView.h"
#import "M_SpikeListModel.h"
@interface M_CarDetailHeaderView1 : DLView

AS_FACTORY_FRAME(M_CarDetailHeaderView1);

-(void)updateData:(M_SpikeItemModel*)data;
@end
