//
//  M_IntegralCell.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/12.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"
#import "M_IntegralModel.h"
#import "CB_Label.h"

@interface M_IntegralCell : DLTableViewCell


@property(nonatomic,strong) CB_Label *label1;
@property(nonatomic,strong) CB_Label *label2;
@property(nonatomic,strong) CB_Label *label3;
@property(nonatomic,strong) CB_Label *label4;

@property(nonatomic,strong) NSString *btnStr;
-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;
@end
