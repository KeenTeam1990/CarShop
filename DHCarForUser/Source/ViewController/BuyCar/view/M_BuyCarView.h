//
//  M_BuyCarView.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/10/30.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLTableView.h"
#import "MM_BuyCarItemView.h"

@interface M_BuyCarView : DLView<UITableViewDataSource,UITableViewDelegate,buyCarItem>


@property(nonatomic,retain) UITableView *myTableView;
@property(nonatomic,retain) UISearchBar *mySearchBar;
@property(nonatomic,retain) MM_BuyCarItemView *buyCarItem;
@property(nonatomic,retain) NSMutableArray *myDataArray;
@end
