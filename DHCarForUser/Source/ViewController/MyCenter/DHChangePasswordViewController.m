//
//  DHChangePasswordViewController.m
//  DHCarForUser
//
//  Created by 张海亮 on 16/3/23.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DHChangePasswordViewController.h"
#import "TTReqEngine.h"
#import "Dh_ChangePasswordModel.h"

@interface DHChangePasswordViewController ()<UITextFieldDelegate>
AS_MODEL_STRONG(UIButton, mySendBtn);
@end

@implementation DHChangePasswordViewController

DEF_MODEL(mySendBtn);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    
    [self addTapToBaseView];
    
    [self addKeywordNotify];
}

-(void)initView
{
    switch ([APPDELEGATE.viewController.myUserModel.myHas_Set_Password integerValue]) {
        case 0:
        {
            [self addCustomNavBar:@"设置密码"
                      withLeftBtn:@"icon_back.png"
                     withRightBtn:nil
                    withLeftLabel:@"返回"
                   withRightLabel:nil];
        }
            break;
        case 1:
        {
            [self addCustomNavBar:@"修改密码"
                      withLeftBtn:@"icon_back.png"
                     withRightBtn:nil
                    withLeftLabel:@"返回"
                   withRightLabel:nil];
        }
            break;
        default:
            break;
    }
    self.baseView.backgroundColor = [UIColor colorWithRed:0.93725 green:0.93725 blue:0.93725 alpha:1.0];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight+10, self.baseView.bounds.size.width, self.baseView.bounds.size.height-30) withSeparatoStyle:UITableViewCellSeparatorStyleSingleLine];
    self.myTableView.rowHeight = 50;
    self.myTableView.scrollEnabled = NO;
    self.myTableView.backgroundColor = [UIColor colorWithRed:0.93725 green:0.93725 blue:0.93725 alpha:1.0];
    
    
    self.mySendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mySendBtn.style = DLButtonStyleMake(style.backgroundColor =[UIColor redColor];
                                             style.cornerRedius = 6;);
    [self.mySendBtn addTarget:self action:@selector(sendBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.mySendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.mySendBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.mySendBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    self.mySendBtn.frame = CGRectMake(10, NavigationBarHeight + 210, ScreenWidth-20, 45);
    //self.mySendBtn.layer.cornerRadius = 6.0;
    [self.baseView addSubview:self.mySendBtn];
    
}

-(void)sendBtnPressed:(UIButton *)sender
{
    UITableViewCell* tempcell0 = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField *cellTextField0 = (UITextField *)[tempcell0 viewWithTag:101];
    UITableViewCell* tempcell1 = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UITextField *cellTextField1 = (UITextField *)[tempcell1 viewWithTag:101];

    
    switch ([APPDELEGATE.viewController.myUserModel.myHas_Set_Password integerValue]) {
        case 0:
        {
            
            if ([cellTextField0.text empty]) {
                [SVProgressHUD showErrorWithStatus:@"请输入密码"];
                return;
            }
            if ([cellTextField1.text empty]) {
                [SVProgressHUD showErrorWithStatus:@"请重新输入新密码"];
                return;
            }
            if (![cellTextField0.text isEqualToString:cellTextField1.text]) {
                [SVProgressHUD showErrorWithStatus:@"新密码与确认密码一致"];
                return;
            }
            
            [TTReqEngine C_PostUser_SetPassword:cellTextField0.text andWith:APPDELEGATE.viewController.myUserModel.user_id withBlock:^(BOOL success, id dataModel) {
                M_UserInfoModel* tempModel = (M_UserInfoModel*)dataModel;
                if (success) {
                    if (tempModel!=nil) {
                        
                        APPDELEGATE.viewController.myUserModel.myHas_Set_Password = @"1";
                        
                        [self dismissViewControllerAnimated:NO completion:nil];
                        [SVProgressHUD showSuccessWithStatus:@"设置密码成功!"];
                        [self.mydelegate successGoBackAndRefreshViewController];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }
            }];
            
        }
            break;
        case 1:
        {
            if ([cellTextField0.text empty]) {
                [SVProgressHUD showErrorWithStatus:@"请输入原密码"];
                return;
            }
            if ([cellTextField1.text empty]) {
                [SVProgressHUD showErrorWithStatus:@"请输入新密码"];
                return;
            }
            UITableViewCell* tempcell2 = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            UITextField *cellTextField2 = (UITextField *)[tempcell2 viewWithTag:101];
            if (![cellTextField2.text isEqualToString:cellTextField1.text]) {
                [SVProgressHUD showErrorWithStatus:@"新密码和确认密码不一致!"];
                return;
            }
            [TTReqEngine C_PostUser_ModifyPassword:APPDELEGATE.viewController.myUserModel.user_id andWithOldPassword:cellTextField0.text  andWithNewPassword:cellTextField1.text  andWithBlock:^(BOOL success, id dataModel) {
                M_UserInfoModel* tempModel = (M_UserInfoModel*)dataModel;
                if (success) {
                    if (tempModel!=nil) {
                        
//                        APPDELEGATE.viewController.myUserModel = tempModel;
//                        
//                        [DLAppData sharedInstance].myUserName = cellTextField0.text;
//                        [[DLUserDefaults sharedInstance] setObject:cellTextField0.text forKey:@"username"];
                        
                        [self dismissViewControllerAnimated:NO completion:nil];
                        [SVProgressHUD showSuccessWithStatus:@"修改密码成功!"];
                        
                        [self.mydelegate successGoBackAndRefreshViewController];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }
            }];
        }
            break;
        default:
            break;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    switch ([APPDELEGATE.viewController.myUserModel.myHas_Set_Password integerValue]) {}
    switch ([APPDELEGATE.viewController.myUserModel.myHas_Set_Password integerValue]) {
        case 0:
        {
            return 2;
        }
            break;
        case 1:
        {
            return 3;
        }
            break;
        default:
            break;
    }
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"identify";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        UITextField *contentText = [[UITextField alloc] initWithFrame:CGRectMake(90, 10, ScreenWidth - 100, 30)];
        contentText.font = [UIFont systemFontOfSize:15];
        contentText.delegate = self;
        contentText.tag = 101;
        contentText.secureTextEntry = YES;
        [cell addSubview:contentText];
    }
    
    UITextField *cellTextField = (UITextField *)[cell viewWithTag:101];
    switch ([APPDELEGATE.viewController.myUserModel.myHas_Set_Password integerValue]) {
        case 0:
        {
            if (indexPath.row == 0) {
                cellTextField.placeholder = @"请输入新密码";
                cell.textLabel.text = @"新密码";
            } else  if (indexPath.row == 1) {
                cellTextField.placeholder = @"请再次输入新密码";
                cell.textLabel.text = @"确认密码";
            }
            
        }
            break;
        case 1:
        {
            if (indexPath.row == 0) {
                cellTextField.placeholder = @"请输入旧密码";
                cell.textLabel.text = @"旧密码";
            } else  if (indexPath.row == 1) {
                cellTextField.placeholder = @"请输入新密码";
                cell.textLabel.text = @"新密码";
            }
            else{
                cellTextField.placeholder = @"请再次输入新密码";
                cell.textLabel.text = @"确认密码";
            }
        }
            
        default:
            break;
    }
    
    return cell;
}

-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}




@end
