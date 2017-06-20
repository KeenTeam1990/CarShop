//
//  LL_GiftVieww.m
//  DHCarForSales
//
//  Created by leiyu on 16/1/12.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "LL_GiftView.h"
#import "M_MyOrderModel.h"

@interface LL_GiftView()
AS_MODEL_STRONG(NSArray, myDataArray);
AS_MODEL_STRONG(UILabel, myTitleLabel);

@end
@implementation LL_GiftView
DEF_MODEL(myTitleLabel)
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initLableWithFrame:CGRectMake(10, 10, 300, 20)];
    }
    return self;
}
-(void)initLableWithFrame:(CGRect )frame
{
    self.myTitleLabel = [[UILabel alloc]initWithFrame:frame];
    self.myTitleLabel.font = [UIFont systemFontOfSize:14];
    self.myTitleLabel.textColor = [Unity getColor:@"#2c2c2d"];
    self.myTitleLabel.text = @"赠送礼包：";
    [self addSubview:self.myTitleLabel];
}
-(void)upDataWithDataArray:(NSArray *)arr
{
    self.myDataArray = [[NSMutableArray alloc]initWithArray:arr];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        M_QuoteComboItemModel *model = (M_QuoteComboItemModel *)obj;
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.myTitleLabel.frame)+idx*20, self.bounds.size.width, 20)];
        [self addSubview:view];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag =1000+[model.myComboId integerValue];
        button.frame = CGRectMake(10, 0, 20, 20);
        [button setBackgroundImage:[UIImage imageNamed:@"礼包.png"] forState:UIControlStateNormal];
        button.userInteractionEnabled = NO;
        [button addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchDown];
        [view addSubview:button];
        
        CGFloat lableHeight = [Unity getLabelHeightWithWidth:self.frame.size.width-50 andDefaultHeight:20 andFontSize:12 andText:model.myComboContent];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button.frame)+20, CGRectGetMinY(button.frame), self.frame.size.width-50, lableHeight)];
        lable.textColor = [Unity getColor:@"#99999"];
        lable.text = model.myComboContent;
        lable.font = [UIFont systemFontOfSize:12];
        [view addSubview:lable];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        
        [view addGestureRecognizer:tap];
        tap.view.tag =1000+idx;
        
    }];

}
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    M_QuoteComboItemModel *model = self.myDataArray[tap.view.tag -1000];
    if (self.myClickAction != nil) {
        self.myClickAction(model);
    }

    
}
-(void)buttonClickAction:(UIButton *)button
{
    button.selected = !button.selected;
   

}
-(NSString *)allTypeSelected
{
    NSArray *subviewArr = [self subviews];
   __block NSString *tagStr = [NSString string];
    [subviewArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)obj;
            NSInteger tag = button.tag -1000;
            if (button.selected == YES) {
                tagStr = [NSString stringWithFormat:@"%ld,",tag];
            }
        }
    }];
    return  [self removeLastCharWithStr:tagStr];
}
-(NSString *)removeLastCharWithStr:(NSString *)str
{
    NSMutableString *muStr = [NSMutableString stringWithFormat:@"%@",str];
    if ([str hasSuffix:@","]) {
        [muStr deleteCharactersInRange:NSMakeRange(str.length-1, 1)];
    }
    return muStr;
}
@end
