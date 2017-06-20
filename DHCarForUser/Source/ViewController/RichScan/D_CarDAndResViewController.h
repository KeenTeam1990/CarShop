//
//  D_CarDAndResViewController.h
//  DHCarForUser
//
//  Created by lucaslu on 16/4/3.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLTableViewController.h"
#import "AppPublicData.h"
#import "M_DealerItemModel.h"

@interface D_CarDAndResViewController : DLTableViewController

AS_FACTORY(D_CarDAndResViewController);

//车id
AS_MODEL_STRONG(NSString, myCarId);

AS_MODEL(TCarBottomType, carType);

AS_MODEL_STRONG(NSString , myGetUrl);

@end
