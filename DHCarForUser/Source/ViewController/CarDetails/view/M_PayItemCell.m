//
//  M_PayItemCell.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/17.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_PayItemCell.h"

@interface M_PayItemCell ()

AS_MODEL_STRONG(UIButton, mySeleteButton);

@end

@implementation M_PayItemCell

DEF_MODEL(mySeleteButton);

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        [self.textLabel setFont:[UIFont systemFontOfSize:14]];
        
        self.mySeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.mySeleteButton.frame = CGRectMake(self.bounds.size.width-50, 0, 50, 50);
        self.mySeleteButton.userInteractionEnabled = NO;
        
        [self.mySeleteButton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
        [self.mySeleteButton setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateSelected];
        
        [self.contentView addSubview:self.mySeleteButton];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempFrame= self.mySeleteButton.frame;
    tempFrame.origin.x = self.bounds.size.width-50;
    self.mySeleteButton.frame = tempFrame;
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    NSMutableDictionary* tempDic = [array objectAtIndex:indexPath.row];
    if (tempDic!=nil) {
        
        NSString* tempName = [tempDic hasItemAndBack:@"name"];
//        NSString* tempId = [tempDic hasItemAndBack:@"id"];
        NSString* tempIcon = [tempDic hasItemAndBack:@"icon"];
        NSString* tempSeleted = [tempDic hasItemAndBack:@"seleted"];
        
        self.textLabel.text = tempName;
        self.imageView.image = [UIImage imageNamed:tempIcon];
        
        [self.mySeleteButton setSelected:[tempSeleted toBool]];
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
