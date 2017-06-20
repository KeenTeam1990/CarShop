//
//  DLView.m
//  Auction
//
//  Created by 卢迎志 on 14-12-24.
//
//

#import "DLView.h"

@implementation DLView

DEF_MODEL(currFieldRect);

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.currFieldRect = CGRectZero;
    }
    return self;
}

-(void)showkeyword
{
    
}

-(void)hidekeyword
{
    
}

-(CGRect)getCurrFieldRect:(UIView*)toView
{
    CGRect tempFrame = [toView convertRect:self.currFieldRect fromView:self];
    return CGRectInset(tempFrame, 0, -10);
}

-(void)baseTapKeyword
{
    [APPDELEGATE.window endEditing:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
