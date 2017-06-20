//
//  DLSetPasswordViewController.m
//  DHCarForUser
//
//  Created by 张海亮 on 16/3/23.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DLSetPasswordViewController.h"
#import "TTReqEngine.h"

@interface DLSetPasswordViewController ()<UITextFieldDelegate>
AS_MODEL_STRONG(UIButton, mySendBtn);
@end

@implementation DLSetPasswordViewController

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
    [self addCustomNavBar:@"设置密码"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    self.baseView.backgroundColor = [UIColor colorWithRed:0.93725 green:0.93725 blue:0.93725 alpha:1.0];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight+30, self.baseView.bounds.size.width, self.baseView.bounds.size.height-30) withSeparatoStyle:UITableViewCellSeparatorStyleSingleLine];
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
    self.mySendBtn.frame = CGRectMake(10, NavigationBarHeight + 160, ScreenWidth-20, 45);
    //self.mySendBtn.layer.cornerRadius = 6.0;
    [self.baseView addSubview:self.mySendBtn];
    
}

-(void)sendBtnPressed:(UIButton *)sender
{
    NSString* tempPassword0 = nil;
    NSString* tempPassword1 = nil;
    UITableViewCell* tempcell0 = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (tempcell0!=nil) {
        UITextField *cellTextField = (UITextField *)[tempcell0 viewWithTag:101];
        if (cellTextField!=nil) {
            tempPassword0 = cellTextField.text;
        }
    }
    
    UITableViewCell* tempcell1 = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (tempcell1!=nil) {
        UITextField *cellTextField = (UITextField *)[tempcell1 viewWithTag:101];
        if (cellTextField!=nil) {
            tempPassword1 = cellTextField.text;
        }
    }
    
    if ([tempPassword0 empty]) {
        [SVProgressHUD showErrorWithStatus:@"请输入11位的手机号码"];
        return;
    }
    /*
     还应该加入密码格式判断
     
     
     */
    if (![tempPassword0 isEqualToString:tempPassword1]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入密码不一致"];
        return;
    }
    
    [TTReqEngine C_PostUser_SetPassword:tempPassword0 andWith:APPDELEGATE.viewController.myUserModel.user_id withBlock:^(BOOL success, id dataModel) {
        M_UserInfoModel* tempModel = (M_UserInfoModel*)dataModel;
        if (success) {
            if (tempModel!=nil) {
                APPDELEGATE.viewController.myUserModel.myHas_Set_Password = @"1";
                [self dismissViewControllerAnimated:NO completion:nil];
                [SVProgressHUD showSuccessWithStatus:@"设置密码成功!"];
            }
        }

    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
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
        [cell addSubview:contentText];
    }
    
    UITextField *cellTextField = (UITextField *)[cell viewWithTag:101];
    cellTextField.secureTextEntry = YES;

    if (indexPath.row == 0) {
        cellTextField.placeholder = @"请输入新密码";
        cell.textLabel.text = @"密    码";
    } else {
        cellTextField.placeholder = @"请确认新密码";
        cell.textLabel.text = @"确认密码";
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
