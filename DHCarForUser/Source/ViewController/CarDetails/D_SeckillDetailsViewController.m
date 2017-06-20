//
//  D_SeckillDetailsViewController.m
//  DHCarForUser
//
//  Created by lucaslu on 16/1/13.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "D_SeckillDetailsViewController.h"
#import "M_ShareView.h"
#import "M_CarDetailsView.h"
#import "D_WebViewController.h"

#import "M_CarDetailHeaderView1.h"

#import "TTReqEngine.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "WeiboSDK.h"


//#import "M_CarListModel.h"
#import "M_SpikeListModel.h"
#import "D_PayViewController.h"

#import "M_SpikeRushModel.h"


@interface D_SeckillDetailsViewController ()<UIWebViewDelegate>


AS_MODEL_STRONG(M_ShareView, myShareView);


AS_MODEL_STRONG(M_CarDetailHeaderView1, myHeaderView);


AS_MODEL_STRONG(UIButton, mySureBtn);
AS_MODEL_STRONG(UIButton, mySeckillStateBtn);
AS_MODEL_STRONG(UILabel, myTimerLabel);
AS_BOOL(isMyRefresh);
AS_MODEL_STRONG(NSTimer, myTimer);

AS_INT(currIndex);

AS_MODEL_STRONG(NSDate, myCurrDate);

AS_MODEL_STRONG(M_SpikeItemModel, myModel);

AS_MODEL_STRONG(UIView, myCurrTimerView);

AS_INT(currState);

AS_MODEL_STRONG(UIWebView, carAction);

@end

@implementation D_SeckillDetailsViewController

DEF_FACTORY(D_SeckillDetailsViewController);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.isMyRefresh = NO;
    self.currIndex = 60;
    
    [self initView];
    
    [self initData];
}

-(void)initView
{
    [self addCustomNavBar:@"秒杀"
              withLeftBtn:@"icon_back.png"
             withRightBtn:@""
            withLeftLabel:@"返回"
           withRightLabel:nil];
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight*2) withSeparatoStyle:UITableViewCellSeparatorStyleSingleLine];
    
    NSInteger headerHeight = 220+130;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        headerHeight = 440+130;
    }
    
    self.myHeaderView = [M_CarDetailHeaderView1 allocInstanceFrame:CGRectMake(0, 0, self.baseView.frame.size.width, headerHeight)];
    
    UIView* tempTime = [[UIView alloc]initWithFrame:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, 30)];
    self.myCurrTimerView = tempTime;
    [tempTime setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    
    UIImage* tempMiImage = [UIImage imageNamed:@"秒杀.png"];
    
    UIButton* tempClewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tempClewBtn setBackgroundImage:tempMiImage forState:UIControlStateNormal];
    tempClewBtn.titleLabel.font = SYSTEMFONT(12);
    [tempClewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tempClewBtn setTitle:@"秒拍进行中" forState:UIControlStateNormal];
    tempClewBtn.userInteractionEnabled = NO;
    tempClewBtn.frame = CGRectMake(0, 0, tempMiImage.size.width, tempMiImage.size.height);
    self.mySeckillStateBtn = tempClewBtn;
    [tempTime addSubview:self.mySeckillStateBtn ];
    
    self.myTimerLabel = [[UILabel alloc]initWithFrame:CGRectMake(tempMiImage.size.width+20, 0, tempTime.frame.size.width-tempMiImage.size.width-30, tempTime.frame.size.height)];
    self.myTimerLabel.font = SYSTEMFONT(12);
    self.myTimerLabel.textColor = [UIColor blackColor];
    
    [tempTime addSubview:self.myTimerLabel];
    
    [self.baseView addSubview:tempTime];
    
    UIView* tempView = [[UIView alloc]initWithFrame:CGRectMake(0, self.baseView.frame.size.height-NavigationBarHeight, self.baseView.frame.size.width, NavigationBarHeight)];
    tempView.backgroundColor = [UIColor whiteColor];
    
    self.mySureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mySureBtn.titleLabel.font = SYSTEMFONT(14);
    self.mySureBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor redColor];
                                       style.cornerRedius = 5;);
    [self.mySureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.mySureBtn setUserInteractionEnabled:NO];
    [self.mySureBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.mySureBtn addTarget:self action:@selector(sureBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.mySureBtn.frame = CGRectMake(10, (NavigationBarHeight-40)/2, self.baseView.frame.size.width-20, 40);
    [tempView addSubview:self.mySureBtn];
    
    [self.baseView addSubview:tempView];
    
    [self initTimer];
}

-(void)sureBtnPressed:(id)sender
{
    NSDate *tempDate = [NSDate dateWithTimeIntervalSince1970:[self.myModel.spike_started_at doubleValue]];
    NSTimeInterval timetrave = [tempDate timeIntervalSinceNow];
    if (timetrave > 0) {
        UIAlertView *start = [[UIAlertView alloc] initWithTitle:nil message:@"秒拍还为开始，请您耐心等待!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [start show];
        return;
    }
    
    if ([self.myModel.spike_has_order isEqualToString:@"1"]) {
        UIAlertView *start = [[UIAlertView alloc] initWithTitle:nil message:@"您已经秒拍成功!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [start show];
        return;
    
    }

    
    [TTReqEngine C_GetSpike_RushSetID:self.myModel.spike_id
                              withUid:[DLAppData sharedInstance].myUserKey
                        withTimestamp:self.myModel.timestamp
                            withBlock:^(BOOL success, id dataModel) {
                                if (success) {
                                    M_SpikeRushModel *tempData= (M_SpikeRushModel *)dataModel;
                                    [self successSpikeRush:tempData];
                                    [self getDetailsData];
                                    self.backBlock(YES);
                                    [SVProgressHUD showSuccessWithStatus:@"秒拍成功"];
                                    [self.mySureBtn setUserInteractionEnabled:NO];
                                    [self.mySureBtn setTitle:@"已经秒成拍功" forState:UIControlStateNormal];
                                    [self.mySureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                    [self.mySureBtn setBackgroundColor:[UIColor lightGrayColor]];
                                    self.myModel.spike_has_order=@"1";

                                }
                            }];
}

-(void)initData
{
    //self.mySureBtn.hidden = YES;
    
    [self getDetailsData];
}


-(void)initLineData
{
    [self.myDataArray removeAllObjects];
    
    M_DetailIconTextModel* temoITItem = [M_DetailIconTextModel allocInstance];
    temoITItem.myText = @"产品参数";
    temoITItem.myImage = @"icon_spec.png";
   NSString *str = [NSString stringWithFormat:@"%@/customservice?car_id=%@&type=parameter",KH5Host,self.myModel.myCar_Id];
    temoITItem.myUrl = str;
    temoITItem.myTag = 1;
    [self.myDataArray addObject:temoITItem];
    
    temoITItem = [M_DetailIconTextModel allocInstance];
    temoITItem.myText = @"售后政策";
    temoITItem.myImage = @"icon_shou.png";
    str = [NSString stringWithFormat:@"%@/customservice?car_id=%@&type=policy",KH5Host,self.myModel.myCar_Id];
    temoITItem.myUrl = str;
    temoITItem.myTag = 2;
    [self.myDataArray addObject:temoITItem];
    

//    temoITItem = [M_DetailIconTextModel allocInstance];
//    temoITItem.myText = @"活动说明";
//    temoITItem.myImage = @"icon_sound2.png";
//    str = [NSString stringWithFormat:@"%@/customservice?car_id=%@&type=hire&city_id=%@",KH5Host,self.myModel.myCar_Id,APPDELEGATE.viewController.myCityModel.myCity_Id];
//    temoITItem.myUrl = str;
//    temoITItem.myTag = 3;
//    [self.myDataArray addObject:temoITItem];
    
    self.carAction = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.baseView.frame.size.width, 400)];
    self.carAction.delegate = self;
    [self.carAction loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.myModel.myCarUrl_Info]]];

}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    CGRect frame = webView.frame;
    webView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height+20);
    webView.scrollView.scrollEnabled = NO;
    self.myTableView.tableFooterView = webView;
}
-(void)successSpikeRush:(M_SpikeRushModel *)model
{
    D_PayViewController* tempController=  [D_PayViewController allocInstance];
//    tempController.myItemModel = self.itemModel.car;
//    tempController.myDealerItemModel = self.itemModel.myDealerModel;
    tempController.order_id = model.spikeRush_id;
    tempController.order_num= model.spikeRush_id;
    tempController.myDealerId = model.spikeRush_dealer_id;
    
    __weak D_PayViewController* tempCon = tempController;
    tempController.block = ^(NSInteger tag){
        if (tag == 0) {
            [tempCon.navigationController popViewControllerAnimated:NO];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    };
//
    [self.navigationController pushViewController:tempController animated:YES];
}
-(void)getDetailsData
{
    [TTReqEngine C_GetSpike_InfoSetID:self.spike_id
                           withSetUid:[DLAppData sharedInstance].myUserKey
                            withBlock:^(BOOL success, id dataModel) {
                                     if (success) {
                                         
                                         self.myModel = (M_SpikeItemModel*)dataModel;
                                         
                                         if ([self.myModel.myCar_Id notEmpty]) {
                                         
                                             [self upDataTitle];
                                             if ([self.myModel.timestamp notEmpty] &&
                                                 [self.myModel.spike_ended_at notEmpty] &&
                                                 [self.myModel.spike_started_at notEmpty]) {
                                                 
                                                 NSTimeInterval secondsInterval1 = [self.myModel.spike_started_at doubleValue] - [self.myModel.timestamp doubleValue];
                                                 
                                                 NSTimeInterval secondsInterval2 = [self.myModel.spike_ended_at doubleValue] - [self.myModel.timestamp doubleValue];
                                                 
                                                 if (secondsInterval1>=0) {
                                                     
                                                     self.currState = 1;
                                                     NSLog(@"未开启");
                                                     
                                                     if ([self.myModel.myCar_Deposit notEmpty] ) {
                                                         self.mySureBtn.hidden = NO;
                                                         [self.mySeckillStateBtn setTitle:@"秒拍尚未开始" forState:UIControlStateNormal];
                                                         [self.mySureBtn setTitle:[NSString stringWithFormat:@"%@元订金 秒拍",self.myModel.myCar_Deposit] forState:UIControlStateNormal];
                                                         self.myTimerLabel.hidden = NO;
                                                         NSLog(@"测试这个方法是否一直走");
                                                     }
                                                     
                                                     if (secondsInterval2<0) {
                                                         [self.mySureBtn setUserInteractionEnabled:NO];
                                                         [self.mySeckillStateBtn setTitle:@"秒拍已结束" forState:UIControlStateNormal];
                                                         [self.mySureBtn setTitle:@"秒拍已结束" forState:UIControlStateNormal];
                                                         [self.mySureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                                         [self.mySureBtn setBackgroundColor:[UIColor lightGrayColor]];
                                                         self.currState = 3;
                                                         NSLog(@"秒拍结束");
                                                         [self stop];
                                                         self.myCurrTimerView.hidden = YES;
                                                     }
                                                 }else{
                                                     
                                                     self.currState = 2;
                                                     NSLog(@"正在秒拍");
                                                     if ([self.myModel.spike_isopened isEqualToString:@"0"] && [self.myModel.spike_has_order isEqualToString:@"1"]) {
                                                         NSLog(@"我以秒杀成功");
                                                         self.myTimerLabel.hidden = YES;
                                                         [self stop];
                                                         [self.mySeckillStateBtn setTitle:@"秒拍已结束" forState:UIControlStateNormal];
                                                         [self.mySureBtn setTitle:[NSString stringWithFormat:@"恭喜您，您已秒拍成功"] forState:UIControlStateNormal];
                                                         [self.mySureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                                         [self.mySureBtn setBackgroundColor:[UIColor lightGrayColor]];
                                                     }
                                                     else if([self.myModel.spike_isopened isEqualToString:@"0"] && [self.myModel.spike_has_order isEqualToString:@"0"])
                                                     {
                                                         NSLog(@"我秒拍失败，别人秒拍了");
//                                                         [self.mySureBtn setTitle:[NSString stringWithFormat:@"秒杀失败"] forState:UIControlStateNormal];
                                                         self.isMyRefresh = YES;
                                                         [self.mySureBtn setTitle:@"秒拍已结束" forState:UIControlStateNormal];
                                                         [self.mySeckillStateBtn setTitle:@"秒拍已结束" forState:UIControlStateNormal];
                                                         [self.mySureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                                         [self.mySureBtn setBackgroundColor:[UIColor lightGrayColor]];
                                                         self.myTimerLabel.hidden = YES;
                                                         [self stop];
                                                         
                                                         
                                                         
                                                     }
                                                     else if([self.myModel.spike_isopened isEqualToString:@"1"]&&[self.myModel.spike_has_order isEqualToString:@"1"])
                                                     {
                                                         NSLog(@"还在秒杀，我已秒拍成功");
                                                         self.myTimerLabel.hidden = YES;
                                                         [self stop];
                                                         [self.mySeckillStateBtn setTitle:@"秒拍已结束" forState:UIControlStateNormal];
                                                         [self.mySureBtn setTitle:[NSString stringWithFormat:@"恭喜您，您已秒拍成功"] forState:UIControlStateNormal];
                                                         [self.mySureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                                         [self.mySureBtn setBackgroundColor:[UIColor lightGrayColor]];
                                                         
                                                     }
                                                     else if([self.myModel.spike_isopened isEqualToString:@"1"] &&[self.myModel.spike_has_order isEqualToString:@"0"])
                                                     {
                                                         NSLog(@"已开启，我未秒拍");
                                                         [self.mySeckillStateBtn setTitle:@"秒拍进行中" forState:UIControlStateNormal];
                                                         self.mySureBtn.userInteractionEnabled = YES;
                                                         self.myTimerLabel.hidden = NO;
                                                         [self.mySureBtn setTitle:[NSString stringWithFormat:@"%@元订金 秒拍",self.myModel.myCar_Deposit] forState:UIControlStateNormal];
                                                         [self.mySureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                                         [self.mySureBtn setBackgroundColor:[UIColor redColor]];
                                                         
                                                     }
                                                     
                                                 }
                                             }
                                             else{
                                                 self.myCurrDate = nil;
                                                 //self.mySureBtn.hidden = YES;
                                                 self.myCurrTimerView.hidden = YES;
                                             }
                                            
                                             
                                            [self.myHeaderView updateData:self.myModel];
                                             
                                             [self initLineData];
                                             
                                             self.myTableView.tableHeaderView = self.myHeaderView;
                                             
                                             [self.myTableView reloadData];
                                             
                                             
                                             
//                                             if ([self.myModel.spike_isopened isEqualToString:@"1"]) {
//                                                 
//                                                 if ([self.myModel.timestamp notEmpty] &&
//                                                     [self.myModel.spike_ended_at notEmpty] &&
//                                                     [self.myModel.spike_started_at notEmpty]) {
//                                                     
//                                                     NSTimeInterval secondsInterval1 = [self.myModel.spike_started_at doubleValue] - [self.myModel.timestamp doubleValue];
//                                                     
//                                                     NSTimeInterval secondsInterval2 = [self.myModel.spike_ended_at doubleValue] - [self.myModel.timestamp doubleValue];
//                                                     
//                                                     if (secondsInterval1>=0) {
//                                                         
//                                                         self.currState = 1;
//                                                         NSLog(@"未开启");
//                                                         if (secondsInterval2<0) {
//                                                             
//                                                             self.currState = 3;
//                                                             NSLog(@"秒杀结束");
//                                                             [self stop];
//                                                             
//                                                             self.myCurrTimerView.hidden = YES;
//                                                         }
//                                                     }else{
//                                                         
//                                                         self.currState = 2;
//                                                         NSLog(@"正在秒杀");
//                                                     }
//                                                 }
//                                                 
//                                                 if ([self.myModel.myCar_Deposit notEmpty]) {
//                                                     self.mySureBtn.hidden = NO;
//                                                     [self.mySureBtn setTitle:[NSString stringWithFormat:@"%@元订金 秒杀",self.myModel.myCar_Deposit] forState:UIControlStateNormal];
//                                                 }
//                                             }else{
//                                                 self.myCurrDate = nil;
//                                                 //self.mySureBtn.hidden = YES;
//                                                 self.myCurrTimerView.hidden = YES;
//                                             }
//                                             
//                                             if ([self.myModel.spike_has_order notEmpty]) {
//                                                 if ([self.myModel.spike_has_order isEqualToString:@"1"]) {
//                                                     
//                                                     [self.mySureBtn setUserInteractionEnabled:NO];
//                                                     [self.mySureBtn setTitle:@"已经秒杀成功" forState:UIControlStateNormal];
//                                                     [self.mySureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//                                                     [self.mySureBtn setBackgroundColor:[UIColor lightGrayColor]];
//                                                 }
//                                             }
//                                             
//                                             [self.myHeaderView updateData:self.myModel];
//                                             
//                                             [self initLineData];
//                                             
//                                             self.myTableView.tableHeaderView = self.myHeaderView;
//                                         
//                                             [self.myTableView reloadData];
                                         }
                                     }
                                }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.myDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    DLTableViewCell* cell = [DLTableViewCell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    if ([self.myDataArray count]>indexPath.row) {
        M_DetailIconTextModel* tempItem = [self.myDataArray objectAtIndex:indexPath.row];
        if (tempItem!=nil) {
            cell.textLabel.text = tempItem.myText;
            cell.imageView.image = [UIImage imageNamed:tempItem.myImage];
        }
    }
    
    UIImageView* tempLine = [cell.contentView viewWithTag:1001];
    if (tempLine == nil) {
        tempLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, tableView.frame.size.width, 1)];
        tempLine.backgroundColor = RGBCOLOR(202, 202, 202);
        [cell.contentView addSubview:tempLine];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_DetailIconTextModel* tempItem = [self.myDataArray objectAtIndex:indexPath.row];
    if (tempItem!=nil) {
        [self toWebController:tempItem.myText withUrl:tempItem.myUrl];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self start];
    
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
    
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self stop];
}

-(void)upDataTitle
{
    [self.customNavBar updateTitle:self.myModel.myBrand_Name];
}

-(void)leftBtnPressed:(id)sender
{
    if(self.backBlock != nil)
    {
        self.backBlock(YES);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)toWebController:(NSString*)title withUrl:(NSString*)url
{
    D_WebViewController* tempController = [D_WebViewController allocInstance];
    tempController.myTitle = title;
    tempController.myUrl = url;
    [self.navigationController pushViewController:tempController animated:YES];
}


-(void)initTimer
{
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.myTimer forMode:NSRunLoopCommonModes];
    [self stop];
}

-(void)scrollTimer
{
    if (self.currState>0) {
        if (self.currState == 1) {
            NSString* tempStr = [Unity dayOrTime:self.myModel.spike_started_at];
            
            if (tempStr == nil||[tempStr isEqualToString:@"0秒"]) {

                [[NSNotificationCenter defaultCenter] postNotificationName:@"SpikeEnd" object:nil];
                self.myTimerLabel.text = @"秒拍已开始";
                [self.mySureBtn setUserInteractionEnabled:YES];
                [self.mySureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.mySureBtn setBackgroundColor:[UIColor redColor]];
                self.currState = 2;
            } else {
                self.myTimerLabel.text = [NSString stringWithFormat:@"秒拍还有%@开始",tempStr];
            }
            
        }else if (self.currState == 2){
            NSString* tempStr = [Unity dayOrTime:self.myModel.spike_ended_at];
            if (tempStr == nil||[tempStr isEqualToString:@"0秒"]) {
                //首页更新数据
//                self.mySureBtn.hidden = YES;
//                self.mySureBtn.enabled = NO;
                self.myTimerLabel.text = @"秒拍已结束";
                [self.mySureBtn setUserInteractionEnabled:NO];
                [self.mySureBtn setTitle:@"秒拍已结束" forState:UIControlStateNormal];
                [self.mySureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.mySureBtn setBackgroundColor:[UIColor lightGrayColor]];
                [self stop];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SpikeEnd" object:nil];
            }
            else {
                self.myTimerLabel.text = [NSString stringWithFormat:@"秒拍还有%@结束",tempStr];
//                if ([self.myModel.spike_has_order isEqualToString:@"1"]) {
//                    [self.mySureBtn setUserInteractionEnabled:NO];
//                    [self.mySureBtn setTitle:@"已经秒杀成功" forState:UIControlStateNormal];
//                    [self.mySureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//                    [self.mySureBtn setBackgroundColor:[UIColor lightGrayColor]];
//                }else{
//                    [self.mySureBtn setUserInteractionEnabled:YES];
//                    [self.mySureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//                    [self.mySureBtn setBackgroundColor:[UIColor redColor]];
//                }

            }
        }

        
    }
}

-(void)start
{
    //开启定时器
    [self.myTimer setFireDate:[NSDate distantPast]];
}
-(void)stop
{
    //关闭定时器
    [self.myTimer setFireDate:[NSDate distantFuture]];
}

-(void)afterInterval:(float)interval
{
    [self.myTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
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
