//
//  LL_RichScanViewController.m
//  DHCarForUser
//
//  Created by leiyu on 16/3/24.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "LL_RichScanViewController.h"
 #import <AudioToolbox/AudioToolbox.h>
#import "ZXingObjC.h"
#import "ZXQRCodeReader.h"
#import "LL_ScanView.h"
#import "D_CarDAndResViewController.h"
#import "TTReqUrl.h"
#import "TTReqEngine.h"
#import "LL_GetScanUrlModel.h"
@interface LL_RichScanViewController ()<ZXCaptureDelegate,UIAlertViewDelegate>
AS_MODEL_STRONG(NSTimer, myTimer);
AS_MODEL_STRONG(UIImageView, myLineImage);
AS_MODEL_STRONG(ZXCapture, myCapture);
AS_MODEL_STRONG(LL_ScanView, myScanView);



@end

@implementation LL_RichScanViewController{
    CGAffineTransform _captureSizeTransform;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMyCapture];
    [self initView];
    [self initScanView];
    
}

-(void)initView
{
    [self addCustomNavBar:@"扫一扫"
              withLeftBtn:@"ic_goBack"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];

}
-(void)initScanView
{
    LL_ScanView *scanView = [[LL_ScanView alloc]initWithFrame:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight)];
    [self.baseView addSubview:scanView];
}
-(void)initMyCapture
{
    self.myCapture = [[ZXCapture alloc] init];
    self.myCapture.camera = self.myCapture.back;
    self.myCapture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    self.myCapture.rotation = 90.0f;
    
    self.myCapture.delegate = self;
    
    CGRect rect = CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight);
  
    
    self.myCapture.layer.frame = rect;
    
    [self.baseView.layer addSublayer:self.myCapture.layer];
   
    self.myCapture.scanRect =CGRectMake((self.baseView.frame.size.width-250)/2, (self.baseView.frame.size.height-250)/2, 250, self.baseView.frame.size.height-250);
    NSLog(@"self.myCapture.scanRect.origin.x=%f,self.myCapture.scanRect.origin.y=%f,self.myCapture.scanRect.size.width=%f,self.myCapture.scanRect.size.height=%f",self.myCapture.scanRect.origin.x,self.myCapture.scanRect.origin.y,self.myCapture.scanRect.size.width,self.myCapture.scanRect.size.height);
    
    [self.myCapture start];
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == kCLAuthorizationStatusRestricted || authStatus ==kCLAuthorizationStatusDenied){
        Alert_Message(@"提醒", @"请在设备的\"设置-隐私-相机\"中允许访问相机");
    }
}
#pragma mark - Private Methods

- (NSString *)barcodeFormatToString:(ZXBarcodeFormat)format {
    switch (format) {
        case kBarcodeFormatAztec:
            return @"Aztec";
            
        case kBarcodeFormatCodabar:
            return @"CODABAR";
            
        case kBarcodeFormatCode39:
            return @"Code 39";
            
        case kBarcodeFormatCode93:
            return @"Code 93";
            
        case kBarcodeFormatCode128:
            return @"Code 128";
            
        case kBarcodeFormatDataMatrix:
            return @"Data Matrix";
            
        case kBarcodeFormatEan8:
            return @"EAN-8";
            
        case kBarcodeFormatEan13:
            return @"EAN-13";
            
        case kBarcodeFormatITF:
            return @"ITF";
            
        case kBarcodeFormatPDF417:
            return @"PDF417";
            
        case kBarcodeFormatQRCode:
            return @"QR Code";
            
        case kBarcodeFormatRSS14:
            return @"RSS 14";
            
        case kBarcodeFormatRSSExpanded:
            return @"RSS Expanded";
            
        case kBarcodeFormatUPCA:
            return @"UPCA";
            
        case kBarcodeFormatUPCE:
            return @"UPCE";
            
        case kBarcodeFormatUPCEANExtension:
            return @"UPC/EAN extension";
            
        default:
            return @"Unknown";
    }
}

-(void)dealloc
{
    [self.myCapture.layer removeFromSuperlayer];
}
#pragma mark ZXCaptureDelegate
- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result
{
    NSLog(@"ccccccccca%@",result);
    if (!result)
    {
        return;
    }
    self.myCapture.delegate = nil;
   
    NSString *formatString = [self barcodeFormatToString:result.barcodeFormat];
    
    NSString *symbolStr = result.text;
    if ([result.text canBeConvertedToEncoding:NSShiftJISStringEncoding])
        
    {
        symbolStr = [NSString stringWithCString:[result.text cStringUsingEncoding:NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
    }
    
    NSLog(@"扫描结果:%@",symbolStr);
    [self successInScanresule:symbolStr];
    
    NSString *display = [NSString stringWithFormat:@"Scanned!\n\nFormat: %@\n\nContents:\n%@", formatString, result.text];
    NSLog(@"扫描结果:%@",display);
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.myTimer invalidate];
    self.myTimer = nil;
}
/**
 *  扫描成功后执行的方法
 *
 *  @param result 扫描的结果
 */
-(void)successInScanresule:(NSString *)result
{
    
    NSLog(@"扫描结果成功%@",result);
    if ([result hasPrefix:@"http://t.cn"]) {
       
        ;
        [TTReqEngine C_GetScanDetail_Get:result withBlock:^(BOOL success, id dataModel) {
            if (success) {
                LL_GetScanUrlModel *model = (LL_GetScanUrlModel *)dataModel;
                NSLog(@"%@",model.myResult);
                 D_CarDAndResViewController *tempView = [[D_CarDAndResViewController alloc]init];
                tempView.myGetUrl = [NSString stringWithFormat:@"%@&output=json",model.myResult];
                [self.navigationController pushViewController:tempView animated:YES];
            }
            
        }];
//
    }
    else
    {
        Alert_Message(@"提醒", @"请扫描东汇汽车销售人员提供的二维码");
//        UIAlertView *alteView = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"此二维码不正确，请扫描东汇汽车销售人员提供的二维码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alteView show];
        
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex ) {
        case 0:
        {
            self.myCapture.delegate = self;
        }
            break;
            
        default:
            break;
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.myCapture.delegate = self;
    [self setNeedHideTabBar:YES];
}


@end
