//
//  D_WebViewController.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_WebViewController.h"

@interface D_WebViewController ()

AS_MODEL_STRONG(UIWebView, myWebView);

@end

@implementation D_WebViewController

DEF_FACTORY(D_WebViewController);
DEF_MODEL(myWebView);
DEF_MODEL(myTitle);
DEF_MODEL(myUrl);

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    
    [self initData];
}

-(void)initView
{
    [self addCustomNavBar:self.myTitle
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];

    self.myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight)];
    [self.baseView addSubview:self.myWebView];

}

-(void)initData
{
    if ([self.myUrl notEmpty]) {
        
        [self setCookie];
        
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.myUrl]]];
    }
}

//设置cookie
- (void)setCookie{
    
    NSURL* tempHost= [NSURL URLWithString:KH5Host];
//    NSURL* tempUrl= [NSURL URLWithString:self.myUrl];
    
    NSMutableArray* tempArray = [NSMutableArray allocInstance];
    
    NSMutableDictionary *cookiePropertiesUser = [NSMutableDictionary dictionary];
    [cookiePropertiesUser setObject:@"app" forKey:NSHTTPCookieName];
    [cookiePropertiesUser setObject:@"1" forKey:NSHTTPCookieValue];
    
    [cookiePropertiesUser setObject:[tempHost host] forKey:NSHTTPCookieDomain];
    [cookiePropertiesUser setObject:[tempHost path] forKey:NSHTTPCookiePath];
    [cookiePropertiesUser setObject:@"0" forKey:NSHTTPCookieVersion];
    
    // set expiration to one month from now or any NSDate of your choosing
    // this makes the cookie sessionless and it will persist across web sessions and app launches
    /// if you want the cookie to be destroyed when your app exits, don't set this
    [cookiePropertiesUser setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
    
    NSHTTPCookie *cookieuser = [NSHTTPCookie cookieWithProperties:cookiePropertiesUser];
    
    [tempArray addObject:cookieuser];
    
    if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
        
        NSMutableDictionary *cookiePropertiesUser = [NSMutableDictionary dictionary];

        [cookiePropertiesUser setObject:@"uid" forKey:NSHTTPCookieName];
        [cookiePropertiesUser setObject:[DLAppData sharedInstance].myUserKey forKey:NSHTTPCookieValue];
        
        [cookiePropertiesUser setObject:[tempHost host] forKey:NSHTTPCookieDomain];
        [cookiePropertiesUser setObject:[tempHost path] forKey:NSHTTPCookiePath];
        [cookiePropertiesUser setObject:@"0" forKey:NSHTTPCookieVersion];
        
        // set expiration to one month from now or any NSDate of your choosing
        // this makes the cookie sessionless and it will persist across web sessions and app launches
        /// if you want the cookie to be destroyed when your app exits, don't set this
        [cookiePropertiesUser setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
        
        NSHTTPCookie *cookieuser2 = [NSHTTPCookie cookieWithProperties:cookiePropertiesUser];
        
        [tempArray addObject:cookieuser2];
    }

    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:tempArray forURL:tempHost mainDocumentURL:nil];
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieuser];
}

//清除cookie
- (void)deleteCookie{
    if (self.myUrl != nil) {
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//        NSLog(@"count = %ld",[cookieJar cookiesForURL: [NSURL URLWithString: self.myUrl]]);
//        NSArray *cookieAry = [cookieJar cookiesForURL: [NSURL URLWithString: self.myUrl]];
//        for (cookie in cookieAry) {
//            [cookieJar deleteCookie: cookie];
//        }
        for (cookie in [cookieJar cookies]) {
            [cookieJar deleteCookie:cookie];
        }
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self deleteCookie];
}

-(void)leftBtnPressed:(id)sender
{
    if (self.showPush) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        if (self.comeFromAD) {
            [self dismissViewControllerAnimated:YES completion:nil];
            [APPDELEGATE.viewController toHome];
        } else {
            if (self.myWebView!=nil) {
                if ([self.myWebView canGoBack]) {
                    [self.myWebView goBack];
                }else{
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
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
