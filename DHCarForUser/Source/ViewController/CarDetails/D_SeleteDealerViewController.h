//
//  D_SeleteDealerViewController.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewController.h"
#import "M_CityListModel.h"
#import "M_CarListModel.h"
#import "AppPublicData.h"
#import "M_DealerItemModel.h"


typedef void (^TSeleteDealerViewControllerBlock)(M_DealerItemModel* model);

@interface D_SeleteDealerViewController : DLTableViewController

AS_FACTORY(D_SeleteDealerViewController);

AS_BLOCK(TSeleteDealerViewControllerBlock, block);

AS_BOOL(isRadio);

AS_MODEL_STRONG(M_CarItemModel, myCarItemModel);
AS_MODEL_STRONG(M_CityItemModel, myCityItemModel);

AS_MODEL(TCarBottomType, carType);

AS_MODEL_STRONG(NSDictionary, myInquiryData);

@end
