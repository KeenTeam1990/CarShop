//
//  D_ShaixuanViewController.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseViewController.h"

typedef void (^TShaixuanControllerBlock)(NSMutableDictionary* dataDic);

@interface D_ShaixuanViewController : DLBaseViewController

AS_FACTORY(D_ShaixuanViewController);

AS_BLOCK(TShaixuanControllerBlock, block);

-(void)updateDic:(NSMutableDictionary*)dataDic;

@end
