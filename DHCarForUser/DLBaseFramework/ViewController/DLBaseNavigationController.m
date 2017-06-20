//
//  DLBaseNavigationController.m
//  TickTock
//
//  Created by 卢迎志 on 14-11-26.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import "DLBaseNavigationController.h"

@interface DLBaseNavigationController ()

@end

@implementation DLBaseNavigationController

DEF_MODEL(currentShowVC);

+(instancetype)sharedInstanceRoot:(UIViewController*)controller
{
    return [[DLBaseNavigationController alloc] initWithRootViewController:controller];
}
- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    DLBaseNavigationController* nvc = [super initWithRootViewController:rootViewController];
    if (DeviceVersion >= 7.0f) {
        self.interactivePopGestureRecognizer.delegate = self;
        nvc.delegate = self;
    }
    return nvc;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
}
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController.viewControllers.count == 1)
        self.currentShowVC = nil;
    else
        self.currentShowVC = viewController;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return (self.currentShowVC == self.topViewController); //the most important
    }
    return YES;
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
