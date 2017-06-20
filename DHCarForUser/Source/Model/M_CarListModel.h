//
//  M_CarListModel.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/10.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"
#import "M_DealerItemModel.h"

@interface M_CarParameterItemModel : DLBaseModel

AS_FACTORY(M_CarParameterItemModel);

AS_MODEL_STRONG(NSString, myParameter_Id);
AS_MODEL_STRONG(NSString, myParameter_Name);
AS_MODEL_STRONG(NSString, myParameter_Value);
AS_MODEL_STRONG(NSMutableArray, myParameter_ItemArray);

@end

@interface M_CarPolicyItemModel : DLBaseModel

AS_FACTORY(M_CarPolicyItemModel);

AS_MODEL_STRONG(NSString, myPolicy_Id);//售后政策Id
AS_MODEL_STRONG(NSString, myPolicy_Title);//售后政策名称
AS_MODEL_STRONG(NSString, myPolicy_Wap);//WAP地址

@end

@interface M_CarLoanItemModel : DLBaseModel

AS_FACTORY(M_CarLoanItemModel);

AS_MODEL_STRONG(NSString, myLoan_Id);//金融贷款方案Id
AS_MODEL_STRONG(NSString, myLoan_Title);//金融贷款方案名称
AS_MODEL_STRONG(NSString, myLoan_Wap);//WAP地址

@end


@interface M_CarLeaseItemModel : DLBaseModel

AS_FACTORY(M_CarLeaseItemModel);

AS_MODEL_STRONG(NSString, myLease_Id);//租购ID
AS_MODEL_STRONG(NSString, myDealer_Car_id);//经销商车型id
AS_MODEL_STRONG(NSString, myLease_Title);//方案标题
AS_MODEL_STRONG(NSString, myLease_Content);//方案内容
AS_MODEL_STRONG(NSString, myLease_Loan);//分期数
AS_MODEL_STRONG(NSString, myLease_Panyment);//首付金额 单位万元

AS_BOOL(isSelete);

@end

@interface M_CarColorItemModel : DLBaseModel

AS_FACTORY(M_CarColorItemModel);

AS_MODEL_STRONG(NSString, myColor_Id);//颜色ID
AS_MODEL_STRONG(NSString, myCar_Color_Id);//颜色ID
AS_MODEL_STRONG(NSString, myCar_Color_Name);//颜色名称
AS_MODEL_STRONG(NSString, myCar_Color_Img);//颜色图片

AS_MODEL_STRONG(NSString, myCar_Count);//数量

AS_BOOL(selete);

@end

@interface M_CarItemModel : DLBaseModel

AS_FACTORY(M_CarItemModel);

AS_BOOL(showQRCodeData);

AS_MODEL_STRONG(NSIndexPath, myIndexPath);

AS_MODEL_STRONG(NSString, myUpDated_at);//时间
AS_MODEL_STRONG(NSString, myCreated_at);//时间
AS_MODEL_STRONG(NSString, myCar_Id);//汽车ID
AS_MODEL_STRONG(NSString, myBigBrand_Id);//大品牌ID
AS_MODEL_STRONG(NSString, myBigBrand_Name);//大品牌名称
AS_MODEL_STRONG(NSString, myBrand_Id);//品牌ID
AS_MODEL_STRONG(NSString, myBrand_Name);//品牌名称
AS_MODEL_STRONG(NSString, mySubbrand_Id);//车系ID
AS_MODEL_STRONG(NSString, mySubbrand_Name);//车系名称
AS_MODEL_STRONG(NSString, myCar_Name);//车型名称
AS_MODEL_STRONG(NSString, myCar_Price);//官方指导价 单位万元
AS_MODEL_STRONG(NSString, myLease_Price);//最低报价 租购使用
AS_MODEL_STRONG(NSString, myCar_Img);//图片
AS_MODEL_STRONG(NSString, myCar_Policy);//售后政策

AS_BOOL(myCar_Lease);//是否租购
AS_BOOL(myCar_Sales);//是否特价
AS_BOOL(myCar_New);//是否新车

AS_MODEL_STRONG(NSString, myCar_Code);//编码
AS_MODEL_STRONG(NSString, myCar_Year);//年份
AS_MODEL_STRONG(NSMutableArray, myCarImgArray);//图片
AS_MODEL_STRONG(NSString, myCar_Info);//介绍

AS_MODEL_STRONG(NSString, myCar_Deposit);//订金金额
AS_MODEL_STRONG(NSString, myDealer_Car_Id);//所属经销商唯一ID
AS_MODEL_STRONG(NSString, myDealer_Car_Price);//经销商最低报价 单位万元

AS_MODEL_STRONG(NSString, myCar_Collect);//是否收藏 Y／N
AS_MODEL_STRONG(NSString, has_Favorite);//是否收藏

AS_MODEL_STRONG(NSString, readID);//浏览id

AS_MODEL_STRONG(M_CarColorItemModel, myItemColorModel);//选择的汽车颜色

AS_MODEL_STRONG(NSMutableArray, myColorArray);//颜色数组
AS_MODEL_STRONG(NSMutableArray, myDealersArray);//经销商数组
AS_MODEL_STRONG(NSMutableArray, myParameterArray);//参数配置数组
AS_MODEL_STRONG(NSMutableArray, myLeaseArray);//

AS_MODEL_STRONG(M_DealerItemModel, myDealerItemModel);//经销商
AS_MODEL_STRONG(NSMutableArray, mySelasArray);//销售顾问

@end

@interface M_CarListModel : DLBaseModel

AS_FACTORY(M_CarListModel);

AS_MODEL_STRONG(NSMutableArray, myItemArray);

@end
