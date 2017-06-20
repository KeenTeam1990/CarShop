//
//  C_CashbackViewController.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/12/26.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "C_CashbackViewController.h"

@interface C_CashbackViewController ()

@end

@implementation C_CashbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavBar:@"邀请返现"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    self.view.backgroundColor = [Unity getColor:@"#eeeeee"];
    
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


#pragma mark - UITableViewDataSource
//1.tableview共有多少组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"numberofsectionintableview");
    return 2;
}
//2.section有几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 220;
    }else
    {
        return 44;
    }
    
}
//3.告知每行显示什么
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    DLTableViewCell *cell =[DLTableViewCell reusableCellOfTableView:tableView style:UITableViewCellStyleValue1 ];
    
    if (indexPath.section == 0) {
        
        //钻石
        UIImage *handImage = [UIImage imageNamed:@"img_cash"];
        UIImageView *handImageView = [[UIImageView alloc]initWithFrame:CGRectMake((tableView.frame.size.width-handImage.size.width)/2, 50, handImage.size.width, handImage.size.height)];
        handImageView.image = handImage;
        [cell.contentView addSubview:handImageView];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.frame = CGRectMake((tableView.frame.size.width-190)/2, handImageView.frame.origin.y+handImageView.frame.size.height+10, 190, 20);
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.text = @"您现在的账户返现金是";
        titleLabel.textColor = GrayText;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:titleLabel];
        
        NSString *str =APPDELEGATE.viewController.myUserModel.user_balance;
        if (str == nil) {
            str =@"0";
        }
        UILabel *titleLabel1 = [[UILabel alloc]init];
        titleLabel1.frame = CGRectMake((tableView.frame.size.width-100)/2, handImageView.frame.origin.y+handImageView.frame.size.height+40, 100, 20);
        titleLabel1.text = [NSString stringWithFormat:@"%@元",str];
        titleLabel1.textColor = RedText;
        titleLabel1.font = [UIFont boldSystemFontOfSize:20];
        titleLabel1.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:titleLabel1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
    }else
    {
        //电话icon
        UIImage *phoneImage = [UIImage imageNamed:@"call.png"];
        UIImageView *phoneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (44-phoneImage.size.height)/2, phoneImage.size.width, phoneImage.size.height)];
        phoneImageView.image = phoneImage;
        [cell.contentView addSubview:phoneImageView];
        
        
        UILabel *titleLabel1 = [[UILabel alloc]init];
        titleLabel1.frame = CGRectMake(phoneImageView.frame.size.width+20, 12, 190, 20);
        titleLabel1.text = [NSString stringWithFormat:@"联系客服025-96596返现"];
        titleLabel1.textColor = GrayText;
        titleLabel1.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:titleLabel1];
        
        cell.selectionStyle = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1)
    {
        
        //打电话
        [Unity openCallPhone:@"025-96596"];
    }
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
