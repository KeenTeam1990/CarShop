//
//  M_CityItemCell.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CityItemCell.h"
#import "M_CityListModel.h"

@implementation M_CityItemCell


DEF_MODEL(myLineView);

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        [self.textLabel setFont:[UIFont systemFontOfSize:14]];
        
        self.myLineView = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.myLineView.backgroundColor = RGBCOLOR(202, 202, 202);
//        self.myLineView.image = [UIImage imageNamed:@"dashedLine.png"];
        [self.contentView addSubview:self.myLineView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempFrame = self.myLineView.frame;
    tempFrame.origin.y = self.bounds.size.height-1;
    tempFrame.size.width = self.bounds.size.width-30;
    self.myLineView.frame = tempFrame;
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    M_CityItemModel* tempitem = [array objectAtIndex:indexPath.row];
    
    if (tempitem!=nil) {
        
        self.textLabel.text = @"";

        if ([tempitem.myCity_Name notEmpty]) {
            self.textLabel.text = tempitem.myCity_Name;
        }
        
        self.myLineView.frame = CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width-30, 1);
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
