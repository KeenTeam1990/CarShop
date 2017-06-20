//
//  LLLable.h
//  DHCarForSales
//
//  Created by leiyu on 15/11/6.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLLable : UILabel
+(LLLable *)labelWithColor:(UIColor *)color andTextFont:(CGFloat )textFont;
+(LLLable *)labelWithBoldColor:(UIColor *)boldColor  andTextFont:(CGFloat )textFont;
+(LLLable *)labelWithColor:(UIColor *)color frame:(CGRect)lableFrame andTextFont:(CGFloat )textFont;
+(LLLable *)labelWithBoldColor:(UIColor *)boldColor  frame:(CGRect)lableFrame andTextFont:(CGFloat )textFont;

@end
