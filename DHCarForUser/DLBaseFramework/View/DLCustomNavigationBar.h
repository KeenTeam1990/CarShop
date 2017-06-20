//
//  DLCustomNavigationBar.h
//  TickTock
//
//  Created by 卢迎志 on 14-11-27.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DLCustomNavigationBarDelegate <NSObject>

@optional
-(void)leftBtnPressed:(id)sender;
-(void)rightBtnPressed:(id)sender;

@end

@interface DLCustomNavigationBar : UIView

AS_DELEGATE(id<DLCustomNavigationBarDelegate>, delegate);

AS_MODEL_STRONG(UIButton, leftBtn);
AS_MODEL_STRONG(UIButton, rightBtn);
AS_MODEL_STRONG(UILabel, titleLabel);
AS_MODEL_STRONG(UIImageView, backImageView);

- (id)initWithFrame:(CGRect)frame
        withBgImage:(NSString*)bgImage
          withTitle:(NSString*)title
        withLeftBtn:(NSString*)leftImage
       withRightBtn:(NSString*)rightImage
      withLeftLabel:(NSString*)leftLabel
     withRightLabel:(NSString*)rightLabel;

-(void)updateBackImage:(NSString*)bgImage;

-(void)updateTitle:(NSString*)label;

-(void)updateLeftBtn:(NSString*)leftLabel withImage:(NSString*)leftImage;

-(void)updateRightBtn:(NSString*)rightLabel withImage:(NSString*)rightImage;

@end
