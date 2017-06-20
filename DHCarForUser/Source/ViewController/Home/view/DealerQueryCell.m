//
//  DealerQueryCell.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DealerQueryCell.h"
#import "M_DealerItemModel.h"

#define KLeftOffset 10
#define KLabelWidth 50

@interface DealerQueryCell ()

AS_MODEL_STRONG(UIButton, myNumIconView);
AS_MODEL_STRONG(UILabel, myNameLabel);
AS_MODEL_STRONG(UILabel, myAddrLabel);
AS_MODEL_STRONG(UILabel, myTellLabel);
AS_MODEL_STRONG(UIImageView, myLineView);

@end

@implementation DealerQueryCell

DEF_MODEL(myAddrLabel);

DEF_MODEL(myLineView);
DEF_MODEL(myNameLabel);
DEF_MODEL(myNumIconView);
DEF_MODEL(myTellLabel);

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        [self initRow1View:CGRectMake(0, 5, self.bounds.size.width, 30)];
        
        [self initRow2View:CGRectMake(0, 30, self.bounds.size.width, 40)];
        
        [self initRow3View:CGRectMake(0, 70, self.bounds.size.width, 30)];
    }
    return self;
}

-(UILabel*)getLabel:(CGRect)frame
{
    UILabel* tempLabel = [[UILabel alloc]initWithFrame:frame];
    [tempLabel setBackgroundColor:[UIColor clearColor]];
    [tempLabel setFont:[UIFont systemFontOfSize:14]];
    [tempLabel setTextColor:RGBCOLOR(102, 102, 102)];
    [self.contentView addSubview:tempLabel];
    return tempLabel;
}

-(void)initRow1View:(CGRect)frame
{
    UIImage* tempIconBgImage = [UIImage imageNamed:@"icon_red_bg.png"];
    
    self.myNumIconView = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.myNumIconView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.myNumIconView.titleLabel setFont:[UIFont systemFontOfSize:9]];
    [self.myNumIconView setBackgroundImage:tempIconBgImage forState:UIControlStateNormal];
    self.myNumIconView.frame = CGRectMake(KLeftOffset, frame.origin.y+(frame.size.height-tempIconBgImage.size.height)/2, tempIconBgImage.size.width, tempIconBgImage.size.height);
    self.myNumIconView.userInteractionEnabled = NO;
    [self.contentView addSubview:self.myNumIconView];
    
    self.myNameLabel = [self getLabel:CGRectMake(KLeftOffset*2+tempIconBgImage.size.width, frame.origin.y, frame.size.width-KLeftOffset*2-tempIconBgImage.size.width, frame.size.height)];
    [self.myNameLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [self.myNameLabel setTextColor:[UIColor redColor]];
}

-(void)initRow2View:(CGRect)frame
{
    UIImage* tempIconBgImage = [UIImage imageNamed:@"icon_red_bg.png"];
    
    UILabel* tempLabel = [self getLabel:CGRectMake(KLeftOffset*2+tempIconBgImage.size.width, frame.origin.y+(frame.size.height-30)/2, KLabelWidth, 30)];
    tempLabel.text  = @"地址：";
    
    self.myAddrLabel = [self getLabel:CGRectMake(tempLabel.frame.origin.x+KLabelWidth, frame.origin.y, frame.size.width-KLabelWidth-KLeftOffset*2-tempIconBgImage.size.width, frame.size.height)];
    [self.myAddrLabel setNumberOfLines:2];
}

-(void)initRow3View:(CGRect)frame
{
    UIImage* tempIconBgImage = [UIImage imageNamed:@"icon_red_bg.png"];
    
    UILabel* tempLabel = [self getLabel:CGRectMake(KLeftOffset*2+tempIconBgImage.size.width, frame.origin.y, KLabelWidth, frame.size.height)];
    tempLabel.text  = @"电话：";
    
    self.myTellLabel = [self getLabel:CGRectMake(tempLabel.frame.origin.x+KLabelWidth, frame.origin.y, frame.size.width-KLabelWidth-KLeftOffset*2-tempIconBgImage.size.width, frame.size.height)];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    UIImage* tempIconBgImage = [UIImage imageNamed:@"icon_red_bg.png"];
    
    CGRect tempFrame = self.myNameLabel.frame;
    tempFrame.size.width = self.bounds.size.width-KLeftOffset*3-tempIconBgImage.size.width;
    self.myNameLabel.frame = tempFrame;
    
    tempFrame = self.myTellLabel.frame;
    tempFrame.size.width = self.bounds.size.width-KLeftOffset*3-KLabelWidth-tempIconBgImage.size.width;
    self.myTellLabel.frame = tempFrame;
    
    tempFrame = self.myAddrLabel.frame;
    tempFrame.size.width = self.bounds.size.width-KLeftOffset*3-KLabelWidth-tempIconBgImage.size.width;
    self.myAddrLabel.frame = tempFrame;
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    M_DealerItemModel* tempItem = [array objectAtIndex:indexPath.row];
    
    if (tempItem!=nil) {
        
        self.myNameLabel.text = @"";
        self.myAddrLabel.text = @"";
        self.myTellLabel.text = @"";
        [self.myNumIconView setTitle:[NSString fromInt:(int)indexPath.row] forState:UIControlStateNormal];
        
        if ([tempItem.dealer_tel notEmpty]) {
            self.myTellLabel.text = tempItem.dealer_tel;
        }
        if ([tempItem.dealer_name notEmpty]) {
            self.myNameLabel.text = tempItem.dealer_name;
        }
        if ([tempItem.dealer_address notEmpty]) {
            self.myAddrLabel.text = tempItem.dealer_address;
        }
        
    }
}

@end
