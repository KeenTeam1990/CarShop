//
//  D_InquiryFinishViewController.m
//  DHCarForUser
//
//  Created by lucaslu on 16/1/15.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "D_InquiryFinishViewController.h"
#import "D_LLDetailOrderViewController.h"
#import "QueryModelsItemViewController.h"
#import "D_InquiryViewController.h"
@interface D_InquiryFinishViewController ()

AS_MODEL_STRONG(UIView, myView);

AS_MODEL_STRONG(UIButton, myLeftBtn);
AS_MODEL_STRONG(UIButton, myRightBtn);

AS_MODEL_STRONG(UIImageView, myImageView);

AS_MODEL_STRONG(UILabel, myNameLabel);

AS_MODEL_STRONG(UILabel, myTitleLabel);

AS_MODEL_STRONG(UILabel, myClewLabel);

@end

@implementation D_InquiryFinishViewController

DEF_FACTORY(D_InquiryFinishViewController);

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    [self initView];
    
    [self initData];
}

-(void)initView
{
    [self addCustomNavBar:@"提交成功"
              withLeftBtn:nil
             withRightBtn:nil
            withLeftLabel:nil
           withRightLabel:nil];
 
    self.myView = [[UIView alloc]initWithFrame:CGRectMake(10, NavigationBarHeight+30, self.baseView.frame.size.width-20, self.baseView.frame.size.width-20)];
    self.myView.style = DLViewStyleMake(style.borderColor = [UIColor redColor];
                                        style.borderWidth = 1;
                                        style.cornerRedius = 2;
                                        style.backgroundColor = [UIColor whiteColor];);
    
    self.myView.backgroundColor = [UIColor whiteColor];
    [self.baseView addSubview:self.myView];
    
    self.myTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, self.myView.frame.size.width-40, 30)];
    self.myTitleLabel.font = SYSTEMFONT(20);
    self.myTitleLabel.textColor = [UIColor redColor];
        self.myTitleLabel.textAlignment = UITextAlignmentCenter;
    [self.myView addSubview:self.myTitleLabel];
    
    self.myClewLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, self.myView.frame.size.width-40, 60)];
    self.myClewLabel.font  = SYSTEMFONT(16);
    self.myClewLabel.textColor = [UIColor blackColor];
    self.myClewLabel.numberOfLines = 2;
        self.myClewLabel.textAlignment = UITextAlignmentCenter;
    [self.myView addSubview:self.myClewLabel];
    
    self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.myView.frame.size.width-100)/2, 140, 100, 100)];
    self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.myView addSubview:self.myImageView];
    
    self.myNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 260, self.myView.frame.size.width-40, 50)];
    self.myNameLabel.font = SYSTEMFONT(14);
    self.myNameLabel.textColor = [UIColor blackColor];
    self.myNameLabel.numberOfLines = 2;
    self.myNameLabel.textAlignment = UITextAlignmentCenter;
    [self.myView addSubview:self.myNameLabel];
    
    self.myLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myLeftBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor redColor];
                                             style.cornerRedius =5;
                                             );
    [self.myLeftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.myLeftBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.myLeftBtn addTarget:self action:@selector(left2BtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.myLeftBtn.frame = CGRectMake(10, MaxY(self.myView)+20, self.baseView.frame.size.width/2-20, 40);
    [self.baseView addSubview:self.myLeftBtn];
    
    self.myRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myRightBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor];
                                              style.cornerRedius = 5;
                                              style.borderWidth = 1;
                                              style.borderColor = [UIColor redColor];);
    [self.myRightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.myRightBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.myRightBtn addTarget:self action:@selector(right2BtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.myRightBtn.frame = CGRectMake(self.baseView.frame.size.width/2+10, MaxY(self.myView)+20, self.baseView.frame.size.width/2-20, 40);
    [self.baseView addSubview:self.myRightBtn];
}

-(void)left2BtnPressed:(id)sender
{
    if(self.showPay){
        [self.navigationController popToRootViewControllerAnimated:NO];
        
        D_LLDetailOrderViewController* tempController = [D_LLDetailOrderViewController allocInstance];
        tempController.orderID = self.orderId;
        [APPDELEGATE.viewController.homeController.navigationController pushViewController:tempController animated:NO];
    }else{
        [self.navigationController popToRootViewControllerAnimated:NO];
        
        QueryModelsItemViewController* tempController = [QueryModelsItemViewController allocInstance];
        tempController.order_id = self.orderId;
        [APPDELEGATE.viewController.homeController.navigationController pushViewController:tempController animated:NO];
    }
    
}

-(void)right2BtnPressed:(id)sender
{
    NSInteger parentIndex = [self.navigationController.viewControllers count];
    if (parentIndex>2) {
        id parentViewController = [self.navigationController.viewControllers objectAtIndex:parentIndex-2];
        if ([parentViewController isKindOfClass:[D_InquiryViewController class]]) {
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
            return;
        }

    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];

}


-(void)initData
{
    if (self.myCarModel!=nil) {
        if ([self.myCarModel.myCar_Img notEmpty]) {
            [self.myImageView setImageWithURL:[NSURL URLWithString:self.myCarModel.myCar_Img] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
        }
        
        if ([self.myCarModel.myBrand_Name notEmpty] &&
            [self.myCarModel.mySubbrand_Name notEmpty] &&
            [self.myCarModel.myCar_Name notEmpty] &&
            [self.myCarModel.myCar_Year notEmpty]) {
            self.myNameLabel.text = [NSString stringWithFormat:@"%@ %@ \n%@ %@",self.myCarModel.myBrand_Name,self.myCarModel.mySubbrand_Name,self.myCarModel.myCar_Year,self.myCarModel.myCar_Name];
        }
    }
    
    if (self.showPay) {
        self.myTitleLabel.text = @"支付成功";
        self.myClewLabel.text = @"已经成功为您向商家支付\n是否立刻查看订单？";
        
        [self.myLeftBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    }else{
        self.myTitleLabel.text = @"提交成功";
        self.myClewLabel.text = @"已经成功为您向商家提交询价\n是否立刻查看询价单？";

        [self.myLeftBtn setTitle:@"查看询价单" forState:UIControlStateNormal];
    }
    
    [self.myRightBtn setTitle:@"返回首页" forState:UIControlStateNormal];
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
