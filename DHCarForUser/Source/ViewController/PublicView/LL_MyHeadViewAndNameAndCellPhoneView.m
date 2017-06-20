//
//  LL_MyHeadViewAndNameAndCellPhoneView.m
//  DHCarForSales
//
//  Created by leiyu on 15/12/21.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "LL_MyHeadViewAndNameAndCellPhoneView.h"

#define edge 10
#define CustomHeadViewWidth 30
#define CustomHeadViewHeigth 30

@interface LL_MyHeadViewAndNameAndCellPhoneView()
AS_MODEL_STRONG(UIImageView, myCustomHeadImageView);
AS_MODEL_STRONG(UILabel, myCustomNameAndCellphoneLable);
AS_MODEL_STRONG(UILabel, myDatelabe);
//AS_MODEL_STRONG(LL_TestUsreInfoModel, myModel);
AS_MODEL_STRONG(UIImageView, myCashImageView);
@property(nonatomic,assign)MyUserNameAndPhoneType type;

@end
@implementation LL_MyHeadViewAndNameAndCellPhoneView
DEF_MODEL(myDatelabe);
DEF_MODEL(myCustomHeadImageView);
//DEF_MODEL(myModel);
DEF_MODEL(myCustomNameAndCellphoneLable);
DEF_MODEL(myCashImageView);

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [Unity getColor:@"#ffffff"];
        [self initWithMyCustomHeadViewWithFrame:CGRectMake(edge, 5, CustomHeadViewWidth, CustomHeadViewHeigth)];
        [self initWithMyCustonNameAndPhoneWithFrame:CGRectMake(CGRectGetMaxX(self.myCustomHeadImageView.frame)+10, CGRectGetMidY(self.myCustomHeadImageView.frame)-10, 200, 20)];
        
        [self initWithMyDateLableWithFrame:CGRectMake(self.bounds.size.width-edge-80, CGRectGetMinY(self.myCustomNameAndCellphoneLable.frame), 150, 20)];
        self.myCashImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, frame.size.height -1, frame.size.width, 1)];
        self.myCashImageView.image = [UIImage imageNamed:@"dashedLine"];
        [self addSubview:self.myCashImageView];
        
    }
    return self;
}
-(void)initWithMyCustomHeadViewWithFrame:(CGRect)frame
{
    self.myCustomHeadImageView = [[UIImageView alloc]initWithFrame:frame];
    self.myCustomHeadImageView.layer.masksToBounds = YES;
    self.myCustomHeadImageView.layer.cornerRadius =CustomHeadViewHeigth/2;
    [self addSubview:self.myCustomHeadImageView];
}
-(void)initWithMyCustonNameAndPhoneWithFrame:(CGRect)frame
{
    self.myCustomNameAndCellphoneLable = [[UILabel alloc]initWithFrame:frame];
    self.myCustomNameAndCellphoneLable.textAlignment = NSTextAlignmentLeft;
    self.myCustomNameAndCellphoneLable.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.myCustomNameAndCellphoneLable];
    
}
-(void)initWithMyDateLableWithFrame:(CGRect)frame
{
    self.myDatelabe = [[UILabel alloc]initWithFrame:frame];
    self.myDatelabe.textColor = [Unity getColor:@"#bfbfbf"];
    self.myDatelabe.textAlignment = NSTextAlignmentRight;
    self.myDatelabe.font = [UIFont systemFontOfSize:12];
    [self addSubview:myDatelabe];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat boundWidth = self.bounds.size.width;
    
    CGRect tempFrame = self.myDatelabe.frame;
    tempFrame.origin.x = boundWidth -edge -150;
    self.myDatelabe.frame = tempFrame;
    
    tempFrame = self.myCashImageView.frame;
    tempFrame.size.width = boundWidth;
    self.myCashImageView.frame = tempFrame;
    
}


-(void)upDataUserHeaderUrl:(NSString *)headUrl
               andUserName:(NSString *)userName
              andCellPhone:(NSString *)userCellphone
                   andDate:(NSString *)date
               andWithType:(MyUserNameAndPhoneType )type
{
    self.myCustomHeadImageView.hidden = YES;
    
    self.myCustomNameAndCellphoneLable.hidden = YES;
    
    self.myDatelabe.hidden = YES;
    
    if (type == LL_HaveUserHeadImageView) {
        
        self.myCustomHeadImageView.hidden = NO;
       
        if ([headUrl isUrl]) {
           
            [self.myCustomHeadImageView setImageWithURL:[NSURL URLWithString:headUrl] placeholderImage:[UIImage imageNamed:@"icon_head"]];
        }
        else
        {
            self.myCustomHeadImageView.image = [UIImage imageNamed:@"icon_head"];
        }
        
        
        if ([userName isEqualToString:@""]||[userCellphone isEqualToString:@""]) {
           
            self.myCustomNameAndCellphoneLable.hidden = YES;
        
        }
        else
        {
            self.myCustomNameAndCellphoneLable.hidden = NO;
            
            NSString *text = [NSString stringWithFormat:@"%@  %@",userName,userCellphone];
            
            NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc]initWithString:text];
            
            [attstr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(0, userName.length)];
            
            [attstr addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"#000000"] range:NSMakeRange(0, userName.length)];
            
            
            [attstr addAttribute:NSFontAttributeName  value:[UIFont systemFontOfSize:12] range:NSMakeRange(userName.length +1, userCellphone.length)];
            
            [attstr addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"#666666"] range:NSMakeRange(userName.length +1, userCellphone.length+1)];
            
            self.myCustomNameAndCellphoneLable.attributedText = attstr;
        }
       
        if ([date isEqualToString:@""]) {
            
            self.myDatelabe.hidden = YES;
        
        }
        else
        {
            self.myDatelabe.hidden = NO;
            
            self.myDatelabe.text = date ;
        }
       
        
    }
    if (type == LL_HidenUserHeadImageView) {
        self.myCustomHeadImageView.hidden = YES;
        
        if ([userName isEqualToString:@""]||[userCellphone isEqualToString:@""]) {
            
            self.myCustomNameAndCellphoneLable.hidden = YES;
            
        }
        else
        {
            self.myCustomNameAndCellphoneLable.hidden = NO;
            
            NSString *text = [NSString stringWithFormat:@"%@  %@",userName,userCellphone];
            
            NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc]initWithString:text];
            
            [attstr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(0, userName.length)];
            
            [attstr addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"#000000"] range:NSMakeRange(0, userName.length)];
            
            
            [attstr addAttribute:NSFontAttributeName  value:[UIFont systemFontOfSize:12] range:NSMakeRange(userName.length +1, userCellphone.length)];
            
            [attstr addAttribute:NSForegroundColorAttributeName value:[Unity getColor:@"#666666"] range:NSMakeRange(userName.length +1, userCellphone.length+1)];
            
            self.myCustomNameAndCellphoneLable.attributedText = attstr;
        }
       
        CGRect tempFrame = self.myCustomNameAndCellphoneLable.frame;
        
        tempFrame.origin.x = 10;
        
        tempFrame.origin.y =10;
        
        self.myCustomNameAndCellphoneLable.frame = tempFrame;
        
        if ([date isEqualToString:@""]) {
            
            self.myDatelabe.hidden = YES;
            
        }
        else
        {
            self.myDatelabe.hidden = NO;
            
            self.myDatelabe.text = date ;
        }

        
    }
    
}

@end
