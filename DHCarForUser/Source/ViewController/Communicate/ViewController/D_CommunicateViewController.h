//
//  D_CommunicateViewController.h
//  DHCarForSales
//
//  Created by leiyu on 15/11/3.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLInitCommentViewController.h"
@class M_MymessageListItemModel;

@protocol MyDelegate

-(void)successGoBackAndRefreshViewController;

@end

@interface D_CommunicateViewController : DLInitCommentViewController

@property(nonatomic,strong)M_MymessageListItemModel *m_MessageModel;

AS_DELEGATE(id<MyDelegate>, myDelegate);
AS_MODEL_STRONG(NSString, myTitle);
AS_MODEL_STRONG(NSString , myTargetUid);
AS_MODEL_STRONG(NSString, myQuotedId);
-(void)upDataMyTitle:(NSString *)myTitleaaaa;

@end
