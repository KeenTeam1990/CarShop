//
//  D_selfUserInfoMationController.m
//  DHCarForSales
//
//  Created by leiyu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_selfUserInfoMationController.h"
#import "M_SelfInfoMationModel.h"
#import "DLTableViewCell.h"
//#import "D_ModifyNameInfomationController.h"
#import "D_ConfigHeadView.h"
#import "TTReqEngine.h"
#import "M_SalerInfoModel.h"
#define cellLableSize 14


@interface D_selfUserInfoMationController ()<UIAlertViewDelegate>

@property(nonatomic,strong)UIAlertView *alterView;
@end

@implementation D_selfUserInfoMationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self initData];
}
-(void)initView
{
    [self addCustomNavBar:@"个人资料"
              withLeftBtn:@""
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.bounds.size.width, self.baseView.bounds.size.height-NavigationBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleNone];

}
-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatHeadView
{
    D_ConfigHeadView *headView=[[D_ConfigHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    M_UserInfoModel *tempUserModel=[M_UserInfoModel allocInstance];

    tempUserModel.user_photo=self.salesInfoModel.user_photo;
    tempUserModel.user_sex=self.salesInfoModel.user_sex;
    tempUserModel.user_name=self.salesInfoModel.user_name;
    headView.model=tempUserModel;
    self.myTableView.tableHeaderView=headView;
}
-(void)initData
{

    [self creatHeadView];
    
    [self getData];
}

-(void)getData
{
    [TTReqEngine PostSales_Info:self.salesInfoModel.user_id withBlock:^(BOOL success, id dataModel) {
        
        if (success) {
            
            M_SalerInfoModel *tempModel = (M_SalerInfoModel *)dataModel;
            
        }
    }];
}


#pragma mark tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }else
    {
        return 1;
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
   return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"identify";
    DLTableViewCell *cell=[DLTableViewCell reusableCellOfTableView:tableView style:UITableViewCellStyleValue1 identifier:identify];
    
    cell.detailTextLabel.textColor=[Unity getColor:@"#666666"];
    cell.textLabel.textColor=[UIColor blackColor];
    cell.textLabel.font=[UIFont systemFontOfSize:cellLableSize];
    cell.detailTextLabel.font=[UIFont systemFontOfSize:cellLableSize];
       switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = @"职位";
                    if ([self.salesInfoModel.sales_role notEmpty]) {
                        cell.detailTextLabel.text = self.salesInfoModel.sales_role;
                    }
                    
                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"星级";
                    if ([self.salesInfoModel.sales_star notEmpty]) {
                        
                        
                    }
                }
                    break;
                case 2:
                {
                    cell.textLabel.text = @"从业年限";
                    if ([self.salesInfoModel.sales_work_year notEmpty]) {
                        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@年",self.salesInfoModel.sales_work_year];
                    }
                }
                    break;
                case 3:
                {
                    cell.textLabel.text = @"签名";
                    if ([self.salesInfoModel.sales_sig notEmpty]) {
                        cell.detailTextLabel.text = self.salesInfoModel.sales_sig;
                    }
                }
                    break;
                default:
                    break;
            }

            
        }
            break;
        case 1:
        {
            //第二个cell的布局有重复的直接可以拖过来用
        }
            break;
        default:
            break;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 44;
    }
    else
    {
        return 150;//根据第二行的cell 计算出莱德高度
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
