//
//  DLTableDataSource.h
//  TickTock
//
//  Created by 卢迎志 on 14-12-2.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DLTableViewCellConfigureBlock)(id cell, id item);

@interface DLTableDataSource : NSObject<UITableViewDataSource>

AS_MODEL_STRONG(NSString, cellIdentifier);
AS_MODEL_STRONG(NSArray, items);
AS_BLOCK(DLTableViewCellConfigureBlock,configureCellBlock);

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(DLTableViewCellConfigureBlock)aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
