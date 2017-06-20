//
//  MM_SpecialCarItemView.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/2.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MM_SpecialCarItemView : UIView


@property(nonatomic, strong) UIImageView *rentalImageView;
@property(nonatomic, strong) UIImageView *discountImageView;
@property(nonatomic, strong) UILabel *carName;
@property(nonatomic, strong) UILabel *originalPrice;


-(void)eventTheCar:(UITapGestureRecognizer *)gesture;
@end
