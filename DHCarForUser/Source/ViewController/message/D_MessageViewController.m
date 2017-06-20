//
//  D_MessageViewController.m
//  DHCarForSales
//
//  Created by lucaslu on 15/10/31.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_MessageViewController.h"
#import "TTReqEngine.h"
#import "M_MessageMode.h"
#import "M_MessageFirstCell.h"
#import "DLView.h"
#import "D_CommunicateViewController.h"
#import "M_MymessageListModel.h"

#import "LL_MessageView.h"
#import "LL_SystemMessageVIew.h"

#import "D_CommunicateViewController.h"

#import "M_CarMessageDetailModel.h"
#import "LL_SysteMessageDetailViewController.h"
#import "LL_SystemModel.h"

@interface D_MessageViewController ()<MyDelegate>

AS_MODEL_STRONG(UISegmentedControl, mySegmentControl);
AS_MODEL_STRONG(LL_MessageView, myMessageView);
AS_MODEL_STRONG(LL_SystemMessageView, mySystemMessageView);

@end

@implementation D_MessageViewController

DEF_FACTORY(D_MessageViewController);
DEF_MODEL(myMessageView);
DEF_MODEL(mySystemMessageView);
DEF_MODEL(mySegmentControl);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initView];
    [self initData];
}

-(void)initView
{
    [self addCustomNavBar:@"消息中心"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    
    [self createHeadSecreamentConroller];
   
    [self createMessageView];
    
    [self createSystemMessageView];
    
}
-(void)createHeadSecreamentConroller
{
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, 60)];
    
    headView.backgroundColor=[Unity getColor:@"#ededed"];
    
    self.mySegmentControl = [[UISegmentedControl alloc]initWithItems:@[@"询价消息",@"系统通知"]];
    
     self.mySegmentControl.frame=CGRectMake(10, 8, SCREEN_WIDTH-16, 40);
   
    self.mySegmentControl.selectedSegmentIndex=0;
    
    self.mySegmentControl.tintColor=[UIColor redColor];
    
    self.mySegmentControl.momentary=NO;
    
    self.mySegmentControl.backgroundColor=[Unity   getColor:@"#ffffff"];
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    tempDic[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    tempDic[NSForegroundColorAttributeName] = [Unity getColor:@"#333333"];
    
    [self.mySegmentControl setTitleTextAttributes:tempDic forState:UIControlStateNormal];
    
    [self.mySegmentControl addTarget:self action:@selector(clickSegmentAndChangeView) forControlEvents:UIControlEventValueChanged];
    
    [headView addSubview:self.mySegmentControl];
    
    [self.baseView addSubview:headView];
    
    self.mySegmentControl.selectedSegmentIndex = 0;
   
}
-(void)createMessageView
{
    self.myMessageView = [LL_MessageView allocInstanceFrame:CGRectMake(0, NavigationBarHeight+60, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight-60)];
    __weak D_MessageViewController *tempSelf = self;

    self.myMessageView.block =^(NSInteger tag,id data)
    {
        if (tag == 0) {
            [tempSelf getMessageViewData];
        }else if (tag == 1){
            M_MyMessageItemModel* tempModel = (M_MyMessageItemModel*)data;
            if (tempModel!=nil) {
                D_CommunicateViewController *communicate = [[D_CommunicateViewController alloc]init];
                if([tempModel.myToModel.user_id isEqualToString:[DLAppData sharedInstance].myUserKey])
                {
                    communicate.myTargetUid = tempModel.myFromModel.user_id;
                     communicate.myTitle  = tempModel.myFromModel.user_nick;
                    [communicate upDataMyTitle:tempModel.myFromModel.user_name];
                }
                else{
                    
                    communicate.myTargetUid = tempModel.myToModel.user_id;
                    communicate.myTitle  = tempModel.myToModel.user_nick;
                     [communicate upDataMyTitle:tempModel.myToModel.user_name];
                }

                communicate.myQuotedId = tempModel.myGroup;
                [tempSelf.navigationController pushViewController:communicate animated:YES];
            }
        }
    };
    self.myMessageView .hidden = NO;
    [self.baseView addSubview:self.myMessageView];
    
}
-(void)createSystemMessageView
{
    self.mySystemMessageView = [LL_SystemMessageView allocInstanceFrame:CGRectMake(0, NavigationBarHeight+60, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight-60)];
    
    __weak D_MessageViewController *tempSelf = self;
    self.mySystemMessageView.block = ^(NSInteger tag ,id data){
//        [tempSelf getSystemViewData];
        switch (tag) {
            case 0:
            {
                [tempSelf getSystemViewData];
            }
                break;
            case 1:
            {
                LL_SysteMessageDetailViewController *tempView = [[LL_SysteMessageDetailViewController alloc]init];
                LL_SystemModel *selectData = (LL_SystemModel*)data;
                tempView.contentModel = selectData;
                [tempSelf.navigationController pushViewController:tempView animated:YES];
            }
                break;
   
            default:
                break;
        }
    };
    self.mySystemMessageView.hidden = YES;
    [self.baseView addSubview:self.mySystemMessageView];
}
#pragma mark MyDelegate
-(void)successGoBackAndRefreshViewController
{
    [self getMessageViewData];
}
-(void)clickSegmentAndChangeView
{
    switch (self.mySegmentControl.selectedSegmentIndex) {
        case 0:
        {
            self.myMessageView.hidden = NO;
            self.mySystemMessageView.hidden = YES;
            if (self.myMessageView.myDataArray.count == 0) {
                [self getMessageViewData];
            }
        }
            break;
        case 1:
        {
            self.myMessageView.hidden = YES;
            self.mySystemMessageView.hidden = NO;
            if (self.mySystemMessageView.myDataArray.count == 0) {
                [self.mySystemMessageView resetGetData];
            }
        }
            break;
        default:
            break;
    }
}

-(void)getMessageViewData
{
    [TTReqEngine C_GetIm_GrouplistSetUid:[DLAppData sharedInstance].myUserKey
                               withBlock:^(BOOL success, id dataModel) {
                                   if (success) {
                                       
                                       M_MyMessageModel* tempModel = (M_MyMessageModel*)dataModel;
                                       if (tempModel!=nil) {
                                           [self.myMessageView updateData:tempModel.myItemArray];
                                       }
                                       if([self.myMessageView.myDataArray count]==0)
                                       {
                                           [self.myMessageView showPageError:YES withIsError:NO];
                                       }
                                   }else{
                                       [self.myMessageView showPageError:YES withIsError:YES];
                                   }
                               }];
}
-(void)getSystemViewData
{
    [TTReqEngine C_PostUser_GetSystemImList:APPDELEGATE.viewController.myUserModel.user_id
                    andWithLimit:self.mySystemMessageView.myPageModel.limit
                    andWithpage:nil
                    andWithMax:self.mySystemMessageView.myPageModel.lastMax
                    andWithBlock:^(BOOL success, id dataModel)
     {
         if (success) {
             
             LL_SystemModelArr *systemDataArr = (LL_SystemModelArr *)dataModel;
             if (systemDataArr != nil) {
                 
                 [self.mySystemMessageView.myPageModel toData:systemDataArr.myPageModel];
                
                 [self.mySystemMessageView updateData:systemDataArr.myDataArr];
                 if([self.mySystemMessageView.myDataArray count] ==0)
                 {
                     [self.mySystemMessageView showPageError:YES withIsError:NO];
                 }
                 
             }
             
         }else{
             [self.mySystemMessageView showPageError:YES withIsError:YES];
         }
         [self.mySystemMessageView updateListState:success];
    }];

}

-(void)setShowSysteView
{
    [self clickSegmentAndChangeView];
}
-(void)initData
{
    [self getMessageViewData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
}

-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
