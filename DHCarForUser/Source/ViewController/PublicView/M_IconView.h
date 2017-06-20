//
//  M_IconView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/18.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TIconViewBlock)(NSInteger tag);

@interface M_IconView : UIView

AS_FACTORY_FRAME(M_IconView);

AS_BLOCK(TIconViewBlock, block);

AS_BOOL(showNum);

-(void)updateModel:(NSString*)icon withText:(NSString*)text;

-(void)updateNum:(NSString*)num;

@end
