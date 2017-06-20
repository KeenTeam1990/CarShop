//
//  D_ConfigHeadView.h
//  DHCarForSales
//
//  Created by leiyu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"
@class M_UserInfoModel;
@interface D_ConfigHeadView : DLView
//@property(nonatomic ,copy)NSString *userHeadImageUrl;
//@property(nonatomic,copy)NSString *userName;
//@property(nonatomic,copy)NSString *usrSex;
@property(nonatomic,strong)M_UserInfoModel *model;
@end
