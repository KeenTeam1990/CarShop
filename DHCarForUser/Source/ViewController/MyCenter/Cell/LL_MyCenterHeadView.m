
//
//  LL_MyCenterHeadView.m
//  DHCarForUser
//
//  Created by leiyu on 16/3/23.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "LL_MyCenterHeadView.h"
@interface LL_MyCenterHeadView()
AS_MODEL_STRONG(UIImageView, myBackImageView);
AS_MODEL_STRONG(UIButton, MyHeadViewbtn);
@end
@implementation LL_MyCenterHeadView
DEF_MODEL(MyHeadViewbtn);
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initMyBackImageView:frame];
        [self initMyHeadBtn:CGRectMake(frame.size.width/2-36, 21, 72, 72)];
        [self initMyNameLable:CGRectMake(0, CGRectGetMaxY(self.MyHeadViewbtn.frame)+12, frame.size.width, 20)];
    }
    return self;
}
-(void)initMyBackImageView:(CGRect)frame
{
    self.myBackImageView = [[UIImageView alloc]initWithFrame:frame];
    [self addSubview:self.myBackImageView];
    self.myBackImageView.image = [UIImage imageNamed:@"mine_bg"];
}
-(void)initMyHeadBtn:(CGRect)frame
{
    self.MyHeadViewbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.MyHeadViewbtn .frame = frame;
    [self.MyHeadViewbtn setBackgroundImage:[UIImage imageNamed:@"DefaultAvatar"] forState:UIControlStateNormal];
    self.MyHeadViewbtn.clipsToBounds = YES;
    self.MyHeadViewbtn.layer.cornerRadius = frame.size.height/2;
    [self addSubview:self.MyHeadViewbtn];
}
-(void)initMyNameLable:(CGRect)frame
{
    self.myNameAndSexbtn = [[UIButton alloc]initWithFrame:frame];
    [self addSubview:self.myNameAndSexbtn];
    [self.myNameAndSexbtn setTitleColor:[Unity getColor:@"#000000"] forState:UIControlStateNormal];
    [self.myNameAndSexbtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    self.myNameAndSexbtn.userInteractionEnabled = NO;
    self.myNameAndSexbtn.hidden = YES;
    
    
}
-(void)updateMyHeadImage:(NSString *)url andWithMyName:(NSString *)name andWihtSex:(NSString *)sex
{
//    [self.MyHeadViewbtn setImageForState:UIControlStateSelected withURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"userImage"]];
    if (url == nil) {
        [self.MyHeadViewbtn setImage:[UIImage imageNamed:@"userImage"] forState:UIControlStateNormal];

    } else {
        [self.MyHeadViewbtn setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"userImage"]];
    }
    self.MyHeadViewbtn.hidden = NO;
    self.myNameAndSexbtn.hidden = NO;
    NSString *sexImage;
    if ([sex isEqualToString:@"1"] ||[sex isEqualToString:@"男"]) {
        sexImage = @"female";
    }
    else if([sex isEqualToString:@"0"] || [sex isEqualToString:@"女"])
    {
        sexImage = @"male";
    }
    else if([sex isEqualToString:@"2"] || [sex isEqualToString:@"女"])
    {
        sexImage = @"male";
    }
    
    [self.myNameAndSexbtn setTitle:name forState:UIControlStateNormal];
    
    [self.myNameAndSexbtn setImage:[UIImage imageNamed:sexImage] forState:UIControlStateNormal];
    CGFloat moveWidth =[Unity getLableWidthWithString:name andFontSize:14];
    [ self.myNameAndSexbtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -24, 0, 24)];
    [self.myNameAndSexbtn setImageEdgeInsets:UIEdgeInsetsMake(0,moveWidth, 0, -moveWidth)];
}

@end
