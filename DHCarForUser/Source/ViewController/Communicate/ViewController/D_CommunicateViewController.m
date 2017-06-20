//
//  D_CommunicateViewController.m
//  DHCarForSales
//
//  Created by leiyu on 15/11/3.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_CommunicateViewController.h"

#import "M_CommunicateCell.h"
#import "TTReqEngine.h"
#import "DLPlaceHolderTextView.h"

#import "M_MymessageListModel.h"
#import "M_CarMessageDetailModel.h"
#import "M_MyOrdelListModel.h"
#import "M_UserInfoModel.h"
#import "D_selfUserInfoMationController.h"
#import "LL_SendBaoJiaInfoCell.h"
#import "LL_CarHeadView.h"
#import "LL_OrderDetailViewController.h"
#import "D_ReserveViewController.h"
#import "D_PayViewController.h"
#import "D_LLDetailOrderViewController.h"

#define car_NameSize 12
#define  messageTextSize 14
#define timeDateSize 14
#define posterHeadViewHeight 50
#define posterHeadViewWidth 50
#define MAXITEMCOUNT @"999999999"

@interface D_CommunicateViewController ()<UITextViewDelegate>
AS_MODEL_STRONG(LL_CarHeadView, myCarHeadView);
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *myCarNameLable;
@property(nonatomic,strong)UILabel *myCarDescriptionLable;
@property(nonatomic,strong)UILabel *myDestipLable;
@property(nonatomic,strong)UILabel *myDestipPriceLable;
@property(nonatomic,strong)UILabel *myTimerLable;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UIView *footView;
@property(nonatomic,strong)DLPlaceHolderTextView *textView;
@property(nonatomic,strong)M_MyOrderItemModel *myOrderItemModel;
@property(nonatomic,strong)M_UserInfoModel *myUserInfoModel;
@property(nonatomic,assign)int myMessageCount;
AS_MODEL_STRONG(M_QuoteItemModel, myQuoteModel);
AS_INT(myFirstLastMax);

AS_MODEL_STRONG(DLPageModel, myPageModel);

AS_BOOL(isRefreshing);
AS_BOOL(isLoadingMore);

AS_MODEL_STRONG(NSTimer, myTimer);

AS_BOOL(isTimerData);

@end

@implementation D_CommunicateViewController


DEF_MODEL(isLoadingMore);
DEF_MODEL(isRefreshing);

DEF_MODEL(myTimer);

DEF_MODEL(myCarHeadView);

DEF_MODEL(myFirstLastMax);
DEF_MODEL(myTitle);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.myFirstLastMax = 0;
    
    [self.baseView setBackgroundColor:[Unity getGrayBackColor]];
    
    self.myPageModel = [DLPageModel allocInstance];
    
    [self initView];
    
    [self initTimer];
    
    [self getData];
}
-(void)initView
{
    [self addCustomNavBar:self.myTitle
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
   
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight+150, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight*2-150) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    
    self.myTableView.backgroundColor = [Unity getGrayBackColor];
    
    __weak D_CommunicateViewController* tempself = self;
    
    [self.myTableView addPullToRefreshWithActionHandler:^{
        
        if (tempself.isLoadingMore || tempself.isRefreshing) {
            return;
        }
        
        tempself.isLoadingMore = YES;
        
        [tempself initData];
    }];
    
    [self createHeadView];
}

-(void)getData
{
    self.myPageModel.nextMax = @"";
    
    self.isRefreshing =YES;
    
    [self getMessageDateWith:@"1"];
}

-(void)send:(NSString *)text
{
    [TTReqEngine C_PostIm_SendSetfrom:[DLAppData sharedInstance].myUserKey
                               withTo:self.myTargetUid
                withInquiry_quoted_id:self.myQuotedId
                          withContent:text
                             withType:@"txt"
                            withBlock:^(BOOL success, id dataModel) {
                                if (success) {
                                    
                                    self.commentView.myTextField.text = @"";
                                    
                                    [self scrollTimer];
                                   
                                }
                            }];
}

-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.myDelegate successGoBackAndRefreshViewController];
}

-(void)createHeadView
{
    self.myCarHeadView = [[LL_CarHeadView alloc]initWithFrame:CGRectMake(10, NavigationBarHeight+10, self.baseView.frame.size.width-20, 140)];
    __weak D_CommunicateViewController* tempSelf = self;
    self.myCarHeadView.myBlock = ^(id data){
        NSLog(@"支付");
        [tempSelf createOrderToPay];
    };
    [self.myCarHeadView.layer setMasksToBounds:YES];
    [self.myCarHeadView.layer setCornerRadius:5];
    [self.baseView addSubview:self.myCarHeadView];
}

-(void)createOrderToPay
{
    if (self.myCarHeadView.myItemModel.myOrderModel!=nil) {
        
        if ([self.myCarHeadView.myItemModel.myOrderModel.order_step notEmpty]) {
            if (![self.myCarHeadView.myItemModel.myOrderModel.order_step isEqualToString:@"0"]) {
                
                D_LLDetailOrderViewController* tempController = [D_LLDetailOrderViewController allocInstance];
                tempController.orderID = self.myCarHeadView.myItemModel.myOrderModel.order_id;
                [self.navigationController pushViewController:tempController animated:YES];
                
            }else{
                D_PayViewController* tempController = [D_PayViewController allocInstance];
                tempController.myItemModel = self.myCarHeadView.myItemModel.myInquiryModel.car;
                tempController.order_id = self.myCarHeadView.myItemModel.myOrderModel.order_id;
                tempController.order_num = self.myCarHeadView.myItemModel.myOrderModel.order_no;
                
                __weak D_PayViewController* tempCon = tempController;
                tempController.block = ^(NSInteger tag){
                    if (tag == 0) {
                        [tempCon.navigationController popViewControllerAnimated:YES];
                    }
                };
                
                [self.navigationController pushViewController:tempController animated:YES];
            }
        }
        
    }else{
        
        D_ReserveViewController* tempController = [D_ReserveViewController allocInstance];
        tempController.myItemModel = self.myCarHeadView.myItemModel.myInquiryModel.car;
        tempController.myDealerItemModel = self.myCarHeadView.myItemModel.myDealerModel;
        tempController.carType = EB_NewCar;
        tempController.myInquiry_Quoted_Id = self.myCarHeadView.myItemModel.myQuoteId;
        [self.navigationController pushViewController:tempController animated:YES];
        
        tempController.block = ^(NSInteger tag){
            if (tag == 0) {
                [self getData];
            }
        };
    }
}

-(void)judegTimeButtonShowOrNot
{
    M_MyMessageItemModel *firstModel=[self.myDataArray firstObject];
   
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *tempBudgeDate=[dateFormatter dateFromString:firstModel.myTimer];
    
    for (M_MyMessageItemModel *model in self.myDataArray) {
      
        NSDate *tempDate=[dateFormatter dateFromString:model.myTimer];
        if ([tempBudgeDate timeIntervalSinceDate:tempDate]==0) {
            model.timeButtonShowOrNot=YES;
        }
        else if ([tempBudgeDate timeIntervalSinceDate:tempDate]>-3600)
        {
            model.timeButtonShowOrNot=NO;
        }
        else if ([tempBudgeDate timeIntervalSinceDate:tempDate]<-3600)
        {
            model.timeButtonShowOrNot=YES;
            tempBudgeDate=tempDate;
        }
    }
}
-(CGFloat)getLbaleWidthWithString:(NSString *)string andFontSize:(CGFloat )fontSize
{
    return [string sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}].width;
}
-(void)buttonAction:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initData
{
    [self getMessageDateWith:@"2"];
}

-(void)getMessageDateWith:(NSString *)getType
{
//    if (!self.isTimerData) {
//        [SVProgressHUD showWithStatus:@"请稍候..."];
//    }
    
    NSString* tempMin = @"";
    NSString* temoMax = @"";
    
    if ([getType isEqualToString:@"2"] && self.myFirstLastMax == 0) {
        tempMin= self.myPageModel.lastMax;
    }else if([getType isEqualToString:@"2"] && self.myFirstLastMax != 0)
    {
        tempMin = [NSString stringWithFormat:@"%ld",(long)self.myFirstLastMax];
    }
    else if ([getType isEqualToString:@"1"]){
        temoMax = self.myPageModel.nextMax;
    }
    
    [TTReqEngine C_GetIm_ListSetUid:[DLAppData sharedInstance].myUserKey
                     withTarget_uid:self.myTargetUid
              withInquiry_quoted_id:self.myQuotedId
                          withLimit:self.myPageModel.limit
                            withMin:tempMin
                            withMax:temoMax
                          withBlock:^(BOOL success, id dataModel) {
                              if (success) {
                                  
                                  M_CarMessageDetailModel* tempModel = (M_CarMessageDetailModel*)dataModel;
                                  
                                  if (tempModel!=nil) {
                                      if([tempModel.myItemArray count]>0 &&([self.myTitle isEqualToString:@""] || self.myTitle == nil))
                                      {
                                          M_MyMessageItemModel *messageModel = [tempModel.myItemArray firstObject];
                                          if (![messageModel.myFromModel.user_id isEqualToString:APPDELEGATE.viewController.myUserModel.user_id]) {
                                              self.myTitle = messageModel.myFromModel.user_name;
                                              [self.customNavBar updateTitle:self.myTitle];
                                          }
                                      }
                                      [self.myCarHeadView updateData:tempModel.myQuoteModel];
                                      //
                                      //
                                      if (self.isRefreshing) {
                                          [self.myDataArray removeAllObjects];
                                      }
                                      self.myQuoteModel = tempModel.myQuoteModel;
                                      
                                      if ([tempModel.myItemArray count]>0) {
                                          
                                          if ([getType isEqualToString:@"2"]) {
                                          
                                              self.myPageModel.lastMax = tempModel.myPageModel.lastMax;
                                              
                                              for (int i=(int)[tempModel.myItemArray count]-1; i>-1; i--) {
                                                  M_MyMessageItemModel* temoItem = [tempModel.myItemArray objectAtIndex:i];
                                                  if (temoItem!=nil) {
                                                      [self.myDataArray insertObject:temoItem atIndex:0];
                                                  }
                                              }
                                              
                                          }else if ([getType isEqualToString:@"1"]){
                                              
                                              if (self.isRefreshing) {
                                                  [self.myPageModel toData:tempModel.myPageModel];
                                              }else{
                                                  self.myPageModel.nextMax = tempModel.myPageModel.nextMax;
                                              }
                                              
                                              [self.myDataArray addObjectsFromArray:tempModel.myItemArray];
                                          }
                                      }
                                      
                                      [self.myTableView reloadData];
                                      
                                      [self toBottom];
                                  }
                              }
                               [self updateListState:success];
                          }];

}
-(void)upDataMyTitle:(NSString *)myTitleaaaa
{
    self.myTitle = myTitleaaaa;
    [self.customNavBar updateTitle:myTitleaaaa];
}
-(void)toBottom
{
    if ([self.myDataArray count] >0) {
        [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.myDataArray count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }

}

-(void)updateListState:(BOOL)success
{
    if (success) {
        [self closeRefresh];
    }else{
        [self tableViewDidFinishedLoadingWithReachedTheEnd:YES];
    }
    
    if (self.isTimerData) {
        self.isTimerData = NO;
    }
}

-(void)closeRefresh
{
    [self tableViewDidFinishedLoadingWithReachedTheEnd:YES];
}

- (void)tableViewDidFinishedLoadingWithReachedTheEnd:(BOOL)reachedTheEnd
{
    if (self.isLoadingMore) {
        self.isLoadingMore = NO;
        [self.myTableView.pullToRefreshView stopAnimating];
        if (reachedTheEnd) {
            self.myTableView.infiniteScrollingView.enabled = NO;
        }
    }
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        [self.myTableView.infiniteScrollingView stopAnimating];
        self.myTableView.infiniteScrollingView.enabled = YES;
        if (reachedTheEnd) {
            self.myTableView.infiniteScrollingView.enabled = NO;
        }
    }
}


#pragma mark tableViewDelegete
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.myDataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if ([self.myDataArray count]>indexPath.row) {
        
        M_MyMessageItemModel *model=self.myDataArray[indexPath.row];
        if (model!=nil) {
            //类型 0文字 1图片 2音频 3视频 80首次报价 81最终报价 99系统提示
            if ([model.myType notEmpty]) {
            
                if ([model.myType isEqualToString:@"0"] ||
                    [model.myType isEqualToString:@"1"] ||
                    [model.myType isEqualToString:@"2"] ||
                    [model.myType isEqualToString:@"3"] ) {
                    M_CommunicateCell *cell=[M_CommunicateCell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
                    [cell updateData:model];
                    cell.myBlock = ^(NSInteger tag ,M_MyMessageItemModel *model)
                    {
                        
                        NSLog(@"ssdda123456");
                        if (tag == 0) {
                            if (![model.myFromModel.user_id isEqualToString:APPDELEGATE.viewController.myUserModel.user_id]) {
                                D_selfUserInfoMationController *view=[[D_selfUserInfoMationController alloc]init];
                                [view upDateWithMessage:model andWithDealerModel:self.myCarHeadView.myItemModel.myDealerModel];
                                [self.navigationController pushViewController:view animated:YES];
                            }
                        }
                    };
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    return cell;
                }else if ([model.myType isEqualToString:@"80"]||
                          [model.myType isEqualToString:@"81"]){
                    LL_SendBaoJiaInfoCell *cell = [LL_SendBaoJiaInfoCell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault identifier:@"LL_SendBaoJiaInfoCell"];
                    [cell updataItem:model];
                    cell.myBlock = ^(NSInteger tag,id data){
                        
                        if (tag == 0) {
                            
                            LL_OrderDetailViewController *tempController = [[LL_OrderDetailViewController alloc]init];
                            if ([model.myType isEqualToString:@"80"]) {
//                                tempController.title = @"首次报价";
                            }else if ([model.myType isEqualToString:@"81"]){
//                                tempController.title = @"最终报价";
                            }
                            tempController.myEntry = @"message";
                            
                            tempController.myQuotedId = self.myCarHeadView.myItemModel.myQuoteId;
                            
                            [self.navigationController pushViewController:tempController animated:YES];
                        }else if (tag == 1){
                            
                            D_selfUserInfoMationController *view=[[D_selfUserInfoMationController alloc]init];
//                            view.salesInfoModel=model;
//                            view.myDealerItemModel = self.myCarHeadView.myItemModel.myDealerModel;
                            [view upDateWithMessage:model andWithDealerModel:self.myCarHeadView.myItemModel.myDealerModel];
                            [self.navigationController pushViewController:view animated:YES];
                        }
                        
                    };
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    return cell;
                }else if ([model.myType isEqualToString:@"99"]){
                    
                }
            }
        }
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_MyMessageItemModel *model=self.myDataArray[indexPath.row];
    
    if ([model.myType notEmpty]) {
        
        if ([model.myType isEqualToString:@"0"] ||
            [model.myType isEqualToString:@"1"] ||
            [model.myType isEqualToString:@"2"] ||
            [model.myType isEqualToString:@"3"] ) {
            
            CGFloat messageLableWidth=[self getLbaleWidthWithString:model.myContent andFontSize:messageTextSize];
            CGFloat maxLableWidth=[UIScreen mainScreen].bounds.size.width-20-posterHeadViewWidth-10-20-20-30;//聊天信息的
            if(model.timeButtonShowOrNot)
            {
                CGFloat totalHeightOne=10+30+10+posterHeadViewHeight+20;
                CGFloat totalHeightTwo=10+30+10+20;
                CGFloat textLableHeight;
                if (messageLableWidth>maxLableWidth)
                {
                    textLableHeight=[Unity getLabelHeightWithWidth:maxLableWidth andDefaultHeight:0 andFontSize:messageTextSize andText:model.myContent];
                    totalHeightTwo=totalHeightTwo+10+textLableHeight+10;
                    return MAX(totalHeightOne, totalHeightTwo);
                }
                else if(messageLableWidth<maxLableWidth)
                {
                    textLableHeight=[Unity getLabelHeightWithWidth:messageLableWidth andDefaultHeight:0 andFontSize:messageTextSize andText:model.myContent];
                    totalHeightTwo=totalHeightTwo+10+textLableHeight+10;
                    return MAX(totalHeightOne, totalHeightTwo);
                }
            }
            else
            {
                CGFloat totalHeightOne=10+posterHeadViewHeight+20;
                CGFloat totalHeightTwo=10+20;
                CGFloat textLableHeight;
                if (messageLableWidth>maxLableWidth)
                {
                    textLableHeight=[Unity getLabelHeightWithWidth:maxLableWidth andDefaultHeight:0 andFontSize:messageTextSize andText:model.myContent];
                    totalHeightTwo=totalHeightTwo+10+textLableHeight+10;
                    return MAX(totalHeightOne, totalHeightTwo);
                }
                else if(messageLableWidth<maxLableWidth)
                {
                    textLableHeight=[Unity getLabelHeightWithWidth:messageLableWidth andDefaultHeight:0 andFontSize:messageTextSize andText:model.myContent];
                    totalHeightTwo=totalHeightTwo+10+textLableHeight+10;
                    return MAX(totalHeightOne, totalHeightTwo);
                }
            }
            
        }else if ([model.myType isEqualToString:@"80"]||
                  [model.myType isEqualToString:@"81"]){
            return 120;
        }else if ([model.myType isEqualToString:@"99"]){
            return 40;
        }
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_MyMessageItemModel *model=self.myDataArray[indexPath.row];
    if (model!=nil) {
        //类型 0文字 1图片 2音频 3视频 80首次报价 81最终报价 99系统提示
        if ([model.myType notEmpty]) {
            
            if ([model.myType isEqualToString:@"0"] ||
                [model.myType isEqualToString:@"1"] ||
                [model.myType isEqualToString:@"2"] ||
                [model.myType isEqualToString:@"3"] ) {
                
                    NSLog(@"ssdda123456");
                
                        if (![model.myFromModel.user_id isEqualToString:APPDELEGATE.viewController.myUserModel.user_id]) {
                            D_selfUserInfoMationController *view=[[D_selfUserInfoMationController alloc]init];
                            [view upDateWithMessage:model andWithDealerModel:self.myCarHeadView.myItemModel.myDealerModel];
                            [self.navigationController pushViewController:view animated:YES];
                        }
            }
        }
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stop];
    [_footView removeFromSuperview];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self start];
}

-(void)initTimer
{
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
    [self stop];
}

-(void)scrollTimer
{
    if (self.isLoadingMore || self.isRefreshing||self.isTimerData) {
        return;
    }
    
    self.isTimerData = YES;
    
    [self getMessageDateWith:@"1"];
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
    
}

@end
