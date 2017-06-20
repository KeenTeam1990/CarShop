//
//  DLFaceCameraView.h
//  Auction
//
//  Created by 卢迎志 on 14-12-29.
//
//

#import "DLView.h"
#import <AVFoundation/AVFoundation.h>

typedef void(^DidCapturePhotoBlock)(UIImage *stillImage);

typedef enum{
    IPHONE3x5 = 0,
    IPHONE4 = 1,
    IPAD = 2,
    IPHONE5 = 3,
    IPHONE6 = 4,
    IPHONE6P = 5
} DeviceType;

@interface DLFaceCameraView : DLView<AVCaptureVideoDataOutputSampleBufferDelegate>

AS_FACTORY_FRAME(DLFaceCameraView);

AS_POINT(offset);
AS_MODEL_STRONG(UIImage, currentImage);
AS_MODEL(AVCaptureDevicePosition, cameraType);
AS_MODEL_STRONG(AVCaptureVideoPreviewLayer, previewLayer);
AS_MODEL_STRONG(AVCaptureDeviceInput, inputDevice);
AS_MODEL_STRONG(AVCaptureStillImageOutput, stillImageOutput);
AS_MODEL_STRONG(AVCaptureSession, session);
AS_BOOL(draggable);
AS_MODEL_STRONG(AVCaptureDevice, currentDevice);
AS_BLOCK(DidCapturePhotoBlock, videoCamBlock);

-(id)initWithDeviceType:(DeviceType)type;
//启动监控
-(void)startVideoCam:(DidCapturePhotoBlock)camBlock;
//启动摄像头
-(void)startFaceCam;
//停止摄像头
-(void)stopFaceCam;
//切换摄像头
-(void)switchCamera:(BOOL)isFrontCamera;
//拍照
- (void)takePicture:(DidCapturePhotoBlock)block;
//切换闪光灯
-(void)changeFlash;
-(AVCaptureFlashMode)currFlashMode;
//检查设备是否存在前置摄像头
- (BOOL) frontCameraAvailable;
//检查设备是否存在视频摄像头
- (BOOL) videoCameraAvailable;
//检查设备是否存在闪光灯
- (BOOL) cameraFlashAvailable;
//检查设备是否存在摄像头
- (BOOL) cameraAvailable;

@end
