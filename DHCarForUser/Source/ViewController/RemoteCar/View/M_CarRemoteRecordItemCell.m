//
//  M_CarRemoteRecordItemCell.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarRemoteRecordItemCell.h"
#import "M_CarRemoteListModel.h"

#define KLeftOffset 20
#define KLabelWidth 70

@interface M_CarRemoteRecordItemCell ()

AS_MODEL_STRONG(UILabel, myDateLable);
AS_MODEL_STRONG(UILabel, myAddrLable);
AS_MODEL_STRONG(UILabel, myNumLable);
AS_MODEL_STRONG(UILabel, myTypeLable);
AS_MODEL_STRONG(UILabel, myTimeLable);
AS_MODEL_STRONG(UIImageView, myLine);

@end

@implementation M_CarRemoteRecordItemCell

DEF_MODEL(myAddrLable);
DEF_MODEL(myDateLable);
DEF_MODEL(myLine);
DEF_MODEL(myNumLable);
DEF_MODEL(myTimeLable);
DEF_MODEL(myTypeLable);

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        [self initRow1View:CGRectMake(0, 0, self.bounds.size.width, 30)];
        
        [self initRow2View:CGRectMake(0, 30, self.bounds.size.width, 30)];

        [self initRow3View:CGRectMake(0, 60, self.bounds.size.width, 30)];
        
        UIImageView* tempLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 85, self.bounds.size.width, 10)];
        tempLine.tag = 9993;
        tempLine.backgroundColor = RGBCOLOR(201, 201, 201);
        [self.contentView addSubview:tempLine];
        
    }
    return self;
}

-(void)initRow1View:(CGRect)frame
{
    UILabel* tempLabel1 = [self getLabel:CGRectMake(KLeftOffset, frame.origin.y+(frame.size.height-30)/2, KLabelWidth, 30)];
    tempLabel1.text = @"用车日期：";
    
    self.myDateLable = [self getLabel:CGRectMake(KLeftOffset+KLabelWidth, frame.origin.y+(frame.size.height-30)/2, frame.size.width/2-KLabelWidth-KLeftOffset, 30)];
    [self.myDateLable setFont:[UIFont systemFontOfSize:12]];
    [self.myDateLable setTextColor:RGBCOLOR(0, 123, 206)];
    
    UILabel* tempLabel2 = [self getLabel:CGRectMake(frame.size.width/2, frame.origin.y+(frame.size.height-30)/2, KLabelWidth, 30)];
    tempLabel2.text = @"用车地点：";
    tempLabel2.tag = 9991;
    
    self.myAddrLable = [self getLabel:CGRectMake(frame.size.width/2+KLabelWidth, frame.origin.y+(frame.size.height-30)/2, frame.size.width/2-KLabelWidth-KLeftOffset, 30)];
    [self.myAddrLable setFont:[UIFont systemFontOfSize:12]];
    [self.myAddrLable setTextColor:RGBCOLOR(102, 102, 102)];
}

-(void)initRow2View:(CGRect)frame
{
    UILabel* tempLabel1 = [self getLabel:CGRectMake(KLeftOffset, frame.origin.y+(frame.size.height-30)/2, self.bounds.size.width/2, 30)];
    tempLabel1.text = @"用车人数：";
    
    self.myNumLable = [self getLabel:CGRectMake(KLeftOffset+KLabelWidth, frame.origin.y+(frame.size.height-30)/2, frame.size.width/2-KLabelWidth-KLeftOffset, 30)];
    [self.myNumLable setFont:[UIFont systemFontOfSize:12]];
    [self.myNumLable setTextColor:RGBCOLOR(102, 102, 102)];
    
    UILabel* tempLabel2 = [self getLabel:CGRectMake(frame.size.width/2, frame.origin.y+(frame.size.height-30)/2, KLabelWidth, 30)];
    tempLabel2.text = @"用车类型：";
    tempLabel2.tag = 9992;
    
    self.myTypeLable = [self getLabel:CGRectMake(frame.size.width/2+KLabelWidth, frame.origin.y+(frame.size.height-30)/2, frame.size.width/2-KLabelWidth-KLeftOffset, 30)];
    [self.myTypeLable setFont:[UIFont systemFontOfSize:12]];
    [self.myTypeLable setTextColor:RGBCOLOR(102, 102, 102)];
}

-(void)initRow3View:(CGRect)frame
{
    self.myLine = [[UIImageView alloc]initWithFrame:CGRectMake(KLeftOffset, frame.origin.y, frame.size.width-KLeftOffset*2, 1)];
    self.myLine.image = [UIImage imageNamed:@"dashedLine.png"];
    [self.contentView addSubview:self.myLine];
    
    self.myTimeLable = [self getLabel:CGRectMake(frame.size.width-140-KLeftOffset, frame.origin.y+(frame.size.height-30)/2, 140, 30)];
    [self.myTimeLable setFont:[UIFont systemFontOfSize:12]];
    [self.myTimeLable setTextAlignment:UITextAlignmentRight];
}

-(UILabel*)getLabel:(CGRect)frame
{
    UILabel* tempLabel = [[UILabel alloc]initWithFrame:frame];
    [tempLabel setBackgroundColor:[UIColor clearColor]];
    [tempLabel setFont:[UIFont systemFontOfSize:14]];
    [tempLabel setTextColor:[UIColor blackColor]];
    [self.contentView addSubview:tempLabel];
    return tempLabel;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempFrame = self.myDateLable.frame;
    tempFrame.size.width = self.frame.size.width/2-KLabelWidth-KLeftOffset;
    self.myDateLable.frame = tempFrame;
    
    tempFrame = self.myAddrLable.frame;
    tempFrame.origin.x = self.frame.size.width/2+KLabelWidth;
    tempFrame.size.width = self.frame.size.width/2-KLabelWidth-KLeftOffset;
    self.myAddrLable.frame = tempFrame;
    
    tempFrame = self.myNumLable.frame;
    tempFrame.size.width = self.frame.size.width/2-KLabelWidth-KLeftOffset;
    self.myNumLable.frame = tempFrame;
    
    tempFrame = self.myTypeLable.frame;
    tempFrame.origin.x = self.frame.size.width/2+KLabelWidth;
    tempFrame.size.width = self.frame.size.width/2-KLabelWidth-KLeftOffset;
    self.myTypeLable.frame = tempFrame;
    
    tempFrame = self.myLine.frame;
    tempFrame.size.width = self.frame.size.width-KLeftOffset;
    self.myLine.frame = tempFrame;
    
    tempFrame = self.myTimeLable.frame;
    tempFrame.origin.x = self.frame.size.width-KLeftOffset-140;
    self.myTimeLable.frame = tempFrame;
    
    UILabel* tempLabel = [self.contentView viewWithTag:9991];
    if (tempLabel!=nil) {
        tempFrame = tempLabel.frame;
        tempFrame.origin.x = self.frame.size.width/2;
        tempLabel.frame = tempFrame;
    }
    
    tempLabel = [self.contentView viewWithTag:9992];
    if (tempLabel!=nil) {
        tempFrame = tempLabel.frame;
        tempFrame.origin.x = self.frame.size.width/2;
        tempLabel.frame = tempFrame;
    }
    
    UIImageView* tempLine = [self.contentView viewWithTag:9993];
    if (tempLine!=nil) {
        tempFrame = tempLine.frame;
        tempFrame.size.width = self.frame.size.width;
        tempLine.frame = tempFrame;
    }
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    M_CarRemoteItemModel* tempItem = [array objectAtIndex:indexPath.row];
    if (tempItem!=nil) {
        
        self.myAddrLable.text = @"";
        self.myDateLable.text = @"";
        self.myNumLable.text = @"";
        self.myTimeLable.text = @"";
        self.myTypeLable.text = @"";
        
        if ([tempItem.rentalCar_MakeTime notEmpty]) {
            self.myDateLable.text = tempItem.rentalCar_MakeTime;
        }
        if ([tempItem.cityName notEmpty]) {
            self.myAddrLable.text = tempItem.cityName;
        }
        if ([tempItem.rentalCar_PersonName notEmpty]) {
            self.myNumLable.text = tempItem.rentalCar_PersonName;
        }
        if ([tempItem.rentalCar_TypeName notEmpty]) {
            self.myTypeLable.text = tempItem.rentalCar_TypeName;
        }
        if ([tempItem.rentalCar_CreateTime notEmpty]) {
            self.myTimeLable.text = tempItem.rentalCar_CreateTime;
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
