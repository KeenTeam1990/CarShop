
//
//  LL_SysteMessageDetailViewController.m
//  DHCarForUser
//
//  Created by leiyu on 16/4/8.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "LL_SysteMessageDetailViewController.h"

@interface LL_SysteMessageDetailViewController ()

@end

@implementation LL_SysteMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
-(void)initView
{
    [self addCustomNavBar:@"系统消息详情" withLeftBtn:@"返回" withRightBtn:nil withLeftLabel:@"返回" withRightLabel:nil];
    
    //[self.customNavBar.leftBtn setTitleColor:[Unity getColor:@"#1b71ff"] forState:UIControlStateNormal];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, NavigationBarHeight+10, ScreenWidth, 25)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.contentModel.myTitle;
    titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    [self.baseView addSubview:titleLabel];
    
    float contentHeight = [Unity getLabelHeightWithWidth:ScreenWidth-20 andDefaultHeight:30 andFontSize:14 andText:self.contentModel.myTitle];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, NavigationBarHeight+50, ScreenWidth-20, MAX(contentHeight, 30))];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.text = self.contentModel.myContent;
    contentLabel.font = [UIFont systemFontOfSize:14];
    [self.baseView addSubview:contentLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, contentLabel.frame.origin.y+contentLabel.frame.size.height+10, ScreenWidth-10, MAX(contentHeight, 30))];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.text = [NSString stringWithFormat:@"创建日期:  %@",[self changeTime:self.contentModel.myCreateAt]];
    timeLabel.font = [UIFont systemFontOfSize:14];
    [self.baseView addSubview:timeLabel];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)leftBtnPressed:(id)sender
{
    if (self.showPush) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
    {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

 -(NSString *)changeTime:(NSString *)timeValue
 {
     NSDateFormatter *fromtter = [[NSDateFormatter alloc] init];
     NSTimeInterval time = [timeValue doubleValue];
     NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
     NSInteger distanceSec = [date timeIntervalSinceNow];
     if (distanceSec<-24*60*60) {
         [fromtter setDateFormat:@"YYYY:MM:dd"];
     }
     else if (distanceSec<-60*60) {
         [fromtter setDateFormat:@"HH:mm"];
     }
     else if (distanceSec<-60) {
         [fromtter setDateFormat:@"mm:ss"];
     }
     else{
         [fromtter setDateFormat:@"ss"];
     }
     
     NSString *timeStr = [fromtter stringFromDate:date];
     return timeStr;
 }


@end
