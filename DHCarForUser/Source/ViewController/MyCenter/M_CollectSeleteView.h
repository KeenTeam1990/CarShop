//
//  M_CollectSeleteView.h
//  DHCarForUser
//
//  Created by lucaslu on 16/4/3.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLView.h"
#import "M_CarListModel.h"

typedef void (^TCollectSeleteViewBlock)(NSString *carTypeStr,id data);

@interface M_CollectSeleteView : DLView

AS_FACTORY_FRAME(M_CollectSeleteView);

AS_BLOCK(TCollectSeleteViewBlock, block);

AS_BOOL(showNew);
AS_BOOL(showRental);
AS_BOOL(showSpecia);

AS_MODEL_STRONG(M_CarItemModel, myModel);

-(void)showDialog:(M_CarItemModel*)model;


@end
