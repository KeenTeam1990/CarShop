//
//  M_DealerHomeTabView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"

typedef void (^TDealerHomeTabViewBlock)(NSInteger tag);

@interface M_DealerHomeTabItemModel : NSObject

AS_FACTORY(M_DealerHomeTabItemModel);

-(instancetype)initData:(NSString*)name withSelete:(BOOL)selete;

AS_MODEL_STRONG(NSString, myName);
AS_BOOL(isSelete);

@end

@interface M_DealerHomeTabView : DLView

AS_FACTORY_FRAME(M_DealerHomeTabView);

AS_BLOCK(TDealerHomeTabViewBlock, block);

-(void)addItem:(M_DealerHomeTabItemModel*)tabItem;

-(void)updateData;

@end
