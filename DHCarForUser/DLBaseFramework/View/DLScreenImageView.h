//
//  DLScreenImageView.h
//  Auction
//
//  Created by 卢迎志 on 15-1-6.
//
//

#import "DLView.h"

@protocol DLScreenImageViewDelegate <NSObject>

-(void)delBtnPressed:(id)sender;

-(void)closeView;

@end

@interface DLScreenImageView : DLView

AS_FACTORY_FRAME(DLScreenImageView);

AS_DELEGATE(id<DLScreenImageViewDelegate>, delegate);

AS_MODEL_STRONG(UIImageView, myImageView);

AS_MODEL_STRONG(UIButton, myDelBtn);

AS_BOOL(showDelBtn);

-(void)updateImage:(UIImage*)image;

@end
