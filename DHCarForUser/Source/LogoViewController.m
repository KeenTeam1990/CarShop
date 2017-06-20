//
//  LogoViewController.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/10/28.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "LogoViewController.h"
#import "BootstrapViewController.h"
#import <DLBaseFramework/DLBaseFramework.h>
#import "DHAdvertisementViewController.h"
#import "TTReqEngine.h"
#import "DH_ADModel.h"


@interface LogoViewController ()

@end

@implementation LogoViewController

DEF_FACTORY(LogoViewController);

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage* temoIcon =  [UIImage imageNamed:@"引导1.png"];
    CGSize tempSize = temoIcon.size;
    UIImage* bgImage=[UIImage imageNamed:@"Default.png"];
    if (IS_SCREEN_4_INCH) {
        bgImage = [UIImage imageNamed:@"Default-568h.png"];
        tempSize = bgImage.size;
    }
    if (IS_SCREEN_35_INCH) {
        tempSize = bgImage.size;
    }
    
    UIImageView* tempView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    tempView.image = [UIImage imageNamed:@"1-1.png"];
    tempView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:tempView];
    
    
    UIImageView* tempIcon = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-(tempSize.width))/2, (self.view.frame.size.height-(tempSize.height))/2, (tempSize.width), (tempSize.height))];
    tempIcon.image = temoIcon;
    //tempIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:tempIcon];
    
    [self performSelector:@selector(getADImageAction) withObject:nil afterDelay:7];
    
    NSString *myFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/advertisement.png"];
    if ([DLCache isFileExists:myFilePath]) {
        NSString *webUrl =[[NSUserDefaults standardUserDefaults] objectForKey:@"web_url"];
        DHAdvertisementViewController *advertisementViewController = [[DHAdvertisementViewController alloc] init];
        advertisementViewController.ADUrl = webUrl;
        [self.navigationController pushViewController:advertisementViewController animated:NO];
    }
    
}

-(void)initBootstrapController
{
    [self presentViewController:[BootstrapViewController allocInstance] animated:NO completion:nil];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSString *myFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/advertisement.png"];
    if (![DLCache isFileExists:myFilePath]) {
        [self performSelector:@selector(toHome) withObject:nil afterDelay:0.3];
    }
}

-(void)getADImageAction
{
    NSString *myFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/advertisement.png"];
    [TTReqEngine C_GetConfig_AD:@"6"
                      withBlock:^(BOOL success, id dataModel) {
                          if (success) {
                              DH_ADModel *adModel = (DH_ADModel *)dataModel;
                              //下载图片
                              dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                  if (adModel.imageUrl != nil) {
                                      UIImage *adImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:adModel.imageUrl]]];
                                      NSLog(@"spspspspspspsps   %@",adModel.imageUrl);
                                      BOOL result = [UIImagePNGRepresentation(adImage) writeToFile:myFilePath    atomically:YES]; // 保存成功会返回YES
                                      
                                      if (result) {
                                          NSLog(@"图片写入成功");
                                      } else {
                                          NSLog(@"图片写入失败");
                                          
                                      }
                                  }

                              });
                          }
                      }];
}

-(void)toHome
{
//    NSString *myFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/advertisement.png"];
//    
//    if ([DLCache isFileExists:myFilePath]) {
//        NSLog(@"文件路径存在 %@",myFilePath);
//        NSString *webUrl =[[NSUserDefaults standardUserDefaults] objectForKey:@"web_url"];
//        DHAdvertisementViewController *advertisementViewController = [[DHAdvertisementViewController alloc] init];
//        advertisementViewController.ADUrl = webUrl;
//        [self.navigationController pushViewController:advertisementViewController animated:NO];
//        return;
//        
//    } else {
//        NSLog(@"文件路径不存在 %@",myFilePath);
//        
//    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:0.5];
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [self dismissViewControllerAnimated:NO completion:nil];
            [self.navigationController popViewControllerAnimated:NO];
            [APPDELEGATE.viewController toHome];
        });
    });
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
