//
//  LL_FeedBackCell.h
//  DHCarForUser
//
//  Created by leiyu on 15/12/27.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"

@interface LL_FeedBackCell : DLTableViewCell
-(void)upDataWithContent:(NSString *)contentText andType:(NSString *)typeMessage andTimeStr:(NSString *)myTimeStr andBoolTimeButtonShowOrNot:(BOOL)showOrNot andWithHeadImage:(NSString *)headImageUrl;
@end
