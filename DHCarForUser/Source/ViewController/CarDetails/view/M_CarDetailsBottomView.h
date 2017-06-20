//
//  M_CarDetailsBottomView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/8.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppPublicData.h"

//tag

//1 leftbtn  拨发电话
//2 rightbtn 询价
//3 rightbtn 预订
typedef void (^TCarDetailsBottomBlock)(NSInteger tag,BOOL isCollect);

@interface M_CarDetailsBottomView : UIView

AS_FACTORY_FRAME(M_CarDetailsBottomView);

AS_BLOCK(TCarDetailsBottomBlock, block);

AS_MODEL(TCarBottomType, carType);

AS_BOOL(showLeftBtn);

@end
