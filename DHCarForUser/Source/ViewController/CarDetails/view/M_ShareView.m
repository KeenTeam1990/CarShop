//
//  M_ShareView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/28.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_ShareView.h"
#import "M_IconView.h"

@interface M_ShareView ()

AS_MODEL_STRONG(NSMutableArray, myIconArray);

AS_MODEL_STRONG(UIButton, myButton);
AS_MODEL_STRONG(UIView, myView);

AS_MODEL_STRONG(UILabel, myTitleLabel);
AS_MODEL_STRONG(UIButton, myCancelBtn);
AS_MODEL_STRONG(UIImageView, myLineView);

AS_MODEL_STRONG(NSMutableArray, myViewArray);

@end

@implementation M_ShareView

DEF_FACTORY_FRAME(M_ShareView);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
        
        self.myIconArray = [NSMutableArray allocInstance];
        self.myViewArray = [NSMutableArray allocInstance];
        
        UIView* tempView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-200, frame.size.width, 200)];
        [tempView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:tempView];
        
        self.myTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tempView.frame.size.width, 40)];
        self.myTitleLabel.font = SYSTEMFONT(14);
        self.myTitleLabel.text = @"分享给你的好友";
        self.myTitleLabel.textAlignment = UITextAlignmentCenter;
        self.myTitleLabel.textColor = [UIColor lightGrayColor];
        [tempView addSubview:self.myTitleLabel];
        
        self.myView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, frame.size.width, 106)];
        [self.myView setBackgroundColor:[UIColor whiteColor]];
        [tempView addSubview:self.myView];
        
        self.myLineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 146, frame.size.width, 10)];
        self.myLineView.backgroundColor = RGBCOLOR(233, 233, 233);
        [tempView addSubview:self.myLineView];
        
        self.myCancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.myCancelBtn.frame = CGRectMake(0, 156, frame.size.width, 44);
        [self.myCancelBtn addTarget:self action:@selector(touchBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.myCancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.myCancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.myCancelBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [tempView addSubview:self.myCancelBtn];
        
        self.myButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.myButton.frame = CGRectMake(0, 0, frame.size.width, self.frame.size.height-120);
        [self.myButton addTarget:self action:@selector(touchBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.myButton];
        
    }
    return self;
}

-(void)touchBtnPressed:(id)sender
{
    if (self.block!=nil) {
        self.block(0);
    }
}

-(void)addIconItem:(NSString*)name withIcon:(NSString*)icon
{
    NSMutableDictionary* tempDic = [NSMutableDictionary allocInstance];
    
    [tempDic setObject:name forKey:@"name"];
    [tempDic setObject:icon forKey:@"icon"];
    
    [self.myIconArray addObject:tempDic];
}

-(void)updateData
{
    for (int i=0; i<[self.myViewArray count]; i++) {
        M_IconView* tempBtn = [self.myViewArray objectAtIndex:i];
        if (tempBtn!=nil) {
            [tempBtn removeFromSuperview];
        }
    }
    
    NSInteger count = [self.myIconArray count];
    
    NSInteger w = (self.bounds.size.width/4);
    NSInteger h = 100;
    
    NSInteger x = (self.myView.frame.size.width-w*count)/2;
    NSInteger y = (self.myView.frame.size.height-h)/2;
    
    for (int i=0; i<count; i++) {
        
        NSDictionary* tempDic = [self.myIconArray objectAtIndex:i];
        if (tempDic!=nil) {
            
            NSString* tempName = [tempDic hasItemAndBack:@"name"];
            NSString* tempIocn = [tempDic hasItemAndBack:@"icon"];
            
            M_IconView* tempBtn = [M_IconView allocInstanceFrame:CGRectMake(x, y, w, h)];
            tempBtn.tag = 1000+i;
            tempBtn.showNum = NO;
            
            [tempBtn updateModel:tempIocn withText:tempName];
            
            tempBtn.block = ^(NSInteger tag){
                if (self.block!=nil) {
                    self.block(tag-1000+1);
                }
            };
            
            [self.myViewArray addObject:tempBtn];
            [self.myView addSubview:tempBtn];
            
            x+=w;
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
