//
//  NameViewController.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "NameViewController.h"
#import "M_NameView.h"
#import "TTReqEngine.h"
@interface NameViewController ()

@property(nonatomic,strong) UITextField *nameTF;
@end

@implementation NameViewController
@synthesize model,delegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
        // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
}
-(void)initView
{
    [self addCustomNavBar:@"修改姓名"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    self.view.backgroundColor = [Unity getColor:@"#eeeeee"];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, NavigationBarHeight+30, self.baseView.frame.size.width, 44)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    self.nameTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 6, ScreenWidth-40, 30)];
    //self.nameTF.placeholder = self.model.user_nick;
    self.nameTF.text = self.model.user_nick;
    self.nameTF.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    self.nameTF.delegate = self;
    [bgView addSubview:self.nameTF];
    
    UIButton *temprightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [temprightBtn setFrame:CGRectMake(ScreenWidth-80, 0, 70, 44)];
    [temprightBtn setBackgroundColor:[UIColor clearColor]];
    [temprightBtn setTitle:@"保存" forState:UIControlStateNormal];
    temprightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [temprightBtn addTarget:self action:@selector(PersonalInfo:) forControlEvents:UIControlEventTouchUpInside];
    [temprightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.customNavBar addSubview:temprightBtn];
    
    
    [self.customNavBar updateRightBtn:nil withImage:nil];

}

-(void)PersonalInfo:(UIButton *)sender
{
    
}

-(void)initData
{
    
}
-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnPressed:(id)sender
{
    if (self.nameTF.text.length <2 ||self.nameTF.text.length >10) {
        
        UIAlertView * alertview = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入2-10位的姓名" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertview show];
        return;
        
    }
    if(![Unity isKindOfStr:self.nameTF.text])
    {
        UIAlertView * alertview = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入中文，数字和字母组合，且长度不超过10" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertview show];
        return;
    }
   __weak NameViewController *tempVC = self;
    
    [TTReqEngine C_PostUser_UpdateSetUid:[DLAppData sharedInstance].myUserKey
                                 withSex:nil
                                withNick:self.nameTF.text
                               withEmail:nil
                            withBirthday:nil
                              withAvatar:nil
                             withCity_id:APPDELEGATE.viewController.myUserModel.city_id
                                  withQQ:nil
                               withBlock:^(BOOL success, id dataModel)
     {
        
         if (success)
        {
            APPDELEGATE.viewController.myUserModel.user_nick = self.nameTF.text;
            
            if (self.delegate !=nil && [self.delegate respondsToSelector:@selector(UpdataNameSetName:)]){
                [self.delegate UpdataNameSetName:self.nameTF.text];
            }
            [tempVC.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    
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
