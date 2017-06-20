    //
//  PersonalInfoViewController.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/10.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "M_UserInfoModel.h"
#import "NameViewController.h"
#import "M_IntegralViewController.h"
#import "TTReqEngine.h"
#import "M_CityListModel.h"
#import "DLPickerView.h"
#import "DLDateOrTimePickerView.h"
#import "DLUpYunHelper.h"
#import "DHChangePasswordViewController.h"

//#import "DLImagePickerTool.h"
@interface PersonalInfoViewController ()<DLPickerViewDelegate,nameDelegate,MyDelegate>

AS_MODEL_STRONG(DLPickerView , myPickerView);
AS_MODEL_STRONG(DLDateOrTimePickerView, myDatePickerView);

AS_MODEL_STRONG(M_CityListModel, myCityListModel);

AS_INT(currCityIndex);

@end

@implementation PersonalInfoViewController
@synthesize infoModel;
DEF_MODEL(myCityListModel);

DEF_MODEL(myPickerView);
DEF_MODEL(myDatePickerView);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.currCityIndex = 0;
    
    [self addCustomNavBar:@"个人资料"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    self.view.backgroundColor = [Unity getColor:@"#eeeeee"];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.bounds.size.width, self.baseView.bounds.size.height-NavigationBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleSingleLine];
    
    [self initData];
    
}


-(void)UpdataNameSetName:(NSString *)name
{
    self.infoModel.user_nick = name;
    
    [self.myTableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
}

-(void)initData
{
//    [APPDELEGATE.viewController getUserData:^(id data) {
//         self.infoModel = (M_UserInfoModel *)data;
//        [self.myTableView reloadData];
//    }];
    self.infoModel = APPDELEGATE.viewController.myUserModel;
    [self.myTableView reloadData];
}

-(void)getCityAllData
{
       [ TTReqEngine C_GetCity_AllwithBlock:^(BOOL success, id dataModel) {
           if (success) {
               
               self.myCityListModel = (M_CityListModel*)dataModel;
               
               [self seleteCity:self.myCityListModel
                  withSeleteStr:self.infoModel.province_name
                 withSeleteStr2:self.infoModel.city_name];
           }
        }];
}

-(void)leftBtnPressed:(id)sender
{
    [self.mydelegate successGoBackAndRefreshViewController];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableviewdelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"identify";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
 
    UILabel* infoLabel = [cell.contentView viewWithTag:1001];
    
    if (infoLabel == nil) {
        infoLabel = [[UILabel alloc]init];
        infoLabel.frame = CGRectMake(ScreenWidth/2, 7, ScreenWidth/2-50, 30);
        infoLabel.font = [UIFont systemFontOfSize:14];
        infoLabel.textColor = [Unity getColor:@"#666666"];
        infoLabel.textAlignment = NSTextAlignmentRight;
        infoLabel.tag = 1001;
        [cell.contentView addSubview:infoLabel];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (0==indexPath.section) {
        
        UIImage *userImage = [UIImage imageNamed:@"DefaultAvatar.png"];
        UIImageView *userImageView = [cell.contentView viewWithTag:1002];
        
        
        if (userImageView == nil) {
            userImageView = [[UIImageView alloc]initWithFrame:CGRectMake((tableView.frame.size.width-72-30), 8, 72, 72)];
            userImageView.tag = 1002;
            [userImageView.layer setMasksToBounds:YES];
            userImageView.layer.cornerRadius = 36;
            [cell.contentView addSubview:userImageView];
            
            
//            userImageView = [[UIImageView alloc]initWithFrame:CGRectMake((tableView.frame.size.width-80), 8, 72, 72)];
//            userImageView.tag = 1002;
//            [userImageView.layer setMasksToBounds:YES];
//            userImageView.layer.cornerRadius = 36;
//            
//            //userImageView.contentMode = UIViewContentModeScaleAspectFit;
//            userImageView.image = userImage;
//            //userImageView.layer.cornerRadius = (userImage.size.width/3.5)/2;
//            [cell.contentView addSubview:userImageView];
        }
        
        if ([APPDELEGATE.viewController.myUserModel.user_photo notEmpty]) {
            
            [userImageView setImageWithURL:[NSURL URLWithString:APPDELEGATE.viewController.myUserModel.user_photo] placeholderImage:userImage];
        }else
        {
            userImageView.image = userImage;
        }

        cell.textLabel.text= @"头像";
        
    
    } else if(1== indexPath.section){
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text= @"姓名";
                if ([self.infoModel.user_nick notEmpty]) {
                     infoLabel.text= self.infoModel.user_nick;
                }
            }
                break;
            case 1:
            {
               
                cell.textLabel.text= @"手机号码";
                
                if ([self.infoModel.user_phone notEmpty]) {
                    infoLabel.text= self.infoModel.user_phone;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    cell.userInteractionEnabled = NO;
                }else
                {
                    infoLabel.text= @"请绑定手机号";
                }
            }
                break;
            case 2:
            {
                cell.textLabel.text= @"性别";
                if ([self.infoModel.user_sex notEmpty]) {
                    
                    if ([self.infoModel.user_sex isEqualToString:@"0"]) {
                        
                        infoLabel.text= @"女";
                    }else
                    {
                        infoLabel.text= @"男";
                    }
                }else{
                    infoLabel.text= @"男";
                }

            }
                break;
            case 3:
            {
               
                cell.textLabel.text= @"生日";
                if ([self.infoModel.user_birthday notEmpty]) {
                    infoLabel.text= [[NSDate dateWithTimeIntervalSince1970:[self.infoModel.user_birthday doubleValue]] dateToString];
                }

                
            }
                break;
                
            case 4:
            {
                
                cell.textLabel.text= @"地区";
                if ([self.infoModel.province_name notEmpty]&&[self.infoModel.city_name notEmpty]) {
                    infoLabel.text= [NSString stringWithFormat:@"%@ %@",self.infoModel.province_name,self.infoModel.city_name];
                }
            }
                break;
            
            default:
                break;
        }
    }else if(indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
            {
                
                switch ([self.infoModel.myHas_Set_Password integerValue]) {
                    case 0:
                    {
                        NSLog(@"设置密码");
                         cell.textLabel.text= @"设置密码";
                    }
                        break;
                    case 1:
                    {
                        NSLog(@"修改密码");
                         cell.textLabel.text= @"修改密码";
                        
                    }
                        break;
                    default:
                        break;
                }

            }
                break;
                
            default:
                break;
        }
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [Unity getColor:@"#666666"];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 5;
        }
            break;
        case 2:
        {
            return 1;
        }
            break;
        default:
            break;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 44*2;
    }else
    {
        return 44;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak PersonalInfoViewController *tempSelf = self;
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    [[DLImagePickerTool sharedInstance] showImagePickerSheet:self withBlock:^(UIImage *image) {
                        
                        UIImage* tempImage = [image scaleToSize:CGSizeMake(600, 600)];
                        NSString* tempFliepath=[NSString stringWithFormat:@"%@%@",[DLCache libCachesToUser],@"tempheader.png"];
                        [DLCache writeImage:tempImage toDocumentPath:tempFliepath];
                        if (image!=nil) {
                            [DLUpYunHelper  uploadFile:tempImage withBlock:^(BOOL success, NSString *fileUrl, NSError *error) {
                                if (success) {
                                    [self updatePhoto:fileUrl];
                                }else{
                                    [SVProgressHUD showErrorWithStatus:@"上传头像失败!"];
                                }
                            }];
                        }
                    } withIsEdit:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    [MobClick event:@"user_username"];
                    NameViewController *nameVC = [[NameViewController alloc]init];
                    nameVC.model = self.infoModel;
                    nameVC.delegate = self;
                    [self.navigationController pushViewController:nameVC animated:YES];
                }
                    break;
                case 1:
                {
                    if (![self.infoModel.user_phone notEmpty])
                    {
                        //绑定手机号
                        [APPDELEGATE.viewController bindPhone:self withBlock:^(bool result) {
                            if (result) {
                                self.infoModel = APPDELEGATE.viewController.myUserModel;
                                [self.myTableView reloadData];
                            }
                        }];
                    }

                }
                    break;
                case 2:
                {
                    [MobClick event:@"mine_sex"];
                    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                                  initWithTitle:nil
                                                  delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  destructiveButtonTitle:nil
                                                  otherButtonTitles:@"女", @"男",nil];
                    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
                    actionSheet.tag = 9001;
                    [actionSheet showInView:self.view];
                }
                    break;
                case 3:
                {
                    [MobClick event:@"mine_birthday"];
                    
//                    NSString* tempDate = [[NSDate date] dateToString];
                    NSString* tempDate = [[NSDate dateWithTimeIntervalSince1970:[self.infoModel.user_birthday doubleValue]] dateToString];
                    [self showDateOrTimeView:@"选择生日" withDefault:tempDate withTag:1002];
                }
                    break;
                case 4:
                {
                    [MobClick event:@"main_area"];
                    if([self.myCityListModel.myAllCityArray count]==0){
                        [self getCityAllData];
                    }
                   else
                   {
                       [self seleteCity:self.myCityListModel
                          withSeleteStr:self.infoModel.province_name
                         withSeleteStr2:self.infoModel.city_name];
                   }
                }
                    break;
                default:
                    break;
            }

        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    
                    NSLog(@"修改密码");
                    
                    DHChangePasswordViewController *tempView = [[DHChangePasswordViewController alloc]init];
                    
                    [self.navigationController pushViewController:tempView animated:YES];

                }
                    break;
                    
                default:
                    break;
            }

        }
            break;
        default:
            break;
    }
    if (indexPath.section == 0) {
        
     
    }
    if (indexPath.section ==1) {
        switch (indexPath.row) {
            case 0:
            {
                
            }
                break;
            case 1:
            {
                            }
                break;
            case 2:
            {
                

            }
                break;
            case 3:
            {
               
            }
                break;
            case 4:
            {
               
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark - Add Picture
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *sexStr = [NSString string];
    
    if ([self.infoModel.user_sex integerValue] == 0 && buttonIndex == 0) {
        return;
    }
    
    if ([self.infoModel.user_sex integerValue] == 1 && buttonIndex == 1) {
        return;
    }
    
    if (buttonIndex == 0)
    {
        self.infoModel.user_sex = @"0";
    }
    else if (buttonIndex == 1)
    {
        self.infoModel.user_sex = @"1";
    }
    else if(buttonIndex == 2)
    {
        NSLog(@"取消");
        return ;
    }
    
    sexStr = [NSString stringWithFormat:@"%lu",buttonIndex];
    
    __weak PersonalInfoViewController* tempSelf = self;
    {
        [TTReqEngine C_PostUser_UpdateSetUid:[DLAppData sharedInstance].myUserKey
                                     withSex:sexStr
                                    withNick:nil
                                   withEmail:nil
                                withBirthday:nil
                                  withAvatar:nil
                                 withCity_id:APPDELEGATE.viewController.myUserModel.city_id
                                      withQQ:nil
                                   withBlock:^(BOOL success, id dataModel) {
            if (success) {
                APPDELEGATE.viewController.myUserModel.user_sex= sexStr;
                [tempSelf initData];
                [tempSelf.myTableView reloadData];
            }
        }];
        
    }
}

-(void)seleteCity:(M_CityListModel*)data withSeleteStr:(NSString*)content withSeleteStr2:(NSString*)content2
{
    int defaultIndex = 0;
    int default2Index = 0;
    
    DLPickerDataSource* tempData = [DLPickerDataSource allocInstance];
    
    tempData.pickComponentsCount = 2;
    
    for (int i=0; i<[data.myAllCityArray count]; i++) {
        M_ProvinceItemModel* tempItem = [data.myAllCityArray objectAtIndex:i];
        if (tempItem!=nil) {
            
            NSMutableDictionary* tempdic = [NSMutableDictionary dictionary];
            [tempdic setObject:tempItem.myProvince_Name forKey:PopText];
        
            NSMutableArray* temparray2 = [NSMutableArray array];
            for (int j=0; j<[tempItem.myCityArray1 count]; j++) {
                M_CityItemModel* tempItem2 = [tempItem.myCityArray1 objectAtIndex:j];
                if (tempItem2!=nil) {

                    NSMutableDictionary* tempdic2 = [NSMutableDictionary dictionary];
                    [tempdic2 setObject:tempItem2.myCity_Name forKey:PopText];
                    [temparray2 addObject:tempdic2];
                    if ([tempItem2.myCity_Name isEqualToString:content2]) {
                            default2Index = j;
                            defaultIndex = i;
                        }
                    }
                }
            [tempdic setObject:temparray2 forKey:PopSubArray];
            [tempData.firstArray addObject:tempdic];
        }
    }
    
    NSMutableDictionary* tempDefaultdic = [NSMutableDictionary dictionary];
    [tempDefaultdic setObject:[NSNumber numberWithInt:defaultIndex] forKey:KPICKER_FIRST];
    [tempDefaultdic setObject:[NSNumber numberWithInt:default2Index] forKey:KPICKER_SECOND];
    
    [self showPickerView:@"选择地区" withData:tempData withDefault:tempDefaultdic withTag:1004];
}

-(void)showPickerView:(NSString*)title withData:(DLPickerDataSource*)data withDefault:(NSDictionary*)dic withTag:(NSInteger)tag
{
    self.myPickerView = [[DLPickerView alloc]initWithFrame:CGRectMake(0,NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight)];
    self.myPickerView.delegate = self;
    [self.myPickerView updateViewData:title withData:data withDefault:dic];
    self.myPickerView.tag = tag;
    [self.baseView addSubview:self.myPickerView];
    
    [self.myPickerView startAnimation];
}

-(void)showDateOrTimeView:(NSString*)title withDefault:(NSString*)time withTag:(NSInteger)tag
{
    self.myDatePickerView = [DLDateOrTimePickerView allocInstanceFrame:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight)];
    self.myDatePickerView.tag = tag;
    self.myDatePickerView.myPickerView.maximumDate = [NSDate date];
    [self.myDatePickerView updateViewData:title withData:[time stringToDate] withMode:YES];
    
    [self.myDatePickerView setMaxTime:nil withMinTime:nil];
    
    [self.baseView addSubview:self.myDatePickerView];
    
    __weak PersonalInfoViewController* tempSelf = self;
    self.myDatePickerView.block = ^(int tag,id data){
        if (tag == 1) {
            NSLog(@"dwdwdwdwdwdw   %@",data);
            [TTReqEngine C_PostUser_UpdateSetUid:[DLAppData sharedInstance].myUserKey
                                         withSex:nil
                                        withNick:nil
                                       withEmail:nil
                                    withBirthday:data
                                      withAvatar:nil
                                     withCity_id:APPDELEGATE.viewController.myUserModel.city_id
                                          withQQ:nil
                                       withBlock:^(BOOL success, id dataModel) {
                if (success) {
                     APPDELEGATE.viewController.myUserModel  = (M_UserInfoModel *)dataModel;
                    [tempSelf initData];
                    [tempSelf.myTableView reloadData];
//                    tempSelf.infoModel = (M_UserInfoModel *)data;
//                    UITableViewCell *cell = [tempSelf.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:3]];
//                    UILabel* infoLabel = [cell.contentView viewWithTag:1001];
////                    if ( ![APPDELEGATE.viewController.myUserModel.user_birthday isEqualToString:@""]) {
//                        infoLabel.text =data;
////                    }
//                    [cell reloadInputViews];
                    
                }
            }];
            
        }else if (tag == 0){
            [tempSelf.myDatePickerView removeFromSuperview];
            tempSelf.myDatePickerView = nil;
        }
    };
    
    [self.myDatePickerView startAnimation];
}

#pragma DLPickerViewDelegate

-(void)pickerSureBtnPressed:(NSString *)seleteValue
{
    if (self.myPickerView.tag == 1004) {
        
        M_ProvinceItemModel* tempItem1 = [self.myCityListModel.myAllCityArray objectAtIndex:self.myPickerView.myDataSource.seleteFirstIndex];
       
        if (tempItem1!=nil) {
            M_CityItemModel* tempItem2 = [tempItem1.myCityArray1 objectAtIndex:self.myPickerView.myDataSource.seleteSecondIndex];
            if (tempItem2!=nil) {
                
                [TTReqEngine C_PostUser_UpdateSetUid:[DLAppData sharedInstance].myUserKey
                                             withSex:nil
                                            withNick:nil
                                           withEmail:nil
                                        withBirthday:nil
                                          withAvatar:nil
                                         withCity_id:tempItem2.myCity_Id
                                              withQQ:nil
                                           withBlock:^(BOOL success, id dataModel) {
                    if (success) {
                        
                         APPDELEGATE.viewController.myUserModel.city_code = tempItem2.myCity_Id;
                        APPDELEGATE.viewController.myUserModel.city_name = tempItem2.myCity_Name;
                        APPDELEGATE.viewController.myUserModel.province_name = tempItem1.myProvince_Name;
                        [self initData];
                        [self.myTableView reloadData];
                    }
                }];
            }
        }
        
        
    }
}

-(void)pickerCancelBtnPressed
{
    if (self.myPickerView!=nil) {
        [self.myPickerView removeFromSuperview];
        self.myPickerView = nil;
    }
}

-(void)updatePhoto:(NSString*)fileUrl
{
    [TTReqEngine C_PostUser_UpdateSetUid:[DLAppData sharedInstance].myUserKey
                                 withSex:nil
                                withNick:nil
                               withEmail:nil
                            withBirthday:nil
                              withAvatar:fileUrl
                             withCity_id:nil
                                  withQQ:nil
                               withBlock:^(BOOL success, id dataModel) {
                                     if (success) {
                                         
                                         M_UserInfoModel *tempModel = (M_UserInfoModel *)dataModel;
                                         [SVProgressHUD showSuccessWithStatus:@"上传头像成功！"];
                                         
                                         APPDELEGATE.viewController.myUserModel.user_photo= tempModel.user_photo;
                                         [self initData];
                                         [self.myTableView reloadData];
                                     }
                                 }];
}
-(void)successGoBackAndRefreshViewController
{
    [self.myTableView reloadData];
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
