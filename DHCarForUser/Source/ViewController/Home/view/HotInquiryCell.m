//
//  HotInquiryCell.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "HotInquiryCell.h"
#import "M_CarListModel.h"
#import "LL_LableHaveLine.h"

#define KLeftOffset 10


@interface HotInquiryCell  ()

AS_MODEL_STRONG(UIImageView, myImageView);
AS_MODEL_STRONG(UIImageView, myIconView);
AS_MODEL_STRONG(UILabel, myNameLabel);
AS_MODEL_STRONG(UILabel, myPriceLabel);
AS_MODEL_STRONG(UILabel, myClewLabel);
AS_MODEL_STRONG(UIButton, myButtonBtn);
AS_MODEL_STRONG(LL_LableHaveLine, myPriceLineLabel);

AS_MODEL_STRONG(NSIndexPath, currIndexPath);

@end

@implementation HotInquiryCell

DEF_MODEL(myNameLabel);
DEF_MODEL(myButtonBtn);
DEF_MODEL(myClewLabel);
DEF_MODEL(myIconView);
DEF_MODEL(myImageView);
DEF_MODEL(myPriceLabel);
DEF_MODEL(showSpecial);
DEF_MODEL(block);
DEF_MODEL(currIndexPath);
DEF_MODEL(myPriceLineLabel);

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        UIImage* tempIcon = [UIImage imageNamed:@"cu.png"];
        
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(KLeftOffset, 10, 100, 100)];
        self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.myImageView];
        
        self.myIconView = [[UIImageView alloc]initWithFrame:CGRectMake(self.myImageView.frame.origin.x+self.myImageView.frame.size.width-tempIcon.size.width/2, self.myImageView.frame.origin.y, tempIcon.size.width/2, tempIcon.size.height/2)];
        self.myIconView.image = tempIcon;
        [self.contentView addSubview:self.myIconView];
        
        NSInteger w = self.bounds.size.width-KLeftOffset*3-100;
        
        self.myNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(KLeftOffset*2+100, 0, w, 50)];
        [self.myNameLabel setBackgroundColor:[UIColor clearColor]];
        [self.myNameLabel setFont:[UIFont systemFontOfSize:14]];
        [self.myNameLabel setTextColor:[UIColor blackColor]];
        [self.myNameLabel setNumberOfLines:2];
        [self.contentView addSubview:self.myNameLabel];
        
        self.myPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(KLeftOffset*2+100, 50, w/2, 25)];
        [self.myPriceLabel setBackgroundColor:[UIColor clearColor]];
        [self.myPriceLabel setFont:[UIFont systemFontOfSize:12]];
        [self.myPriceLabel setTextColor:RGBCOLOR(244, 173, 0)];
        [self.contentView addSubview:self.myPriceLabel];
        
        self.myPriceLineLabel = [[LL_LableHaveLine alloc]initWithFrame:CGRectMake(KLeftOffset*2+50+w/2, 50, w/2, 25)];
        
        [self.contentView addSubview:self.myPriceLineLabel];
        
        self.myClewLabel = [[UILabel alloc]initWithFrame:CGRectMake(KLeftOffset*2+100, 70, w,25)];
        [self.myClewLabel setBackgroundColor:[UIColor clearColor]];
        [self.myClewLabel setFont:[UIFont systemFontOfSize:14]];
        [self.myClewLabel setTextColor:[UIColor redColor]];
        [self.contentView addSubview:self.myClewLabel];
        
        UIImage* tempBtnBg = [UIImage imageNamed:@"登录.png"];
        UIImage* tempBtn_HBg = [UIImage imageNamed:@"登录按下.png"];
        
        self.myButtonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.myButtonBtn addTarget:self action:@selector(buttonBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.myButtonBtn setBackgroundImage:[tempBtnBg stretchableImageWithLeftCapWidth:tempBtnBg.size.width/2 topCapHeight:tempBtnBg.size.height/2] forState:UIControlStateNormal];
        [self.myButtonBtn setBackgroundImage:[tempBtn_HBg stretchableImageWithLeftCapWidth:tempBtn_HBg.size.width/2 topCapHeight:tempBtn_HBg.size.height/2] forState:UIControlStateHighlighted];
        [self.myButtonBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        self.myButtonBtn.frame = CGRectMake(KLeftOffset*2+100, 85, 80, 30);
        [self addSubview:self.myButtonBtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger w = self.bounds.size.width-KLeftOffset*3-100;
    
    CGRect tempFrame = self.myNameLabel.frame;
    tempFrame.size.width = w;
    self.myNameLabel.frame = tempFrame;
    
    tempFrame = self.myPriceLabel.frame;
    tempFrame.size.width = w/2;
    self.myPriceLabel.frame = tempFrame;
    
    tempFrame = self.myPriceLineLabel.frame;
    tempFrame.origin.x = KLeftOffset*2+50+w/2;
    tempFrame.size.width = w/2;
    self.myPriceLineLabel.frame = tempFrame;
    
    tempFrame = self.myClewLabel.frame;
    tempFrame.size.width = w;
    self.myClewLabel.frame = tempFrame;
}

-(void)buttonBtnPressed:(id)sender
{
    if (self.block!=nil) {
        self.block(self.currIndexPath);
    }
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    M_CarItemModel* tempItem = [array objectAtIndex:indexPath.row];
    if (tempItem!=nil) {
        
        self.currIndexPath = indexPath;
        
        self.myImageView.image = [UIImage imageNamed:@"tempcar.jpg"];
        self.myIconView.hidden = NO;
        self.myNameLabel.text = @"";
        self.myPriceLabel.text = @"";
        self.myClewLabel.text = @"";
        self.myButtonBtn.hidden = YES;
        
        if ([tempItem.myCar_Img notEmpty]) {
            [self.myImageView setImageWithURL:[NSURL URLWithString:tempItem.myCar_Img] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
        }
        
        if ([tempItem.myBrand_Name notEmpty]&& [tempItem.myCar_Year notEmpty]&&[tempItem.myCar_Name notEmpty] && [tempItem.mySubbrand_Name notEmpty]) {
            self.myNameLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",tempItem.myCar_Year,tempItem.myBrand_Name,tempItem.mySubbrand_Name, tempItem.myCar_Name];
        }
        
        if ([tempItem.myCar_Price notEmpty]) {
            self.myPriceLineLabel.myText = [NSString stringWithFormat:@"%@万元",tempItem.myCar_Price];
        }
        
        if (self.showSpecial) {
            if ([tempItem.myDealer_Car_Price notEmpty]) {
                self.myPriceLabel.text = [NSString stringWithFormat:@"%@万元",tempItem.myDealer_Car_Price];
            }
        }else{
            if ([tempItem.myLease_Price notEmpty]) {
                self.myPriceLabel.text = [NSString stringWithFormat:@"首付最低%@万",tempItem.myLease_Price];
            }
        }
        
        if ([tempItem.myDealer_Car_Price notEmpty] && [tempItem.myCar_Year notEmpty] && self.showSpecial) {
            
            self.myClewLabel.font = [UIFont boldSystemFontOfSize:16];
            self.myClewLabel.textColor = RedText;
            
            CGFloat tempp = [tempItem.myCar_Price floatValue]-[tempItem.myDealer_Car_Price floatValue];
            NSString* tempPrice = [NSString stringWithFormat:@"%.02f",tempp];
            self.myClewLabel.text = [NSString stringWithFormat:@"东汇赠购礼包%@万元",tempPrice];
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:self.myClewLabel.text];
            
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:[UIFont systemFontOfSize:12.0]
                                  range:NSMakeRange(0,6)];
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
                                  value:[UIColor redColor]
                                  range:NSMakeRange(0, 6)];
            
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:[UIFont systemFontOfSize:12.0]
                                  range:NSMakeRange(self.myClewLabel.text.length-2,2)];
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
                                  value:[UIColor redColor]
                                  range:NSMakeRange(self.myClewLabel.text.length-2, 2)];
            
            self.myClewLabel.attributedText = AttributedStr;
        }
        
        if (self.showSpecial) {
            [self.myButtonBtn setTitle:@"我要特惠" forState:UIControlStateNormal];
        }else{
            [self.myButtonBtn setTitle:@"我要询价" forState:UIControlStateNormal];
        }
        
        //self.myButtonBtn.hidden = NO;
    }
}

@end
