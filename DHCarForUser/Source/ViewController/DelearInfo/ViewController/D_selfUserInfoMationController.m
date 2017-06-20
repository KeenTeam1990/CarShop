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
#import "M_CarDistributorItemCell.h"
#import "D_ConfigHeadView.h"
#import "TTReqEngine.h"
#import "M_SalerInfoModel.h"

#define cellLableSize 14


@interface D_selfUserInfoMationController ()<UIAlertViewDelegate>

AS_MODEL_STRONG(D_ConfigHeadView, myHeaderView);

@end

@implementation D_selfUserInfoMationController

DEF_FACTORY(D_selfUserInfoMationController);

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self initData];
}
-(void)initView
{
    [self addCustomNavBar:@"销售顾问"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.bounds.size.width, self.baseView.bounds.size.height-NavigationBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleSingleLine];

    self.myHeaderView=[[D_ConfigHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    self.myTableView.tableHeaderView=self.myHeaderView;
}
-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initData
{
    [self getData];
}
-(void)upDateWithMessage:(M_MyMessageItemModel *)messageModel andWithDealerModel:(M_DealerItemModel *)dealerModel
{
    self.myDealerItemModel = dealerModel;
    self.salesInfoModel = messageModel;
    NSLog(@"%@",dealerModel.dealer_address);
    NSLog(@"%@",dealerModel.dealer_code);
    NSLog(@"%@",messageModel.myFromModel.user_id);
    [self.myTableView reloadData];
}
-(void)getData
{
    if (self.salesInfoModel!=nil) {
        if (self.salesInfoModel.myFromModel!=nil) {
            self.myHeaderView.model = self.salesInfoModel.myFromModel;
        }
    }
    
}


#pragma mark tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else
    {
        return 1;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==1 ) {
         return 50;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
   return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
       switch (indexPath.section) {
        case 0:
        {
            static NSString *identify=@"identify";
             DLTableViewCell *cell=[DLTableViewCell reusableCellOfTableView:tableView style:UITableViewCellStyleValue1 identifier:identify];
            
            cell.detailTextLabel.textColor=[Unity getColor:@"#666666"];
            cell.textLabel.textColor=[UIColor blackColor];
            cell.textLabel.font=[UIFont systemFontOfSize:cellLableSize];
            cell.detailTextLabel.font=[UIFont systemFontOfSize:cellLableSize];
            M_UserInfoModel *tempModel =[M_UserInfoModel allocInstance];
            if ([self.salesInfoModel.myFromModel.user_id isEqualToString:APPDELEGATE.viewController.myUserModel.user_id]) {
                tempModel = self.salesInfoModel.myToModel;
            }
            else
            {
                tempModel = self.salesInfoModel.myFromModel;
            }
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = @"职位";
                     NSLog(@"%@", tempModel.myTitle);
                    
                        if ([tempModel.myTitle notEmpty]) {
                            
                            cell.detailTextLabel.text = tempModel.myTitle;
                        }
                }
                    break;
//                case 1:
//                {
//                    cell.textLabel.text = @"星级";
//                    if (self.salesInfoModel!=nil && self.salesInfoModel.myFromModel!=nil) {
////                    if ([self.salesInfoModel.sales_star notEmpty]) {
////                        
////                        
////                    }
//                    }
//                }
//                    break;
                case 1:
                {
                    cell.textLabel.text = @"从业年限";
                    
                        if ([self.salesInfoModel.myFromModel.myStarted_at notEmpty]) {
                            NSDateFormatter *fromtter = [[NSDateFormatter alloc]init];
                            [fromtter setDateFormat:@"YYYY-MM-dd"];
                            NSTimeInterval time = [tempModel.myStarted_at doubleValue];
                            NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
                            NSTimeInterval time1  = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSinceDate:date];
                         
                    
                            NSLog(@"%@",[NSString stringWithFormat:@"%@年",tempModel.myStarted_at]);
                            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d年",(int)time1/(60*60*24*365)+1];
                        }

                }
                    break;
                case 2:
                {
                    cell.textLabel.text = @"签名";
//                    if (self.salesInfoModel!=nil && self.salesInfoModel.myFromModel!=nil) {
                        if ([self.salesInfoModel.myFromModel.myWord notEmpty]) {
                            cell.detailTextLabel.text = tempModel.myWord;
//                        }
                    }
                }
                    break;
                default:
                    break;
                    
            }
            return cell;
            
        }
               
            break;
        case 1:
        {
            //第二个cell的布局有重复的直接可以拖过来用
            M_CarDistributorItemCell *cell = [M_CarDistributorItemCell reusableCellOfTableView:tableView identifier:@"M_CarDistributorItemCell"];
            
            if (self.myDealerItemModel!=nil) {
                NSMutableArray *secondArr = [[NSMutableArray alloc]init];
                [secondArr addObject:self.myDealerItemModel];
//                繁盛的时候
                [cell configCellIndexPath:indexPath withDataArray:secondArr andwithType:EB_Not];
            }

            return cell;
            
        }
            break;
        default:
            break;
    }
    
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section ==1 ) {
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200,30)];
        NSMutableParagraphStyle *stytle = [[NSMutableParagraphStyle alloc]init];
        stytle.firstLineHeadIndent = 10;
        
        NSMutableAttributedString *attsteq = [[NSMutableAttributedString alloc] initWithString:@"所属商家"  attributes:@{NSParagraphStyleAttributeName:stytle}];
      
        titleLable.attributedText = attsteq;
        return titleLable;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 44;
    }
    else
    {
        return 120;//根据第二行的cell 计算出莱德高度
    }
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
