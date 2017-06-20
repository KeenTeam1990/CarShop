//
//  DLInitCommentViewController.h
//  Auction
//
//  Created by 卢迎志 on 14-12-16.
//
//

#import "DLTableViewController.h"
#import "DLCommentView.h"

@interface DLInitCommentViewController : DLTableViewController<DLCommentViewDelegate>

AS_MODEL_STRONG(DLCommentView, commentView);
AS_MODEL_STRONG(UIButton, touchBtn);

@end
