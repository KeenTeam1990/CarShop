//
//  DLTableViewController.m
//  Auction
//
//  Created by 卢迎志 on 14-12-16.
//
//

#import "DLTableViewController.h"
#import "DLPageErrorView.h"

@interface DLTableViewController ()

AS_MODEL_STRONG(DLPageErrorView, myErrorView);

@end

@implementation DLTableViewController

DEF_MODEL(myTableView);
DEF_MODEL(myDataArray);

-(id)init
{
    self = [super init];
    
    if (self) {
        
        self.myDataArray = [NSMutableArray allocInstance];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.myErrorView = [DLPageErrorView allocInstanceFrame:CGRectZero];
    self.myErrorView.hidden = YES;
    [self.baseView addSubview:self.myErrorView];
    
    __weak DLTableViewController *tempSelf = self;
    self.myErrorView.block = ^(NSInteger tag){
        
        tempSelf.myErrorView.hidden = YES;
        tempSelf.myTableView.hidden = NO;
        [tempSelf errorData];
    };
}

-(void)errorData
{
    [self resetGetData];
}

-(void)resetGetData
{
    
}

-(void)initTablePlainView:(CGRect)rect withSeparatoStyle:(UITableViewCellSeparatorStyle)style
{
    self.myTableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    [self.myTableView setBackgroundColor:[Unity getGrayBackColor]];
    [self.myTableView setBackgroundView:nil];
    self.myTableView.separatorStyle = style;
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.baseView addSubview:self.myTableView];
    
    self.myTableView.tableFooterView= [[UIView alloc]init];
}

-(void)initTableGroupView:(CGRect)rect withSeparatoStyle:(UITableViewCellSeparatorStyle)style
{
    self.myTableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    [self.myTableView setBackgroundColor:[Unity getGrayBackColor]];
    [self.myTableView setBackgroundView:nil];
    self.myTableView.separatorStyle = style;
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.baseView addSubview:self.myTableView];
}

-(void)showPageError:(BOOL)show withIsError:(BOOL)error
{
    self.myErrorView.frame = self.myTableView.frame;
    self.myErrorView.isError = error;
    self.myErrorView.hidden = !show;
    self.myTableView.hidden = show;
    
    [self.baseView bringSubviewToFront:self.myErrorView];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
