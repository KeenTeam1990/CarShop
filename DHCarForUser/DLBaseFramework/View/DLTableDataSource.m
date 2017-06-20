//
//  DLTableDataSource.m
//  TickTock
//
//  Created by 卢迎志 on 14-12-2.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import "DLTableDataSource.h"

@implementation DLTableDataSource

DEF_MODEL(items);
DEF_MODEL(cellIdentifier);
DEF_MODEL(configureCellBlock);

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(DLTableViewCellConfigureBlock)aConfigureCellBlock
{
    self = [super init];
    if (self) {
        self.items = anItems;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = [aConfigureCellBlock copy];
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
     return self.items[(NSUInteger) indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                            forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    
    /**
     之所以把configureCellBlock作为一个属性，是为了该类可以被复用
     只要TableViewController定制了对应的代码块并作为参数传入就可以了
     
     复用的关键：不要被具体的实现代码入侵，只需要调用接口和给出接口就可以了
     */
    self.configureCellBlock(cell, item);
    
    return cell;
}


@end
