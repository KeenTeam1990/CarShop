//
//  SetUpViewController.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/10.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "SetUpViewController.h"
#import "M_SelfInfoMationModel.h"
#import "DLTableViewCell.h"
#import "CB_Button.h"
#import "D_WebViewController.h"
#import "LL_FeedBackViewController.h"
#import "JPUSHService.h"
#define headViewLableSize 12
#define cellLableSize  14

@interface SetUpViewController ()<UIAlertViewDelegate>
@property(nonatomic, strong) UILabel *pushStatusLabel;//push的状态
@property(nonatomic ,strong) UIButton *cleanBtn;
@property(nonatomic, strong) UILabel *tempLabel;
@end

@implementation SetUpViewController
@synthesize pushStatusLabel,cleanBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    
}
-(void)initView
{
    [self addCustomNavBar:@"设置" withLeftBtn:@"icon_back.png" withRightBtn:nil withLeftLabel:@"返回" withRightLabel:nil];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleSingleLine];
    
    
}
-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else
    {
        return 3;
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 120;
    }
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==1) {
        
        UIView *footView = [[UIView alloc]init];
        
        footView.frame = CGRectMake(0, 0, ScreenWidth, 100);
        
        self.cleanBtn = [footView viewWithTag:1001];
        if (self.cleanBtn == nil) {
            
            self.cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.cleanBtn.frame = CGRectMake(20, 44, ScreenWidth-40,40);
            [self.cleanBtn.layer setBorderWidth:1];
            self.cleanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [self.cleanBtn.layer setCornerRadius:5];
            [self.cleanBtn setTitle:@"退出登录" forState:UIControlStateNormal];
            [self.cleanBtn setTitleColor:RGBCOLOR(252, 41, 42) forState:UIControlStateNormal];
            [self.cleanBtn.layer setBorderColor:RGBCOLOR(252,41, 42).CGColor];
            self.cleanBtn.tag = 1001;
            [self.cleanBtn addTarget:self action:@selector(outForLogin:) forControlEvents:UIControlEventTouchUpInside];
            
            [footView addSubview:self.cleanBtn];
        }
        
        self.cleanBtn.hidden = YES;
        if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
            self.cleanBtn.hidden = NO;
        }
        
        return footView;
        
    }
    return nil;

}
-(void)cleanMenmery
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"" message:@"是否清除缓存的内容?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alter.tag = 2002;
    [alter show];
}


//退出登录
-(void)outForLogin:(UIButton *)sender
{
    [MobClick event:@"mine_loginout"];
    
    [APPDELEGATE.viewController logout:self];
    
    [self.myTableView reloadData];
    APPDELEGATE.viewController.updateSpike = YES;
    [JPUSHService setTags:[NSSet set] alias:@"nil" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        //NSLog(@"iResCode =%@, iTags=%@,iAlias =%@",iResCode,iTags,iAlias);
    }];
    [JPUSHService setTags:[NSSet set] aliasInbackground:@"nil"];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"identify";

    DLTableViewCell *cell=[DLTableViewCell reusableCellOfTableView:tableView style:UITableViewCellStyleValue1 identifier:identify];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
   
    // cell.userInteractionEnabled = NO;
    
    if (indexPath.section==0) {
        
        if (indexPath.row ==0) {
            cell.textLabel.text=@"接收新消息通知";

            if (!self.pushStatusLabel) {
                UILabel *tempLabel = [[UILabel alloc]init];
                tempLabel.frame = CGRectMake(SCREEN_WIDTH-130, 0, 50, 44);
                tempLabel.textAlignment = UITextAlignmentRight;
                tempLabel.font = [UIFont systemFontOfSize:14];
                tempLabel.textColor = [UIColor lightGrayColor];
                [cell.contentView addSubview:tempLabel];
                self.pushStatusLabel = tempLabel;
            }
            
            UISwitch *switchView=[[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
//             [[UIApplication sharedApplication] unregisterForRemoteNotifications];
            if([[UIApplication sharedApplication] isRegisteredForRemoteNotifications] == YES)
            {
                switchView.on=YES;
                self.pushStatusLabel.text = @"已开启";
            }
            else
            {
                switchView.on=NO;
                self.pushStatusLabel.text = @"已关闭";
            }
            switchView.tag=1000+indexPath.row;
            [switchView addTarget:self action:@selector(swichValueChange:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView=switchView;
        }
            else
        {
            cell.textLabel.text=@"清理缓存";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UILabel* tempDe = [cell.contentView viewWithTag:1002];
            if (tempDe==nil) {
                tempDe = [[UILabel alloc]initWithFrame:CGRectMake(self.baseView.frame.size.width-100, 0, 90, 44)];
                tempDe.tag = 1002;
                tempDe.textColor =[UIColor redColor];
                tempDe.font = SYSTEMFONT(14);
                [cell.contentView addSubview:tempDe];
            }

            NSString *appIdentifier = [[NSBundle mainBundle] bundleIdentifier];
            NSString  *libraryFile = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
            NSString *cacheFilePath = [libraryFile stringByAppendingFormat:@"/Caches/%@/fsCachedData",appIdentifier];
            CGFloat temd = [self folderSizeAtPath:cacheFilePath];
            tempDe.text = [NSString stringWithFormat:@"%.02fMB",temd];
            
            //[cell.contentView addSubview:arrowImageView];

        }
    }
    else if (indexPath.section == 1)
    {

        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        switch (indexPath.row) {
            case 0:
               
            {
                cell.textLabel.text=@"问题反馈";
            }
                

                break;
            case 1:
                
            {
                cell.textLabel.text=@"帮助中心";
            }
                
                
                break;
            case 2:
                
            {
                cell.textLabel.text=@"关于我们";
            }
                
                
                break;
                
            default:
                break;
        }
    }
    cell.tintColor=[Unity getColor:@"#000000"];
    cell.textLabel.font=[UIFont systemFontOfSize:cellLableSize];
        return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.rac_deallocDisposable) {
            if (indexPath.row == 1) {
                [self cleanMenmery];
            }
            
        }
        
    }
    else
    {
        switch (indexPath.row) {
            case 0:
                
            {
                //@"问题反馈";
                //问题反馈
//                FeedbackViewController *feedbackViewController = [[FeedbackViewController alloc]init];
//                
//                [self.navigationController pushViewController:feedbackViewController animated:YES];
                
                [MobClick event:@"mine_suggest"];
                LL_FeedBackViewController *tempView = [[LL_FeedBackViewController alloc]init];
                [self.navigationController pushViewController:tempView animated:YES];

            }
                
                
                break;
            case 1:
                
            {
                //帮助中心
                [MobClick event:@"mine_help"];
                D_WebViewController *helpCenterViewController = [[D_WebViewController alloc]init];
                helpCenterViewController.myTitle = @"帮助中心";
                helpCenterViewController.myUrl = [NSString stringWithFormat:@"%@/help",KH5Host];
                [self.navigationController pushViewController:helpCenterViewController animated:YES];

                //@"帮助中心";
            }
                
                
                break;
            case 2:
                
            {
                //@"关于";
                //关于
                
                D_WebViewController *helpCenterViewController = [[D_WebViewController alloc]init];
                helpCenterViewController.myTitle = @"关于我们";
                helpCenterViewController.myUrl = [NSString stringWithFormat:@"%@/about?version=%@",KH5Host,[DLSystemInfo appVersion]];
                [self.navigationController pushViewController:helpCenterViewController animated:YES];
            }
                
                
                break;
                
            default:
                break;
        }

    }
}

//单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSLog(@"path = %@",folderPath);
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

-(void)swichValueChange:(UISwitch *)swich
{
    self.pushStatusLabel.text = @"";
    if (swich.isOn) {
        NSLog(@"允许推送");
        self.pushStatusLabel.text = @"已开启";
        NSLog(@"这个是的发生的 = %@",[DLAppData sharedInstance].myUserKey);
        [[UIApplication sharedApplication] registerForRemoteNotifications];

        
    }
    else
        
    {

        [[UIApplication sharedApplication] unregisterForRemoteNotifications];

        NSLog(@"不允许推送");
        self.pushStatusLabel.text = @"已关闭";
    }
  
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
    [self.myTableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2002) {
        if (buttonIndex == 1) {
            NSString *appIdentifier = [[NSBundle mainBundle] bundleIdentifier];
            NSString  *libraryFile = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
            NSString *cacheFilePath = [libraryFile stringByAppendingFormat:@"/Caches/%@/fsCachedData",appIdentifier];
            [DLCache removeItem:cacheFilePath];
            
            [SVProgressHUD showSuccessWithStatus:@"清理缓存成功"];
            
            [self.myTableView reloadData];
        }
    }
}

@end
