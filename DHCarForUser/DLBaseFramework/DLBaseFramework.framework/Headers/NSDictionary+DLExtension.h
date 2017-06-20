//
//  NSDictionary+DLExtension.h
//  TickTock
//
//  Created by 卢迎志 on 14-12-1.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLFactory.h"

@interface NSDictionary(DLExtension) 

-(id)hasItemAndBack:(NSString*)key;

@end


@interface NSMutableDictionary(DLExtension)

AS_FACTORY(NSMutableDictionary);

-(id)hasItemAndBack:(NSString*)key;

@end
