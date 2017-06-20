//
//  M_QueryModelsCell.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/12.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"
#import "M_QueryModelsModel.h"
#import "CB_Label.h"
@interface M_QueryModelsCell : DLTableViewCell


@property(nonatomic , strong)M_QueryModelsModel *myQueryModel;
@property(nonatomic ,strong)NSMutableArray *dataArray;
@property(nonatomic,strong) UIImageView *carImageView;
@property(nonatomic,strong) UILabel *label1;
@property(nonatomic,strong) UILabel *label2;
@property(nonatomic,strong) UILabel *label3;
@property(nonatomic,strong) UILabel *label4;
@property(nonatomic,strong) UILabel *label5;
@property(nonatomic,strong) UIImageView *myLineView;

AS_MODEL_STRONG(UILabel, myComboLabel);
AS_MODEL_STRONG(UIView, myComboView);
AS_MODEL_STRONG(UIImageView, myLine8View);


-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;

@end
