//
//  M_RentalCarView.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/2.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MM_RentalCarItemView.h"
@interface M_RentalCarView : UIView<UITableViewDelegate,UITableViewDataSource,rentalCarItemDelegate>



@property(nonatomic,retain) UITableView *myTableView;

@property(nonatomic,retain) MM_RentalCarItemView *rentalCarItem;
@property(nonatomic,retain) NSMutableArray *myDataArray;

@end
