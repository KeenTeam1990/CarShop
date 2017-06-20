//
//  M_PayWebViewController.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/17.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_PayWebViewController.h"

@interface M_PayWebViewController ()<UIWebViewDelegate>

AS_MODEL_STRONG(UIWebView, myWebView);

@end

@implementation M_PayWebViewController

DEF_FACTORY(M_PayWebViewController);
DEF_MODEL(myWebView);
DEF_MODEL(myUrl);

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    
    [self initData];
}

-(void)initView
{
    [self addCustomNavBar:@"网页"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    
    self.myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight)];
    self.myWebView.scalesPageToFit= YES;
    self.myWebView.delegate = self;
    [self.baseView addSubview:self.myWebView];
}

-(void)initData
{
    if ([self.myUrl notEmpty]) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.myUrl]]];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
        NSString * currentURL = [webView stringByEvaluatingJavaScriptFromString: @" document.location.href " ];
        NSString *url=webView.request.URL.absoluteString;
        NSLog(@"location url  is %@",currentURL);
        NSLog(@"url is %@",url);
        
        NSRange tempFindCallback = [currentURL rangeOfString:@"/PlayHTML/return_url.php?"];
        if (tempFindCallback.length>0) {
            NSString* tempurl = currentURL;
            NSRange tempresult = [tempurl rangeOfString:@"is_success="];
            if (tempresult.length > 0) {
                tempurl = [tempurl substringFromIndex:tempresult.location+tempresult.length];
                NSRange tempresultend = [tempurl rangeOfString:@"&"];
                if (tempresultend.length > 0) {
                    tempurl = [tempurl substringToIndex:tempresultend.location];
                    if ([tempurl isEqualToString:@"T"]) {

                        [SVProgressHUD showSuccessWithStatus:@"支付成功！"];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                        
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"支付失败！"];
                    }
                }
            }
        }
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
