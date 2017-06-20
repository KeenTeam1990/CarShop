//
//  LL_FeedBackViewController.m
//  DHCarForUser
//
//  Created by leiyu on 15/12/27.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "LL_FeedBackViewController.h"
#import "UMFeedback.h"
#import "LL_FeedBackCell.h"
#import "UMOpenMacros.h"
@interface LL_FeedBackViewController ()<UMFeedbackDataDelegate>
AS_MODEL_STRONG(NSTimer,myTimer);
AS_MODEL_STRONG(UMFeedback, myFeedBack)

@end

@implementation LL_FeedBackViewController
DEF_MODEL(myFeedBack);
DEF_MODEL(myTimer);
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
    [self performSelector:@selector(initTimer) withObject:self afterDelay:10.0];
}
-(void)initView
{
    [self addCustomNavBar:@"问题反馈"
              withLeftBtn:@"icon_back.png"
             withRightBtn:@""
            withLeftLabel:@"返回"
           withRightLabel:@""];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight*2) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    
    self.myTableView.backgroundColor = [Unity getGrayBackColor];
    self.myFeedBack = [UMFeedback sharedInstance];
    
}
-(void)initData
{
    [self.myFeedBack get:^(NSError *error) {
        if (error == nil) {
            [self.myDataArray addObjectsFromArray:self.myFeedBack.topicAndReplies];
            [self.myTableView reloadData];
        }
    }];
}
-(void)send:(NSString *)text
{
    self.commentView.myTextField.text = @"";
    NSDictionary *postContent = @{@"content":text,
                                  @"user_name":APPDELEGATE.viewController.myUserModel.user_nick,
                                  @"tel":APPDELEGATE.viewController.myUserModel.user_phone,
                                  @"type": @"user_reply"
                                  };
    [self.myFeedBack post:postContent completion:^(NSError *error) {
        if (error ==nil) {
            [self stop];
            [self.myDataArray removeAllObjects];
            [self.myDataArray addObjectsFromArray:self.myFeedBack.topicAndReplies];
            [self.myTableView reloadData];
            [self toBottom];
            [self start];
        }
    }];
}
-(void)toBottom
{
    if ([self.myFeedBack.topicAndReplies count] >0) {
        [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.myFeedBack.topicAndReplies.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark TabelViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@" count = %d",self.myDataArray.count);
        return self.myDataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tempDic = self.myDataArray[indexPath.row];
    CGFloat  textHeight = [Unity  getLabelHeightWithWidth:self.myTableView.frame.size.width -10-10-50-30-10 andDefaultHeight:20 andFontSize:14 andText:tempDic[@"content"]];
    
    return textHeight+100;
 
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LL_FeedBackCell *cell = [LL_FeedBackCell reusableCellOfTableView:tableView identifier:@"LL_FeedBackCell"];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    NSDictionary *info = self.myDataArray[indexPath.row];


    NSNumber *num = info[@"created_at"];
    NSDate *date =[NSDate dateWithTimeIntervalSince1970:[num integerValue]/1000];
    
    [cell upDataWithContent:info[@"content"] andType:info[@"type"] andTimeStr:[self humanableInfoFromDate:date] andBoolTimeButtonShowOrNot:YES andWithHeadImage:APPDELEGATE.viewController.myUserModel.user_photo];
    return cell;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self toBottom];
}
- (NSString *)humanableInfoFromDate: (NSDate *) theDate {
    NSString *info;
    
    NSTimeInterval delta = - [theDate timeIntervalSinceNow];
    if (delta < 60) {
        // 1分钟之内
        info = UM_Local(@"刚刚");
    } else {
        delta = delta / 60;
        if (delta < 60) {
            // n分钟前
            info = [NSString stringWithFormat:UM_Local(@"%d 分钟前"), (NSUInteger)delta];
        } else {
            delta = delta / 60;
            if (delta < 24) {
                // n小时前
                info = [NSString stringWithFormat:UM_Local(@"%d 小时前"), (NSUInteger)delta];
            } else {
                delta = delta / 24;
                if ((NSInteger)delta == 1) {
                    //昨天
                    info = UM_Local(@"昨天");
                } else if ((NSInteger)delta == 2) {
                    info = UM_Local(@"前天");
                } else {
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"MM-dd"];
                    info = [dateFormatter stringFromDate:theDate];
                  
                }
            }
        }
    }
    return info;
}

//轮询机制
-(void)initTimer
{
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(getReply) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:myTimer forMode:NSRunLoopCommonModes];
    [self start];
    
}
-(void)getReply
{
    [self.myFeedBack get:^(NSError *error) {
        if (error == nil) {
            if (self.myFeedBack.topicAndReplies.count != 0 ) {
                [self.myDataArray removeAllObjects];
                [self.myDataArray addObjectsFromArray:self.myFeedBack.topicAndReplies];
                [self.myTableView reloadData];
                [self toBottom];
            }
        }
        else{
            NSLog(@"%@",error);
        }
    }];
}
-(void)start
{
    [self.myTimer setFireDate:[NSDate distantPast]];
}
-(void)stop
{
    [self.myTimer setFireDate:[NSDate distantFuture]];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self stop];
    [self.myTimer invalidate];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
