//
//  SpecialCarCell.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/8.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "SpecialCarCell.h"
#import "Dh_SpecialCarModel.h"
@implementation SpecialCarCell

@synthesize rentalImageView,discountImageView,label1,label2,label3,label4,label5,selectBtn,delegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
//        self.myViewArray = [NSMutableArray allocInstance];
//        self.myDataArray = [NSMutableArray allocInstance];
        
        //        int w = self.bounds.size.width/2-10;
        //        int h = 200;
        //        int x = 6;
        //        int y = 5;
        
        [self initView];
        self.specialCarModel  = [[Dh_SpecialCarModel alloc]init];
        self.specialCarModel.iconImageStr = @"";
        self.specialCarModel.label1 = @"惠";
        self.specialCarModel.label2 = @"2013款 别克 凯悦 1.2T手动运动款";
        self.specialCarModel.label3 = @"42,210";
        self.specialCarModel.label2 = @"180000";
        self.specialCarModel.label3 = @"本市3家经销商直接报底价";
        [self initUIForData:self.specialCarModel];
        
    }
    return self;
}

-(void)initView
{
    
    UIView *bgView = [[UIView alloc]init];
            bgView.layer.cornerRadius = 1;
            bgView.layer.borderWidth = 1.0;
            bgView.layer.borderColor = [UIColor grayColor].CGColor;
    [self addSubview:bgView];
    
    self.rentalImageView = [[UIImageView alloc]init];
    self.rentalImageView.frame = CGRectMake(0, 10, 145, 170/2);
    
    //self.carImageView.image = [UIImage imageNamed:@"登录-按下@2x.png"];
    self.rentalImageView.userInteractionEnabled = YES;
    [bgView addSubview:self.rentalImageView];
    
    self.discountImageView = [[UIImageView alloc]init];
    self.discountImageView.frame = CGRectMake(145-30, 0, 30, 30);
    
    self.discountImageView.userInteractionEnabled = YES;
    [bgView addSubview:self.discountImageView];
    
    
    self.label1 = [[UILabel alloc]init];
    self.label1.frame = CGRectMake(discountImageView.frame.size.width/2 , 10, discountImageView.frame.size.width/2, 30);
    self.label1.font = [UIFont boldSystemFontOfSize:16];
    [self.discountImageView addSubview:label1];

    self.label2 = [[UILabel alloc]init];
    self.label2.frame = CGRectMake(bgView.frame.size.width+40 , 30, 200, 30);
    self.label2.font = [UIFont boldSystemFontOfSize:16];
    [self addSubview:label2];
    
    self.label3 = [[UILabel alloc]init];
    self.label3.frame = CGRectMake(bgView.frame.size.width+40 , 30+50, 100, 30);
    self.label3.textAlignment = NSTextAlignmentCenter;
    self.label3.textColor = [UIColor grayColor];
    self.label3.font = [UIFont boldSystemFontOfSize:16];
    [self addSubview:label3];
    
    self.label4 = [[UILabel alloc]init];
    self.label4.frame = CGRectMake(bgView.frame.size.width+40+120 , 30+50, 100, 30);
    self.label4.textAlignment = NSTextAlignmentCenter;
    self.label4.textColor = [UIColor redColor];
    self.label4.font = [UIFont boldSystemFontOfSize:16];
    [self addSubview:self.label4];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 15, 100, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    [self.label3 addSubview:lineView];
    
    self.label5 = [[UILabel alloc]init];
    self.label5.frame = CGRectMake(bgView.frame.size.width+40+120 , 30+50+50, 200, 30);
    self.label5.textAlignment = NSTextAlignmentCenter;
    self.label5.textColor = [UIColor orangeColor];
    self.label5.font = [UIFont boldSystemFontOfSize:16];

    

    
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.frame  = CGRectMake(20,self.label3.frame.origin.y+50+33+36, self.frame.size.width-40, 31);
    self.selectBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.selectBtn setTitle:@"我要特惠" forState:UIControlStateNormal];
    self.selectBtn.layer.cornerRadius = 4;
    self.selectBtn.layer.borderWidth = 1.0;
    self.selectBtn.backgroundColor = [Unity getNavBarBackColor];
    //self.selectBtn.layer.borderColor = [UIColor grayColor].CGColor;
    [self.selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.selectBtn addTarget:self action:@selector(specialCar:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)initUIForData:(Dh_SpecialCarModel *)model
{
    
    if (model) {
        self.rentalImageView.image = [UIImage imageNamed:model.iconImageStr];
        self.label1.text = model.label1;
        self.label2.text = model.label2;
        self.label3.text = model.label3;
        self.label4.text = model.label4;
        self.label5.text = model.label5;
    }
}


-(void)specialCar:(UIButton *)sender
{
    
    if (self.delegate !=nil && [self.delegate respondsToSelector:@selector(selectTheCarForModel:)]) {
        [self.delegate selectTheCarForModel:self.specialCarModel];
    }
}


-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    
    
}

@end
