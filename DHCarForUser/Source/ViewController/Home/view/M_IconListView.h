//
//  M_IconListView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/18.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"

typedef void (^TIconListViewBlock)(NSInteger tag,id data);

@interface M_IconListView : DLView

AS_FACTORY_FRAME(M_IconListView);

AS_BLOCK(TIconListViewBlock, block);

-(void)updateViewArray:(NSMutableArray*)data;

-(void)showAniw;

@end
