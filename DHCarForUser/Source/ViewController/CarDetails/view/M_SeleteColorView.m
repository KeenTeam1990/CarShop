//
//  M_SeleteColorView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/24.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_SeleteColorView.h"
#import "M_CarListModel.h"

@interface M_SeleteColorView ()

AS_MODEL_STRONG(NSMutableArray, myDataArray);

AS_MODEL_STRONG(UIView, myView);
AS_MODEL_STRONG(UIScrollView, myScrollView);

AS_MODEL_STRONG(UILabel, myTitleLabel);

@end

@implementation M_SeleteColorView

DEF_FACTORY_FRAME(M_SeleteColorView);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.myDataArray  = [NSMutableArray allocInstance];
        self.myView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/3, 0, (self.frame.size.width/3)*2, self.frame.size.height)];
        [self.myView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.myView];
        
        self.myTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.myView.frame.size.width, NavigationBarHeight)];
        self.myTitleLabel.backgroundColor = [UIColor clearColor];
        self.myTitleLabel.text = @"选择颜色";
        self.myTitleLabel.textAlignment = UITextAlignmentCenter;
        [self.myView addSubview:self.myTitleLabel];
        
        self.myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NavigationBarHeight*2, self.myView.frame.size.width, self.myView.frame.size.height-NavigationBarHeight*2)];
        self.myScrollView.showsHorizontalScrollIndicator = NO;
        self.myScrollView.showsVerticalScrollIndicator = NO;
        [self.myView addSubview:self.myScrollView];
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tempsingleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
        tempsingleTap.numberOfTapsRequired=1;
        [self addGestureRecognizer:tempsingleTap];
    }
    
    return self;
}

-(void)singleTap:(UITapGestureRecognizer*)gesture
{
    if (self.block!=nil) {
        self.block(nil);
    }
}

-(void)showBack:(BOOL)show
{
    if (show) {
        [self setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.6]];
    }else{
        [self setBackgroundColor:[UIColor clearColor]];
    }
    
}

-(void)updateData:(NSMutableArray*)data
{
    [self.myDataArray removeAllObjects];
    
    [self.myDataArray addObjectsFromArray:data];
    
    for (int i=0; i<[self.myScrollView.subviews count]; i++) {
        UIButton* tempBtn = [self.myScrollView.subviews objectAtIndex:i];
        if (tempBtn!=nil) {
            [tempBtn removeFromSuperview];
        }
    }
    
    NSInteger offset = 10;
    
    NSInteger x = offset;
    NSInteger y = offset;
    NSInteger w = 50;
    NSInteger h = 50;
    
    NSInteger wcount = self.myScrollView.frame.size.width/(w+offset);
    
    for (int i=0; i<[data count]; i++) {
        M_CarColorItemModel* tempItem = [data objectAtIndex:i];
        if (tempItem!=nil) {
            
            UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            tempBtn.style = DLButtonStyleMake(style.cornerRedius = 2;);
            
            tempBtn.frame = CGRectMake(x, y, w, h);
            tempBtn.tag = 1000+i;
            
            [tempBtn addTarget:self action:@selector(buttonBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self.myScrollView addSubview:tempBtn];
            
            if ([tempItem.myCar_Color_Img notEmpty]) {
                //[tempBtn setBackgroundColor:[UIColor redColor]];
                [tempBtn setBackgroundColor:[Unity getColor:tempItem.myCar_Color_Img]];
            }
            
            if (i!=0 && (i+1)%wcount == 0) {
                x = offset;
                y +=h+offset;
            }else{
                x+=w+offset;
            }
        }
    }
}

-(void)buttonBtnPressed:(id)sender
{
    UIButton* tempView = (UIButton*)sender;
    if (tempView!=nil) {
        
        M_CarColorItemModel* tempItem = [self.myDataArray objectAtIndex:tempView.tag-1000];
        if (tempItem!=nil) {
            
            if (self.block!=nil) {
                self.block(tempItem);
            }
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
