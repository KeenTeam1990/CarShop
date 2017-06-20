//
//  M_SearchView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"

typedef void (^TSearchViewBlock)(NSString* keyword);

@interface M_SearchView : DLView<UITextFieldDelegate>

AS_FACTORY_FRAME(M_SearchView);

AS_BLOCK(TSearchViewBlock, block);

AS_MODEL_STRONG(NSString, keyword);

@end
