//
//  LL_MyCenterCollectionCell.m
//  DHCarForUser
//
//  Created by leiyu on 16/3/23.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "LL_MyCenterCollectionCell.h"
@interface LL_MyCenterCollectionCell()
AS_MODEL_STRONG(UIImageView, myImageView);
AS_MODEL_STRONG(UILabel, myLable);
@end
@implementation LL_MyCenterCollectionCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =[UIColor whiteColor];
        [self initMyimageView:CGRectMake(self.frame.size.width/2-10, 21, 20, 20)];
        [self initMyLable:CGRectMake(0, CGRectGetMaxY(self.myImageView.frame)+10, frame.size.width, 20)];
    }
    return self;
}
-(void)initMyimageView:(CGRect)frame
{
    self.myImageView =[[UIImageView alloc]initWithFrame:frame];
    [self.contentView addSubview:self.myImageView];
}
-(void)initMyLable:(CGRect)frame
{
    self.myLable = [[UILabel alloc]initWithFrame:frame];
    self.myLable.textColor = [Unity getColor:@"#333333"];
    [self.contentView addSubview:self.myLable];
    self.myLable.textAlignment = NSTextAlignmentCenter;
    self.myLable.font = [UIFont systemFontOfSize:11];
}
-(void)updateMyCell:(NSString *)title andWithImageName:(NSString *)imageName
{
    self.myImageView.image = [UIImage imageNamed:imageName];
    self.myLable.text = title;
}
-(void)upDateOnlyMytitle:(NSString *)title
{
    self.myLable.text = title;
}
@end
