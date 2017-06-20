//
//  M_IconView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/18.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_IconView.h"

@interface M_IconView ()

AS_MODEL_STRONG(UIImageView, myIconView);
AS_MODEL_STRONG(UILabel, myTextLabel);
AS_MODEL_STRONG(UIButton, myTouchBtn);
AS_MODEL_STRONG(UIButton, myNumBtn);

@end

@implementation M_IconView

DEF_FACTORY_FRAME(M_IconView);

DEF_MODEL(myIconView);
DEF_MODEL(myNumBtn);
DEF_MODEL(myTextLabel);
DEF_MODEL(myTouchBtn);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.myIconView = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.myIconView.frame = CGRectMake(15, 10, frame.size.width-30, frame.size.width-30);
        self.myIconView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.myIconView];
        
        self.myNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.myNumBtn.layer setMasksToBounds:YES];
        [self.myNumBtn.layer setCornerRadius:5];
        [self.myNumBtn setBackgroundColor:[UIColor redColor]];
        [self.myNumBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [self.myNumBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.myNumBtn.frame = CGRectZero;
        self.myNumBtn.userInteractionEnabled = NO;
        [self addSubview:self.myNumBtn];
        
        self.myTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-25, frame.size.width, 25)];
        [self.myTextLabel setBackgroundColor:[UIColor clearColor]];
        [self.myTextLabel setFont:[UIFont systemFontOfSize:12]];
        [self.myTextLabel setTextAlignment:UITextAlignmentCenter];
        [self.myTextLabel setTextColor:[UIColor blackColor]];
        [self addSubview:self.myTextLabel];
        
        self.myTouchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.myTouchBtn addTarget:self action:@selector(touchBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.myTouchBtn.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:self.myTouchBtn];
    }
    return self;
}

-(void)touchBtnPressed:(id)sender
{
    if (self.block!=nil) {
        self.block(self.tag);
    }
}

-(void)updateModel:(NSString*)icon withText:(NSString*)text
{
    UIImage* tempImage = [UIImage imageNamed:icon];
    
    self.myIconView.image = tempImage;
    
    CGRect tempFrame = self.myIconView.frame;
    tempFrame.size = tempImage.size;
    tempFrame.origin.x = (self.frame.size.width - tempFrame.size.width)/2;
    tempFrame.origin.y = (self.frame.size.height-15 - tempFrame.size.height)/2;
    self.myIconView.frame = tempFrame;
    
    self.myTextLabel.text = text;
}

-(void)updateNum:(NSString*)num
{
    self.myNumBtn.hidden = !self.showNum;
    if ([num isEqualToString:@"0"]) {
        self.myNumBtn.hidden = YES;
    }
    [self.myNumBtn setTitle:num forState:UIControlStateNormal];
    
    CGRect tempFrame = self.myNumBtn.frame;
    tempFrame.origin.x = self.myIconView.frame.origin.x+self.myIconView.frame.size.width;
    tempFrame.origin.y = self.myIconView.frame.origin.y;
    tempFrame.size = CGSizeMake(10, 10);
    self.myNumBtn.frame = tempFrame;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
