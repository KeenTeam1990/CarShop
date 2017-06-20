//
//  DLTableView.m
//  Auction
//
//  Created by 卢迎志 on 14-12-17.
//
//

#import "DLTableView.h"


@interface DLTableView ()



@end

@implementation DLTableView

DEF_MODEL(myDataArray);
DEF_MODEL(myTableView);

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.myDataArray = [NSMutableArray allocInstance];
    
        self.myErrorView = [DLPageErrorView allocInstanceFrame:CGRectZero];
        self.myErrorView.hidden = YES;
        [self addSubview:self.myErrorView];
        
        __weak DLTableView *tempSelf = self;
        self.myErrorView.block = ^(NSInteger tag){
            
            tempSelf.myErrorView.hidden = YES;
            tempSelf.myTableView.hidden = NO;
            [tempSelf errorData];
        };
    }
    
    return self;
}

-(void)errorData
{
    [self resetGetData];
}

-(void)resetGetData
{
   
    
}

-(void)initTableView:(CGRect)rect withSeparatoStyle:(UITableViewCellSeparatorStyle)style
{
    self.myTableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    [self.myTableView setBackgroundColor:[Unity getGrayBackColor]];
    [self.myTableView setBackgroundView:nil];
    self.myTableView.separatorStyle = style;
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self addSubview:self.myTableView];
    
    self.myTableView.tableFooterView = [[UIView alloc]init];
}

-(void)showPageError:(BOOL)show withIsError:(BOOL)error
{
    self.myErrorView.frame = self.myTableView.frame;
    self.myErrorView.hidden = !show;
    self.myTableView.hidden = show;
    self.myErrorView.isError = error;
    
    [self bringSubviewToFront:self.myErrorView];
    
    if (error) {
        self.myErrorView.myIcon = [UIImage imageNamed:@"loaderror_icon.png"];
    }else{
        self.myErrorView.myIcon = [UIImage imageNamed:@"loadzero_icon.png"];
    }
}

#pragma mark-
#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.myTableView.frame.size.width, 30)];
    
    return tempView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleDelete;
//}
//
///*改变删除按钮的title*/
//-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"删除";
//}
//
///*删除用到的函数*/
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete)
//    {
//        [self.myDataArray removeObjectAtIndex:[indexPath row]];  //删除数组里的数据
//        [self.myTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
//    }
//}

@end
