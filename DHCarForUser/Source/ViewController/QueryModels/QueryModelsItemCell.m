//
//  QueryModelsItemCell.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/16.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "QueryModelsItemCell.h"
#import "M_CarDistributorItemView.h"
#import "M_MyOrderModel.h"

@interface QueryModelsItemCell()

AS_MODEL_STRONG(M_CarDistributorItemView, myDealerView);

AS_MODEL_STRONG(UIView, myView);
AS_MODEL_STRONG(UILabel, myPriceLabel);
AS_MODEL_STRONG(UIButton, myMsgBtn);
AS_MODEL_STRONG(UIButton, myReserveBtn);
AS_MODEL_STRONG(UIButton, myOpenCallBtn);

AS_MODEL_STRONG(UIImageView, myLineView);
AS_MODEL_STRONG(UILabel, myInfoClewLabel);
AS_MODEL_STRONG(UILabel, myInfoLabel);

AS_MODEL_STRONG(UILabel, myComboLabel);
AS_MODEL_STRONG(UIView, myComboView);
AS_MODEL_STRONG(UIImageView, myLine2View);

AS_MODEL_STRONG(M_QuoteItemModel, myItemModel);

@end

@implementation QueryModelsItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.myDealerView = [M_CarDistributorItemView allocInstanceFrame:CGRectMake(10, 5, self.bounds.size.width-20, 110)];
        self.myDealerView.showPrice = NO;
        [self.contentView addSubview:self.myDealerView];
        
        self.myView = [[UIView alloc]initWithFrame:CGRectMake(10, 115, self.bounds.size.width-20, 80)];
        [self.myView setBackgroundColor:RGBCOLOR(251, 251, 251)];
        self.myView.userInteractionEnabled = YES;
        [self.myView setClipsToBounds:YES];
        [self.contentView addSubview:self.myView];
        
        self.myPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, self.myView.frame.size.width-130, 40)];
        [self.myPriceLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [self.myPriceLabel setTextColor:[UIColor redColor]];
        [self.myView addSubview:self.myPriceLabel];
        
        self.myLineView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 50, self.myView.frame.size.width-20, 1)];
        self.myLineView.image = [UIImage imageNamed:@"dashedLine.png"];
        [self.myView addSubview:self.myLineView];
        
        self.myInfoClewLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 51, 120, 30)];
        self.myInfoClewLabel.font = [UIFont systemFontOfSize:12];
        self.myInfoClewLabel.textColor = [UIColor  blackColor];
        self.myInfoClewLabel.text = @"报价说明";
        [self.myView addSubview:self.myInfoClewLabel];
        
        self.myInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 81, self.myView.frame.size.width-20, 30)];
        self.myInfoLabel.font = [UIFont systemFontOfSize:12];
        self.myInfoLabel.textColor = [UIColor  grayColor];
        [self.myView addSubview:self.myInfoLabel];
        
        self.myMsgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.myMsgBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor redColor];
                                                style.cornerRedius = 2;);
        [self.myMsgBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.myMsgBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        self.myMsgBtn.frame = CGRectMake(self.myView.frame.size.width-190, 5, 80, 30);
        [self.myMsgBtn addTarget:self action:@selector(msgBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.myMsgBtn setTitle:@"咨询" forState:UIControlStateNormal];
        self.myMsgBtn.userInteractionEnabled = YES;
        [self.myView addSubview:self.myMsgBtn];
        
        self.myReserveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.myReserveBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor redColor];
                                                style.cornerRedius = 2;
                                                   );
        [self.myReserveBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        self.myReserveBtn.frame = CGRectMake(self.myView.frame.size.width-100, 5, 80, 30);
        [self.myReserveBtn addTarget:self action:@selector(reserverBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.myReserveBtn setTitle:@"马上预定" forState:UIControlStateNormal];
        self.myReserveBtn.userInteractionEnabled = YES;
        [self.myView addSubview:self.myReserveBtn];
        
        self.myOpenCallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.myOpenCallBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor]; style.borderWidth = 1;
                                                     style.borderColor = [UIColor blackColor];
                                                    style.cornerRedius = 5;);
        self.myOpenCallBtn.tintColor = [UIColor blackColor];
        [self.myOpenCallBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.myOpenCallBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        self.myOpenCallBtn.frame = CGRectMake(self.myView.frame.size.width-280, 5, 80, 30);
        [self.myOpenCallBtn addTarget:self action:@selector(openCallBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.myOpenCallBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
        self.myOpenCallBtn.userInteractionEnabled = YES;
        [self.myView addSubview:self.myOpenCallBtn];
        
        self.myLine2View = [[UIImageView alloc]initWithFrame:CGRectMake(10, MaxY(self.myInfoLabel), self.myView.frame.size.width-20, 1)];
        self.myLine2View.backgroundColor = RGBCOLOR(202, 202, 202);
        self.myLine2View.hidden = YES;
        [self.myView addSubview:self.myLine2View];
        
        self.myComboLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, MaxY(self.myLine2View), self.myView.frame.size.width-20, 30)];
        self.myComboLabel.font = [UIFont systemFontOfSize:12];
        self.myComboLabel.textColor = [UIColor  blackColor];
        [self.myView addSubview:self.myComboLabel];
        
        self.myComboView = [[UIView alloc]initWithFrame:CGRectMake(10, MaxY(self.myComboLabel), self.myView.frame.size.width-20, 30)];
        [self.myView addSubview:self.myComboView];
        
        
    }
    return self;
}

-(void)openCallBtnPressed:(id)sender
{
    if (self.myItemModel!=nil) {
        if (self.block!=nil) {
            self.block(3,self.myItemModel);
        }
    }
}

-(void)reserverBtnPressed:(id)sender
{
    if (self.myItemModel!=nil) {
        if (self.block!=nil) {
            self.block(2,self.myItemModel);
        }
    }
}

-(void)msgBtnPressed:(id)sender
{
    if(self.myItemModel!=nil){
        if (self.block!=nil) {
            self.block(0,self.myItemModel);
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempFrame = self.myDealerView.frame;
    tempFrame.size.width = self.bounds.size.width-20;
    self.myDealerView.frame = tempFrame;
    
    tempFrame = self.myView.frame;
    tempFrame.size.width = self.bounds.size.width-20;
    self.myView.frame = tempFrame;
    
    tempFrame = self.myPriceLabel.frame;
    tempFrame.size.width = self.myView.frame.size.width-20;
    self.myPriceLabel.frame = tempFrame;
    
    if ([self.myItemModel.myHasConverted notEmpty]) {
        if ([self.myItemModel.myHasConverted isEqualToString:@"1"]) {
            
            tempFrame = self.myOpenCallBtn.frame;
            tempFrame.origin.x = self.myView.frame.size.width-100;
            self.myOpenCallBtn.frame = tempFrame;

        }else{
            if ([self.myItemModel.mySalesUid notEmpty]) {
                if ([self.myItemModel.mySalesUid integerValue]<=0) {
                    
                    tempFrame = self.myReserveBtn.frame;
                    tempFrame.origin.x = self.myView.frame.size.width-100;
                    self.myReserveBtn.frame = tempFrame;
                    
                    tempFrame = self.myOpenCallBtn.frame;
                    tempFrame.origin.x = self.myView.frame.size.width-190;
                    self.myOpenCallBtn.frame = tempFrame;
                }else{
                    tempFrame = self.myMsgBtn.frame;
                    tempFrame.origin.x = self.myView.frame.size.width-100;
                    self.myMsgBtn.frame = tempFrame;
                    
                    tempFrame = self.myOpenCallBtn.frame;
                    tempFrame.origin.x = self.myView.frame.size.width-190;
                    self.myOpenCallBtn.frame = tempFrame;
                }
            }
        }
    }
    
    tempFrame = self.myLineView.frame;
    tempFrame.size.width = self.myView.frame.size.width-20;
    self.myLineView.frame = tempFrame;
    
    tempFrame = self.myLine2View.frame;
    tempFrame.size.width = self.myView.frame.size.width-20;
    self.myLine2View.frame = tempFrame;
    
    tempFrame = self.myInfoLabel.frame;
    tempFrame.size.width = self.myView.frame.size.width-20;
    self.myInfoLabel.frame = tempFrame;
    
    tempFrame = self.myComboLabel.frame;
    tempFrame.size.width = self.myView.frame.size.width-20;
    self.myComboLabel.frame = tempFrame;
    
    tempFrame = self.myComboView.frame;
    tempFrame.size.width = self.myView.frame.size.width-20;
    self.myComboView.frame = tempFrame;
    
    UIImage* tempIcon2 = [UIImage imageNamed:@"icon_more.png"];
    
    for (int i=0; i<[self.myComboView.subviews count]; i++) {
        UIButton* tempBtn = [self.myComboView.subviews objectAtIndex:i];
        if (tempBtn!=nil) {
            
            CGRect tempFrame = tempBtn.frame;
            tempFrame.size.width = self.myComboView.frame.size.width-10;
            tempBtn.frame = tempFrame;
            
            UIImageView* tempArraw = [tempBtn viewWithTag:1001];
            if (tempArraw!=nil) {
                CGRect tempFrame = tempArraw.frame;
                tempFrame.origin.x = self.myComboView.frame.size.width-tempIcon2.size.width-10;
                tempArraw.frame = tempFrame;
            }
        }
    }
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    M_QuoteItemModel* tempModel = [array objectAtIndex:indexPath.row];
    
    if (tempModel!=nil) {
        
        self.myItemModel= tempModel;
        
        self.myInfoLabel.text = @"";
        self.myPriceLabel.text = @"";
        self.myInfoClewLabel.hidden = YES;
        
        self.myView.hidden = YES;
        self.myInfoLabel.hidden = YES;
        self.myMsgBtn.hidden = YES;
        self.myPriceLabel.hidden = YES;
        
        self.myComboLabel.hidden = YES;
        self.myComboLabel.text = @"购车大礼包";
        self.myComboView.hidden = YES;
        self.myLine2View.hidden = YES;
        self.myReserveBtn.hidden = YES;
        self.myOpenCallBtn.hidden = YES;
        
        if (tempModel.myDealerModel!=nil) {
            [self.myDealerView updateData:tempModel.myDealerModel];
        }
        
        NSInteger showCombo = 0;
        BOOL showPrice = NO;
        if ([tempModel.myLastPrice notEmpty] && ![tempModel.myLastPrice isEqualToString:@"0"]) {
            self.myPriceLabel.text = [NSString stringWithFormat:@"最终报价：%@万",tempModel.myLastPrice];
            showPrice = YES;
            self.myView.hidden = NO;
            
            if ([tempModel.myLastInfo notEmpty]) {
                
                self.myInfoLabel.text = tempModel.myLastInfo;
                
                self.myInfoLabel.hidden = NO;
                
            }
            
            if ([tempModel.myLastComboArray count]>0) {
                showCombo = 1;
            }
            
            self.myOpenCallBtn.hidden = NO;
            
        }else if ([tempModel.myFirstPrice notEmpty] && ![tempModel.myFirstPrice isEqualToString:@"0"]){
            self.myPriceLabel.text = [NSString stringWithFormat:@"首次报价：%@万",tempModel.myFirstPrice];
            showPrice = YES;
            self.myView.hidden = NO;
            if ([tempModel.myFirstInfo notEmpty]) {
                self.myInfoLabel.text = tempModel.myFirstInfo;
                
                self.myInfoLabel.hidden = NO;
                
            }
            
            if ([tempModel.myFirstComboArray count]>0) {
                showCombo = 2;
            }
            
            self.myOpenCallBtn.hidden = NO;
            
        }else{
            
            self.myPriceLabel.text = @"未报价";
            
            self.myPriceLabel.hidden = NO;
            
            self.myView.hidden = NO;
            
            CGRect tempFrame = self.myView.frame;
            tempFrame.size.height = 40;
            self.myView.frame = tempFrame;
            
            self.myOpenCallBtn.hidden = NO;
        }
        
        if ([self.myPriceLabel.text notEmpty] && showPrice) {
            
            NSMutableAttributedString* tempAttr = [[NSMutableAttributedString alloc]initWithString:self.myPriceLabel.text];
            
            [tempAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 5)];
            
            self.myPriceLabel.attributedText = tempAttr;
            self.myPriceLabel.hidden = NO;
            self.myInfoClewLabel.hidden = NO;
            
            CGRect tempFrame = self.myView.frame;
            tempFrame.size.height = 80;
            self.myView.frame = tempFrame;
        }
        
        if ([self.myInfoLabel.text notEmpty]) {
            
            NSInteger tempHeight = [Unity getLabelHeightWithWidth:self.myInfoLabel.frame.size.width andDefaultHeight:30 andFontSize:12 andText:self.myInfoLabel.text];
            
            CGRect tempFrame = self.myInfoLabel.frame;
            tempFrame.size.height = tempHeight;
            self.myInfoLabel.frame = tempFrame;
            
            tempFrame = self.myView.frame;
            tempFrame.size.height = 80+tempHeight;
            self.myView.frame = tempFrame;
        }
        
        if ([tempModel.myHasConverted notEmpty]) {
            //转订单
            if ([tempModel.myHasConverted isEqualToString:@"1"]) {
                self.myPriceLabel.textColor = [UIColor blueColor];
                [self.myMsgBtn setBackgroundColor:[UIColor blueColor]];
                
                self.myReserveBtn.hidden = YES;
                self.myMsgBtn.hidden = YES;
                
            }else{
                self.myPriceLabel.textColor = [UIColor redColor];
                [self.myMsgBtn setBackgroundColor:[UIColor redColor]];
                
                if ([tempModel.mySalesUid notEmpty]) {
                    if ([tempModel.mySalesUid integerValue]<=0) {
                        
                        self.myReserveBtn.hidden = NO;
                        self.myMsgBtn.hidden = YES;
                    }else{
                        self.myMsgBtn.hidden = NO;
                        self.myReserveBtn.hidden = YES;
                    }
                }
            }
        }
        
        if (showCombo == 1) {
            if ([tempModel.myLastComboArray count]>0) {
                self.myComboLabel.hidden  = NO;
                self.myComboView.hidden = NO;
                self.myLine2View.hidden = NO;
                
                CGRect tempFrame = self.myLine2View.frame;
                tempFrame.origin.y = MaxY(self.myInfoLabel);;
                self.myLine2View.frame = tempFrame;
                
                tempFrame = self.myComboLabel.frame;
                tempFrame.origin.y = MaxY(self.myLine2View);;
                self.myComboLabel.frame = tempFrame;
                
                for (int i=0; i<[self.myComboView.subviews count]; i++) {
                    UIView* tempView=  [self.myComboView.subviews objectAtIndex:i];
                    if (tempView!=nil) {
                        [tempView removeFromSuperview];
                    }
                }
                
                UIImage* tempIcon = [UIImage imageNamed:@"礼包.png"];
                UIImage* tempIcon2 = [UIImage imageNamed:@"icon_more.png"];
                
                NSInteger x = 0;
                NSInteger y = 0;
                NSInteger h = 0;
                NSInteger w = self.myComboView.frame.size.width-tempIcon.size.width-tempIcon2.size.width;
                
                NSInteger t_H = 0;
                
                
                for (int i=0; i<[tempModel.myLastComboArray count]; i++) {
                    
                    M_QuoteComboItemModel* tempComboItem = [tempModel.myLastComboArray objectAtIndex:i];
                    if (tempComboItem!=nil) {
                        
                        UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                        
                        tempBtn.titleLabel.font = SYSTEMFONT(12);
                        tempBtn.titleLabel.numberOfLines = 0;
                        tempBtn.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
                        
                        [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        [tempBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                        [tempBtn setImage:tempIcon forState:UIControlStateNormal];
                        
                        [tempBtn addTarget:self action:@selector(libaoBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
                        
                        NSString* tempStr = [NSString stringWithFormat:@"%@:%@",tempComboItem.myComboTitle,tempComboItem.myComboContent];
                        
                        [tempBtn setTitle:tempStr forState:UIControlStateNormal];
                        
                        NSInteger tempH = [tempStr sizeWithFont:SYSTEMFONT(12) byWidth:w].height+20;
                        
                        if (tempH < 30) {
                            tempH = 30;
                        }
                        
                        h = tempH;
                        
                        tempBtn.tag = 8000+i;
                        
                        tempBtn.frame = CGRectMake(x, y, w, h);
                        
                        UIImageView* tempArrow = [[UIImageView alloc]initWithFrame:CGRectMake(tempBtn.frame.size.width-tempIcon2.size.width, (tempBtn.frame.size.height-tempIcon2.size.height)/2, tempIcon2.size.width, tempIcon2.size.height)];
                        tempArrow.image = tempIcon2;
                        tempArrow.tag = 1001;
                        [tempBtn addSubview:tempArrow];
                        
                        [self.myComboView addSubview:tempBtn];
                        
                        t_H+=h;
                        
                        y+=h;
                    }
                }
                
                tempFrame = self.myComboView.frame;
                tempFrame.origin.y = MaxY(self.myComboLabel);
                tempFrame.size.height = t_H+10;
                self.myComboView.frame = tempFrame;
                
                tempFrame = self.myView.frame;
                tempFrame.size.height = MaxY(self.myComboView);
                self.myView.frame = tempFrame;
                
            }
        }else if (showCombo == 2){
            if ([tempModel.myFirstComboArray count]>0) {
                self.myComboLabel.hidden  = NO;
                self.myComboView.hidden = NO;
                self.myLine2View.hidden = NO;
                
                CGRect tempFrame = self.myLine2View.frame;
                tempFrame.origin.y = MaxY(self.myInfoLabel);;
                self.myLine2View.frame = tempFrame;
                
                tempFrame = self.myComboLabel.frame;
                tempFrame.origin.y = MaxY(self.myLine2View);;
                self.myComboLabel.frame = tempFrame;
                
                for (int i=0; i<[self.myComboView.subviews count]; i++) {
                    UIView* tempView=  [self.myComboView.subviews objectAtIndex:i];
                    if (tempView!=nil) {
                        [tempView removeFromSuperview];
                    }
                }
                
                UIImage* tempIcon = [UIImage imageNamed:@"礼包.png"];
                UIImage* tempIcon2 = [UIImage imageNamed:@"icon_more.png"];
                
                NSInteger x = 0;
                NSInteger y = 0;
                NSInteger h = 0;
                NSInteger w = self.myComboView.frame.size.width-tempIcon.size.width-tempIcon2.size.width;
                
                NSInteger t_H = 0;
                
                
                for (int i=0; i<[tempModel.myFirstComboArray count]; i++) {
                    M_QuoteComboItemModel* tempComboItem = [tempModel.myFirstComboArray objectAtIndex:i];
                    if (tempComboItem!=nil) {
                        
                        UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                        
                        tempBtn.titleLabel.font = SYSTEMFONT(12);
                        tempBtn.titleLabel.numberOfLines = 0;
                        tempBtn.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
                        
                        [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        [tempBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                        [tempBtn setImage:tempIcon forState:UIControlStateNormal];
                        
                        NSString* tempStr = [NSString stringWithFormat:@"%@:%@",tempComboItem.myComboTitle,tempComboItem.myComboContent];
                        
                        [tempBtn setTitle:tempStr forState:UIControlStateNormal];
                        
                        [tempBtn addTarget:self action:@selector(libaoBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
                        
                        NSInteger tempH = [tempStr sizeWithFont:SYSTEMFONT(12) byWidth:w].height+20;
                        
                        if (tempH < 30) {
                            tempH = 30;
                        }
                        
                        h = tempH;
                        
                        tempBtn.tag = 8000+i;
                        
                        tempBtn.frame = CGRectMake(x, y, w, h);
                        
                        UIImageView* tempArrow = [[UIImageView alloc]initWithFrame:CGRectMake(tempBtn.frame.size.width-tempIcon2.size.width, (tempBtn.frame.size.height-tempIcon2.size.height)/2, tempIcon2.size.width, tempIcon2.size.height)];
                        tempArrow.image = tempIcon2;
                        tempArrow.tag = 1001;
                        [tempBtn addSubview:tempArrow];
                        
                        [self.myComboView addSubview:tempBtn];
                        
                        t_H+=h;
                        
                        y+=h;
                    }
                }
                
                tempFrame = self.myComboView.frame;
                tempFrame.origin.y = MaxY(self.myComboLabel);
                tempFrame.size.height = t_H+10;
                self.myComboView.frame = tempFrame;
                
                tempFrame = self.myView.frame;
                tempFrame.size.height = MaxY(self.myComboView);
                self.myView.frame = tempFrame;
            }
        }else{
            
        }
    }
}

-(void)libaoBtnPressed:(id)sender
{
    UIButton* tempBtn = (UIButton*)sender;
    if (tempBtn!=nil) {
        
        if (self.myItemModel!=nil) {
            if ([self.myItemModel.myLastComboArray count]>0) {
                M_QuoteComboItemModel* tempItem = [self.myItemModel.myLastComboArray objectAtIndex:tempBtn.tag - 8000];
                if (tempItem!=nil) {
                    if (self.block!=nil) {
                        self.block(1,tempItem);
                    }
                }
            }else if ([self.myItemModel.myFirstComboArray count]>0){
                M_QuoteComboItemModel* tempItem = [self.myItemModel.myFirstComboArray objectAtIndex:tempBtn.tag - 8000];
                if (tempItem!=nil) {
                    if (self.block!=nil) {
                        self.block(1,tempItem);
                    }
                }
            }
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
