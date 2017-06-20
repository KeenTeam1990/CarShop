//
//  TestDriveViewController.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/10.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "TestDriveViewController.h"
#import "M_TestDriverModel.h"
#import "TestDriveCell.h"
#import "TTReqEngine.h"
@interface TestDriveViewController ()

@end

@implementation TestDriveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavBar:@"我的试驾"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    self.view.backgroundColor = [Unity getColor:@"#eeeeee"];
    
    
    [self initData];
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.bounds.size.width, self.baseView.bounds.size.height-TabBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
}

-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initData
{
    [TTReqEngine C_GetTrydriving_ListSetUid:[DLAppData sharedInstance].myUserKey
                                  withBlock:^(BOOL success, id dataModel) {
        if (success) {
            if (dataModel) {
                M_TestDriverModel *testDriverModel = (M_TestDriverModel *)dataModel;
                self.dataArray = testDriverModel.myItemArray ;
                if([self.dataArray count]==0)
                {
                    [self showPageError:YES withIsError:NO];
                }
                else{
                    [self.myTableView reloadData];
                }
                
            }
        }
    else{
        [self showPageError:YES withIsError:YES];
    }
    }];
}
-(void)resetGetData
{
    [self.myDataArray removeAllObjects];
    [self initData];
}
#pragma mark - UITableViewDataSource
//1.tableview共有多少组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//2.section有几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 235;
}
//3.告知每行显示什么
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestDriveCell *cell =[TestDriveCell reusableCellOfTableView:tableView style:UITableViewCellStyleValue1 ];
    [cell configCellIndexPath:indexPath withDataArray:self.dataArray];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
     __weak TestDriveViewController *tempVC = self;
    cell.block = ^(NSInteger tag,id data){
        M_TestDriverItemModel *tempModel = data;
       
        [TTReqEngine C_PostTrydriving_DelSetID:tempModel.test_drive_id
                                     withBlock:^(BOOL success, id dataModel)
        {
            
            if (success)
            {
                [tempVC initData];
            }

        }];
    };
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
