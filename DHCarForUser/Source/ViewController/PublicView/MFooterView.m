//
//  MFooterView.m
//  Auction
//
//  Created by 卢迎志 on 14-12-14.
//
//

#import "MFooterView.h"

@interface MFooterView ()

AS_MODEL_STRONG(UIImageView, myBackView);
AS_MODEL_STRONG(UIButton, leftBtn);
AS_MODEL_STRONG(UIButton, rightBtn);

@end

@implementation MFooterView

DEF_FACTORY_FRAME(MFooterView);

DEF_MODEL(leftBtn);
DEF_MODEL(rightBtn);
DEF_MODEL(delegate);
DEF_MODEL(myBackView);

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.myBackView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.myBackView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.myBackView];
        
        self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.leftBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
        [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.leftBtn addTarget:self action:@selector(leftBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.leftBtn];
        
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.rightBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
        [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.rightBtn addTarget:self action:@selector(rightBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightBtn];
        
        self.leftBtn.frame = CGRectMake(10, 0, frame.size.width/2-20, frame.size.height);
        self.rightBtn.frame = CGRectMake(frame.size.width/2+10, 0, frame.size.width/2-20, frame.size.height);
    }
    return self;
}

-(void)leftBtnPressed:(id)sender
{
    if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(footerToLeftBtn)]) {
        [self.delegate footerToLeftBtn];
    }
}

-(void)rightBtnPressed:(id)sender
{
    if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(footerToRightBtn)]) {
        [self.delegate footerToRightBtn];
    }
}

-(void)updateBackView:(UIColor*)color withImage:(NSString*)image
{
    if (color != nil) {
        [self.myBackView setBackgroundColor:color];
    }else{
        if ([image notEmpty]) {
            self.myBackView.image = [UIImage imageNamed:image];
        }
    }
}

-(void)addLeftIcon:(NSString*)icon withText:(NSString*)text
{
    if ([icon notEmpty]) {
        [self.leftBtn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    }
    if ([text notEmpty]) {
        [self.leftBtn setTitle:text forState:UIControlStateNormal];
    }
}

-(void)addRightIcon:(NSString*)icon withText:(NSString*)text
{
    if ([icon notEmpty]) {
        [self.rightBtn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    }
    if ([text notEmpty]) {
        [self.rightBtn setTitle:text forState:UIControlStateNormal];
    }
}

-(void)updateLeftBtn:(NSString*)text
{
    if ([text notEmpty]) {
        [self.leftBtn setTitle:text forState:UIControlStateNormal];
    }
}
-(void)updateRightBtn:(NSString*)text
{
    if ([text notEmpty]) {
        [self.rightBtn setTitle:text forState:UIControlStateNormal];
    }
}

-(void)updateLeftIcon:(NSString*)icon
{
    if ([icon notEmpty]) {
        [self.leftBtn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    }
}

-(void)updateRightIcon:(NSString*)icon
{
    if ([icon notEmpty]) {
        [self.rightBtn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    }
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
