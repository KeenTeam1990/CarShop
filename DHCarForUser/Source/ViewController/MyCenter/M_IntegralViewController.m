//
//  M_IntegralViewController.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_IntegralViewController.h"
#import "M_IntegralCell.h"
#import "M_IntegralModel.h"
#import "TTReqEngine.h"
@interface M_IntegralViewController ()

@end

@implementation M_IntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addCustomNavBar:@"积分纪录"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    self.view.backgroundColor = [Unity getColor:@"#eeeeee"];
    
    [self initData];
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.bounds.size.width, self.baseView.bounds.size.height-TabBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleNone];


    // Do any additional setup after loading the view.
}

-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initData
{
    
     self.dataArray = [NSMutableArray array];
    
//    [TTReqEngine PostGold_List:@"0" withPageNum:@"10" withBlock:^(BOOL success, id dataModel) {
//        if (success) {
//            M_IntegralModel *integralModel  = (M_IntegralModel *)dataModel;
//            self.dataArray = integralModel.itemArray;
//
//        }
//    }];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    M_IntegralCell *cell=[M_IntegralCell reusableCellOfTableView:tableView style:UITableViewCellStyleValue1 ];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configCellIndexPath:indexPath withDataArray:self.dataArray];
    return cell;
}

#pragma mark - UITableViewDataSource
//1.tableview共有多少组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"numberofsectionintableview");
    return 1;
}
//2.section有几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
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
