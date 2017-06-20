
//
//  LL_CarInforView.m
//  DHCarForSales
//
//  Created by leiyu on 15/12/23.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "LL_CarInforView.h"
#import "M_MyOrderModel.h"
#define edge 10
@interface LL_CarInforView()
AS_MODEL_STRONG(UILabel, myDisplacementLable);//排量
AS_MODEL_STRONG(UILabel, myGearInfoLable);//档位
AS_MODEL_STRONG(UILabel, myOilConsumptionIfoLable);//油耗
AS_MODEL_STRONG(UILabel, myDriveTypeInfoLable);//驱动模式
AS_MODEL_STRONG(UILabel, myCarInfo1Lable);
AS_MODEL_STRONG(UILabel, myCarInfo2Lable);
AS_MODEL_STRONG(UILabel, myCarInfo3Lable);
AS_MODEL_STRONG(UILabel, myCarInfo4Lable);
AS_MODEL_STRONG(UILabel, myCarInfo5Lable);
AS_MODEL_STRONG(UILabel, myCarInfo6Lable);
AS_MODEL_STRONG(UILabel, myCarInfo7Lable);
AS_MODEL_STRONG(UILabel, myCarInfo8Lable);
@end
@implementation LL_CarInforView
DEF_MODEL(myGearInfoLable);
DEF_MODEL(myDisplacementLable);
DEF_MODEL(myDriveTypeInfoLable);
DEF_MODEL(myOilConsumptionIfoLable);

DEF_MODEL(myCarInfo1Lable);
DEF_MODEL(myCarInfo2Lable);
DEF_MODEL(myCarInfo3Lable);
DEF_MODEL(myCarInfo4Lable);
DEF_MODEL(myCarInfo5Lable);
DEF_MODEL(myCarInfo6Lable);
DEF_MODEL(myCarInfo7Lable);
DEF_MODEL(myCarInfo8Lable);
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [Unity getColor:@"#f8f8f8"];
        [self initMyDisplacementWithFrame:CGRectMake(edge, edge, 100, 20)];
        [self initMyGearInfoLableWithFrame:CGRectMake(self.bounds.size.width/2, CGRectGetMinY(self.myDisplacementLable.frame), 100, 20)];
        [self initMyOilConsumptionIfoWithFrame:CGRectMake(edge, CGRectGetMaxY(self.myDisplacementLable.frame), 100, 20)];
        [self initMyDriveTypeInfoWithFrame:CGRectMake(self.bounds.size.width/2, CGRectGetMinY(self.myOilConsumptionIfoLable.frame), 100, 20)];
        [self initMyCarInfoLable1];
        [self initMyCarInfoLable2];
        [self initMyCarInfoLable3];
        [self initMyCarInfoLable4];
        [self initMyCarInfoLable5];
        [self initMyCarInfoLable6];
        [self initMyCarInfoLable7];
        [self initMyCarInfoLable8];
        
    }
    return self;
}
-(void)initMyCarInfoLable1
{
    self.myCarInfo1Lable = [[UILabel alloc]init];
    [self addSubview:self.myCarInfo1Lable];
    self.myCarInfo1Lable.textAlignment = NSTextAlignmentLeft;
    self.myCarInfo1Lable.font = [UIFont systemFontOfSize:12];
    self.myCarInfo1Lable.textColor = [Unity getColor:@"#777777"];
    
}
-(void)initMyCarInfoLable2
{
    self.myCarInfo2Lable = [[UILabel alloc]init];
    [self addSubview:self.myCarInfo2Lable];
    self.myCarInfo2Lable.font = [UIFont systemFontOfSize:12];
    self.myCarInfo2Lable.textColor = [Unity getColor:@"#777777"];
    self.myCarInfo2Lable.textAlignment = NSTextAlignmentLeft;
}
-(void)initMyCarInfoLable3
{
    self.myCarInfo3Lable = [[UILabel alloc]init];
    [self addSubview:self.myCarInfo3Lable];
    self.myCarInfo3Lable.font = [UIFont systemFontOfSize:12];
    self.myCarInfo3Lable.textColor = [Unity getColor:@"#777777"];
     self.myCarInfo3Lable.textAlignment = NSTextAlignmentLeft;
}
-(void)initMyCarInfoLable4
{
    self.myCarInfo4Lable = [[UILabel alloc]init];
    [self addSubview:self.myCarInfo4Lable];
    self.myCarInfo4Lable.font = [UIFont systemFontOfSize:12];
    self.myCarInfo4Lable.textColor = [Unity getColor:@"#777777"];
     self.myCarInfo4Lable.textAlignment = NSTextAlignmentLeft;
}
-(void)initMyCarInfoLable5
{
    self.myCarInfo5Lable = [[UILabel alloc]init];
    [self addSubview:self.myCarInfo5Lable];
    self.myCarInfo5Lable.font = [UIFont systemFontOfSize:12];
    self.myCarInfo5Lable.textColor = [Unity getColor:@"#777777"];
     self.myCarInfo5Lable.textAlignment = NSTextAlignmentLeft;
}
-(void)initMyCarInfoLable6
{
    self.myCarInfo6Lable = [[UILabel alloc]init];
    [self addSubview:self.myCarInfo6Lable];
    self.myCarInfo6Lable.font = [UIFont systemFontOfSize:12];
    self.myCarInfo6Lable.textColor = [Unity getColor:@"#777777"];
     self.myCarInfo6Lable.textAlignment = NSTextAlignmentLeft;
}
-(void)initMyCarInfoLable7
{
    self.myCarInfo7Lable = [[UILabel alloc]init];
    [self addSubview:self.myCarInfo7Lable];
    self.myCarInfo7Lable.font = [UIFont systemFontOfSize:12];
    self.myCarInfo7Lable.textColor = [Unity getColor:@"#777777"];
     self.myCarInfo7Lable.textAlignment = NSTextAlignmentLeft;
}
-(void)initMyCarInfoLable8
{
    self.myCarInfo8Lable = [[UILabel alloc]init];
    [self addSubview:self.myCarInfo8Lable];
    self.myCarInfo8Lable.font = [UIFont systemFontOfSize:12];
    self.myCarInfo8Lable.textColor = [Unity getColor:@"#777777"];
     self.myCarInfo8Lable.textAlignment = NSTextAlignmentLeft;
}
-(void)initMyDisplacementWithFrame:(CGRect)frame
{
    self.myDisplacementLable = [[UILabel alloc]initWithFrame:frame];
    [self addSubview:self.myDisplacementLable];
    self.myDisplacementLable.font = [UIFont systemFontOfSize:12];
    self.myDisplacementLable.textColor = [Unity getColor:@"#777777"];
    
}
-(void)initMyGearInfoLableWithFrame:(CGRect)frame
{
    self.myGearInfoLable = [[UILabel alloc]initWithFrame:frame];
    [self addSubview:self.myGearInfoLable];
    self.myGearInfoLable.font = [UIFont systemFontOfSize:12];
    self.myGearInfoLable.textColor = [Unity getColor:@"#777777"];
    
}
-(void)initMyOilConsumptionIfoWithFrame:(CGRect)frame
{
    self.myOilConsumptionIfoLable = [[UILabel alloc]initWithFrame:frame];
    [self addSubview:self.myOilConsumptionIfoLable];
    self.myOilConsumptionIfoLable.font = [UIFont systemFontOfSize:12];
    self.myOilConsumptionIfoLable.textColor = [Unity getColor:@"#777777"];
    
}
-(void)initMyDriveTypeInfoWithFrame:(CGRect)frame
{
    self.myDriveTypeInfoLable = [[UILabel alloc]initWithFrame:frame];
    [self addSubview:self.myDriveTypeInfoLable];
    self.myDriveTypeInfoLable.font = [UIFont systemFontOfSize:12];
    self.myDriveTypeInfoLable.textColor = [Unity getColor:@"#777777"];
}

-(void)upDataWithArr:(NSArray *)carinfoArr
{    for(int i=0;i<carinfoArr.count;i++)
    {
         M_CarParameterItemModel *partModel=(M_CarParameterItemModel *)carinfoArr[i];
        switch (i) {
            case 0:
            {
                self.myCarInfo1Lable.text = [NSString stringWithFormat:@"%@:%@",partModel.myParameter_Name,partModel.myParameter_Value];
                self.myCarInfo1Lable.frame =CGRectMake(edge, edge, 150, 20);
            }
                break;
            case 1:
            {
                self.myCarInfo2Lable.text = [NSString stringWithFormat:@"%@:%@",partModel.myParameter_Name,partModel.myParameter_Value];
                self.myCarInfo2Lable.frame = CGRectMake(self.bounds.size.width/2, CGRectGetMinY(self.myCarInfo1Lable.frame), 150, 20);
            }
                break;
            case 2:
            {
                self.myCarInfo3Lable.text = [NSString stringWithFormat:@"%@:%@",partModel.myParameter_Name,partModel.myParameter_Value];
                self.myCarInfo3Lable.frame = CGRectMake(CGRectGetMinX(self.myCarInfo1Lable.frame), CGRectGetMaxY(self.myCarInfo1Lable.frame), 150, 20);
            }
                break;
            case 3:
            {
                self.myCarInfo4Lable.text = [NSString stringWithFormat:@"%@:%@",partModel.myParameter_Name,partModel.myParameter_Value];
                self.myCarInfo4Lable.frame= CGRectMake(CGRectGetMinX(self.myCarInfo2Lable.frame), CGRectGetMinY(self.myCarInfo3Lable.frame), 150, 20);
            }
                break;
            case 4:
            {
                self.myCarInfo5Lable.text = [NSString stringWithFormat:@"%@:%@",partModel.myParameter_Name,partModel.myParameter_Value];
                self.myCarInfo5Lable.frame = CGRectMake(CGRectGetMinX(self.myCarInfo1Lable.frame), CGRectGetMaxY(self.myCarInfo3Lable.frame), 150, 20);
            }
                break;
            case 5:
            {
                self.myCarInfo6Lable.text = [NSString stringWithFormat:@"%@:%@",partModel.myParameter_Name,partModel.myParameter_Value];
                self.myCarInfo6Lable.frame = CGRectMake(CGRectGetMinX(self.myCarInfo4Lable.frame), CGRectGetMaxY(self.myCarInfo4Lable.frame), 150, 20);
            }
                break;
            case 6:
            {
                self.myCarInfo7Lable.text = [NSString stringWithFormat:@"%@:%@",partModel.myParameter_Name,partModel.myParameter_Value];
                self.myCarInfo7Lable.frame = CGRectMake(CGRectGetMinX(self.myCarInfo1Lable.frame), CGRectGetMaxY(self.myCarInfo5Lable.frame), 150, 20);
            }
                break;
            case 7:
            {
                self.myCarInfo8Lable.text = [NSString stringWithFormat:@"%@:%@",partModel.myParameter_Name,partModel.myParameter_Value];
                self.myCarInfo8Lable.frame =CGRectMake(CGRectGetMinX(self.myCarInfo2Lable.frame), CGRectGetMaxY(self.myCarInfo6Lable.frame), 150, 20);
            }
                break;
          
            default:
                break;
        }
        
    }
   
    for (int i= carinfoArr.count+1; i<=8; i++) {
        switch (i) {
            case 1:
            {
                self.myCarInfo1Lable.hidden = YES;
            }
                break;
            case 2:
            {
                 self.myCarInfo2Lable.hidden = YES;
            }
                break;
            case 3:
            {
                 self.myCarInfo3Lable.hidden = YES;
            }
                break;
            case 4:
            {
                 self.myCarInfo4Lable.hidden = YES;
            }
                break;
            case 5:
            {
                 self.myCarInfo5Lable.hidden = YES;
            }
                break;
            case 6:
            {
                 self.myCarInfo6Lable.hidden = YES;
            }
                break;
            case 7:
            {
                 self.myCarInfo7Lable.hidden = YES;
            }
                break;
            case 8:
            {
                 self.myCarInfo8Lable.hidden = YES;
            }
                break;
            default:
                break;
        }
    }
    
}
@end
