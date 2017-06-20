//
//  MM_RentalCarItemView.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/2.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dh_RentalCarModel.h"

@protocol rentalCarItemDelegate <NSObject>

-(void)selectTheCarForTag:(NSUInteger)tag;

@end

@interface MM_RentalCarItemView : DLView


@property(nonatomic, assign) id<rentalCarItemDelegate>delegate;
@property(nonatomic, strong) UIImageView *rentalImageView;
@property(nonatomic, strong) UIImageView *discountImageView;
@property(nonatomic, strong) UILabel *carName;
@property(nonatomic, strong) UILabel *originalPrice;
@property(nonatomic, strong) UILabel *presentPrice;


-(void)eventTheCar:(UITapGestureRecognizer *)gesture;
-(void)showUI:(Dh_RentalCarModel*)rentalCarModel;

@end
