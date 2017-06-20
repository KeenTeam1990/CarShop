//
//  D_VersionHeadView.m
//  DHCarForSales
//
//  Created by leiyu on 15/11/10.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_VersionHeadView.h"
#import "M_VersionModel.h"

#define versionLableSize 14
#define logoHeadViewWidth 70
@interface D_VersionHeadView()
@property(nonatomic,strong)UIImageView *logoHeadImageView;
@property(nonatomic,strong)UILabel *verSionLable;
@end


@implementation D_VersionHeadView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self initlogoHeadImageViewWithFrame:CGRectMake(SCREEN_WIDTH/2-logoHeadViewWidth/2, 40, 70, 70)];
        [self initVersionLable];
    }
    return self;
}
-(void)initlogoHeadImageViewWithFrame:(CGRect)frame
{
    _logoHeadImageView=[[UIImageView alloc]initWithFrame:frame];
    [self addSubview:_logoHeadImageView];
}
-(void)initVersionLable
{
    _verSionLable=[[UILabel alloc]init];
    _verSionLable.font=[UIFont systemFontOfSize:versionLableSize];
    _verSionLable.textColor=[Unity getColor:@"#666666"];
    [self addSubview:_verSionLable];
}
-(void)setModel:(M_VersionModel *)model
{
    _model=model;
    _logoHeadImageView.image=[UIImage imageNamed:_model.logoImageViewUrl];
    _verSionLable.text=_model.version;
    CGFloat verSionLableWidth=[Unity getLableWidthWithString:_model.version andFontSize:versionLableSize];
    _verSionLable.frame=CGRectMake(SCREEN_WIDTH/2-verSionLableWidth/2-10, CGRectGetMaxY(_logoHeadImageView.frame), verSionLableWidth+20, 30);
}

@end
