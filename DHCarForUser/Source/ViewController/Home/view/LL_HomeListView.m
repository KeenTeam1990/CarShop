
//
//  LL_HomeListView.m
//  DHCarForUser
//
//  Created by leiyu on 16/3/23.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "LL_HomeListView.h"

@implementation LL_HomeListView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void)upDataWithMyArr:(NSArray *)myArr
{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    
    [myArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat headedgWidth = (self.frame.size.width -63*3)/4;
        CGFloat x = 63*idx+headedgWidth*(idx+1);
        UIButton *tempImage = [[UIButton alloc]initWithFrame:CGRectMake(x, 10, 63, 63)];
        [tempImage setBackgroundImage:[UIImage imageNamed:obj] forState:UIControlStateNormal];
        tempImage.tag = 1100+idx;
        [self addSubview:tempImage];
        [tempImage addTarget:self action:@selector(MyClickAction:) forControlEvents:UIControlEventTouchDown];
    }];
}
-(void)MyClickAction:(UIButton *)tap
{
    if (self.myClickBlock != nil) {
        self.myClickBlock(tap.tag);
    }
}
@end
