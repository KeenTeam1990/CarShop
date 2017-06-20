

//
//  LL_LableHaveLine.m
//  DHCarForSales
//
//  Created by leiyu on 15/11/17.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "LL_LableHaveLine.h"
@interface LL_LableHaveLine()

@property(nonatomic,strong)UIImageView *myLineImageView;

@end
@implementation LL_LableHaveLine

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self initLableView];
        [self initLineImageView];
    }
    return self;
}
-(void)initLableView
{
    _myLable=[[UILabel alloc]init];
    _myLable.font = [UIFont systemFontOfSize:10];
    _myLable.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_myLable];
    
}
-(void)initLineImageView
{
    _myLineImageView=[[UIImageView alloc]init];
    [_myLable addSubview:_myLineImageView];
}
-(void)setMyText:(NSString *)myText
{
    CGFloat lableWidth=[Unity getLableWidthWithString:myText andFontSize:10];
    CGFloat lableHeight=[Unity getLabelHeightWithWidth:lableWidth andDefaultHeight:0 andFontSize:10 andText:myText];
    _myLable.textColor=[UIColor grayColor];
    _myLable.text=myText;
    _myLable.frame=CGRectMake(0,(self.frame.size.height-lableHeight)/2, lableWidth+20, lableHeight);
    _myLineImageView.frame=CGRectMake(0, _myLable.frame.size.height/2, _myLable.frame.size.width-20, 1);
    [_myLineImageView setBackgroundColor:[UIColor grayColor]];
}
@end
