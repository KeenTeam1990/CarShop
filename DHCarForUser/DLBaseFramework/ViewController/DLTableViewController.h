//
//  DLTableViewController.h
//  Auction
//
//  Created by 卢迎志 on 14-12-16.
//
//

#import "DLBaseViewController.h"

@interface DLTableViewController : DLBaseViewController<UITableViewDataSource,UITableViewDelegate>

AS_MODEL_STRONG(UITableView, myTableView);
AS_MODEL_STRONG(NSMutableArray, myDataArray);

-(void)initTableGroupView:(CGRect)rect withSeparatoStyle:(UITableViewCellSeparatorStyle)style;

-(void)initTablePlainView:(CGRect)rect withSeparatoStyle:(UITableViewCellSeparatorStyle)style;

-(void)showPageError:(BOOL)show withIsError:(BOOL)error;

-(void)resetGetData;

@end
