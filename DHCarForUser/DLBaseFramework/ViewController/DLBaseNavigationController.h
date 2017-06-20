//
//  DLBaseNavigationController.h
//  TickTock
//
//  Created by 卢迎志 on 14-11-26.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLBaseNavigationController : UINavigationController<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIGestureRecognizerDelegate>

AS_MODEL_STRONG(UIViewController,currentShowVC);

+(instancetype)sharedInstanceRoot:(UIViewController*)controller;

@end
