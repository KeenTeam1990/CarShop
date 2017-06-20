//
//  LLLable.m
//  DHCarForSales
//
//  Created by leiyu on 15/11/6.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "LLLable.h"

@implementation LLLable

+(LLLable *)labelWithColor:(UIColor *)color andTextFont:(CGFloat )textFont
{
    LLLable *lable=[[LLLable alloc]init];
    lable.font=[UIFont systemFontOfSize:textFont];
    lable.textColor=color;
    return lable;
}
+(LLLable *)labelWithBoldColor:(UIColor *)boldColor andTextFont:(CGFloat )textFont
{
    LLLable *lable=[[LLLable alloc]init];
    lable.font=[UIFont boldSystemFontOfSize:textFont];
    lable.textColor=boldColor;
    return lable;
}
+(LLLable *)labelWithColor:(UIColor *)color frame:(CGRect)lableFrame andTextFont:(CGFloat )textFont
{
    LLLable *lable=[[LLLable alloc]initWithFrame:lableFrame];
    lable.font=[UIFont boldSystemFontOfSize:textFont];
    lable.textColor=color;
    return lable;
}
+(LLLable *)labelWithBoldColor:(UIColor *)boldColor  frame:(CGRect)lableFrame andTextFont:(CGFloat )textFont
{
    LLLable *lable=[[LLLable alloc]initWithFrame:lableFrame];
    lable.font=[UIFont boldSystemFontOfSize:textFont];
    lable.textColor=boldColor;
    return lable;
}
@end
