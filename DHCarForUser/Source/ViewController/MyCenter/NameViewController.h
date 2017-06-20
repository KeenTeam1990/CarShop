//
//  NameViewController.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseViewController.h"
#import "DLTableViewController.h"
#import "M_UserInfoModel.h"

@protocol nameDelegate <NSObject>

-(void)UpdataNameSetName:(NSString *)name;

@end

@interface NameViewController :DLTableViewController

@property(nonatomic,assign)id<nameDelegate>delegate;

@property(nonatomic ,strong) M_UserInfoModel *model;

@end
