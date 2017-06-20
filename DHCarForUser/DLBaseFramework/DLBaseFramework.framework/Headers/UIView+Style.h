//
//  UIView+Style.h
//  DLBase
//
//  Created by lucaslu on 15/12/17.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLViewStyle.h"

#import <UIKit/UIKit.h>
#import "DLViewStyle.h"
#import "DLButtonStyle.h"
#import "DLLabelStyle.h"
#import "DLButtonStyle.h"
#import "DLPageControlStyle.h"
#import "DLTextFieldStyle.h"
#import "DLTextViewStyle.h"
#import "DLSwitchStyle.h"
#import "DLSegementStyle.h"

@interface UIView (Style)
- (void) registreStyleClass:(Class)cla;
@property (nonatomic, copy) DLViewStyle* style;
@end

@interface UIButton (Style)
@property (nonatomic, copy) DLButtonStyle* style;
@end

@interface UILabel (Style)
@property (nonatomic, copy) DLLabelStyle* style;
@end

@interface UISegmentedControl (Style)
@property (nonatomic, copy) DLSegementStyle* style;
@end

@interface UITextField (Style)
@property (nonatomic, copy) DLTextFieldStyle* style;
@end

@interface UITextView (Style)
@property (nonatomic, copy) DLTextViewStyle* style;
@end

@interface UISwitch (Style)
@property (nonatomic, copy) DLSwitchStyle* style;
@end

@interface UIPageControl (Style)
@property (nonatomic, copy) DLPageControlStyle* style;
@end
