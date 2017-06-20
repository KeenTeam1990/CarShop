//
//  M_Shaixuan3View.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/22.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableView.h"

typedef void (^TShaixuan3ViewBlock)(NSInteger tag,NSInteger topTag,id data);

@interface M_Shaixuan3View : DLTableView

AS_FACTORY_FRAME(M_Shaixuan3View);

AS_BLOCK(TShaixuan3ViewBlock, block);

AS_INT(topTag);

-(void)updateShowFrame:(CGRect)frame;

-(void)updateData:(NSMutableArray*)data;

@end
