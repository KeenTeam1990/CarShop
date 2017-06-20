//
//  M_DealerItemCell.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_DealerItemCell.h"
#import "M_CarDistributorItemView.h"
#import "M_DealerItemModel.h"

@interface M_DealerItemCell ()

AS_MODEL_STRONG(M_CarDistributorItemView, myItemView);
AS_MODEL_STRONG(M_DealerItemModel, myItemModel);
AS_MODEL_STRONG(UIButton, myOpenCallBtn);
AS_MODEL_STRONG(M_DealerItemModel, myModel);

@end

@implementation M_DealerItemCell

DEF_MODEL(myItemModel);
DEF_MODEL(myItemView);

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        self.myItemView = [M_CarDistributorItemView allocInstanceFrame:CGRectMake(0, 5, self.bounds.size.width, 110)];
        self.myItemView.showPrice = NO;
        [self.contentView addSubview:self.myItemView];
        self.myOpenCallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.myOpenCallBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor]; style.borderWidth = 1;
                                                     style.borderColor = [UIColor grayColor];
                                                     style.cornerRedius = 5;);
        self.myOpenCallBtn.tintColor = [UIColor blackColor];
        [self.myOpenCallBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.myOpenCallBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        self.myOpenCallBtn.frame = CGRectMake(self.frame.size.width-110, CGRectGetMaxY(self.myItemView.frame)-35, 80, 30);
        [self.myOpenCallBtn addTarget:self action:@selector(openCallBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.myOpenCallBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
        self.myOpenCallBtn.userInteractionEnabled = YES;
        [self.contentView addSubview:self.myOpenCallBtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempFrame = self.myItemView.frame;
    tempFrame.size.width = self.bounds.size.width;
    self.myItemView.frame = tempFrame;
    
    tempFrame = self.myOpenCallBtn.frame;
    tempFrame.origin.x =self.frame.size.width-110;
    self.myOpenCallBtn.frame = tempFrame;
}
-(void)openCallBtnPressed:(UIButton *)button
{
    if(self.myBlock!= nil)
    {
        self.myBlock(self.myModel.dealer_tel);
    }
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    M_DealerItemModel* tempItem = [array objectAtIndex:indexPath.row];
    if (tempItem!=nil) {
        tempItem.myIndexPath = indexPath;
        self.myModel = tempItem;
        [self.myItemView updateData:tempItem];
    }
}


@end
