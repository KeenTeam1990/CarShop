//
//  M_ShaixuanBrandView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/22.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"
#import "M_SeriesListModel.h"

typedef void (^TShaixuanBrandViewBlock)(NSInteger tag,id data);

@interface M_ShaixuanBrandView : DLView

AS_FACTORY_FRAME(M_ShaixuanBrandView);

AS_BLOCK(TShaixuanBrandViewBlock, block);

AS_MODEL_STRONG(NSString, myBid);
AS_MODEL_STRONG(NSString, mySid);

-(void)updateTableFrame:(CGRect)frame;

-(void)upDateData:(M_SeriesListModel*)data;

@end
