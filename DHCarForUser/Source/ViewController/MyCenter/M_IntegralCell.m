//
//  M_IntegralCell.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/12.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_IntegralCell.h"
//#import "M_IntegralModel.h"

@implementation M_IntegralCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        [self initView];
        
    }
    return self;
}

-(void)initView
{
    CGRect rect1 = CGRectMake(20 ,20, 60,20);
    
    self.label1 = [CB_Label labelWithBoldColor:RedText frame:rect1 andTextFont:14];
    [self.contentView addSubview:self.label1];
    
    CGRect rect2 = CGRectMake(100 ,20, ScreenWidth - 60,20);
    self.label2 = [CB_Label labelWithBoldColor:[UIColor blackColor] frame:rect2 andTextFont:14];
    [self.contentView addSubview:self.label2];
    
    UIImageView *lineView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50,ScreenWidth, 1)];
    lineView1.image = [UIImage imageNamed:@"dashedLine.png"];
    [self.contentView addSubview:lineView1];
    
    CGRect rect3 = CGRectMake(20 ,51, 100,20);
    self.label3 = [CB_Label labelWithBoldColor:GrayView frame:rect3 andTextFont:14];
    [self.contentView addSubview:self.label3];
    
    CGRect rect4 = CGRectMake(StartX(450) ,50, Width(250),20);
    self.label4 = [CB_Label labelWithBoldColor:GrayText frame:rect4 andTextFont:12];
    [self.contentView addSubview:self.label4];
    
    
}



-(void)layoutSubviews
{
    [super layoutSubviews];
}


-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
   // M_IntegralModel *model = [array objectAtIndex:indexPath.row];
    M_IntegralTtemModel *model = [array objectAtIndex:indexPath.row];
    if (model != nil) {
        self.label1.text = @"";
        self.label2.text = @"";
        self.label3.text = @"";
        self.label4.text = @"";
        
        if ([model.gold_name notEmpty]) {
            
            self.label1.text = model.gold_name;
        }
        if ([model.gold_memo notEmpty]) {
            self.label2.text = model.gold_memo;
        }
        if ([model.gold_number notEmpty]) {
            self.label3.text = model.gold_number;
        }
        if ([model.gold_time notEmpty]) {
            self.label4.text = model.gold_time;
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
