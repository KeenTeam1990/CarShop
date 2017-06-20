//
//  DLTableViewCell.h
//  TickTock
//
//  Created by 卢迎志 on 14-12-2.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLTableViewCell : UITableViewCell

- (BOOL)usesCustomSelectedBackgroundView;

+ (CGFloat)rowHeightOfDataObject:(id)data;
+ (CGFloat)rowHeightOfDataObject:(id)data tableView:(UITableView *)tableView;
+ (id)reusableCellOfTableView:(UITableView *)tableView;
+ (id)reusableCellOfTableView:(UITableView *)tableView userInfo:(NSDictionary *)userInfo;
+ (id)reusableCellOfTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;
+ (id)reusableCellOfTableView:(UITableView *)tableView style:(UITableViewCellStyle)style userInfo:(NSDictionary *)userInfo;
+ (id)reusableCellOfTableView:(UITableView *)tableView identifier:(NSString *)reuseIdentifier;
+ (id)reusableCellOfTableView:(UITableView *)tableView style:(UITableViewCellStyle)style identifier:(NSString *)reuseIdentifier;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier userInfo:(NSDictionary *)userInfo;



@end

@interface DLGroupedTableViewCell : DLTableViewCell
- (UIImage*)getBackgroundByStatus:(BOOL)isSelect;
@property (nonatomic,retain) UIImageView *accessoryCustomView;
@end

