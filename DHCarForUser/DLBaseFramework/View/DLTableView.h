//
//  DLTableView.h
//  Auction
//
//  Created by 卢迎志 on 14-12-17.
//
//

#import <UIKit/UIKit.h>
#import "DLView.h"
#import "DLPageErrorView.h"
@interface DLTableView : DLView<UITableViewDataSource,UITableViewDelegate>

AS_MODEL_STRONG(UITableView, myTableView);
AS_MODEL_STRONG(NSMutableArray, myDataArray);
AS_MODEL_STRONG(DLPageErrorView, myErrorView);

-(void)initTableView:(CGRect)rect withSeparatoStyle:(UITableViewCellSeparatorStyle)style;

-(void)showPageError:(BOOL)show withIsError:(BOOL)error;

-(void)resetGetData;

@end
