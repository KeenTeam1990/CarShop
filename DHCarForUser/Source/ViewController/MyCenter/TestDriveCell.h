//
//  TestDriveCell.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"
#import "M_TestDriverModel.h"
#import "M_CarDistributorItemView1.h"
#import "M_TestDriverModel.h"

typedef void (^TMyTestDriveCellBlock)(NSInteger tag,id data);

@interface TestDriveCell : DLTableViewCell

@property(nonatomic , strong)M_TestDriverModel *testDriverModel;

@property(nonatomic ,strong)NSMutableArray *dataArray;
@property(nonatomic,strong) UIImageView *carImageView;
@property(nonatomic,strong) UILabel *label1;
@property(nonatomic,strong) UILabel *label2;
@property(nonatomic,strong) UILabel *label3;
@property(nonatomic,strong) UILabel *label4;
@property(nonatomic,strong) UILabel *label5;
@property(nonatomic,strong) UILabel *label6;

@property(nonatomic,strong) UILabel *testDriveDate;
@property(nonatomic,strong) UIButton *mydelBtn;//删除按钮
@property(nonatomic,strong) M_TestDriverItemModel *myItemModel;


@property(nonatomic,strong) M_CarDistributorItemView1 *dealerView;

AS_BLOCK(TMyTestDriveCellBlock, block);

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;
@end
