//
//  MM_BuyCarItemView.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/10/30.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dh_BuyCarModel.h"
@protocol buyCarItem <NSObject>

-(void)selectTheCarForTag:(NSUInteger)tag;

@end

@interface MM_BuyCarItemView : DLView

@property(nonatomic, assign) id<buyCarItem>delegate;
@property(nonatomic, strong) UIImageView *carImageView;
@property(nonatomic, strong) UIImageView *discountImageView;
@property(nonatomic, strong) UILabel *carName;
@property(nonatomic, strong) UILabel *originalPrice;
@property(nonatomic, strong) UILabel *presentPrice;

-(void)eventTheCar:(UITapGestureRecognizer *)gesture;
-(void)showUI:(Dh_BuyCarModel*)buyCarModel;
@end
