//
//  M_CarImagesView.m
//  DHCarForSales
//
//  Created by lucaslu on 15/11/1.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarImagesView.h"
#import "DLPageView.h"

@interface M_CarImagesView ()<UIScrollViewDelegate>

AS_MODEL_STRONG(UIScrollView, myScrollView);
AS_MODEL_STRONG(NSMutableArray, myImageArray);
AS_MODEL_STRONG(DLPageView, myPageView);
AS_MODEL_STRONG(UIImageView, myLineView);

@end

@implementation M_CarImagesView

DEF_FACTORY_FRAME(M_CarImagesView);

DEF_MODEL(myScrollView);
DEF_MODEL(myImageArray);
DEF_MODEL(block);
DEF_MODEL(myLineView);
DEF_MODEL(myPageView);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.myImageArray = [NSMutableArray allocInstance];
        
        self.myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.myScrollView.showsHorizontalScrollIndicator = NO;
        self.myScrollView.showsVerticalScrollIndicator = NO;
        self.myScrollView.pagingEnabled =YES;
        self.myScrollView.delegate = self;
        [self addSubview:self.myScrollView];
        
        self.myPageView = [[DLPageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-50, self.frame.size.width, 30)];
        self.myPageView.userInteractionEnabled = YES;
        self.myPageView.hidesForSinglePage = YES;
        [self addSubview:self.myPageView];
        
        self.myScrollView.contentSize = CGSizeMake(self.myScrollView.frame.size.width, self.myScrollView.frame.size.height);
        
        self.myPageView.numberOfPages = 0;
        self.myPageView.currentPage = 0;
        
        self.myLineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
        self.myLineView.backgroundColor = RGBCOLOR(186, 186, 187);
//        [self addSubview:self.myLineView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempFrame = self.myScrollView.frame;
    tempFrame.size.width = self.frame.size.width;
    self.myScrollView.frame = tempFrame;
    
    tempFrame = self.myPageView.frame;
    tempFrame.size.width = self.frame.size.width;
    self.myPageView.frame = tempFrame;
    
    tempFrame = self.myLineView.frame;
    tempFrame.size.width = self.frame.size.width;
    self.myLineView.frame = tempFrame;
}

-(void)upDateData:(NSMutableArray*)data
{
    [self.myImageArray removeAllObjects];
    [self.myImageArray addObjectsFromArray:data];

    UIImage* tempImage = [UIImage imageNamed:@"tempcar.jpg"];
    
    for (int i=0; i<[self.myScrollView.subviews count]; i++) {
        UIView* tempView = [self.myScrollView.subviews objectAtIndex:i];
        if (tempView!=nil) {
            [tempView removeFromSuperview];
        }
    }
    
    for (int i=0; i<[self.myImageArray count]; i++) {

        NSString* tempImg =[self.myImageArray objectAtIndex:i];
        
        UIImageView* tempItemView = [[UIImageView alloc]initWithFrame:CGRectMake(self.myScrollView.frame.size.width*i, 0, self.myScrollView.frame.size.width, self.myScrollView.frame.size.height)];
        
        tempItemView.tag = 1000+i;
        
        if ([tempImg isEqualToString:@"1"]) {
            [tempItemView setImage:tempImage];
        }else{
            [tempItemView setImageWithURL:[NSURL URLWithString:tempImg] placeholderImage:tempImage];
        }
        
        tempItemView.contentMode = UIViewContentModeScaleAspectFill;
        
        [tempItemView setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *tempsingleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
        tempsingleTap.numberOfTapsRequired=1;
        [tempItemView addGestureRecognizer:tempsingleTap];

        [self.myScrollView addSubview:tempItemView];
    }
    
    self.myScrollView.contentSize = CGSizeMake(self.myScrollView.frame.size.width*[self.myImageArray count], self.myScrollView.frame.size.height);
    
    self.myPageView.numberOfPages = [self.myImageArray count];
    self.myPageView.currentPage = 0;
}

#pragma mark-
#pragma UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = self.myScrollView.contentOffset.x/self.frame.size.width;//通过滚动的偏移量来判断目前页面所对应的小白点
    self.myPageView.currentPage = page;//pagecontroll响应值的变化
}

-(void)singleTap:(UITapGestureRecognizer*)gesture
{
    UIImageView* tempView = (UIImageView*)gesture.view;
    
    NSInteger tempIndex = tempView.tag - 1000;
    
    if (self.block!=nil) {
        self.block(tempIndex);
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
