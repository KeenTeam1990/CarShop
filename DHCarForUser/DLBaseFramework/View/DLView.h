//
//  DLView.h
//  Auction
//
//  Created by 卢迎志 on 14-12-24.
//
//

#import <UIKit/UIKit.h>

@interface DLView : UIView

AS_RECT(currFieldRect);

-(void)showkeyword;

-(void)hidekeyword;

-(CGRect)getCurrFieldRect:(UIView*)toView;

-(void)baseTapKeyword;

@end
