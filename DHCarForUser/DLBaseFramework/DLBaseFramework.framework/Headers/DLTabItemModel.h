//
//  DLTabItemModel.h
//  TickTock
//
//  Created by 卢迎志 on 14-11-26.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DLModel.h"
#import "DLFactory.h"

@interface DLTabItemModel : NSObject

AS_FACTORY(DLTabItemModel);

AS_MODEL_STRONG(NSString, tabIcon);
AS_MODEL_STRONG(NSString, tabIcon_H);

AS_MODEL_STRONG(NSString, tabItem);
AS_MODEL_STRONG(UIColor, tabItemColor);
AS_MODEL_STRONG(UIColor, tabItemColor_H);

-(id)initWithIcon:(NSString*)icon
       withIcon_H:(NSString*)icon_h
         withItem:(NSString*)item
    withItemColor:(UIColor*)itemColor
  withItemColor_H:(UIColor*)itemColor_h;

@end
