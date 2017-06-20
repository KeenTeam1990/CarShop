//
//  DLPageView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/20.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLPageView.h"

@interface DLPageView ()

AS_MODEL_STRONG(NSMutableArray, myPageArray);

@end

@implementation DLPageView

DEF_FACTORY_FRAME(DLPageView);

DEF_MODEL(myPageArray);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.myPageArray = [NSMutableArray allocInstance];
        
        self.currentPage = 0;
        self.currColor = [UIColor redColor];
        self.otherColor = [UIColor grayColor];
        self.hidesForSinglePage = NO;
        self.pageAlignment = EPageAlignmentDefault;
    }
    return self;
}

-(void)setNumberOfPages:(NSInteger)number
{
    _numberOfPages = number;
    
    if (self.hidesForSinglePage) {
        if (number == 1) {
            _numberOfPages = 0;
        }
    }
    
    [self updatePageArray];
}

-(void)setCurrentPage:(NSInteger)current
{
    _currentPage = current;
    
    [self updateCurrIndex];
}

-(void)setCurrColor:(UIColor *)color
{
    _currColor = color;
    
    [self updateCurrIndex];
}

-(void)setOtherColor:(UIColor *)color
{
    _otherColor = color;
    
    [self updateCurrIndex];
}

-(void)setPageAlignment:(TPageAlignment)alignment
{
    _pageAlignment = alignment;
    
    [self updatePageArray];
}

-(void)updatePageArray
{
    for (int i=0; i<[self.myPageArray count]; i++) {
        UIView* tempView = [self.myPageArray objectAtIndex:i];
        if (tempView!=nil) {
            [tempView removeFromSuperview];
        }
    }
    
    [self.myPageArray removeAllObjects];

    NSInteger offset = 4;
    NSInteger w = 8;
    NSInteger h = 8;
    NSInteger x = (self.frame.size.width - (w+offset)*self.numberOfPages)/2;
    NSInteger y = (self.frame.size.height - h)/2;
    
    switch (self.pageAlignment) {
        case EPageAlignmentDefault:
        case EPageAlignmentCenter:
            x = (self.frame.size.width - (w+offset)*self.numberOfPages)/2;
            break;
        case EPageAlignmentLeft:
            x = (w+offset)*self.numberOfPages;
            break;
        case EPageAlignmentRight:
            x = (self.frame.size.width - (w+offset)*self.numberOfPages);
            break;
        default:
            x = (self.frame.size.width - (w+offset)*self.numberOfPages)/2;
            break;
    }
    
    for (int i=0; i<self.numberOfPages; i++) {

        UIView* tempView = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
        tempView.layer.cornerRadius = 4;
        if (self.currentPage == i) {
            tempView.backgroundColor = self.currColor;
        }else{
            tempView.backgroundColor = self.otherColor;
        }
        
        [self.myPageArray addObject:tempView];
        [self addSubview:tempView];
        
        x += w+offset;
    }
}

-(void)updateCurrIndex
{
    for (int i=0; i<[self.myPageArray count]; i++) {
        
        UIView* tempView = [self.myPageArray objectAtIndex:i];
        
        if (self.currentPage == i) {
            tempView.backgroundColor = self.currColor;
        }else{
            tempView.backgroundColor = self.otherColor;
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
