//
//  H_HomeItemView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/24.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "H_HomeItemView.h"
#import "M_CarItemView.h"

@interface H_HomeItemView ()

AS_MODEL_STRONG(M_CarItemView, myCarView);
AS_MODEL_STRONG(UIImageView, myImageView);

@end

@implementation H_HomeItemView

DEF_FACTORY_FRAME(H_HomeItemView);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.myCarView = [M_CarItemView allocInstanceFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.myCarView.showLine = NO;
        [self addSubview:self.myCarView];
        
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.myImageView];
        
        self.myCarView.hidden = YES;
        self.myImageView.hidden = YES;
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempFrame =self.myImageView.frame;
    tempFrame.size.width = self.bounds.size.width;
    tempFrame.size.height = self.bounds.size.height;
    self.myImageView.frame = tempFrame;
    
    tempFrame =self.myCarView.frame;
    tempFrame.size.width = self.bounds.size.width;
    tempFrame.size.height = self.bounds.size.height;
    self.myCarView.frame = tempFrame;
}

-(void)updateData:(M_IndexLineItemModel*)data
{
    if (data!=nil) {
        if ([data.myType notEmpty]) {
            if ([data.myType isEqualToString:@"1"]) {
                self.myImageView.hidden = NO;
                self.myCarView.hidden = YES;
                
                if (data.myCoverModel!=nil) {
                    if ([data.myCoverModel.myCover notEmpty]) {
                        [self.myImageView setImageWithURL:[NSURL URLWithString:data.myCoverModel.myCover] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
                    }
                }
                
            }else if ([data.myType isEqualToString:@"2"]){
                self.myImageView.hidden = YES;
                self.myCarView.hidden = NO;
                
                [self.myCarView updateData:data.myCarModel];
            }
        }
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
