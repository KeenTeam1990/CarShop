//
//  M_MyOlderCell.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/12.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_MyOlderCell.h"

#define KLeftOffset 10

@interface M_MyOlderCell ()

AS_MODEL_STRONG(M_MyOrderTtemModel, myItemModel);

AS_MODEL_STRONG(UILabel, myOrderNoLabel);
AS_MODEL_STRONG(UILabel, myOrderStatusLabel);
AS_MODEL_STRONG(UIImageView, myImageView);
AS_MODEL_STRONG(UILabel, myNameLabel);
AS_MODEL_STRONG(UILabel, myOrderPriceLabel);
AS_MODEL_STRONG(UIButton, myStatusBtn);

AS_MODEL_STRONG(UIImageView, myLine1View);
AS_MODEL_STRONG(UIImageView, myLine2View);
AS_MODEL_STRONG(UIImageView, myLine3View);

AS_MODEL_STRONG(UIButton, mydelBtn);

@end

@implementation M_MyOlderCell

 // Only override drawRect: if you perform custom drawing.

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        NSInteger tempImageW = self.frame.size.width/2-KLeftOffset*2;
        if (IS_SCREEN_35_INCH||IS_SCREEN_4_INCH) {
            tempImageW = 100;
        }
        self.myOrderNoLabel = [self getLabel:CGRectMake(KLeftOffset, 0, self.bounds.size.width-120, 30)];
        self.myOrderNoLabel.textColor = [UIColor blackColor];
        
        self.myOrderStatusLabel = [self getLabel:CGRectMake(self.bounds.size.width-110, 0, 100, 30)];
        self.myOrderStatusLabel.textAlignment = UITextAlignmentRight;
        
        self.myLine1View = [self getLineView:CGRectMake(0, 30, self.bounds.size.width, 1)];
        
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(KLeftOffset, 35, tempImageW, 100)];
        self.myImageView.image = [UIImage imageNamed:@"tempcar.jpg"];
        self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.myImageView];
        
        self.myNameLabel = [self getLabel:CGRectMake(KLeftOffset*2+tempImageW, 35, self.bounds.size.width-KLeftOffset*3-tempImageW, 100)];
        self.myNameLabel.font = [UIFont systemFontOfSize:14];
        self.myNameLabel.textColor = [UIColor blackColor];
        self.myNameLabel.numberOfLines = 3;
        
        self.myLine2View = [self getLineView:CGRectMake(0, 135, self.bounds.size.width, 1)];
        
        self.myOrderPriceLabel = [self getLabel:CGRectMake(KLeftOffset, 135, self.bounds.size.width/2, 40)];
        self.myOrderPriceLabel.textColor = [UIColor blackColor];
        
        self.myStatusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.myStatusBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor];
                                                   style.cornerRedius = 2;
                                                   style.borderWidth =1;
                                                   style.borderColor = [UIColor redColor];);
        [self.myStatusBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.myStatusBtn.frame = CGRectMake(self.bounds.size.width-90, self.myOrderPriceLabel.frame.origin.y+10, 80, 20);
        self.myStatusBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.myStatusBtn addTarget:self action:@selector(stutasBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.myStatusBtn.hidden = YES;
        [self.contentView addSubview:self.myStatusBtn];
        
        self.mydelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.mydelBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor];
                                                style.cornerRedius = 2;
                                                style.borderWidth =1;
                                                style.borderColor = [UIColor lightGrayColor];);
        [self.mydelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.mydelBtn.frame = CGRectMake(self.bounds.size.width-180, self.myOrderPriceLabel.frame.origin.y+10, 80, 20);
        self.mydelBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.mydelBtn addTarget:self action:@selector(mydelBtnBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.mydelBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        [self.contentView addSubview:self.mydelBtn];
        self.mydelBtn.hidden = YES;
        self.myLine3View = [self getLineView:CGRectMake(0, self.myOrderPriceLabel.frame.origin.y+40, self.bounds.size.width, 5)];
        self.myLine3View.image = nil;
        self.myLine3View.backgroundColor = [Unity getGrayBackColor];
    }
    return self;
}

-(void)stutasBtnPressed:(id)sender
{
    UIButton* tempBtn = (UIButton*)sender;
    if (tempBtn!=nil) {
        if (self.myItemModel!=nil) {
            if (tempBtn.tag == 1001) {
                if (self.block!=nil) {
                    self.block(0,self.myItemModel);
                }
            }else if (tempBtn.tag == 1002){
                if (self.block!=nil) {
                    self.block(1,self.myItemModel);
                }
            }
        }
    }
}


-(void)mydelBtnBtnPressed:(id)sender
{
    
    UIAlertView *alertView= [[UIAlertView alloc]initWithTitle:@"提示"
                                                      message:@"是否删除该订单"
                                                     delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.delegate = self;
    [alertView show];
    
}

#pragma mark - alertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (self.myItemModel !=nil) {
            if (self.block!=nil) {
                self.block(2,self.myItemModel);
            }
        }

    }
}
-(UIImageView*)getLineView:(CGRect)frame
{
    UIImageView* tempLine = [[UIImageView alloc]initWithFrame:frame];
    tempLine.image = [UIImage imageNamed:@"dashedLine.png"];
    [self.contentView addSubview:tempLine];
    return tempLine;
}

-(UILabel*)getLabel:(CGRect)frame
{
    UILabel* tempLabel = [[UILabel alloc]initWithFrame:frame];
    tempLabel.font = [UIFont systemFontOfSize:12];
    tempLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:tempLabel];
    return tempLabel;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger tempImageW = self.frame.size.width/2-KLeftOffset*2;
    
    if (IS_SCREEN_35_INCH||IS_SCREEN_4_INCH) {
        tempImageW = 100;
    }
    
    CGRect tempFrame = self.myLine1View.frame;
    tempFrame.size.width = self.bounds.size.width;
    self.myLine1View.frame = tempFrame;
    
    tempFrame = self.myLine2View.frame;
    tempFrame.size.width = self.bounds.size.width;
    self.myLine2View.frame = tempFrame;
    
    tempFrame = self.myLine3View.frame;
    tempFrame.size.width = self.bounds.size.width;
    self.myLine3View.frame = tempFrame;
    
    tempFrame = self.myOrderNoLabel.frame;
    tempFrame.size.width = self.bounds.size.width-120;
    self.myOrderNoLabel.frame = tempFrame;
    
    tempFrame = self.myOrderStatusLabel.frame;
    tempFrame.origin.x = self.bounds.size.width-110;
    tempFrame.size.width = 100;
    self.myOrderStatusLabel.frame = tempFrame;
    
    tempFrame = self.myNameLabel.frame;
    tempFrame.size.width = self.bounds.size.width-tempImageW-KLeftOffset*3-20;
    self.myNameLabel.frame = tempFrame;
    
    tempFrame = self.myStatusBtn.frame;
    tempFrame.origin.x = self.bounds.size.width-100;
    self.myStatusBtn.frame = tempFrame;
    
    tempFrame = self.mydelBtn.frame;
    tempFrame.origin.x = self.bounds.size.width-110-tempFrame.size.width;
    self.mydelBtn.frame = tempFrame;

    
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    M_MyOrderTtemModel* tempItem = [array objectAtIndex:indexPath.row];
    
    if (tempItem!=nil) {
        
        self.myItemModel  =tempItem;
        
        self.myStatusBtn.hidden = YES;
        self.mydelBtn.hidden = YES;
        self.myOrderNoLabel.text = @"订单：";
        self.myOrderStatusLabel.text = @"";
        self.myOrderPriceLabel.text = @"订单价格：";
        self.myNameLabel.text = @"";
        self.myImageView.image = nil;

        if (tempItem.car!=nil) {
            if ([tempItem.car.myCar_Img notEmpty]) {
                [self.myImageView setImageWithURL:[NSURL URLWithString:tempItem.car.myCar_Img] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
            }
            

            if ([tempItem.car.myBrand_Name notEmpty] && [tempItem.car.mySubbrand_Name notEmpty]&& [tempItem.car.myCar_Name notEmpty]&& [tempItem.car.myCar_Year notEmpty]) {
              self.myNameLabel.text =[NSString stringWithFormat:@"%@ %@ %@款 %@",tempItem.car.myBrand_Name,tempItem.car.mySubbrand_Name,tempItem.car.myCar_Year,tempItem.car.myCar_Name] ;
            }
            
            if ([tempItem.car.myCar_Deposit notEmpty]) {
                self.myOrderPriceLabel.text = [NSString stringWithFormat:@"订单价格：%@元",tempItem.car.myCar_Deposit];
                
            }
        }
        
        if ([tempItem.order_no notEmpty]) {
            self.myOrderNoLabel.text = [NSString stringWithFormat:@"订单号：%@",tempItem.order_no];
            
            NSMutableAttributedString* tempArrt = [[NSMutableAttributedString alloc]initWithString:self.myOrderNoLabel.text];
            
            [tempArrt addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 4)];
            
            self.myOrderNoLabel.attributedText = tempArrt;
        }
        
        if ([tempItem.order_step notEmpty]) {
            //0未支付 1未发码 2未核销 3未上传凭证 4凭证待审核 5订单完成 -1订单关闭未退款 -2订单关闭已退款 -3凭证未通过审核 -4订单过期关闭
            if ([tempItem.order_step isEqualToString:@"0"])
            {
                self.mydelBtn.hidden = NO;
                self.myStatusBtn.hidden = NO;
                self.myOrderStatusLabel.text = @"待支付";
                self.myStatusBtn.tag = 1001;
                [self.myStatusBtn setTitle:@"立即支付" forState:UIControlStateNormal];
            }
            else if ([tempItem.order_step isEqualToString:@"1"])
            {
                self.myOrderStatusLabel.text = @"支付完成";
            }
            else if ([tempItem.order_step isEqualToString:@"2"])
            {
                self.myOrderStatusLabel.text = @"敬请提车";
            }
            else if ([tempItem.order_step isEqualToString:@"3"])
            {
                
                self.myStatusBtn.hidden = YES;
                self.mydelBtn.hidden = YES;
                self.myOrderStatusLabel.text = @"上传交易凭证";
                self.myStatusBtn.tag = 1002;
                [self.myStatusBtn setTitle:@"上传凭证并评价" forState:UIControlStateNormal];
            }
            else if ([tempItem.order_step isEqualToString:@"4"])
            {
                self.myOrderStatusLabel.text = @"等待奖励";
            }
            else if ([tempItem.order_step isEqualToString:@"5"])
            {
                self.myOrderStatusLabel.text = @"订单完成";
            }
            else if([tempItem.order_step isEqualToString:@"-1"])
            {
                self.myOrderStatusLabel.text = @"订单关闭";
            }else if([tempItem.order_step isEqualToString:@"-3"])
            {
                self.myStatusBtn.hidden = NO;
                self.mydelBtn.hidden = YES;
                self.myOrderStatusLabel.text = @"凭证未通过审核";
                self.myStatusBtn.tag = 1002;
                [self.myStatusBtn setTitle:@"上传凭证并评价" forState:UIControlStateNormal];
            }else if([tempItem.order_step isEqualToString:@"-2"])
            {
                self.myOrderStatusLabel.text = @"订单关闭";
            }else if([tempItem.order_step isEqualToString:@"-4"])
            {
                self.myOrderStatusLabel.text = @"订单关闭";
            }
            else if([tempItem.order_step isEqualToString:@"-5"])
            {
                self.myOrderStatusLabel.text = @"订单关闭";
            }else if([tempItem.order_step isEqualToString:@"-6"])
            {
                self.myOrderStatusLabel.text = @"订单关闭";
            }
        }
    }
}

@end
