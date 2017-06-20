//
//  BootstrapViewController.m
//  TickTock
//
//  Created by 卢迎志 on 14-11-26.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import "BootstrapViewController.h"

@interface BootstrapViewController ()

AS_MODEL_STRONG(UIButton, myBtn);

@end

@implementation BootstrapViewController

DEF_FACTORY(BootstrapViewController);

DEF_MODEL(myScrollView);
DEF_MODEL(myBtn);

- (UIImage *)clipImage:(UIImage *)image
{
    
    NSLog(@"mhhhhhhmhmhhmhmhhmhh   %f",image.size.width);
    NSLog(@"dqdqdqdqdqddqdqdqd   %f",image.size.height);

    float height = (ScreenHeight/ScreenWidth)*image.size.width;
    float orginy = (image.size.height - height)/2;
    
    CGRect imageRect = CGRectMake(0, orginy, image.size.width, image.size.height-2*orginy);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], imageRect);
    UIImage *thumbScale = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return thumbScale;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    self.myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.myScrollView.showsHorizontalScrollIndicator = NO;
    self.myScrollView.showsVerticalScrollIndicator = NO;
    self.myScrollView.pagingEnabled =YES;
    self.myScrollView.delegate = self;
    [self.view addSubview:self.myScrollView];

    self.myPageView = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 30)];
    self.myPageView.userInteractionEnabled = YES;
    [self.view addSubview:self.myPageView];
    
    NSInteger count = 3;
    for (int i=0; i<count; i++) {
        UIImage* tempImage = [UIImage imageNamed:[NSString stringWithFormat:@"引导%d.png",i+2]];
        //float scareImage = ScreenWidth/tempImage0.size.width;

//        UIImage* tempImage = [UIImage imageWithCIImage:[tempImage0 CIImage] scale:scareImage orientation:UIImageOrientationUp];

//        UIImage* tempBGImage = [UIImage imageNamed:[NSString stringWithFormat:@"%d-1.png",i+2]];

        
        UIView* tempView = [[UIView alloc]initWithFrame:CGRectMake(self.myScrollView.frame.size.width*i, 0, self.myScrollView.frame.size.width, self.myScrollView.frame.size.height)];
        [tempView setClipsToBounds:YES];
        
//        UIImageView* tempBGView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//        tempBGView.image = tempBGImage;
//        //tempBGView.contentMode = UIViewContentModeScaleAspectFill;
//        [tempView addSubview:tempBGView];
        
        CGSize tempSize = tempImage.size;
        UIImage* bgImage=[UIImage imageNamed:@"Default.png"];
        if (IS_SCREEN_4_INCH) {
            bgImage = [UIImage imageNamed:@"Default-568h.png"];
            tempSize = bgImage.size;
        }
        if (IS_SCREEN_35_INCH) {
            tempSize = bgImage.size;
        }
        
        UIImageView* tempItemView = [[UIImageView alloc]initWithFrame:CGRectMake((tempView.frame.size.width-tempSize.width)/2, (tempView.frame.size.height-tempSize.height)/2, tempSize.width, tempSize.height)];
//        UIImageView* tempItemView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, tempSize.width, tempSize.height)];

        if (tempImage != nil) {
            //tempItemView.contentMode = UIViewContentModeScaleAspectFit;
            tempItemView.image = tempImage;
        }else{
            switch (i) {
                case 0:
                    tempItemView.image = [UIImage imageNamed:@"1-1"];
                    break;
                case 1:
                    tempItemView.image = [UIImage imageNamed:@"2-1"];
                    break;
                case 2:
                    tempItemView.image = [UIImage imageNamed:@"3-1"];
                    break;
                case 3:
                    tempItemView.image = [UIImage imageNamed:@"4-1"];
                    break;
                default:
                    break;
            }
        }
        [tempView addSubview:tempItemView];

        if (i==count-1) {
            
            [tempView setUserInteractionEnabled:YES];
            
            UITapGestureRecognizer *tempsingleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
            tempsingleTap.numberOfTapsRequired=1;
            [tempView addGestureRecognizer:tempsingleTap];
            
            UILabel* tepBtn = [[UILabel alloc]init];
            [tepBtn setBackgroundColor:[UIColor clearColor]];
            tepBtn.frame = CGRectMake(ScreenWidth/2-50, ScreenHeight-90, 100, 40);
            [tepBtn setTextColor:[UIColor whiteColor]];
            [tepBtn setText:@"立即进入"];
            tepBtn.textAlignment = NSTextAlignmentCenter;
            [tepBtn setFont:[UIFont systemFontOfSize:14]];
            
            [tempView addSubview:tepBtn];
        }
        
        [self.myScrollView addSubview:tempView];
    }
    
    self.myScrollView.contentSize = CGSizeMake(self.myScrollView.frame.size.width*count, self.myScrollView.frame.size.height);
    
    self.myPageView.numberOfPages = count;
    self.myPageView.currentPage = 0;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[[DLUserDefaults sharedInstance] getAppKey:@"first"]];
}

-(void)btnPressed:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
    
    [APPDELEGATE.viewController toHome];
}

-(void)singleTap:(UITapGestureRecognizer*)gesture
{
    [self dismissViewControllerAnimated:NO completion:nil];

    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[[DLUserDefaults sharedInstance] getAppKey:@"first"]];
    
    [APPDELEGATE.viewController toHome];
}

#pragma mark-
#pragma UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = self.myScrollView.contentOffset.x/self.view.frame.size.width;//通过滚动的偏移量来判断目前页面所对应的小白点
    
    self.myPageView.currentPage = page;//pagecontroll响应值的变化

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
