//
//  M_CarDetailsBottomView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/8.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarDetailsBottomView.h"
#import "Unity.h"

#define KLeftOffset 20

@interface M_CarDetailsBottomView ()

AS_MODEL_STRONG(UIButton, myLeftBtn);

AS_MODEL_STRONG(UIButton, myRightBtn);

@end

@implementation M_CarDetailsBottomView

DEF_FACTORY_FRAME(M_CarDetailsBottomView);
DEF_MODEL(block);
DEF_MODEL(carType);
DEF_MODEL(myLeftBtn);

DEF_MODEL(myRightBtn);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        
        [self setBackgroundColor:RGBCOLOR(84, 84, 84)];
        
        UIImageView* tempLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 1)];
        [tempLine setBackgroundColor:RGBCOLOR(186, 186, 187)];
        [self addSubview:tempLine];
        
        self.myLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.myLeftBtn.frame = CGRectMake(10, (frame.size.height - 40)/2, frame.size.width/3-20, 40);
        [self.myLeftBtn addTarget:self action:@selector(leftBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.myLeftBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
        [self.myLeftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.myLeftBtn];
        
        self.myRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.myRightBtn addTarget:self action:@selector(rightBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.myRightBtn.frame = CGRectMake(frame.size.width/3, (frame.size.height - 40)/2, (frame.size.width/3)*2-20, 40);
        
        self.myRightBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor redColor];
                                                  style.cornerRedius = 2;
                                                  );
        [self.myRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.myRightBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];

        [self addSubview:self.myRightBtn];
        
        self.showLeftBtn = NO;
    }
    return self;
}

-(void)setShowLeftBtn:(BOOL)show
{
    _showLeftBtn = show;
    
    if (show) {
        self.myLeftBtn.enabled = YES;
        self.myLeftBtn.style = DLButtonStyleMake(style.backgroundColor = RGBCOLOR(255, 187, 0);
                                                 style.cornerRedius = 2;
                                                 );
    }else{
        self.myLeftBtn.enabled = NO;
        self.myLeftBtn.style = DLButtonStyleMake(style.backgroundColor = RGBCOLOR(192, 192, 192);
                                                 style.cornerRedius = 2;
                                                 );
    }
}

-(void)leftBtnPressed:(id)sender
{
    if (self.block!=nil) {
        self.block(1,NO);
    }
}

-(void)rightBtnPressed:(id)sender
{
    if (self.carType == EB_NewCar) {
        if (self.block!=nil) {
            self.block(2,NO);
        }
    }else if (self.carType == EB_RentaiCar || self.carType == EB_SpeciaiCar){
        if (self.block!=nil) {
            self.block(3,NO);
        }
    }
}

-(void)setCarType:(TCarBottomType)type
{
    carType = type;
    
    self.myRightBtn.frame = CGRectMake(self.frame.size.width/3, (self.frame.size.height - 40)/2, (self.frame.size.width/3)*2-20, 40);
    
    switch (type) {
        case EB_Not:
            self.myRightBtn.hidden = YES;
            self.myLeftBtn.hidden = YES;
            break;
        case EB_NewCar:
            {
                self.myRightBtn.frame = CGRectMake(10, (self.frame.size.height - 40)/2, self.frame.size.width-20, 40);
                self.myRightBtn.hidden = NO;
                [self.myRightBtn setTitle:@"询价" forState:UIControlStateNormal];
            }
            break;
        case EB_RentaiCar:
            {
                self.myRightBtn.hidden = NO;
                self.myLeftBtn.hidden = NO;
                [self.myRightBtn setTitle:@"预定" forState:UIControlStateNormal];
            }
            break;
        case EB_SpeciaiCar:
            {
                self.myRightBtn.hidden = NO;
                self.myLeftBtn.hidden = NO;
                [self.myRightBtn setTitle:@"预定" forState:UIControlStateNormal];
            }
            break;
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
