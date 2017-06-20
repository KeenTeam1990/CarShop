//
//  DHFindTableCell.h
//  DHCarForUser
//
//  Created by 张海亮 on 16/3/24.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHFindTableCell : UITableViewCell
@property (strong, nonatomic) UILabel *messageTitleLabel;
@property (strong, nonatomic) UILabel *messageReadLabel;
@property (strong, nonatomic) UIImageView *carImageView;
@property (strong, nonatomic) UILabel *messageReleaseTimeLabel;

@end
