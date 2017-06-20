//
//  DLFaceCameraView.m
//  Auction
//
//  Created by 卢迎志 on 14-12-29.
//
//

#import "DLFaceCameraView.h"
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>

@implementation DLFaceCameraView

DEF_FACTORY_FRAME(DLFaceCameraView);
DEF_MODEL(cameraType);
DEF_MODEL(currentDevice);
DEF_MODEL(currentImage);
DEF_MODEL(stillImageOutput);
DEF_MODEL(session);
DEF_MODEL(previewLayer);
DEF_MODEL(draggable);
DEF_MODEL(offset);
DEF_MODEL(inputDevice);
DEF_MODEL(videoCamBlock);

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaults];
    }
    return self;
}

- (id)initWithDeviceType:(DeviceType)type
{
    CGRect frame;
    switch (type)
    {
        case 0:
            frame = CGRectMake(190, 300, 120, 150);
            break;
        case 1:
            frame = CGRectMake(190, 380, 120, 160);
            break;
        case 2:
            frame = CGRectMake(190, 290, 120, 160);
            break;
        default:
            frame = CGRectMake(190, 300, 120, 150);
            break;
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaults];
    }
    return self;
}


-(void)setDefaults
{
    [self setBackgroundColor:[UIColor blackColor]];
    self.layer.cornerRadius = 0;
    self.layer.masksToBounds = YES;
    self.cameraType = AVCaptureDevicePositionBack;
    self.draggable = NO;
}

-(void)startFaceCam
{
    AVCaptureDevice *device = [self CameraIfAvailable];
    self.currentDevice=device;
    if (device) {
        if (!session) {
            session = [[AVCaptureSession alloc] init];
        }
        session.sessionPreset = AVCaptureSessionPresetMedium;
        
        if ([self.currentDevice hasTorch] && [self.currentDevice hasFlash]) {
            [self.currentDevice lockForConfiguration:nil];
            [self.currentDevice setFlashMode:AVCaptureFlashModeOff];
            [self.currentDevice setTorchMode: AVCaptureTorchModeAuto];
            [self.currentDevice unlockForConfiguration];
        }
        NSError *error = nil;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        if (!input){
            // Handle the error appropriately.
            //NSLog(@"ERROR: trying to open camera: %@", error);
        } else{
            if ([session canAddInput:input]) {
                [session addInput:input];
                
                AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
                
                captureVideoPreviewLayer.frame = self.bounds;
                captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
                self.previewLayer=captureVideoPreviewLayer;
                [self.layer addSublayer:captureVideoPreviewLayer];
                
                AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init] ;
                [session addOutput:output];
                
                // Configure your output.
                dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
                [output setSampleBufferDelegate:self queue:queue];
//                dispatch_release(queue);
                
                // Specify the pixel format
                output.videoSettings =
                [NSDictionary dictionaryWithObject:
                 [NSNumber numberWithInt:kCVPixelFormatType_32BGRA]
                                            forKey:(id)kCVPixelBufferPixelFormatTypeKey];
                
                // If you wish to cap the frame rate to a known value, such as 15 fps, set   
                // minFrameDuration.  
//                output.minFrameDuration = CMTimeMake(1, 15);
                
                AVCaptureStillImageOutput *tmpOutput = [[AVCaptureStillImageOutput alloc] init];
                NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];//输出jpeg
                tmpOutput.outputSettings = outputSettings;

                [session addOutput:tmpOutput];
                
                
                self.stillImageOutput = tmpOutput;
                
                [session startRunning];
                
            } else {
                //NSLog(@"Couldn't add input");
            }
        }
    } else {
        //NSLog(@"Camera not available");
    }
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection
{
//     NSLog(@"add input");

    UIImage* tempImage = [self imageFromSampleBuffer:sampleBuffer];
    
    if (tempImage!=nil) {
        if (self.videoCamBlock!=nil) {
            self.videoCamBlock(tempImage);
        }
    }
}

-(void)startVideoCam:(DidCapturePhotoBlock)camBlock
{
    if (camBlock!=nil) {
        self.videoCamBlock = [camBlock copy];
    }
}

-(void)stopFaceCam
{
    [session stopRunning];
    session=nil;
}
-(AVCaptureDevice *)CameraIfAvailable
{
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *captureDevice = nil;
    for (AVCaptureDevice *device in videoDevices)
    {
        if (device.position == self.cameraType)
        {
            captureDevice = device;
            break;
        }
    }
    //just in case
    if (!captureDevice) {
        captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    
    return captureDevice;
}
//检查设备是否存在闪光灯
- (BOOL) cameraFlashAvailable
{
#ifdef __IPHONE_4_0
    return [UIImagePickerController isFlashAvailableForCameraDevice:
            UIImagePickerControllerCameraDeviceRear];
#else
    return NO;
#endif
}
//检查设备是否存在前置摄像头
- (BOOL) frontCameraAvailable
{
#ifdef __IPHONE_4_0
    return [UIImagePickerController isCameraDeviceAvailable:
            UIImagePickerControllerCameraDeviceFront];
#else
    return NO;
#endif
}
//检查设备是否存在视频摄像头
- (BOOL) videoCameraAvailable  {
    // 首次调用前面的方法，检查是否存在摄像头
    if(![self cameraAvailable])  return NO;
    NSArray *sourceTypes = [UIImagePickerController availableMediaTypesForSourceType:
                            UIImagePickerControllerSourceTypeCamera];
    
    if (![sourceTypes containsObject:(NSString *)kUTTypeMovie]){
        return NO;
    }
    return YES;
}
//检查设备是否存在摄像头
- (BOOL) cameraAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypeCamera];
}

#pragma mark -用户方法
- (void)switchCamera:(BOOL)isFrontCamera
{
    if (![self frontCameraAvailable]) {
        return;
    }
    [self stopFaceCam];
    if (self.cameraType==AVCaptureDevicePositionFront) {
        self.cameraType=AVCaptureDevicePositionBack;
    }else{
        self.cameraType=AVCaptureDevicePositionFront;
    }
    [self startFaceCam];
}

-(AVCaptureFlashMode)currFlashMode
{
    return self.currentDevice.flashMode;
}

-(void)changeFlash
{
    if (![self cameraFlashAvailable]) {
        return;
    }
    
    if (self.cameraType == AVCaptureDevicePositionFront) {
        return;
    }
    
    if ([self.currentDevice hasTorch] && [self.currentDevice hasFlash]) {
        [self.currentDevice lockForConfiguration:nil];
        if (self.currentDevice.flashMode==AVCaptureFlashModeOff) {
            [self.currentDevice setFlashMode:AVCaptureFlashModeAuto];
        }else if (self.currentDevice.flashMode==AVCaptureFlashModeOn){
            [self.currentDevice setFlashMode:AVCaptureFlashModeOff];
        }else if (self.currentDevice.flashMode==AVCaptureFlashModeAuto){
            [self.currentDevice setFlashMode:AVCaptureFlashModeOn];
        }
        if (self.currentDevice.torchMode == AVCaptureTorchModeAuto) {
            [self.currentDevice setTorchMode: AVCaptureTorchModeOn];
        }else if (self.currentDevice.torchMode == AVCaptureTorchModeOff){
            [self.currentDevice setTorchMode: AVCaptureTorchModeAuto];
        }else if (self.currentDevice.torchMode == AVCaptureTorchModeOn){
            [self.currentDevice setTorchMode: AVCaptureTorchModeOff];
        }
        [self.currentDevice unlockForConfiguration];
    }
}
- (void)takePicture:(DidCapturePhotoBlock)block
{
    AVCaptureConnection *videoConnection = [self findVideoConnection];
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
        CFDictionaryRef exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, nil);
        if (exifAttachments) {
            // Do something with the attachments.
        }
        // 获取图片数据
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
        UIImage *t_image = [[UIImage alloc] initWithData:imageData];
        
        //        UIImage *croppedImage=[self scaleAndRotateImage:t_image];
        
        if (block) {
            block(t_image);
        }
        
    }];
    
}
- (AVCaptureConnection*)findVideoConnection {
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in self.stillImageOutput.connections) {
        for (AVCaptureInputPort *port in connection.inputPorts) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) {
            break;
        }
    }
    return videoConnection;
}
//UIImage *image = [self imageFromSampleBuffer:sampleBuffer];

- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    // Get a CMSampleBuffer's Core Video image buffer for the media data
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    // Get the number of bytes per row for the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Create a bitmap graphics context with the sample buffer data
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    // Create a Quartz image from the pixel data in the bitmap graphics context
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // Unlock the pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    // Free up the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // Create an image object from the Quartz image
    //UIImage *image = [UIImage imageWithCGImage:quartzImage];
    UIImage *image = [UIImage imageWithCGImage:quartzImage scale:1.0f orientation:UIImageOrientationRight];
    
    // Release the Quartz image
    CGImageRelease(quartzImage);
    
    return (image);
}


- (UIImage *)scaleAndRotateImage:(UIImage *)image {
    static int kMaxResolution = 320;
    
    CGImageRef imgRef = image.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        } else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
        case UIImageOrientationUp:
            transform = CGAffineTransformIdentity;
            break;
        case UIImageOrientationUpMirrored:
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        case UIImageOrientationDown:
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        case UIImageOrientationLeftMirrored:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationLeft:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRightMirrored:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        case UIImageOrientationRight:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    } else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
