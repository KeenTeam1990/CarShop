//
//  M_CarGasRecordItemCell.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarGasRecordItemCell.h"
#import "M_CarGasListModel.h"

#define KLeftOffset  20
#define KLabelWidth  80

@interface M_CarGasRecordItemCell ()

AS_MODEL_STRONG(UILabel, myGas_number);
AS_MODEL_STRONG(UILabel, myGas_price);
AS_MODEL_STRONG(UILabel, myGas_state);
AS_MODEL_STRONG(UILabel, myGas_createtime);
AS_MODEL_STRONG(UILabel, myGas_pay_state);
AS_MODEL_STRONG(UIButton, myResendBtn);
AS_MODEL_STRONG(M_CarGasItemModel, myItemModel);

@end

@implementation M_CarGasRecordItemCell

DEF_MODEL(myGas_createtime);
DEF_MODEL(myGas_number);
DEF_MODEL(myGas_pay_state);
DEF_MODEL(myGas_price);
DEF_MODEL(myGas_state);
DEF_MODEL(myResendBtn);
DEF_MODEL(block);
DEF_MODEL(myItemModel);

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
    UILabel* tempLabel = [self getLabel:CGRectMake(KLeftOffset, frame.origin.y+(frame.size.height-30)/2, KLabelWidth, 30)];
    [tempLabel setText:@"充值单号："];
    
    self.myGas_number = [self getLabel:CGRectMake(KLeftOffset+KLabelWidth, frame.origin.y+(frame.size.height-30)/2, frame.size.width-KLeftOffset*2-KLabelWidth, 30)];
    [self.myGas_number setTextColor:RGBCOLOR(0, 123, 206)];
}


-(void)initRow2View:(CGRect)frame
{
    UILabel* tempLabel = [self getLabel:CGRectMake(KLeftOffset, frame.origin.y+(frame.size.height-30)/2, KLabelWidth, 30)];
    [tempLabel setText:@"充值金额："];
    
    self.myGas_price = [self getLabel:CGRectMake(KLeftOffset+KLabelWidth, frame.origin.y+(frame.size.height-30)/2, frame.size.width-KLeftOffset*2-KLabelWidth, 30)];
    [self.myGas_price setTextColor:RGBCOLOR(102, 102, 102)];
}

-(void)initRow3View:(CGRect)frame
{
    UILabel* tempLabel = [self getLabel:CGRectMake(KLeftOffset, frame.origin.y+(frame.size.height-30)/2, KLabelWidth, 30)];
    [tempLabel setText:@"充值时间："];
    
    self.myGas_createtime = [self getLabel:CGRectMake(KLeftOffset+KLabelWidth, frame.origin.y+(frame.size.height-30)/2, frame.size.width-KLeftOffset*2-KLabelWidth, 30)];
    [self.myGas_createtime setTextColor:RGBCOLOR(152, 152, 152)];
}

-(void)initRow4View:(CGRect)frame
{
    UIImage* tempBtnBg = [UIImage imageNamed:@"登录.png"];
    UIImage* tempBtn_HBg = [UIImage imageNamed:@"登录按下.png"];

    self.myResendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.myResendBtn addTarget:self action:@selector(resendBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.myResendBtn setBackgroundImage:[tempBtnBg stretchableImageWithLeftCapWidth:tempBtnBg.size.width/2 topCapHeight:tempBtnBg.size.height/2] forState:UIControlStateNormal];
    [self.myResendBtn setBackgroundImage:[tempBtn_HBg stretchableImageWithLeftCapWidth:tempBtn_HBg.size.width/2 topCapHeight:tempBtn_HBg.size.height/2] forState:UIControlStateHighlighted];
    [self.myResendBtn setTitle:@"重新发送" forState:UIControlStateNormal];
    [self.myResendBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    self.myResendBtn.frame = CGRectMake(frame.size.width-80-KLeftOffset, frame.origin.y+(frame.size.height-30)/2, 80, 30);
    self.myResendBtn.hidden = YES;
    [self.contentView addSubview:self.myResendBtn];
    
    self.myGas_state = [self getLabel:CGRectMake(frame.size.width-200-KLeftOffset, frame.origin.y+(frame.size.height-30)/2, 200, 30)];
    [self.myGas_state setTextColor:[UIColor redColor]];
    [self.myGas_state setTextAlignment:UITextAlignmentRight];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    M_CarGasItemModel* tempItem = [array objectAtIndex:indexPath.row];
    if (tempItem!=nil) {
        
        self.myItemModel = tempItem;
        
        self.myGas_state.text = @"";
        self.myGas_price.text = @"";
        self.myGas_pay_state.text = @"";
        self.myGas_number.text = @"";
        self.myGas_createtime.text = @"";
        self.myResendBtn.hidden = YES;
        
        if ([tempItem.order_gas_number notEmpty]) {
            self.myGas_number.text= tempItem.order_gas_number;
        }
        if ([tempItem.order_gas_price notEmpty]) {
            self.myGas_price.text = tempItem.order_gas_price;
        }
        if ([tempItem.order_gas_createtime notEmpty]) {
            self.myGas_createtime.text = tempItem.order_gas_createtime;
        }
        if ([tempItem.order_gas_state notEmpty]) {
            //状态，0待付款，1 已支付(待审核)，2 已审核
            if ([tempItem.order_gas_state isEqualToString:@"0"]) {
                self.myGas_state.text = @"待支付";
            }else if ([tempItem.order_gas_state isEqualToString:@"1"]) {
                self.myGas_state.text = @"待审核";
            }else if ([tempItem.order_gas_state isEqualToString:@"2"]) {
                self.myGas_state.text = @"已审核，等待短信";
            }
        }
    }
}

-(void)resendBtnPressed:(id)sender
{
    if (self.block!=nil) {
        self.block(self.myItemModel);
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
