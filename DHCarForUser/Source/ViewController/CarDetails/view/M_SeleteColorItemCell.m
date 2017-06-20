//
//  M_SeleteColorItemCell.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/24.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_SeleteColorItemCell.h"

@interface M_SeleteColorItemCell ()

AS_MODEL_STRONG(UILabel, myKeyLabel);
AS_MODEL_STRONG(UIView, myView);

@end

@implementation M_SeleteColorItemCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        self.myView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, self.bounds.size.width, 50)];
        [self.myView setBackgroundColor:[UIColor whiteColor]];
        self.myView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.myView];
        
        self.myKeyLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, self.bounds.size.width-40, 50)];
        [self.myKeyLabel setBackgroundColor:[UIColor clearColor]];
        self.myKeyLabel.font = [UIFont systemFontOfSize:14];
        self.myKeyLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:self.myKeyLabel];
        
        UITapGestureRecognizer *tempsingleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
        tempsingleTap.numberOfTapsRequired=1;
        [self.myView addGestureRecognizer:tempsingleTap];
    }
    return self;
}

-(void)singleTap:(UITapGestureRecognizer*)gesture
{
    if (self.block!=nil) {
        self.block();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGRect tempFrame = self.myKeyLabel.frame;
    tempFrame.size.width = self.bounds.size.width-40;
    self.myKeyLabel.frame = tempFrame;
    
    tempFrame = self.myView.frame;
    tempFrame.size.width = self.bounds.size.width;
    self.myView.frame = tempFrame;

}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    NSMutableDictionary* tempDic = [array objectAtIndex:indexPath.row];
    
    if (tempDic!=nil) {
        
        NSString* tempKey = [tempDic hasItemAndBack:@"key"];
        NSString* tempValue = [tempDic hasItemAndBack:@"value"];
        
        if ([tempKey notEmpty] && [tempValue notEmpty]) {
            self.myKeyLabel.text = [NSString stringWithFormat:@"%@%@",tempKey,tempValue];
            
            NSMutableAttributedString* tempAttr = [[NSMutableAttributedString alloc]initWithString:self.myKeyLabel.text];
            
            [tempAttr addAttribute:NSForegroundColorAttributeName
                             value:[UIColor blackColor]
                             range:NSMakeRange(0, tempKey.length)];
            
            self.myKeyLabel.attributedText = tempAttr;
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
