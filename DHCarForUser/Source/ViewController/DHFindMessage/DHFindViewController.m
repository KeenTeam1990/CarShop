//
//  DHFindViewController.m
//  DHCarForUser
//
//  Created by 张海亮 on 16/3/24.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DHFindViewController.h"
#import "DHFindTableCell.h"
#import "D_WebViewController.h"
#import "TTReqEngine.h"
#import "Dh_TitleModel.h"
#import "DH_UserMessageView.h"
#import "DH_CreateMessageView.h"
#import "DH_DealerMessageView.h"
@interface DHFindViewController ()
AS_BOOL(isRefreshing);
AS_BOOL(isLoadingMore);
AS_MODEL_STRONG(DH_UserMessageView, myUserMessageView);
AS_MODEL_STRONG(DH_CreateMessageView, myCreateMessageView);
AS_MODEL_STRONG(DH_DealerMessageView, myDealerMessageView);
AS_MODEL_STRONG(DLPageModel, myUserModel);
AS_MODEL_STRONG(DLPageModel, myCreateModel);
AS_MODEL_STRONG(DLPageModel, myDealerModel);
AS_MODEL_STRONG(UISegmentedControl, mySegmentControl);
AS_BOOL(changeCreateTitle);

@end

@implementation DHFindViewController
DEF_MODEL(isLoadingMore);
DEF_MODEL(isRefreshing);
DEF_MODEL(myUserMessageView);
DEF_MODEL(myCreateMessageView);
DEF_MODEL(myDealerMessageView);
DEF_MODEL(myUserModel);
DEF_MODEL(myCreateModel);
DEF_MODEL(myDealerModel);
DEF_MODEL(changeCreateTitle);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.changeCreateTitle = NO;
    
    self.myUserModel = [DLPageModel allocInstance];
    self.myCreateModel = [DLPageModel allocInstance];
    self.myDealerModel = [DLPageModel allocInstance];

    [self initView];
   //self.myDealerMessageView.myTableView  trat
    [self.myCreateMessageView resetGetData];

}
-(void)initData
{
    [TTReqEngine C_GetArticle_List_Get:@"10" withPage:@"0" withMax:nil withCityId:APPDELEGATE.viewController.myUserModel.city_id withType:@"0" withBlock:^(BOOL success, id dataModel) {
        if (success) {
            Dh_TitleModel *model = (Dh_TitleModel *)dataModel;
            [self.myTableView reloadData];
            [SVProgressHUD showSuccessWithStatus:model.run_mess];
        }
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:YES];
    //NSURL *url =  [NSURL URLWithString:@"http://www.baidu.com"];

}

-(void)initView
{
    [self addCustomNavBar:@"发现"
              withLeftBtn:nil
             withRightBtn:nil
            withLeftLabel:nil
           withRightLabel:nil];
    self.baseView.backgroundColor = [UIColor colorWithRed:0.93725 green:0.93725 blue:0.93725 alpha:1.0];
    
    [self createHeadSecreamentConroller];
    [self makeDealerMessageTableView];
    //[self makeUserMessageTableView];
    [self makeCreateMessageTableView];
}
-(void)createHeadSecreamentConroller
{
   
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, 60)];
    
    headView.backgroundColor=[UIColor whiteColor];
    
    self.mySegmentControl = [[UISegmentedControl alloc]initWithItems:@[@"原创",@"经销商"]];
    
    self.mySegmentControl.frame=CGRectMake(10, 8, SCREEN_WIDTH-16, 40);
    
    self.mySegmentControl.selectedSegmentIndex=0;
    
    self.mySegmentControl.tintColor=[UIColor redColor];
    
    self.mySegmentControl.momentary=NO;
    
    self.mySegmentControl.backgroundColor=[Unity   getColor:@"#ffffff"];
    NSMutableDictionary *tempDic = [NSMutableDictionary allocInstance];
    tempDic[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    tempDic[NSForegroundColorAttributeName] = [Unity getColor:@"#333333"];
    
    [self.mySegmentControl setTitleTextAttributes:tempDic forState:UIControlStateNormal];
    
    [self.mySegmentControl addTarget:self action:@selector(loginTypeChange:) forControlEvents:UIControlEventValueChanged];
    
    [headView addSubview:self.mySegmentControl];
    
    [self.baseView addSubview:headView];
    
    self.mySegmentControl.selectedSegmentIndex = 0;
    
}

-(void)getDealerMessageViewData
{
    [TTReqEngine C_GetArticle_List_Get:self.myDealerMessageView.myPageModel.limit
                              withPage:nil
                               withMax:self.myDealerMessageView.myPageModel.nextMax
                            withCityId:APPDELEGATE.viewController.myUserModel.city_id
                              withType:@"1"
                             withBlock:^(BOOL success, id dataModel) {
        if (success) {
            Dh_TitleModel *model = (Dh_TitleModel *)dataModel;
            
            if (model!=nil) {
             
                [self.myDealerMessageView.myPageModel toData:model.myPageModel];
                
                [self.myDealerMessageView updateData:model.allTitle];
                
//                if (model.allTitle.count == 0) {
//                    [SVProgressHUD showSuccessWithStatus:@"暂无经销商文章!"];
//                } else {
//                    [SVProgressHUD showSuccessWithStatus:@"获取经销商文章成功!"];
//                }
            }
            
        }else{
            [self.myDealerMessageView showPageError:YES withIsError:YES];
        }
        
        [self.myDealerMessageView updateListState:success];
    }];
}
-(void)makeDealerMessageTableView
{
    self.myDealerMessageView = [DH_DealerMessageView allocInstanceFrame:CGRectMake(0, NavigationBarHeight+60, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight-60-TabBarHeight)];
    __weak DHFindViewController *tempSelf = self;
    
    self.myDealerMessageView.block =^(NSInteger tag,id data)
    {
        if (tag == 0) {
            [tempSelf getDealerMessageViewData];
        }else if (tag == 1){
            D_WebViewController *webView = [[D_WebViewController alloc] init];
            NSDictionary *titleData = (NSDictionary *)data;
            webView.myTitle = [titleData hasItemAndBack:@"title"];
            webView.myUrl = [titleData hasItemAndBack:@"tinyurl"];
            [tempSelf.navigationController pushViewController:webView animated:YES];
        }
    };
    
    self.myDealerMessageView.hidden = YES;
    [self.baseView addSubview:self.myDealerMessageView];
}
-(void)getUserMessageViewData
{
    [TTReqEngine C_GetArticle_List_Get:self.myUserMessageView.myPageModel.limit
                              withPage:nil
                               withMax:self.myUserMessageView.myPageModel.nextMax
                            withCityId:APPDELEGATE.viewController.myUserModel.city_id
                              withType:@"1"
                             withBlock:^(BOOL success, id dataModel) {
        if (success) {
            
            Dh_TitleModel *model = (Dh_TitleModel *)dataModel;
 
            if (model!=nil) {
                
                [self.myUserMessageView.myPageModel toData:model.myPageModel];
                
                [self.myUserMessageView updateData:model.allTitle];
            }
            
            [SVProgressHUD showSuccessWithStatus:@"获取用户文章成功!"];
        }else{
            [self.myUserMessageView showPageError:YES withIsError:YES];
        }
        
        [self.myUserMessageView updateListState:success];
    }];
}
-(void)makeUserMessageTableView
{
    self.myUserMessageView = [DH_UserMessageView allocInstanceFrame:CGRectMake(0, NavigationBarHeight+60, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight-60)];
    __weak DHFindViewController *tempSelf = self;
    
    self.myUserMessageView.block =^(NSInteger tag,id data)
    {
        if (tag == 0) {
            [tempSelf getUserMessageViewData];
        }else if (tag == 1){
            D_WebViewController *webView = [[D_WebViewController alloc] init];
            NSDictionary *titleData = (NSDictionary *)data;
            webView.myTitle = [titleData hasItemAndBack:@"title"];
            webView.myUrl = [titleData hasItemAndBack:@"tinyurl"];
            if (![webView.myUrl isEqualToString:@""]) {
                [tempSelf.navigationController pushViewController:webView animated:YES];
            }
            
        }
    };
    self.myUserMessageView.hidden = YES;
    [self.baseView addSubview:self.myUserMessageView];
}
-(void)getCreateMessageViewData
{
    [TTReqEngine C_GetArticle_List_Get:self.myCreateMessageView.myPageModel.limit
                              withPage:nil
                               withMax:self.myCreateMessageView.myPageModel.nextMax
                            withCityId:APPDELEGATE.viewController.myUserModel.city_id
                              withType:@"0"
                             withBlock:^(BOOL success, id dataModel) {
        if (success) {
            Dh_TitleModel *model = (Dh_TitleModel *)dataModel;
            
            if (model!=nil) {
                
                [self.myCreateMessageView.myPageModel toData:model.myPageModel];
                
                [self.myCreateMessageView updateData:model.allTitle];
                
//                if (model.allTitle.count == 0) {
//                    [SVProgressHUD showSuccessWithStatus:@"暂无原创文章!"];
//                } else {
//                    [SVProgressHUD showSuccessWithStatus:@"获取原创文章成功!"];
//                }
            }
        }else{
            [self.myCreateMessageView showPageError:YES withIsError:YES];
        }
        
        [self.myCreateMessageView updateListState:success];
    }];
}
-(void)makeCreateMessageTableView
{
    self.myCreateMessageView = [DH_CreateMessageView allocInstanceFrame:CGRectMake(0, NavigationBarHeight+60, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight-60-TabBarHeight)];
    __weak DHFindViewController *tempSelf = self;
    
    self.myCreateMessageView.block =^(NSInteger tag,id data)
    {
        if (tag == 0) {
            [tempSelf getCreateMessageViewData];
        }else if (tag == 1){
            D_WebViewController *webView = [[D_WebViewController alloc] init];
            NSDictionary *titleData = (NSDictionary *)data;
            webView.myTitle = [titleData hasItemAndBack:@"title"];
            webView.myUrl = [titleData hasItemAndBack:@"tinyurl"];\
            if (![webView.myUrl isEqualToString:@""]) {
                 [tempSelf.navigationController pushViewController:webView animated:YES];
            }
           
        }
    };
    
    self.myCreateMessageView.hidden = NO;
    [self.baseView addSubview:self.myCreateMessageView];
}

-(void)loginTypeChange:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
        self.myDealerMessageView.hidden = YES;
        self.myCreateMessageView.hidden = NO;
        [self.baseView bringSubviewToFront:self.myCreateMessageView];

    }else if (sender.selectedSegmentIndex == 1) {
        if (!self.changeCreateTitle) {
            self.changeCreateTitle = YES;
            if ([self.myDealerMessageView.myDataArray count] == 0) {
                [self.myDealerMessageView resetGetData];
            }
        }
        self.myDealerMessageView.hidden = NO;
        self.myCreateMessageView.hidden = YES;
        [self.baseView bringSubviewToFront:self.myDealerMessageView];
    }else if (sender.selectedSegmentIndex == 2) {
        self.myUserMessageView.hidden = NO;
        [self.baseView bringSubviewToFront:self.myUserMessageView];
    }
}

@end
