//
//  MyCenterViewController.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/10/30.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "MyCenterViewController.h"
#import "MyOrderViewController.h"
#import "PersonalInfoViewController.h"
#import "MyCollectViewController.h"
#import "QueryModelsViewController.h"
#import "TestDriveViewController.h"
#import "SetUpViewController.h"
#import "D_selfUserInfoMationController.h"
#import "TTReqEngine.h"
#import "M_MyOrderModel.h"
#import "D_WebViewController.h"
#import "M_IntegralViewController.h"
#import "C_CashbackViewController.h"
#import "D_MessageViewController.h"
#import "M_IconView.h"
#import "LL_FeedBackViewController.h"
#import "M_SpikeListModel.h"
#import "M_SpikeRushModel.h"

#import "LL_MyCenterHeadView.h"

#define KMyCellIdentify @"LL_MyCenterCollectionCell"
#define KMyHeadViewIdentify @"LL_MyCollectionHeadView"

#import "LL_MyCenterCollectionCell.h"
@interface MyCenterViewController ()<MyDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

AS_MODEL_STRONG(UIButton, myLogoutBtn);

//是否签到
AS_MODEL_ASSIGN(BOOL, isPunch);
AS_MODEL_STRONG(UILabel, integralLabel);
AS_MODEL_STRONG(UIButton, myRighddtBtn);

AS_MODEL_STRONG(UICollectionView, myCollectionView);

@end

@implementation MyCenterViewController
DEF_FACTORY(MyCenterViewController)
DEF_MODEL(dataArray);
DEF_MODEL(countOrderStr);
DEF_MODEL(myLogoutBtn);
DEF_MODEL(isPunch);
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    self.isPunch = NO;
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:YES];
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initView
{
    [self addCustomNavBar:@"个人中心"
              withLeftBtn:@""
             withRightBtn:nil
            withLeftLabel:nil
           withRightLabel:nil];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.bounds.size.width, self.baseView.bounds.size.height-NavigationBarHeight-TabBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleSingleLine];
    
    [self initCollectionView];
    self.myTableView.tableHeaderView = self.myCollectionView;
    
    UIButton *temprightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.myRighddtBtn = temprightBtn;
    [temprightBtn setFrame:CGRectMake(ScreenWidth-80, 0, 70, 44)];
    [temprightBtn setBackgroundColor:[UIColor clearColor]];
    [temprightBtn setTitle:@"请登录" forState:UIControlStateNormal];
    temprightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [temprightBtn addTarget:self action:@selector(logonBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [temprightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.customNavBar addSubview:temprightBtn];
}
-(void)initCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing=1;
    
    self.myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight-20) collectionViewLayout:flowLayout];
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
//    [self.baseView addSubview:self.myCollectionView];
    [self.myCollectionView setBackgroundColor:[UIColor clearColor]];
    
    [self.myCollectionView registerClass:NSClassFromString(@"LL_MyCenterCollectionCell") forCellWithReuseIdentifier:KMyCellIdentify];
    [self.myCollectionView registerClass:NSClassFromString(@"LL_MyCenterHeadView") forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KMyHeadViewIdentify];
}
-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LL_MyCenterCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KMyCellIdentify forIndexPath:indexPath];

    switch (indexPath.row) {
        case 0:
        {
            NSLog(@"user_id = %@",APPDELEGATE.viewController.myUserModel.user_id);
            if(APPDELEGATE.viewController.myUserModel == nil || APPDELEGATE.viewController.myUserModel.user_id ==nil || [APPDELEGATE.viewController.myUserModel.user_id isEqualToString:@""] )
            {
                  [cell updateMyCell:@"每日签到" andWithImageName:@"myCenter_signIn"];
            }
            else{
                NSLog(@"userId = %@",APPDELEGATE.viewController.myUserModel.user_id);
                if ([APPDELEGATE.viewController.myUserModel.user_has_sign isEqualToString:@"0"])
                {
                    self.isPunch = NO;
                }else
                {
                    self.isPunch = YES;
                }
                if (self.isPunch ==NO) {
                    [cell updateMyCell:@"每日签到" andWithImageName:@"myCenter_signIn"];
                }
                else{
                    [cell updateMyCell:@"已签到" andWithImageName:@"myCenter_signIn"];
                }

            }
            
        }
            break;
          
        case 1:
        {
            [cell updateMyCell:@"我的消息" andWithImageName:@"myCenter_myMessage"];
        }
            break;
        case 2:
        {
            [cell updateMyCell:@"我的收藏" andWithImageName:@"myCenter_myFavorite"];
        }
            break;
        case 3:
        {
            [cell updateMyCell:@"我的订单" andWithImageName:@"myCenter_myOrder"];
        }
            break;
        case 4:
        {
            [cell updateMyCell:@"询价车型" andWithImageName:@"myCenter_myEnquiry"];
        }
            break;
            
        case 5:
        {
            [cell updateMyCell:@"我的积分" andWithImageName:@"myCenter_myIntegral"];
        }
            break;
        case 6:
        {
            [cell updateMyCell:@"浏览车型" andWithImageName:@"myCenter_glanceCar"];
        }
            break;
        case 7:
        {
            [cell updateMyCell:@"我的试驾" andWithImageName:@"myCenter_applyForDriveCar"];
        }
            break;
//        case 8:
//        {
//            [cell updateMyCell:@"邀请返现" andWithImageName:@"myCenter_inVitationBack"];
//        }
//            break;
        case 8:
        {
            [cell updateMyCell:@"设置" andWithImageName:@"myCenter_Config"];
        }
            break;
            
        default:
            break;
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    LL_MyCenterCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KMyCellIdentify forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
        {

            if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
                if (self.isPunch == NO)
                {
                    [TTReqEngine C_GetPoints_SignSetUid:[DLAppData sharedInstance].myUserKey
                                              withBlock:^(BOOL success, id dataModel) {
                                                  if (success) {
                                                      
                                                      self.isPunch = YES;
                                                      APPDELEGATE.viewController.myUserModel.user_has_sign = @"1";
                                                      [cell upDateOnlyMytitle:@"已签到"];
                                                      LL_MyCenterCollectionCell *cell = (LL_MyCenterCollectionCell *)[self.myCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                                                      if ([APPDELEGATE.viewController.myUserModel.user_has_sign isEqualToString:@"0"])
                                                      {
                                                          self.isPunch = YES;
                                                      }else
                                                      {
                                                          self.isPunch = NO;
                                                      }
                                                      if (self.isPunch) {
                                                          [cell updateMyCell:@"每日签到" andWithImageName:@"myCenter_signIn"];
                                                      }
                                                      else{
                                                          [cell updateMyCell:@"已签到" andWithImageName:@"myCenter_signIn"];
                                                      }
                                                      
                                                      self.integralLabel.alpha = 100;
                                                      [UIView animateWithDuration:0.3
                                                                       animations:^{
                                                                           self.integralLabel.alpha = 0;
                                                                           CGRect tempFrame = self.integralLabel.frame;
                                                                           tempFrame.origin.y = -5;
                                                                           self.integralLabel.frame = tempFrame;
                                                                       } completion:^(BOOL finished) {
                                                                           CGRect tempFrame = self.integralLabel.frame;
                                                                           tempFrame.origin.y = 5;
                                                                           self.integralLabel.frame = tempFrame;
                                                                       }];
                                                  }
                                              }];
                }
                else if(self.isPunch == YES)
                {
                    self.isPunch = YES;
                    APPDELEGATE.viewController.myUserModel.user_has_sign = @"1";
                    [cell upDateOnlyMytitle:@"已签到"];
                    Alert_Message(@"提醒", @"您已签到，不能重复签到");
                }
            }else{
                [APPDELEGATE.viewController openLogin:self];
            }

        }
            break;
        case 1:
        {
            NSLog(@"我的消息");
            if ([[DLAppData sharedInstance].myUserKey notEmpty])
            {
                [self.navigationController pushViewController:[D_MessageViewController allocInstance] animated:YES];
            }else{
                [APPDELEGATE.viewController openLogin:self];
            }

        }
            break;
        case 2:
        {
            NSLog(@"我的收藏");
            if ([[DLAppData sharedInstance].myUserKey notEmpty])
            {
                //我的收藏
                [MobClick event:@"mine_favorite"];
                MyCollectViewController *myCollectViewController = [[MyCollectViewController alloc]init];
                
                myCollectViewController.typeStr = @"我的收藏";
                
                
                [self.navigationController pushViewController:myCollectViewController animated:YES];
            }
            else
            {
                [APPDELEGATE.viewController openLogin:self];
            }

        }
            break;
        case 3:
        {
            NSLog(@"我的订单");
            if ([[DLAppData sharedInstance].myUserKey notEmpty])
            {
                //我的订单
                [MobClick event:@"mine_order"];
                MyOrderViewController *myOrderViewController = [[MyOrderViewController alloc]init];
                [self.navigationController pushViewController:myOrderViewController animated:YES];
            }
            else
            {
                [APPDELEGATE.viewController openLogin:self];
            }

        }
            break;
        case 4:
        {
            NSLog(@"询价车型");
            if ([[DLAppData sharedInstance].myUserKey notEmpty])
            {
                //询价车型
                QueryModelsViewController *queryModelsViewController = [[QueryModelsViewController alloc]init];
                
                [self.navigationController pushViewController:queryModelsViewController animated:YES];
            }
            else
            {
                [APPDELEGATE.viewController openLogin:self];
            }

        }
            break;
        case 5:
        {
            NSLog(@"我的积分");
            if ([[DLAppData sharedInstance].myUserKey notEmpty])
            {
                D_WebViewController *tempController = [[D_WebViewController alloc]init];
                tempController.myTitle = @"积分纪录";
                tempController.myUrl = [NSString stringWithFormat:@"%@/credit",KH5Host];
                [self.navigationController pushViewController:tempController animated:YES];
            }
            else
            {
                [APPDELEGATE.viewController openLogin:self];
            }
        }
            break;
        case 6:
        {
            NSLog(@"浏览车型");
            if ([[DLAppData sharedInstance].myUserKey notEmpty])
            {
                
                MyCollectViewController *myCollectViewController = [[MyCollectViewController alloc]init];
                
                myCollectViewController.typeStr = @"浏览车型";
                
                [self.navigationController pushViewController:myCollectViewController animated:YES];
                
                //浏览车型
            }
            else
            {
                [APPDELEGATE.viewController openLogin:self];
            }

        }
            break;
        case 7:
        {
            NSLog(@"我的试驾车型");
            if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
                
                //试乘试驾
                TestDriveViewController *testDriveViewController = [[TestDriveViewController alloc]init];
                
                [self.navigationController pushViewController:testDriveViewController animated:YES];
            }
            else{
                [APPDELEGATE.viewController openLogin:self];
            }

        }
            break;
//        case 8:
//        {
//            NSLog(@"邀请返现");
//            if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
//                
//                //邀请返现
//                D_WebViewController *cashbackViewController =[[D_WebViewController alloc]init];
//                cashbackViewController.myTitle = @"邀请返现";
//                cashbackViewController.myUrl = [NSString stringWithFormat:@"%@%@",KH5Host,KCash];
//                
//                [self.navigationController pushViewController:cashbackViewController animated:YES];
//            }
//            else{
//                [APPDELEGATE.viewController openLogin:self];
//            }
//
//        }
//            break;
        case 8:
        {
            NSLog(@"设置");
            if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
                
                //设置
                [MobClick event:@"mine_set"];
                SetUpViewController *setUpViewController = [[SetUpViewController alloc]init];
                
                [self.navigationController pushViewController:setUpViewController animated:YES];
            }
            else
            {
                [APPDELEGATE.viewController openLogin:self];
            }

        }
            break;
        default:
            break;
    }
}
- ( UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    LL_MyCenterHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:KMyHeadViewIdentify forIndexPath:indexPath];
    NSString *userName ;
    NSString *imageName;
    NSString *sex;
    if ( APPDELEGATE.viewController.myUserModel !=nil) {
      
        if ([APPDELEGATE.viewController.myUserModel.user_nick notEmpty]) {
            userName = [NSString stringWithFormat:@"%@",APPDELEGATE.viewController.myUserModel.user_nick];
        }
        if ([APPDELEGATE.viewController.myUserModel.user_photo notEmpty]) {
            imageName = [NSString stringWithFormat:@"%@",APPDELEGATE.viewController.myUserModel.user_photo];
        }
        if ([APPDELEGATE.viewController.myUserModel.user_sex notEmpty]) {
            sex = [NSString stringWithFormat:@"%@",APPDELEGATE.viewController.myUserModel.user_sex];
        }
        
    }
    else{
        headView.myNameAndSexbtn.hidden = YES;
    }
    if (![[DLAppData sharedInstance].myUserKey notEmpty]) {
        [headView updateMyHeadImage:nil andWithMyName:nil andWihtSex:nil];
    }
    else{
        [headView updateMyHeadImage:imageName andWithMyName:userName andWihtSex:sex];
    }
    return headView;
}
#pragma mark UICollectionViewFlowLayout delegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((collectionView.frame.size.width-3)/3, 83);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    NSInteger tempHeight = 160;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        tempHeight= 160*2;
    }
    return CGSizeMake(collectionView.frame.size.width, tempHeight);
}
//#pragma mark - UITableViewDataSource
////1.tableview共有多少组
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 4;
//}
////2.section有几行
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//   if (2== section)
//    {
//        return 8;
//    }else
//    {
//        return 1;
//    }
//}
//-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section ==0) {
//        
//        NSInteger tempHeight = 160;
//        
//        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//            tempHeight= 160*2;
//        }
//        return tempHeight;
//    }
//   else
//    {
//        return 44;
//    }
//}
////3.告知每行显示什么
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"cellforowatindexpath %d %d",indexPath.section,indexPath.row);
//    
//    DLTableViewCell *cell =[[DLTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//    if (indexPath.section == 0) {
//        
//        cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mine_bg.png"]];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//         UIImage *userImage = [UIImage imageNamed:@"DefaultAvatar.png"];
//        
//      
//       
//        UIImageView *userImageView = [cell.contentView viewWithTag:1001];
//        if (userImageView == nil) {
//            userImageView = [[UIImageView alloc]initWithFrame:CGRectMake((tableView.frame.size.width-userImage.size.width/3)/2, 20, userImage.size.width/3, userImage.size.height/3)];
//            userImageView.tag = 1001;
//            userImageView.contentMode = UIViewContentModeScaleAspectFit;
//            userImageView.image = userImage;
//            [userImageView.layer setMasksToBounds:YES];
//            userImageView.layer.cornerRadius = (userImage.size.width/3)/2;
//            [cell.contentView addSubview:userImageView];
//        }
//        
//        NSString *tempstr =[NSString stringWithFormat:@"%@",APPDELEGATE.viewController.myUserModel.user_nick] ;
//        CGFloat nameLabelWidth = [Unity getLableWidthWithString:tempstr andFontSize:14]+20;
//        
//
//        UILabel* nameLabel = [cell.contentView viewWithTag:1002];
//        if (nameLabel == nil) {
//            
//            nameLabel = [[UILabel alloc]init];
//            nameLabel.frame = CGRectMake((self.myTableView.frame.size.width - nameLabelWidth)/2-5, userImageView.frame.origin.y+userImageView.frame.size.height+10,nameLabelWidth, 30);
//            nameLabel.textColor = [UIColor blackColor];
//            nameLabel.tag = 1002;
//            nameLabel.textAlignment = NSTextAlignmentRight;
//            [cell.contentView addSubview:nameLabel];
//            
//        }
//        
//        UIImageView *sexImageView = [cell.contentView viewWithTag:1006];
//        
//        UIImage *sexImage = [UIImage imageNamed:@"DefaultAvatar.png"];
//        
//        NSString *sexstr =APPDELEGATE.viewController.myUserModel.user_sex;
// 
//        if ([sexstr isEqualToString:@"1"]) {
//            sexImage = [UIImage imageNamed:@"female.png"];
//        }else if ([sexstr isEqualToString:@"0"])
//        {
//            sexImage = [UIImage imageNamed:@"male.png"];
//        }
//        else
//        {
//            sexImage = nil;
//            sexImageView.hidden = YES;
//        }
//
//        
//        if (sexImageView == nil) {
//            sexImageView = [[UIImageView alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x+nameLabel.frame.size.width+5, nameLabel.frame.origin.y+8, sexImage.size.width, sexImage.size.height)];
//            sexImageView.tag = 1006;
//            sexImageView.contentMode = UIViewContentModeScaleAspectFit;
//            
//            [cell.contentView addSubview:sexImageView];
//        }
//
// 
//        
//        sexImageView.image = sexImage;
//        
//        
//        if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
//            
//            //tempBtn.hidden = YES;
//            
//            if ( APPDELEGATE.viewController.myUserModel !=nil) {
//                if ([APPDELEGATE.viewController.myUserModel.user_nick notEmpty]) {
//                    nameLabel.text = APPDELEGATE.viewController.myUserModel.user_nick;
//                }
//                if ([APPDELEGATE.viewController.myUserModel.user_photo notEmpty]) {
//                    [userImageView setImageWithURL:[NSURL URLWithString:APPDELEGATE.viewController.myUserModel.user_photo] placeholderImage:userImage];
//                }
//            }
//        }else{
//           // tempBtn.hidden = NO;
//            nameLabel.hidden = YES;
//            userImageView.image = userImage;
//        }
//
//        
//    }
//    
//    if (1==indexPath.section)
//    {
//        //签到
//        cell.imageView.image = [UIImage imageNamed:@"icon_mine_everyday.png"];
//        cell.textLabel.text= @"每日签到";
//        
//        UIButton *punchBtn = [cell.contentView viewWithTag:1004];
//        if (punchBtn == nil) {
//            punchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            punchBtn.frame = CGRectMake(tableView.bounds.size.width-70, 10, 60, 24);
//            [punchBtn.layer setMasksToBounds:YES];
//            [punchBtn.layer setBorderWidth:1];
//            punchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//            punchBtn.tag = 1004;
//            [punchBtn.layer setCornerRadius:5];
//            [punchBtn addTarget:self action:@selector(punch:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.contentView addSubview:punchBtn];
//        }
//        
//        self.integralLabel= [cell.contentView viewWithTag:1005];
//        if (self.integralLabel == nil) {
//            self.integralLabel = [[UILabel alloc]initWithFrame:CGRectMake(tableView.bounds.size.width-90, 5, 80, 24)];
//            self.integralLabel.tag = 1005;
//            self.integralLabel.text = @"+5";
//            self.integralLabel.textColor = RGBCOLOR(252, 41, 42);
//            self.integralLabel.alpha = 0;
//            self.integralLabel.font = [UIFont boldSystemFontOfSize:14];
//            self.integralLabel.textAlignment = NSTextAlignmentCenter;
//            [cell.contentView addSubview:self.integralLabel];
//        }
//
//        if ([APPDELEGATE.viewController.myUserModel.user_has_sign isEqualToString:@"1"])
//        {
//            self.isPunch = YES;
//        }else
//        {
//            self.isPunch = NO;
//        }
//
//        if (self.isPunch == YES)
//        {
//            punchBtn.userInteractionEnabled = NO;
//            [punchBtn setTitle:@"已签到" forState:UIControlStateNormal];
//            [punchBtn setTitleColor:RGBCOLOR(236, 237, 238) forState:UIControlStateNormal];
//            [punchBtn.layer setBorderColor:RGBCOLOR(236, 237, 238).CGColor];
//
//        }else
//        {
//            punchBtn.userInteractionEnabled = YES;
//            [punchBtn setTitle:@"签到" forState:UIControlStateNormal];
//            [punchBtn setTitleColor:RGBCOLOR(252, 41, 42) forState:UIControlStateNormal];
//            [punchBtn.layer setBorderColor:RGBCOLOR(252,41, 42).CGColor];
//        }
//        
//    } else if(2== indexPath.section)
//    {
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        
//        switch (indexPath.row)
//        {
//            case 0:
//            {
//                cell.imageView.image = [UIImage imageNamed:@"icon_mine_message.png"];
//                cell.textLabel.text= @"我的消息";
//                
////                UIView *bgview = [[UIView alloc]init];
////                bgview.frame = CGRectMake(tableView.frame.size.width-50, 12, 20, 20);
////                bgview.backgroundColor = RGBCOLOR(236, 237, 238);
////                bgview.layer.cornerRadius = 10;
////                [cell.contentView addSubview:bgview];
////
////                UILabel *countLabel = [[UILabel alloc]init];
////                countLabel.frame = CGRectMake(0, 0, 20, 20);
////                countLabel.font = [UIFont boldSystemFontOfSize:12];
////                countLabel.textColor = [UIColor whiteColor];
////                countLabel.text = @"2";
////                countLabel.textAlignment = NSTextAlignmentCenter;
////                [bgview addSubview:countLabel];
//                
//            }
//                break;
//            case 1:
//            {
//                cell.imageView.image = [UIImage imageNamed:@"我的收藏.png"];
//                cell.textLabel.text= @"我的收藏";
//               
//            }
//                break;
//            case 2:
//            {
//                cell.imageView.image = [UIImage imageNamed:@"我的订单.png"];
//                cell.textLabel.text= @"我的订单";
//            }
//                break;
//            case 3:
//            {  cell.imageView.image = [UIImage imageNamed:@"询价车型.png"];
//                cell.textLabel.text= @"询价车型";
//             
//                
//            }
//                break;
//            case 4:
//            {
//                cell.imageView.image = [UIImage imageNamed:@"icon_mine_points.png"];
//                cell.textLabel.text= @"我的积分";
//            }
//                break;
//                
//            case 5:
//            {
//                cell.imageView.image = [UIImage imageNamed:@"icon_mine_car"];
//                cell.textLabel.text= @"浏览车型";
//
//            }
//                break;
//                
//            case 6:
//            {
//                cell.imageView.image = [UIImage imageNamed:@"icon_mine_drive"];
//                cell.textLabel.text= @"我的试驾";
//
//            }
//                break;
//            case 7:
//            {
//                cell.imageView.image = [UIImage imageNamed:@"icon_mine_invite.png"];
//                cell.textLabel.text= @"邀请返现";
//            }
//                break;
//   
//            default:
//                break;
//        }
//    }else if (3== indexPath.section)
//    {
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        
//        switch (indexPath.row) {
//            case 0:
//            {
//                cell.imageView.image = [UIImage imageNamed:@"设置.png"];
//                
//                cell.textLabel.text= @"设置";
//            }
//                break;
//            default:
//                break;
//        }
//    }
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.textLabel.font = [UIFont systemFontOfSize:14];
//    cell.textLabel.textColor = [Unity getColor:@"#666666"];
//    
//    return cell;
//}
//
-(void)logonBtnPressed
{
    if ([[DLAppData sharedInstance].myUserKey notEmpty])
    {
        //个人资料
        [MobClick event:@"mine_user"];
        PersonalInfoViewController *personalInfoViewController = [[PersonalInfoViewController alloc]init];
        personalInfoViewController.mydelegate = self;
        [self.navigationController pushViewController:personalInfoViewController animated:YES];
        
    }else
    {
        [DLAppData sharedInstance].myUserKey = @"";
        [DLAppData sharedInstance].myUserName = @"";
        
        [[DLUserDefaults sharedInstance] setObject:@"" forKey:@"uid"];
        [[DLUserDefaults sharedInstance] setObject:@"" forKey:@"username"];
        
        [APPDELEGATE.viewController initLoginController:self withIsLogin:YES];
 
    }
}
//
//打卡签到
-(void)punch:(UIButton *)sender
{
    if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
        if (self.isPunch == NO)
        {
            [TTReqEngine C_GetPoints_SignSetUid:[DLAppData sharedInstance].myUserKey
                                      withBlock:^(BOOL success, id dataModel) {
                    if (success) {
                        
                        [sender setTitle:@"已签到" forState:UIControlStateNormal];
                        [sender setTitleColor:RGBCOLOR(236, 237, 238) forState:UIControlStateNormal];
                        [sender.layer setBorderColor:RGBCOLOR(236, 237, 238).CGColor];
                        self.isPunch = YES;
                        APPDELEGATE.viewController.myUserModel.user_has_sign = @"1";
                        
                        self.integralLabel.alpha = 100;
                        [UIView animateWithDuration:0.3
                                         animations:^{
                                             self.integralLabel.alpha = 0;
                                             CGRect tempFrame = self.integralLabel.frame;
                                             tempFrame.origin.y = -5;
                                             self.integralLabel.frame = tempFrame;
                                         } completion:^(BOOL finished) {
                                             CGRect tempFrame = self.integralLabel.frame;
                                             tempFrame.origin.y = 5;
                                             self.integralLabel.frame = tempFrame;
                                         }];
                    }
            }];
        }
    }else{
        [APPDELEGATE.viewController openLogin:self];
    }
}
//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView* tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.baseView.frame.size.width, 20)];
//    tempView.backgroundColor = RGBCOLOR(238, 238, 238);
//    return tempView;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//  
//    return 0;
//}
//
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if (section == 3) {
//        return 0;
//    }
//    return 10;
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (0==indexPath.section)
//    {
////        if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
////            //个人资料
////            PersonalInfoViewController *personalInfoViewController = [[PersonalInfoViewController alloc]init];
////            [self.navigationController pushViewController:personalInfoViewController animated:YES];
////        }
////        else
////        {
////            [APPDELEGATE.viewController openLogin:self];
////        }
//    }
//    else if(2== indexPath.section){
//        switch (indexPath.row) {
//                
//            case 0:
//            {
//                if ([[DLAppData sharedInstance].myUserKey notEmpty])
//                {
//                 [self.navigationController pushViewController:[D_MessageViewController allocInstance] animated:YES];
//                }else{
//                    [APPDELEGATE.viewController openLogin:self];
//                }
//            }
//                break;
//            case 1:
//            {
//                if ([[DLAppData sharedInstance].myUserKey notEmpty])
//                {
//                     //我的收藏
//                    [MobClick event:@"mine_favorite"];
//                    MyCollectViewController *myCollectViewController = [[MyCollectViewController alloc]init];
//
//                    myCollectViewController.typeStr = @"我的收藏";
//                    
//
//                    [self.navigationController pushViewController:myCollectViewController animated:YES];
//                }
//                else
//                {
//                    [APPDELEGATE.viewController openLogin:self];
//                }
//               
//            }
//                break;
//            case 2:
//            {
//                if ([[DLAppData sharedInstance].myUserKey notEmpty])
//                {
//                    //我的订单
//                    [MobClick event:@"mine_order"];
//                    MyOrderViewController *myOrderViewController = [[MyOrderViewController alloc]init];
//                    [self.navigationController pushViewController:myOrderViewController animated:YES];
//                }
//                else
//                {
//                    [APPDELEGATE.viewController openLogin:self];
//                }
//               
//
//            }
//                break;
//            case 3:
//            {
//                if ([[DLAppData sharedInstance].myUserKey notEmpty])
//                {
//                    //询价车型
//                    QueryModelsViewController *queryModelsViewController = [[QueryModelsViewController alloc]init];
//                    
//                    [self.navigationController pushViewController:queryModelsViewController animated:YES];
//                }
//                else
//                {
//                    [APPDELEGATE.viewController openLogin:self];
//                }
//            }
//                break;
//            case 4:
//            {
//                if ([[DLAppData sharedInstance].myUserKey notEmpty])
//                {
//                    D_WebViewController *tempController = [[D_WebViewController alloc]init];
//                    tempController.myTitle = @"积分纪录";
//                    tempController.myUrl = [NSString stringWithFormat:@"%@/credit",KH5Host];
//                    [self.navigationController pushViewController:tempController animated:YES];
//                }
//                else
//                {
//                    [APPDELEGATE.viewController openLogin:self];
//                }
//            }
//                break;
//            case 5:
//            {
//                if ([[DLAppData sharedInstance].myUserKey notEmpty])
//                {
//                    
//                    MyCollectViewController *myCollectViewController = [[MyCollectViewController alloc]init];
//                    
//                    myCollectViewController.typeStr = @"浏览车型";
//                    
//                    [self.navigationController pushViewController:myCollectViewController animated:YES];
//
//                    //浏览车型
//                                    }
//                else
//                {
//                    [APPDELEGATE.viewController openLogin:self];
//                }
//            }
//                break;
//                
//            case 6:
//            {
//                if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
//                    
//                    //试乘试驾
//                    TestDriveViewController *testDriveViewController = [[TestDriveViewController alloc]init];
//                    
//                    [self.navigationController pushViewController:testDriveViewController animated:YES];
//                }
//                else{
//                    [APPDELEGATE.viewController openLogin:self];
//                }
//
//            }
//                break;
//                
//            case 7:
//            {
//                if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
//                    
//                    //邀请返现
//                    D_WebViewController *cashbackViewController =[[D_WebViewController alloc]init];
//                    cashbackViewController.myTitle = @"邀请返现";
//                    cashbackViewController.myUrl = [NSString stringWithFormat:@"%@%@",KH5Host,KCash];
//
//                    [self.navigationController pushViewController:cashbackViewController animated:YES];
//                }
//                else{
//                    [APPDELEGATE.viewController openLogin:self];
//                }
//                
//            }
//                break;
//     
//        }
//    }
//    else if (3== indexPath.section)
//    {
//        switch (indexPath.row)
//        {
//            case 0:
//            {
//                if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
//                    
//                    //设置
//                    [MobClick event:@"mine_set"];
//                    SetUpViewController *setUpViewController = [[SetUpViewController alloc]init];
//                    
//                    [self.navigationController pushViewController:setUpViewController animated:YES];
//                }
//                else
//                {
//                    [APPDELEGATE.viewController openLogin:self];
//                }
//  
//            }
//                break;
//            default:
//                break;
//        }
//    }
//}
//
//修改个人资料
-(void)rightBtnPressed:(id)sender
{
    
    [self logonBtnPressed];
}
#pragma mark MyDelegate
-(void)successGoBackAndRefreshViewController
{
    [self.myCollectionView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:YES];
    
    if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
        [self.myRighddtBtn setTitle:@"修改资料" forState:UIControlStateNormal];
    }
    else{
        [self.myRighddtBtn setTitle:@"请登录" forState:UIControlStateNormal];
    }
//     LL_MyCenterHeadView *headView = [self.myCollectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KMyHeadViewIdentify forIndexPath:inde];
    
    [self.myCollectionView reloadData];
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
