//
//  MM_RentalCarItemView.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/2.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "MM_RentalCarItemView.h"
#import "Unity.h"

@implementation MM_RentalCarItemView

@synthesize rentalImageView;
@synthesize discountImageView;
@synthesize carName;
@synthesize originalPrice;
@synthesize presentPrice;
@synthesize delegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //        UIImage *tempImage = [UIImage imageNamed:@""];
        
        self.layer.cornerRadius = 0.5;
        self.layer.borderWidth = 0.5;
        //self.layer.borderColor = [UIColor colorWithRed:0.5 green:0.5019 blue:0.7411 alpha:1.0].CGColor;
        self.layer.borderColor = [Unity getGrayBackColor].CGColor ;
        
        
        UIImage *tempImage = [UIImage imageNamed:@"tempcar.jpg"];
        
       
        self.rentalImageView = [[UIImageView alloc]init];
        self.rentalImageView.frame =  CGRectMake(10, 10, tempImage.size.width/2, tempImage.size.height/2);
        
        self.rentalImageView.image = tempImage;
        self.rentalImageView.userInteractionEnabled = YES;
        [self addSubview:self.rentalImageView];
        
        self.discountImageView = [[UIImageView alloc]init];
        self.discountImageView.frame = CGRectMake(145-30, 0, 30, 30);
        
        self.discountImageView.userInteractionEnabled = YES;
        [self addSubview:self.discountImageView];
        
        UILabel *discountLabel = [[UILabel alloc]init];
        discountLabel.textColor = [UIColor whiteColor];
        discountLabel.textAlignment = NSTextAlignmentRight;
        discountLabel.font = [UIFont boldSystemFontOfSize:14];
        discountLabel.text = @"惠";
        discountLabel.frame = CGRectMake(8, 0, 20, 20);
        [self.discountImageView addSubview:discountLabel];
        
        self.carName = [[UILabel alloc]initWithFrame:CGRectMake(10, 170/2+20, 145-20, 40)];
        self.carName.text = @"奥迪A4L 50 TFSI 旗舰型   2015";
        self.carName.font = [UIFont systemFontOfSize:16];
        self.carName.textColor = [UIColor blackColor];
        self.carName.lineBreakMode = NSLineBreakByWordWrapping;
        self.carName.numberOfLines = 0;
        
        CGSize size = [self.carName sizeThatFits:CGSizeMake(self.carName.frame.size.width, MAXFLOAT)];
        
        self.carName.frame =CGRectMake(10, 170/2+20, 145-20, size.height);
        
        [self addSubview:self.carName];
        
        self.originalPrice = [[UILabel alloc]initWithFrame:CGRectMake(10, 170/2+10+50, 125/2, 20)];
        //self.originalPrice.text = @"￥42.00万";
        self.originalPrice.textColor = [UIColor redColor];
        self.originalPrice.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview:self.originalPrice];
        
        self.presentPrice = [[UILabel alloc]initWithFrame:CGRectMake(10+125/2, 170/2+10+50, 125/2, 20)];
        //self.presentPrice.text = @"￥42.00万";
        self.presentPrice.textColor = [UIColor grayColor];
        self.presentPrice.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview:self.presentPrice];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10+125/2, 170/2+10+50+10, 125/2, 1)];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
        
        UIView *touchView = [[UIView alloc]init];
        touchView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self addSubview:touchView];
        
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(eventTheCar:)];
        [touchView addGestureRecognizer:tapGesture];
        
    }
    return self;
    
}

-(void)eventTheCar:(UITapGestureRecognizer *)gesture
{
    NSLog(@"the car");
    
    if (self.delegate !=nil &&[self.delegate respondsToSelector:@selector(selectTheCarForTag:)]) {
        [self.delegate selectTheCarForTag:self.tag];
    }
}

-(void)showUI:(Dh_RentalCarModel*)rentalCarModel
{
    
    if (rentalCarModel!=nil) {
        
        //self.rentalImageView.hidden = YES;
        self.discountImageView.hidden = YES;
        self.carName.text = @"奥迪A4L 50 TFSI 旗舰型   2015";
        self.originalPrice.text = @"";
        self.presentPrice.text = @"";
       
        
        // self.carName.text = buyCarModel.carName;
        self.originalPrice.text = rentalCarModel.originalPrice;
        self.presentPrice.text = rentalCarModel.presentPrice;
        
        if ([rentalCarModel.discountStr isEqualToString:@"1"]) {
            self.discountImageView.image = [UIImage imageNamed:@"优惠.png"];
            self.discountImageView.hidden = NO;
        }else
        {
            self.discountImageView.hidden = YES;
        }
        if (rentalCarModel.carName !=nil &&![rentalCarModel.carName isEqualToString:@""]) {
            self.carName.text = rentalCarModel.carName;
            
        }
        if (rentalCarModel.originalPrice !=nil &&![rentalCarModel.originalPrice isEqualToString:@""]) {
            self.originalPrice.text = rentalCarModel.originalPrice;
            
        }
        if (rentalCarModel.presentPrice !=nil &&![rentalCarModel.presentPrice isEqualToString:@""]) {
            self.presentPrice.text = rentalCarModel.presentPrice;
            
        }
        
    }
}



@end
