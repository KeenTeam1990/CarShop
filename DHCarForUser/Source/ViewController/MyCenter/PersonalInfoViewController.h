//
//  PersonalInfoViewController.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/10.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseViewController.h"
#import "DLTableViewController.h"
#import "M_UserInfoModel.h"

@protocol MyDelegate

-(void)successGoBackAndRefreshViewController;

@end

@interface PersonalInfoViewController : DLTableViewController<UIActionSheetDelegate>
@property(nonatomic,strong) M_UserInfoModel *infoModel;
AS_DELEGATE(id<MyDelegate>, mydelegate);
@end
