//
//  M_CarImagesView.h
//  DHCarForSales
//
//  Created by lucaslu on 15/11/1.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"

typedef void (^TCarImagesViewBlock)(NSInteger imageIndex);

@interface M_CarImagesView : DLView

AS_FACTORY_FRAME(M_CarImagesView);

AS_BLOCK(TCarImagesViewBlock, block);

-(void)upDateData:(NSMutableArray*)data;

@end
