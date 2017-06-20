//
//  AppPublicData.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "M_CarListModel.h"

typedef void (^TCarItemViewBlock)(M_CarItemModel* model);

typedef enum
{
    EB_Not,
    EB_NewCar,
    EB_SpeciaiCar,
    EB_RentaiCar
}TCarBottomType;

@interface AppPublicData : NSObject

@end
