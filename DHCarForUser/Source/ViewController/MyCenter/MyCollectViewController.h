//
//  MyCollectViewController.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/10.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseViewController.h"
#import "DLTableViewController.h"
#import "M_MyCollectCell.h"

@interface MyCollectViewController : DLTableViewController

@property(nonatomic,strong) NSString *typeStr;
@property(nonatomic,strong) NSMutableArray *dataArray;

@end
