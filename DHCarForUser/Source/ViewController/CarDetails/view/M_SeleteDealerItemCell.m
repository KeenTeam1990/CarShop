//
//  M_SeleteDealerItemCell.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_SeleteDealerItemCell.h"
#import "M_CarDistributorItemView.h"
#import "M_DealerItemModel.h"

@interface M_SeleteDealerItemCell  ()

AS_MODEL_STRONG(M_CarDistributorItemView, myItemView);
AS_MODEL_STRONG(UIImageView, myLineView);
AS_MODEL_STRONG(UIButton, mySeleteButton);
AS_MODEL_STRONG(M_DealerItemModel, myItemModel);

AS_MODEL_STRONG(UIView, myView);

AS_MODEL_STRONG(UIButton, mySSBtn);
AS_MODEL_STRONG(UIButton, myCallTelBtn);
AS_MODEL_STRONG(UIButton, myReserveBtn);

@end

@implementation M_SeleteDealerItemCell

DEF_MODEL(myItemView);
DEF_MODEL(myLineView);
DEF_MODEL(mySeleteButton);
DEF_MODEL(myItemModel);
DEF_MODEL(isRadio);
DEF_MODEL(myView);
DEF_MODEL(mySSBtn);

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];

        self.myView = [[UIView alloc]initWithFrame:CGRectMake(5, 5, self.bounds.size.width-10, 150)];
        [self.myView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.myView];
        
        self.myItemView = [M_CarDistributorItemView allocInstanceFrame:CGRectMake(5, 5, self.bounds.size.width-50, 110)];
        self.myItemView.userInteractionEnabled = NO;
        self.myItemView.updateNameSize = CGSizeMake(120, 30);
        [self.contentView addSubview:self.myItemView];
        
        self.myLineView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width-40, 5, 1, 100)];
        self.myLineView.backgroundColor = RGBCOLOR(202, 202, 202);
        [self.contentView addSubview:self.myLineView];
        
        self.mySeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.mySeleteButton.frame = CGRectMake(self.bounds.size.width-50, 5, 50, 50);
        self.mySeleteButton.userInteractionEnabled = NO;
        [self.contentView addSubview:self.mySeleteButton];
        
        self.myCallTelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        ViewBorderRadius(self.myCallTelBtn, 5, 1, [UIColor blackColor]);
        self.myCallTelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.myCallTelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.myCallTelBtn.frame = CGRectMake(self.myItemView.frame.origin.x+15, 110, self.myItemView.frame.size.width/3-10, 30);
        [self.myCallTelBtn addTarget:self action:@selector(callTelBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.myCallTelBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
        [self.contentView addSubview:self.myCallTelBtn];
        
        self.mySSBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        ViewBorderRadius(self.mySSBtn, 5, 1, [UIColor blackColor]);
        self.mySSBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.mySSBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.mySSBtn.frame = CGRectMake(self.myItemView.frame.origin.x+self.myItemView.frame.size.width/3+15, 110, self.myItemView.frame.size.width/3-10, 30);
        [self.mySSBtn addTarget:self action:@selector(ssBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.mySSBtn setTitle:@"预约试驾" forState:UIControlStateNormal];
        [self.contentView addSubview:self.mySSBtn];
        
        self.myReserveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        ViewBorderRadius(self.myReserveBtn, 5, 1, [UIColor redColor]);
        self.myReserveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.myReserveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.myReserveBtn setBackgroundColor:[UIColor redColor]];

        self.myReserveBtn.frame = CGRectMake(self.myItemView.frame.origin.x+2*(self.myItemView.frame.size.width/3)+15, 110, self.myItemView.frame.size.width/3-10, 30);
        [self.myReserveBtn addTarget:self action:@selector(reserveBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.myReserveBtn setTitle:@"马上预定" forState:UIControlStateNormal];
        [self.contentView addSubview:self.myReserveBtn];
    }
    return self;
}

-(void)callTelBtnPressed:(id)sender
{
    if (self.block!=nil) {
        self.block(3,self.myItemModel);
    }
}

-(void)reserveBtnPressed:(id)sender
{
    if (self.block!=nil) {
        self.block(2,self.myItemModel);
    }
}

-(void)ssBtnPressed:(id)sender
{
    if (self.block!=nil) {
        self.block(1,self.myItemModel);
    }
}

-(void)setIsRadio:(BOOL)show
{
    isRadio = show;
    
    UIImage* tempImage1 = [UIImage imageNamed:@"unselect.png"];
    UIImage* tempImage2 = [UIImage imageNamed:@"select.png"];
    if (show) {
        tempImage1 = [UIImage imageNamed:@"unselect.png"];
        tempImage2 = [UIImage imageNamed:@"select.png"];
    }
    [self.mySeleteButton setImage:tempImage1 forState:UIControlStateNormal];
    [self.mySeleteButton setImage:tempImage2 forState:UIControlStateSelected];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempFrame = self.myItemView.frame;
    tempFrame.size.width = self.bounds.size.width-40;
    self.myItemView.frame = tempFrame;
    
    int itemw = self.myItemView.frame.size.width-20;
    
    tempFrame = self.myCallTelBtn.frame;
    tempFrame.origin.x = self.myItemView.frame.origin.x+15;
    tempFrame.size.width = itemw/3-10;
    self.myCallTelBtn.frame = tempFrame;
    
    tempFrame = self.mySSBtn.frame;
    tempFrame.origin.x = self.myItemView.frame.origin.x+15+(itemw/3);
    tempFrame.size.width = itemw/3-10;
    self.mySSBtn.frame = tempFrame;
    
    tempFrame = self.myReserveBtn.frame;
    tempFrame.origin.x = self.myItemView.frame.origin.x+15+(itemw/3)*2;
    tempFrame.size.width = itemw/3-10;
    self.myReserveBtn.frame = tempFrame;
    
    tempFrame = self.myView.frame;
    tempFrame.size.width = self.bounds.size.width-10;
    self.myView.frame = tempFrame;
    
    tempFrame = self.myLineView.frame;
    tempFrame.origin.x = self.bounds.size.width-40;
    self.myLineView.frame = tempFrame;
    
    tempFrame = self.mySeleteButton.frame;
    tempFrame.origin.x = self.bounds.size.width-50;
    tempFrame.origin.y = (self.bounds.size.height-50)/2;
    self.mySeleteButton.frame = tempFrame;
    
        
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    M_DealerItemModel* tempItem = [array objectAtIndex:indexPath.row];
    if (tempItem!=nil) {
        
        self.myItemModel = tempItem;
        
        [self.myItemView updateData:tempItem];
        [self.mySeleteButton setSelected:tempItem.selete];
        
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
