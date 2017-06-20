//
//  CB_Label.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CB_Label : UILabel

+(CB_Label *)labelWithColor:(UIColor *)color andTextFont:(CGFloat )textFont;
+(CB_Label *)labelWithBoldColor:(UIColor *)boldColor  andTextFont:(CGFloat )textFont;
+(CB_Label *)labelWithColor:(UIColor *)color frame:(CGRect)lableFrame andTextFont:(CGFloat )textFont;
+(CB_Label *)labelWithBoldColor:(UIColor *)boldColor  frame:(CGRect)lableFrame andTextFont:(CGFloat )textFont;
+(CB_Label *)labelWithAttributedString:(NSString *)str;
@end
