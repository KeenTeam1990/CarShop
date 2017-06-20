//
//  M_CarInsuranceRecordItemCell.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarInsuranceRecordItemCell.h"
#import "M_CarInsuranceListModel.h"

#define KLeftOffset 20
#define KLabelWidth 70

@interface M_CarInsuranceRecordItemCell ()

AS_MODEL_STRONG(UILabel, myCarPlateLabel);
AS_MODEL_STRONG(UILabel, myCarFrameLabel);
AS_MODEL_STRONG(UILabel, myCommenyLabel);
AS_MODEL_STRONG(UILabel, myTimeLabel);

@end

@implementation M_CarInsuranceRecordItemCell

DEF_MODEL(myCarFrameLabel);
DEF_MODEL(myCarPlateLabel);
DEF_MODEL(myCommenyLabel);
DEF_MODEL(myTimeLabel);

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
        
        [self initRow4View:CGRectMake(0, 90, self.bounds.size.width, 30)];
        
        UIImageView* tempLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 120, self.bounds.size.width, 10)];
        tempLine.backgroundColor = RGBCOLOR(201, 201, 201);
        [self.contentView addSubview:tempLine];
        
    }
    return self;
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

-(void)initRow1View:(CGRect)frame
{
    UILabel* tempLabel1 = [self getLabel:CGRectMake(KLeftOffset, frame.origin.y+(frame.size.height-30)/2, KLabelWidth, 30)];
    tempLabel1.text = @"车牌号：";
    
    self.myCarPlateLabel = [self getLabel:CGRectMake(KLeftOffset+KLabelWidth, frame.origin.y+(frame.size.height-30)/2, frame.size.width-KLabelWidth-KLeftOffset, 30)];
    [self.myCarPlateLabel setTextColor:RGBCOLOR(0, 123, 206)];
    
    UIImageView* tempLine= [[UIImageView alloc]initWithFrame:CGRectMake(KLeftOffset, frame.origin.y+frame.size.height-1, frame.size.width-KLeftOffset*2, 1)];
    tempLine.image = [UIImage imageNamed:@"dashedLine.png"];
    [self.contentView addSubview:tempLine];
}

-(void)initRow2View:(CGRect)frame
{
    UILabel* tempLabel1 = [self getLabel:CGRectMake(KLeftOffset, frame.origin.y+(frame.size.height-30)/2, KLabelWidth, 30)];
    tempLabel1.text = @"车架号：";
    
    self.myCarFrameLabel = [self getLabel:CGRectMake(KLeftOffset+KLabelWidth, frame.origin.y+(frame.size.height-30)/2, frame.size.width-KLabelWidth-KLeftOffset, 30)];
    [self.myCarFrameLabel setTextColor:RGBCOLOR(102, 102, 102)];
    
    UIImageView* tempLine= [[UIImageView alloc]initWithFrame:CGRectMake(KLeftOffset, frame.origin.y+frame.size.height-1, frame.size.width-KLeftOffset*2, 1)];
    tempLine.image = [UIImage imageNamed:@"dashedLine.png"];
    [self.contentView addSubview:tempLine];
}

-(void)initRow3View:(CGRect)frame
{
    UILabel* tempLabel1 = [self getLabel:CGRectMake(KLeftOffset, frame.origin.y+(frame.size.height-30)/2, KLabelWidth, 30)];
    tempLabel1.text = @"保险公司：";
    
    self.myCommenyLabel = [self getLabel:CGRectMake(KLeftOffset+KLabelWidth, frame.origin.y+(frame.size.height-30)/2, frame.size.width-KLabelWidth-KLeftOffset, 30)];
    [self.myCommenyLabel setTextColor:RGBCOLOR(102, 102, 102)];
    
    UIImageView* tempLine= [[UIImageView alloc]initWithFrame:CGRectMake(KLeftOffset, frame.origin.y+frame.size.height-1, frame.size.width-KLeftOffset*2, 1)];
    tempLine.image = [UIImage imageNamed:@"dashedLine.png"];
    [self.contentView addSubview:tempLine];
}

-(void)initRow4View:(CGRect)frame
{
    self.myTimeLabel = [self getLabel:CGRectMake(frame.size.width-140-KLeftOffset, frame.origin.y+(frame.size.height-30)/2, 140, 30)];
    [self.myTimeLabel setFont:[UIFont systemFontOfSize:12]];
    [self.myTimeLabel setTextAlignment:UITextAlignmentRight];
}


-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    M_CarInsuranceItemModel* tempItem = [array objectAtIndex:indexPath.row];
    if (tempItem!=nil) {
        
        self.myTimeLabel.text = @"";
        self.myCommenyLabel.text =@"";
        self.myCarPlateLabel.text = @"";
        self.myCarFrameLabel.text = @"";
        
        if ([tempItem.carShelfNumber notEmpty]) {
            self.myCarFrameLabel.text = tempItem.carShelfNumber;
        }
        if ([tempItem.carNumber notEmpty]) {
            self.myCarPlateLabel.text = tempItem.carNumber;
        }
        if ([tempItem.insuranceCommpany notEmpty]) {
            self.myCommenyLabel.text = tempItem.insuranceCommpany;
        }
        if ([tempItem.insuranceCreateTime notEmpty]) {
            self.myTimeLabel.text = tempItem.insuranceCreateTime;
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
