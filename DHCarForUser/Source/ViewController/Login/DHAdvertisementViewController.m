//
//  DHAdvertisementViewController.m
//  DHCarForUser
//
//  Created by 张海亮 on 16/3/25.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DHAdvertisementViewController.h"
#import "D_WebViewController.h"

@interface DHAdvertisementViewController ()
AS_INT(countNumber);
AS_BOOL(haveRun);
AS_MODEL_STRONG(NSTimer, countDownTimer)
AS_MODEL_STRONG(UIButton ,countDownBtn);
@end

@implementation DHAdvertisementViewController

DEF_MODEL(countNumber);
DEF_MODEL(haveRun);
DEF_MODEL(countDownTimer);
DEF_MODEL(countDownBtn);
DEF_MODEL(ADUrl);

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *myFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/advertisement.png"];

    UIImage* temoIcon =  [UIImage imageWithContentsOfFile:myFilePath];
    UIImageView* tempAdvertisementImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    tempAdvertisementImage.image = temoIcon;
    [tempAdvertisementImage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tempsingleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(advertisementImageTap:)];
    tempsingleTap.numberOfTapsRequired=1;
    [tempAdvertisementImage addGestureRecognizer:tempsingleTap];
    //tempAdvertisementImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:tempAdvertisementImage];
    
    self.countDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.countDownBtn.frame = CGRectMake(ScreenWidth-95, 45, 85, 30);
    [self.countDownBtn addTarget:self action:@selector(dismissView:) forControlEvents:UIControlEventTouchUpInside];
    self.countDownBtn.layer.cornerRadius = 15.0;
    self.countDownBtn.backgroundColor = [UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.0];
    [self.countDownBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.countDownBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [self.countDownBtn setTitle:@"跳过3S>>" forState:UIControlStateNormal];
    [self.view addSubview:self.countDownBtn];

    self.countNumber = 3;
    self.haveRun = NO;

    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownButton) userInfo:nil repeats:YES];
}

-(void)dismissView:(UIButton *)sender
{
    self.haveRun = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:NO completion:nil];
            [APPDELEGATE.viewController toHome];
        });
    });
}

-(void)countDownButton
{
    self.countNumber--;
    [self.countDownBtn setTitle:[NSString stringWithFormat:@"跳过%ldS>>",(long)self.countNumber] forState:UIControlStateNormal];
    if (self.countNumber == 0) {
        [self.countDownTimer invalidate];
        self.countDownTimer = nil;
        [self toHome];
    }
}

-(void)advertisementImageTap:(UITapGestureRecognizer*)gesture
{
    [self.countDownTimer invalidate];
    self.countDownTimer = nil;
    self.haveRun = YES;
    D_WebViewController *webView = [[D_WebViewController alloc] init];
    webView.myUrl = ADUrl;
    webView.myTitle = @"";
    webView.comeFromAD = YES;
    [self.navigationController pushViewController:webView animated:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.haveRun) {
        [self dismissViewControllerAnimated:NO completion:nil];
        [APPDELEGATE.viewController toHome];
    }
}

-(void)toHome
{
    if (!self.haveRun) {
        self.haveRun = YES;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:NO completion:nil];
                [APPDELEGATE.viewController toHome];
            });
        });
    }
}

@end
