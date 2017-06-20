//
//  D_SeleteCityViewController.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewController.h"
#import "M_CityListModel.h"

typedef void (^TSeleteCityControllerBlock)(M_CityItemModel* model);

@interface D_SeleteCityViewController : DLTableViewController

AS_FACTORY(D_SeleteCityViewController);

AS_BLOCK(TSeleteCityControllerBlock, block);

@end
