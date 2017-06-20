//
//  DLTableViewCell.m
//  TickTock
//
//  Created by 卢迎志 on 14-12-2.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import "DLTableViewCell.h"

@implementation DLTableViewCell


+ (CGFloat)rowHeightOfDataObject:(id)data
{
	return 44.0;
}

- (BOOL)usesCustomSelectedBackgroundView
{
    return YES;
}

+ (CGFloat)rowHeightOfDataObject:(id)data tableView:(UITableView *)tableView
{
    
	return 44.0;
}

+ (id)reusableCellOfTableView:(UITableView *)tableView
{
	return [self reusableCellOfTableView:tableView style:UITableViewCellStyleDefault identifier:nil];
}

+ (id)reusableCellOfTableView:(UITableView *)tableView userInfo:(NSDictionary *)userInfo
{
    return [self reusableCellOfTableView:tableView style:UITableViewCellStyleDefault identifier:nil userInfo:userInfo];
}

+ (id)reusableCellOfTableView:(UITableView *)tableView style:(UITableViewCellStyle)style
{
	return [self reusableCellOfTableView:tableView style:style identifier:nil];
}

+ (id)reusableCellOfTableView:(UITableView *)tableView style:(UITableViewCellStyle)style userInfo:(NSDictionary *)userInfo
{
    return [self reusableCellOfTableView:tableView style:style identifier:nil userInfo:userInfo];
}

+ (id)reusableCellOfTableView:(UITableView *)tableView identifier:(NSString *)reuseIdentifier
{
	return [self reusableCellOfTableView:tableView style:UITableViewCellStyleDefault identifier:reuseIdentifier];
}

+ (id)reusableCellOfTableView:(UITableView *)tableView style:(UITableViewCellStyle)style identifier:(NSString *)reuseIdentifier
{
    return [self reusableCellOfTableView:tableView style:style identifier:reuseIdentifier userInfo:nil];
}

+ (id)reusableCellOfTableView:(UITableView *)tableView style:(UITableViewCellStyle)style identifier:(NSString *)reuseIdentifier userInfo:(NSDictionary *)userInfo
{
	if (!reuseIdentifier)
	{
		reuseIdentifier = NSStringFromClass(self);
	}
	
	DLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
	if (!cell)
	{
		cell = [[self alloc] initWithStyle:style reuseIdentifier:reuseIdentifier userInfo:userInfo];
	}
	
	return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier userInfo:(NSDictionary *)userInfo
{
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier];
}

@end

@implementation DLGroupedTableViewCell
{
    UIImageView *backgroundBubbleView_;
    UIImageView *backgroundBubbleSelectedView_;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
	{
		backgroundBubbleView_ = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        backgroundBubbleSelectedView_ = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.backgroundView = backgroundBubbleView_;
        self.selectedBackgroundView = backgroundBubbleSelectedView_;
        self.accessoryCustomView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow.png"]];
        [self.contentView addSubview:self.accessoryCustomView];
        self.accessoryCustomView.hidden = YES;
        
    }
	
    return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
    backgroundBubbleView_.image = [self getBackgroundByStatus:NO];
    CGFloat rightMargin = self.bounds.size.width - (self.contentView.frame.origin.x + self.contentView.frame.size.width);
    CGSize accessorySize = self.accessoryCustomView.image.size;
    self.accessoryCustomView.frame = CGRectMake(self.contentView.bounds.size.width - (25.0 - rightMargin) - accessorySize.width, (self.contentView.bounds.size.height - accessorySize.height)/2.0, accessorySize.width, accessorySize.height);
}


- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated
{
    
    backgroundBubbleSelectedView_.image = [self getBackgroundByStatus:selected];
    
    [super setSelected:selected animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
    
    backgroundBubbleSelectedView_.image = [self getBackgroundByStatus:highlighted];
    
    [super setHighlighted:highlighted animated:animated];
}

- (BOOL)usesCustomSelectedBackgroundView
{
    return NO;
}

- (UIImage*)getBackgroundByStatus:(BOOL)isSelect
{
    UITableView *tableview = (UITableView*)self.superview;
    if (![tableview isKindOfClass:[UITableView class]])
    {
        tableview = (UITableView*)self.superview.superview;
        
    }
    NSIndexPath *indexPath = [tableview indexPathForCell:self];
    NSInteger sectionItemCount = [tableview.dataSource tableView:tableview numberOfRowsInSection:indexPath.section];
    //    NSLog(@"%d,section = %d",indexPath.row,indexPath.section);
    BOOL isLastItem = (indexPath.row == sectionItemCount - 1);
    BOOL isfirstitem = (indexPath.row == 0);
    NSString *imageName = nil;
    if (isLastItem)
    {
        imageName = @"common_card_bottom_background.png";
    }
    else if(isfirstitem)
    {
        imageName = @"common_card_top_background.png";
    }
    else if(!isLastItem && !isfirstitem)
    {
        imageName = @"common_card_middle_background.png";
    }
    else if(indexPath.section == 2)
    {
        imageName = nil;
    }
    return [[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:15 topCapHeight:22];
}
@end
