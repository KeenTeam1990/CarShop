//
//  M_QueryModelsCell.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/12.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_QueryModelsCell.h"
#import "M_MyOrderModel.h"

#define KLeftOffset 10

@implementation M_QueryModelsCell


@synthesize myQueryModel;
@synthesize dataArray;
@synthesize carImageView;
@synthesize label1;
@synthesize label2;
@synthesize label3;
@synthesize label4;
@synthesize label5;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        [self initView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger tempImageW = self.frame.size.width/2-KLeftOffset*2;
    if (IS_SCREEN_35_INCH||IS_SCREEN_4_INCH) {
        tempImageW = 100;
    }
    CGRect tempFrame = self.label1.frame;
    tempFrame.size.width = self.bounds.size.width-tempImageW-KLeftOffset*3-20;
    self.label1.frame = tempFrame;
    
    tempFrame = self.carImageView.frame;
    self.carImageView.frame= tempFrame;
    
    tempFrame = self.myLineView.frame;
    tempFrame.size.width = self.bounds.size.width;
    self.myLineView.frame = tempFrame;
}

-(void)initView
{
    NSInteger tempImageW = self.bounds.size.width/2-KLeftOffset*2;
    if (IS_SCREEN_35_INCH||IS_SCREEN_4_INCH) {
        tempImageW = 100;
    }
    self.label4 = [[UILabel alloc]init];
    [self addSubview:self.label4];
    self.label4.frame = CGRectMake(KLeftOffset, KLeftOffset, ScreenWidth-130, 20);
    self.label4.textAlignment = NSTextAlignmentLeft;
    self.label4.textColor = [Unity getColor:@"#666666"];
    self.label4.font = [UIFont boldSystemFontOfSize:12];
    [self.contentView addSubview:label4];
    
    self.label5 = [[UILabel alloc]init];
    self.label5.frame = CGRectMake(ScreenWidth-110 ,KLeftOffset, 100, 20);
    self.label5.textAlignment = NSTextAlignmentLeft;
    self.label5.textColor = [Unity getColor:@"#666666"];
    self.label5.textAlignment = UITextAlignmentRight;
    self.label5.font = [UIFont boldSystemFontOfSize:12];
    [self.contentView addSubview:self.label5];
    
    UIImageView *lineView1 = [[UIImageView alloc]initWithFrame:CGRectMake(KLeftOffset, self.label5.frame.size.height+21,ScreenWidth, 1)];
    lineView1.image = [UIImage imageNamed:@"dashedLine.png"];
    [self.contentView addSubview:lineView1];

    
    UIImage *carImage = [UIImage imageNamed:@"tempcar.jpg"];
    
    self.carImageView = [[UIImageView alloc]init];
    self.carImageView.frame = CGRectMake(KLeftOffset, lineView1.frame.origin.y+10,tempImageW, 100);
    self.carImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.carImageView.image = carImage;
    self.carImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.carImageView];
    
    
    self.label1 = [[UILabel alloc]init];
    self.label1.textColor = [UIColor blackColor];
    self.label1.frame = CGRectMake(KLeftOffset*2+tempImageW , lineView1.frame.origin.y, ScreenWidth-KLeftOffset*3-tempImageW,80);
    self.label1.textAlignment = NSTextAlignmentLeft;
    self.label1.numberOfLines = 3;
    self.label1.lineBreakMode = NSLineBreakByCharWrapping;
    self.label1.font = [UIFont boldSystemFontOfSize:14];
    
    [self.contentView addSubview:self.label1];
    
    self.label2 = [[UILabel alloc]init];
    self.label2.textColor = [UIColor blackColor];
    self.label2.frame = CGRectMake(KLeftOffset*2+tempImageW , lineView1.frame.origin.y+40, ScreenWidth/2, 20);
    self.label2.font = [UIFont boldSystemFontOfSize:10];
    [self.contentView addSubview:self.label2];
    
    self.label3 = [[UILabel alloc]init];
    self.label3.frame = CGRectMake(KLeftOffset*2+tempImageW ,lineView1.frame.origin.y+ 80, 100, 20);
    self.label3.textAlignment = NSTextAlignmentLeft;
    self.label3.textColor = [UIColor redColor];
    self.label3.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:self.label3];
    
    
//    if ([self.myItemModel.myQuoteModel.myLastComboArray count]>0) {
//        
//        self.myComboLabel.hidden  = NO;
//        self.myComboView.hidden = NO;
//        self.myLine8View.hidden = NO;
//        
//        CGRect tempFrame = self.myComboLabel.frame;
//        tempFrame.origin.y = MaxY(self.myLine6View);;
//        self.myComboLabel.frame = tempFrame;
//        
//        for (int i=0; i<[self.myComboView.subviews count]; i++) {
//            UIView* tempView=  [self.myComboView.subviews objectAtIndex:i];
//            if (tempView!=nil) {
//                [tempView removeFromSuperview];
//            }
//        }
//        
//        UIImage* tempIcon = [UIImage imageNamed:@"礼包.png"];
//        
//        NSInteger x = 0;
//        NSInteger y = 0;
//        NSInteger h = 0;
//        NSInteger w = self.myComboView.frame.size.width-tempIcon.size.width;
//        
//        NSInteger t_H = 0;
//        
//        
//        for (int i=0; i<[self.myItemModel.myQuoteModel.myLastComboArray count]; i++) {
//            M_QuoteComboItemModel* tempComboItem = [self.myItemModel.myQuoteModel.myLastComboArray objectAtIndex:i];
//            if (tempComboItem!=nil) {
//                
//                UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//                [tempBtn setBackgroundColor:[UIColor redColor]];
//                //                                        tempBtn.userInteractionEnabled = YES;
//                
//                tempBtn.titleLabel.font = SYSTEMFONT(12);
//                tempBtn.titleLabel.numberOfLines = 0;
//                tempBtn.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
//                
//                [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//                [tempBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//                [tempBtn setImage:tempIcon forState:UIControlStateNormal];
//                
//                [tempBtn addTarget:self action:@selector(libao:) forControlEvents:64];
//                NSString* tempStr = [NSString stringWithFormat:@"%@:%@",tempComboItem.myComboTitle,tempComboItem.myComboContent];
//                
//                [tempBtn setTitle:tempStr forState:UIControlStateNormal];
//                
//                NSInteger tempH = [tempStr sizeWithFont:SYSTEMFONT(12) byWidth:w].height+10;
//                
//                if (tempH < 20) {
//                    tempH = 20;
//                }
//                
//                h = tempH;
//                
//                tempBtn.tag = 8000+i;
//                
//                tempBtn.frame = CGRectMake(x, y, w, h);
//                
//                [self.myComboView addSubview:tempBtn];
//                
//                t_H+=h;
//                
//                y+=h;
//            }
//        }
//        
//        tempFrame = self.myComboView.frame;
//        tempFrame.origin.y = MaxY(self.myComboLabel);
//        tempFrame.size.height = t_H+10;
//        self.myComboView.frame = tempFrame;
//        
//        tempFrame = self.myLine8View.frame;
//        tempFrame.origin.y = MaxY(self.myComboView);
//        self.myLine8View.frame = tempFrame;
//    }
    
    self.myLineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 155, self.bounds.size.width, 5)];
    self.myLineView.backgroundColor = RGBCOLOR(234, 234, 234);
    [self.contentView addSubview:self.myLineView];
    
    
    
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    M_MyOrderTtemModel* tempItem = [array objectAtIndex:indexPath.row];
    
    if (tempItem!=nil) {
        
        self.label1.text = @"";
        self.label2.text = @"";
        self.label3.text = @"";
        self.label4.text = @"";
        self.label5.text = @"";
        
        self.carImageView.image = nil;
        
        if (tempItem.car!=nil) {
            if ([tempItem.car.myCar_Img notEmpty]) {
                [self.carImageView setImageWithURL:[NSURL URLWithString:tempItem.car.myCar_Img] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
            }
            
            if ([tempItem.car.myCar_Name notEmpty] &&
                [tempItem.car.myCar_Year notEmpty] &&
                [tempItem.car.myBrand_Name notEmpty] &&
                [tempItem.car.mySubbrand_Name notEmpty]) {
                self.label1.text =[NSString stringWithFormat:@"%@ %@ %@款 %@",tempItem.car.myBrand_Name,tempItem.car.mySubbrand_Name,tempItem.car.myCar_Year,tempItem.car.myCar_Name] ;
            }
            
            if (tempItem.car.myItemColorModel!=nil) {
                if ([tempItem.car.myItemColorModel.myCar_Color_Name notEmpty]) {
                    self.label3.text = tempItem.car.myItemColorModel.myCar_Color_Name;
                }
            }
        }
        
        if ([tempItem.myDealer_count notEmpty] &&
            [tempItem.myQuoted_count notEmpty]) {
            
             NSString *tempStr = [NSString stringWithFormat:@"已有%@位商家报价,共询价%@位商家",tempItem.myQuoted_count,tempItem.myDealer_count];
            self.label4.text = tempStr;
        }
        
        //时间
        if ([tempItem.myQuoted_at notEmpty]) {
            label5.text = [Unity getTimeFromTimerLong:tempItem.myQuoted_at];
        }
        
    }
}



@end
