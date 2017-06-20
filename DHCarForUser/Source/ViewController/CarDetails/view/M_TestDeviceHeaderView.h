//
//  M_TestDeviceHeaderView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"
#import "AppPublicData.h"
#import "M_CarListModel.h"
#import "M_DealerItemModel.h"

//tag
//0 brand
//1 subbrand
//2 year
//3 car
//4 city
//5 dealer
//6 time
//7 modity
//8 surebtn
//10 打电话
typedef void (^TTestDeviceHeaderViewBlock)(NSInteger tag,id data);

@interface M_TestDeviceHeaderView : DLView

AS_FACTORY_FRAME(M_TestDeviceHeaderView);

AS_BLOCK(TTestDeviceHeaderViewBlock, block);

-(void)updateData:(M_CarItemModel*)model;

-(void)updateDealerData:(M_DealerItemModel*)data;

-(void)updateContent:(id)data withTag:(NSInteger)tag;

@end
