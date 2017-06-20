//
//  CB_Label.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "CB_Label.h"

@implementation CB_Label

+(CB_Label *)labelWithColor:(UIColor *)color andTextFont:(CGFloat )textFont
{
    CB_Label *lable=[[CB_Label alloc]init];
    lable.font=[UIFont systemFontOfSize:textFont];
    lable.textColor=color;
    return lable;
}
+(CB_Label *)labelWithBoldColor:(UIColor *)boldColor andTextFont:(CGFloat )textFont
{
    CB_Label *lable=[[CB_Label alloc]init];
    lable.font=[UIFont boldSystemFontOfSize:textFont];
    lable.textColor=boldColor;
    return lable;
}
+(CB_Label *)labelWithColor:(UIColor *)color frame:(CGRect)lableFrame andTextFont:(CGFloat )textFont
{
    CB_Label *lable=[[CB_Label alloc]initWithFrame:lableFrame];
    lable.font=[UIFont boldSystemFontOfSize:textFont];
    lable.textColor=color;
    return lable;
}
+(CB_Label *)labelWithBoldColor:(UIColor *)boldColor  frame:(CGRect)lableFrame andTextFont:(CGFloat )textFont
{
    CB_Label *lable=[[CB_Label alloc]initWithFrame:lableFrame];
    lable.font=[UIFont boldSystemFontOfSize:textFont];
    lable.textColor=boldColor;
    return lable;
}
//
//+(CB_Label *)labelWithAttributedString:(NSString *)str
//{
//    return <#expression#>
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
