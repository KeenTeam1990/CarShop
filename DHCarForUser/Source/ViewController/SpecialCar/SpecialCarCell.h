//
//  SpecialCarCell.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/8.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"
#import "Dh_SpecialCarModel.h"

@protocol SpecialCarCellDelegate <NSObject>

-(void)selectTheCarForModel:(Dh_SpecialCarModel*)model;

@end

@interface SpecialCarCell : DLTableViewCell

@property(nonatomic, assign) id<SpecialCarCellDelegate>delegate;

@property(nonatomic, strong) UIImageView *rentalImageView;
@property(nonatomic, strong) UIImageView *discountImageView;

@property(nonatomic,retain) UILabel *label1;
@property(nonatomic,retain) UILabel *label2;
@property(nonatomic,retain) UILabel *label3;
@property(nonatomic,retain) UILabel *label4;
@property(nonatomic,retain) UILabel *label5;

@property(nonatomic,retain) UIButton *selectBtn;
//@property(nonatomic, strong) UILabel *carName;
//@property(nonatomic, strong) UILabel *originalPrice;
//@property(nonatomic, strong) UILabel *presentPrice;

@property(nonatomic, strong) Dh_SpecialCarModel *specialCarModel;

@end
