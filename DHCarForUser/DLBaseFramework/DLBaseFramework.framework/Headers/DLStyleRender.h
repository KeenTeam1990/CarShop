//
//  DLStyleRender.h
//  DLBase
//
//  Created by lucaslu on 15/12/16.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLModel.h"
#import "DLSingleton.h"

@class DLStyle;
@interface DLStyleRender : NSObject

AS_SINGLETON(DLStyleRender);

- (void) addNeedRenderStyle:(DLStyle*)style;

@end
