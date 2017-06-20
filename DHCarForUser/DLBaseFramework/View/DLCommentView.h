//
//  DLCommentView.h
//  Auction
//
//  Created by 卢迎志 on 14-12-16.
//
//

#import <UIKit/UIKit.h>
#import "DLView.h"

@protocol DLCommentViewDelegate <NSObject>

-(void)seleteFaceItem:(id)sender;

-(void)showAttachment:(id)sender withType:(NSInteger)type;

-(void)send:(NSString*)text;

-(void)addImageBtnPressed:(id)sender;

@end


@interface DLCommentView : DLView<UITextFieldDelegate>

AS_FACTORY_FRAME(DLCommentView);

AS_DELEGATE(id<DLCommentViewDelegate>, delegate);

AS_MODEL_STRONG(UIImageView, myBackView);
AS_MODEL_STRONG(UIButton, myVoiceIconBtn);
AS_MODEL_STRONG(UIButton, myFaceIconBtn);
AS_MODEL_STRONG(UIButton, myAttachmentIconBtn);
AS_MODEL_STRONG(UITextField, myTextField);
AS_MODEL_STRONG(UIImageView, myTextFieldBackView);
AS_MODEL_STRONG(UIButton, mySendBtn);

AS_MODEL_STRONG(UIButton, addImageBtn);
AS_MODEL_STRONG(UIImageView, myImageView);

AS_BOOL(showAddImage);
AS_BOOL(showVoice);
AS_BOOL(showFace);
AS_BOOL(showAttachment);
AS_BOOL(showSendBtn);

@end
