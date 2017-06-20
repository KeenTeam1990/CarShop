//
//  M_CarDistributorItemCell.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/8.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarDistributorItemCell.h"
#import "M_CarDistributorItemView.h"
#import "M_DealerItemModel.h"

@interface M_CarDistributorItemCell ()

AS_MODEL_STRONG(M_CarDistributorItemView, myItemView);
AS_MODEL_STRONG(UIButton, myOpenCallBtn);
AS_MODEL_STRONG(M_DealerItemModel, myModel);
@end

@implementation M_CarDistributorItemCell

DEF_MODEL(myItemView);
DEF_MODEL(myModel);
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        self.myItemView = [M_CarDistributorItemView allocInstanceFrame:CGRectMake(0, 5, self.bounds.size.width, 110)];
        [self.contentView addSubview:self.myItemView];
        
        self.myOpenCallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.myOpenCallBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor]; style.borderWidth = 1;
                                                     style.borderColor = [UIColor blackColor];
                                                     style.cornerRedius = 5;);
        self.myOpenCallBtn.tintColor = [UIColor blackColor];
        [self.myOpenCallBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.myOpenCallBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        self.myOpenCallBtn.frame = CGRectMake(self.myItemView.frame.size.width-110, 110-35, 80, 30);
        [self.myOpenCallBtn addTarget:self action:@selector(openCallBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.myOpenCallBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
        self.myOpenCallBtn.userInteractionEnabled = YES;
        [self.myItemView addSubview:self.myOpenCallBtn];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempFrame = self.myItemView.frame;
    tempFrame.size.width = self.bounds.size.width;
    self.myItemView.frame = tempFrame;
    
    tempFrame = self.myOpenCallBtn.frame;
    tempFrame.origin.x=self.myItemView.frame.size.width-110;
    self.myOpenCallBtn.frame = tempFrame;
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array andwithType:(TCarBottomType )type
{
    M_DealerItemModel* tempItem = [array objectAtIndex:indexPath.row];
    
    if (type == EB_RentaiCar) {
        self.myItemView.showPrice = NO;
    }
    if (tempItem!=nil) {
        self.myModel = tempItem;
        [self.myItemView updateData:tempItem];
    }
}
-(void)openCallBtnPressed:(UIButton *)button
{
    NSLog(@"ssss=%@",self.myModel.dealer_tel);
    if (self.myModel != nil &&self.myBlock != nil ) {
        self.myBlock(self.myModel);
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
