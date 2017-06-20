//
//  M_ShaixuanItemCell.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_ShaixuanItemCell.h"
#import "M_SeriesListModel.h"

@interface M_ShaixuanItemCell ()

AS_MODEL_STRONG(UILabel, myTitleLabel);
AS_MODEL_STRONG(UIImageView, myLineView);
AS_MODEL_STRONG(UIImageView, myIconView);

AS_MODEL_STRONG(UIButton, myTouchBtn);

@end

@implementation M_ShaixuanItemCell

DEF_MODEL(myLineView);
DEF_MODEL(myTitleLabel);
DEF_MODEL(myIconView);

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
//        UIImage* tempImage = [UIImage imageNamed:@"对勾.png"];
        
        self.myTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.bounds.size.width-20, 44)];
        [self.myTitleLabel setBackgroundColor:[UIColor clearColor]];
        [self.myTitleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.myTitleLabel setTextColor:[UIColor blackColor]];
        [self.myTitleLabel setTextAlignment:UITextAlignmentLeft];
        [self.contentView addSubview:self.myTitleLabel];
        
//        self.myIconView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width-tempImage.size.width-10, (44-tempImage.size.height)/2, tempImage.size.width, tempImage.size.height)];
//        self.myIconView.image = tempImage;
//        [self.contentView addSubview:self.myIconView];
        
        self.myLineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1)];
        self.myLineView.backgroundColor = RGBCOLOR(202, 202, 202);
        [self.contentView addSubview:self.myLineView];
        
        self.myTouchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.myTouchBtn.frame = CGRectMake(0, 0, self.bounds.size.width, 44);
        [self.myTouchBtn addTarget:self action:@selector(touchBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.myTouchBtn];
        
    }
    return self;
}

-(void)touchBtnPressed:(id)sender
{
    if (self.block!=nil) {
        self.block();
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    UIImage* tempImage = [UIImage imageNamed:@"对勾.png"];
    
    CGRect tempFrame = self.myTitleLabel.frame;
    tempFrame.size.width = self.bounds.size.width-20-tempImage.size.width;
    self.myTitleLabel.frame = tempFrame;
    
    tempFrame = self.myTouchBtn.frame;
    tempFrame.size.width = self.bounds.size.width;
    tempFrame.size.height = self.bounds.size.height;
    self.myTouchBtn.frame = tempFrame;
    
    tempFrame = self.myLineView.frame;
    tempFrame.size.width = self.bounds.size.width;
    self.myLineView.frame = tempFrame;
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array withTab:(NSInteger)tabIndex
{
    self.myTitleLabel.text = @"";
    self.myIconView.hidden = YES;
    
    switch (tabIndex) {
        case 0:
            {
                M_SeriesBrandModel* tempItem = [array objectAtIndex:indexPath.row];
                if (tempItem!=nil) {
                    
                    if ([tempItem.myName notEmpty]) {
                        self.myTitleLabel.text = tempItem.myName;
                    }
                    
                    //self.myIconView.hidden = !tempItem.isSelete;
                    
                    if (tempItem.isSelete) {
                        self.backgroundColor = [UIColor whiteColor];
                    }else{
                        self.backgroundColor = [UIColor clearColor];
                    }
                }
            }
            break;
        case 1:
            {
                self.backgroundColor = [UIColor whiteColor];
                
                M_SeriesItemModel* tempItem = [array objectAtIndex:indexPath.row];
                if (tempItem!=nil) {
                    
                    if ([tempItem.myName notEmpty]) {
                        self.myTitleLabel.text = tempItem.myName;
                    }
//                    self.myIconView.hidden = !tempItem.isSelete;
                    
                    if (tempItem.isSelete) {
                        [self.myTitleLabel setTextColor:[UIColor redColor]];
                    }else{
                        [self.myTitleLabel setTextColor:[UIColor blackColor]];
                    }
                }
            }
            break;
        default:
            break;
    }
    
    CGRect tempFrame = self.myLineView.frame;
    tempFrame.size.width = self.bounds.size.width;
    tempFrame.origin.y = self.bounds.size.height-1;
    self.myLineView.frame = tempFrame;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
