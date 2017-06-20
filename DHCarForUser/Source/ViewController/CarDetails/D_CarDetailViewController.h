//
//  D_CarDetailViewController.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/2.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewController.h"
#import "AppPublicData.h"
#import "M_DealerItemModel.h"

@protocol D_CarDetailViewControllerDelegate <NSObject>

-(void)shouleRefreach;
@end

@interface D_CarDetailViewController : DLTableViewController

AS_FACTORY(D_CarDetailViewController);
AS_DELEGATE(id<D_CarDetailViewControllerDelegate>, myDelegate);
//车id
AS_MODEL_STRONG(NSString, myCarId);
//经销商Item
AS_MODEL_STRONG(M_DealerItemModel, myDealerItemModel);

AS_MODEL(TCarBottomType, carType);

@end
