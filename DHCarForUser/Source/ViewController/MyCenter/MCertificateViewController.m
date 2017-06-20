//
//  MCertificateViewController.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/15.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "MCertificateViewController.h"
#import "M_CertificateView.h"
#import "TTReqEngine.h"
#import "DLUpYunHelper.h"

@interface MCertificateViewController ()

AS_MODEL_STRONG(NSString, myFilePath);
AS_MODEL_STRONG(NSString, myFIleUrl);

@end

@implementation MCertificateViewController

DEF_FACTORY(MCertificateViewController);

DEF_MODEL(myOrderID);
DEF_MODEL(myFilePath);
DEF_MODEL(block);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initView];
    // Do any additional setup after loading the view.
    
    [self addTapToBaseView];
}

-(void)initView
{
    [self addCustomNavBar:@"上传凭证并评价"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    
    self.view.backgroundColor = [Unity getColor:@"#eeeeee"];
    
    M_CertificateView *bgView = [[M_CertificateView alloc]initWithFrame:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height/2)];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.bounds.size.width, self.baseView.bounds.size.height-NavigationBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    
    self.myTableView.tableHeaderView = bgView;
    
    __weak M_CertificateView* tempView = bgView;
    bgView.block = ^(NSInteger tag,NSString* content){
    
        if (tag == 0) {
            
            [APPDELEGATE.window endEditing:YES];
            
            [[DLImagePickerTool sharedInstance] showImagePickerSheet:self withBlock:^(UIImage *image) {
                if (image!=nil) {
                    
                    UIImage* tempImage = [image scaleToSize:CGSizeMake(600, 600)];
                    
                    self.myFilePath = [NSString stringWithFormat:@"%@%@",[DLCache libCachesToTemp],@"pingzheng.png"];
                    
                    [DLCache writeImage:tempImage toDocumentPath:self.myFilePath];
                    
                    [tempView updateImage:image];
                    
                    [DLUpYunHelper uploadFile:self.myFilePath withBlock:^(BOOL success, NSString *fileUrl, NSError *error) {
                        if (success) {
                            self.myFIleUrl = fileUrl;
                        }
                    }];
                    
                    [self.myTableView reloadData];
                }
            } withIsEdit:YES];
            
        }else if (tag == 1){
            
            [self sureBtn:content];
        }
    };
}

-(void)sureBtn:(NSString*)content
{
    [APPDELEGATE.window endEditing:YES];
    
    if ([self.myFIleUrl notEmpty]) {
        [TTReqEngine C_PostOrder_Upload_CertificateSetUid:[DLAppData sharedInstance].myUserKey
                                             withOrder_id:self.myOrderID
                                               withImages:self.myFIleUrl
                                                withBlock:^(BOOL success, id dataModel) {
                                                    if (success) {
                                                        [SVProgressHUD showSuccessWithStatus:@"上传成功！"];
                                                        if (self.block!=nil) {
                                                            self.block();
                                                        }
                                                        [self.navigationController popViewControllerAnimated:YES];
                                                    }
                                                }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请上传凭证图片"];
    }
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
