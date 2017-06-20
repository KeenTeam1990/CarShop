//
//  M_CarDistributorItemView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/3.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarDistributorItemView.h"

#define KLeftOffset 20

@interface M_CarDistributorItemView ()

AS_MODEL_STRONG(UILabel, myNameLabel);
AS_MODEL_STRONG(UIImageView, myAddrIconView);
AS_MODEL_STRONG(UIImageView, myTellIconView);
AS_MODEL_STRONG(UILabel, myAddrLabel);
AS_MODEL_STRONG(UILabel, myTellLabel);
AS_MODEL_STRONG(UILabel, myPriceLabel);
AS_MODEL_STRONG(UILabel, myDistanceLabel);
AS_MODEL_STRONG(UIImageView, myLineView);
AS_MODEL_STRONG(UIImageView, mySeleteIconView);

AS_MODEL_STRONG(UIButton, myTouchBtn);

@end

@implementation M_CarDistributorItemView

DEF_FACTORY_FRAME(M_CarDistributorItemView);

DEF_MODEL(myAddrIconView);
DEF_MODEL(myAddrLabel);
DEF_MODEL(myDistanceLabel);
DEF_MODEL(myLineView);
DEF_MODEL(myNameLabel);
DEF_MODEL(myPriceLabel);
DEF_MODEL(myTellIconView);
DEF_MODEL(myTellLabel);
DEF_MODEL(mySeleteIconView);

DEF_MODEL(block);

DEF_MODEL(showLine);
DEF_MODEL(showDistance);
DEF_MODEL(showPrice);

DEF_MODEL(myTouchBtn);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.showLine = YES;
        self.showPrice = YES;
        self.showDistance = YES;
        self.showSelete = NO;
        
        [self initRow1View:CGRectMake(0, 0, frame.size.width, 30)];
        
        [self initRow2View:CGRectMake(0, 30, frame.size.width, 50)];
        
        [self initRow3View:CGRectMake(0, 80, frame.size.width, 30)];
        
        UIImage* tempImage = [UIImage imageNamed:@"details_select.png"];
        self.mySeleteIconView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-tempImage.size.width, 0, tempImage.size.width, tempImage.size.height)];
        [self.mySeleteIconView setImage:tempImage];
        self.mySeleteIconView.hidden = YES;
        [self addSubview:self.mySeleteIconView];
        
        self.myTouchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.myTouchBtn.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self.myTouchBtn addTarget:self action:@selector(touchBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.myTouchBtn];
    }
    
    return self;
}

-(void)touchBtnPressed:(id)sender
{
    if (self.block!=nil) {
        self.block();
    }
}

-(void)setShowSelete:(BOOL)selete
{
    _showSelete = selete;
    
    self.myTouchBtn.userInteractionEnabled = selete;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempframe = self.myLineView.frame;
    tempframe.size.width = self.bounds.size.width-KLeftOffset*2;
    self.myLineView.frame = tempframe;
    
    tempframe = self.myNameLabel.frame;
    if (self.updateNameSize.width>0) {
            tempframe.size.width = self.bounds.size.width-KLeftOffset*2-self.updateNameSize.width;
    }else{
            tempframe.size.width = self.bounds.size.width-KLeftOffset*2;
    }

    self.myNameLabel.frame = tempframe;
    
    tempframe = self.myPriceLabel.frame;
    tempframe.origin.x = self.bounds.size.width-KLeftOffset-tempframe.size.width;
    self.myPriceLabel.frame = tempframe;
    
    tempframe = self.myDistanceLabel.frame;
    tempframe.origin.x = KLeftOffset;
    self.myDistanceLabel.frame = tempframe;
    
    tempframe = self.mySeleteIconView.frame;
    tempframe.origin.x = self.bounds.size.width-tempframe.size.width;
    self.mySeleteIconView.frame = tempframe;
    
    tempframe = self.myTouchBtn.frame;
    tempframe.size.width = self.bounds.size.width;
    tempframe.size.height = self.bounds.size.height;
    self.myTouchBtn.frame = tempframe;
}

-(UILabel*)getLabel:(CGRect)frame
{
    UILabel* tempLabel = [[UILabel alloc]initWithFrame:frame];
    [tempLabel setBackgroundColor:[UIColor clearColor]];
    [tempLabel setFont:[UIFont systemFontOfSize:14]];
    [tempLabel setTextColor:RGBCOLOR(102, 102, 102)];
    [self addSubview:tempLabel];
    return tempLabel;
}

-(void)initRow1View:(CGRect)frame
{
    self.myNameLabel = [self getLabel:CGRectMake(KLeftOffset, frame.origin.y+(frame.size.height-30)/2, frame.size.width-KLeftOffset*2, 30)];
    [self.myNameLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [self.myNameLabel setTextColor:[UIColor blackColor]];
    self.myNameLabel.adjustsFontSizeToFitWidth  = YES;

    self.myLineView = [[UIImageView alloc]initWithFrame:CGRectMake(KLeftOffset, frame.size.height+2, frame.size.width-KLeftOffset*2, 1)];
    self.myLineView.image = [UIImage imageNamed:@"dashedLine.png"];
    [self addSubview:self.myLineView];
}

-(void)initRow2View:(CGRect)frame
{
    UIImage* tempIcon = [UIImage imageNamed:@"icon_addr.png"];
    
    self.myAddrIconView = [[UIImageView alloc]initWithFrame:CGRectMake(KLeftOffset, frame.origin.y+(frame.size.height-tempIcon.size.height)/2, tempIcon.size.width, tempIcon.size.height)];
    self.myAddrIconView.image = tempIcon;
    [self addSubview:self.myAddrIconView];
    
    self.myPriceLabel = [self getLabel:CGRectMake(frame.size.width-90, frame.origin.y+(frame.size.height-30)/2, 100, 30)];
    [self.myPriceLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [self.myPriceLabel setTextAlignment:UITextAlignmentRight];
    [self.myPriceLabel setTextColor:[UIColor redColor]];
    
    self.myAddrLabel = [self getLabel:CGRectMake(self.myAddrIconView.frame.origin.x+tempIcon.size.width+5, frame.origin.y+(frame.size.height-60)/2, frame.size.width-100-KLeftOffset*2-tempIcon.size.width, 60)];
    [self.myAddrLabel setNumberOfLines:2];
}

-(void)initRow3View:(CGRect)frame
{
    UIImage* tempIcon = [UIImage imageNamed:@"icon_tell.png"];
    
//    self.myTellIconView = [[UIImageView alloc]initWithFrame:CGRectMake(KLeftOffset, frame.origin.y+(frame.size.height-tempIcon.size.height)/2, tempIcon.size.width, tempIcon.size.height)];
//    self.myTellIconView.image = tempIcon;
//    [self addSubview:self.myTellIconView];
    
    self.myDistanceLabel = [self getLabel:CGRectMake(KLeftOffset+5+tempIcon.size.width, frame.origin.y+(frame.size.height-30)/2, 160, 30)];
    [self.myDistanceLabel setFont:[UIFont systemFontOfSize:12]];
    [self.myDistanceLabel setTextAlignment:UITextAlignmentLeft];
    
//    self.myTellLabel = [self getLabel:CGRectMake(self.myTellIconView.frame.origin.x+tempIcon.size.width+5, frame.origin.y+(frame.size.height-60)/2, frame.size.width-80-KLeftOffset*2-tempIcon.size.width, 60)];
}

-(void)setUpdateNameSize:(CGSize)size
{
    _updateNameSize = size;
    
    CGRect tempFrame = self.myNameLabel.frame;
    tempFrame.size.width = self.bounds.size.width-size.width-KLeftOffset*2;
    self.myNameLabel.frame = tempFrame;
}

-(void)updateData:(M_DealerItemModel*)data
{
    self.myNameLabel.text = @"";
    self.myAddrLabel.text = @"";
    self.myTellLabel.text = @"";
    self.myPriceLabel.text = @"";
    self.myDistanceLabel.text = @"";
    
    if (data!=nil) {
        
        if ([data.dealer_sname notEmpty]) {
            self.myNameLabel.text = data.dealer_sname;
        }
        
        if ([data.dealer_address notEmpty]) {
            self.myAddrLabel.text = data.dealer_address;
        }
        
//        if ([data.dealer_tel notEmpty]) {
//            self.myTellLabel.text = data.dealer_tel;
//        }
        if ([data.dealer_car_price notEmpty]) {
            self.myPriceLabel.text = [NSString stringWithFormat:@"%@万元",data.dealer_car_price];
        }
        
        if ([data.dealer_distance notEmpty]) {
            self.myDistanceLabel.text = [NSString stringWithFormat:@"%@km",data.dealer_distance];
        }
        
        if (self.showSelete) {
            self.myTouchBtn.userInteractionEnabled = YES;
            
            BOOL tempSelete = data.selete;
            
            if (self.showFirstSelete) {
                tempSelete = NO;
            }
            
            self.mySeleteIconView.hidden = !tempSelete;
            UIImage* tempIcon = [UIImage imageNamed:@"icon_addr.png"];
            UIImage* tempIcon_w = [UIImage imageNamed:@"icon_addr_w.png"];
            UIImage* tempIcon2 = [UIImage imageNamed:@"icon_tell.png"];
            UIImage* tempIcon2_w = [UIImage imageNamed:@"icon_tell_w.png"];
            if (tempSelete) {
                self.myAddrIconView.image = tempIcon_w;
                self.myTellIconView.image = tempIcon2_w;
                [self setBackgroundColor:[UIColor redColor]];
                [self.myNameLabel setTextColor:[UIColor whiteColor]];
                [self.myAddrLabel setTextColor:[UIColor whiteColor]];
                [self.myTellLabel setTextColor:[UIColor whiteColor]];
                [self.myDistanceLabel setTextColor:[UIColor whiteColor]];
                [self.myPriceLabel setTextColor:[UIColor whiteColor]];
            }else{
                self.myAddrIconView.image = tempIcon;
                self.myTellIconView.image = tempIcon2;
                [self setBackgroundColor:[UIColor whiteColor]];
                [self.myNameLabel setTextColor:[UIColor blackColor]];
                [self.myAddrLabel setTextColor:[UIColor grayColor]];
                [self.myTellLabel setTextColor:[UIColor grayColor]];
                [self.myDistanceLabel setTextColor:[UIColor grayColor]];
                [self.myPriceLabel setTextColor:[UIColor redColor]];
            }
        }else{
            self.myTouchBtn.userInteractionEnabled = NO;
        }
    }
    
    UIImage* tempIcon = [UIImage imageNamed:@"icon_addr.png"];
    
    if (self.myPriceLabel.text.length > 0 && self.showPrice) {
        self.myPriceLabel.hidden = NO;
        
        CGRect tempFrame = self.myAddrLabel.frame;
        tempFrame.size.width = self.bounds.size.width-KLeftOffset*2-tempIcon.size.width-80;
        self.myAddrLabel.frame = tempFrame;
        
//        tempFrame = self.myPriceLabel.frame;
//        tempFrame.origin.x = self.bounds.size.width-KLeftOffset-100;
//        self.myPriceLabel.frame = tempFrame;
        
    }else{
        self.myPriceLabel.hidden = YES;
        
        CGRect tempFrame = self.myAddrLabel.frame;
        tempFrame.size.width = self.bounds.size.width-KLeftOffset*2-tempIcon.size.width;
        self.myAddrLabel.frame = tempFrame;
    }
    
    self.myLineView.hidden = !self.showLine;
    self.myDistanceLabel.hidden = !self.showDistance;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
