//
//  DLCropImageVIew.m
//  TickTock
//
//  Created by 卢迎志 on 14-12-12.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import "DLCropImageVIew.h"
#import <AVFoundation/AVFoundation.h>

@implementation DLCropImageVIew

DEF_FACTORY_FRAME(DLCropImageVIew);

DEF_MODEL(myCropRect);
DEF_MODEL(myCropRectView);
DEF_MODEL(myImage);
DEF_MODEL(myImageView);
DEF_MODEL(myScrollview);
DEF_MODEL(myZoomView);

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-(void)setMyCropRect:(CGRect)rect
{
    myCropRect  = rect;
    
    [self initScrollView];
    [self initCropView];
    
    if (self.myImage!=nil) {
        [self initImageView];
    }
}


-(void)initScrollView
{
    self.myScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, (self.frame.size.height-self.myCropRect.size.height)/2, self.myCropRect.size.width, self.myCropRect.size.height)];
    self.myScrollview.delegate = self;
    self.myScrollview.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    self.myScrollview.backgroundColor = [UIColor clearColor];
    self.myScrollview.maximumZoomScale = 10.0f;
    self.myScrollview.showsHorizontalScrollIndicator = NO;
    self.myScrollview.showsVerticalScrollIndicator = NO;
    self.myScrollview.bounces = NO;
    self.myScrollview.bouncesZoom = NO;
    self.myScrollview.clipsToBounds = NO;
    [self addSubview:self.myScrollview];
    
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    rotationGestureRecognizer.delegate = self;
    [self.myScrollview addGestureRecognizer:rotationGestureRecognizer];
}

-(void)initImageView
{
    int maxWidth = self.myCropRect.size.width;
    int maxHeight = self.myCropRect.size.height;
    
    int width = self.myImage.size.width;
    int height = self.myImage.size.height;
    int newWidth = 0;
    int newHeight = 0;
    if (width > height) {
        newHeight = maxHeight;
        newWidth = (int) (((double) newHeight / height) * width);
    }else{
        newWidth = maxWidth;
        newHeight = (int) (((double) newWidth / width) * height);
    }
    
    NSLog(@"newWidth : %d",newWidth);
    NSLog(@"newHeight : %d",newHeight);
    
    int offset = 0;
    
    self.myZoomView =  [[UIView alloc]initWithFrame:CGRectMake(0, offset, newWidth, newHeight+offset)];
    [self.myZoomView setBackgroundColor:[UIColor clearColor]];
    [self.myScrollview addSubview:self.myZoomView];
    
    self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, newWidth, newHeight)];
    self.myImageView.image = self.myImage;
    [self.myZoomView addSubview:self.myImageView];
    
    self.myScrollview.contentSize = CGSizeMake(newWidth, newHeight+offset);
    self.myScrollview.contentOffset = CGPointMake(0, (newHeight+offset-self.myCropRect.size.height)/2);
}

-(void)initCropView
{
    UIImage* tempImage = [UIImage imageNamed:@"editiamge_bord.png"];
    
    self.myCropRectView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (self.frame.size.height-self.myCropRect.size.height)/2, self.myCropRect.size.width, self.myCropRect.size.height)];
    [self.myCropRectView setBackgroundColor:[UIColor clearColor]];
    self.myCropRectView.image = tempImage;
    [self addSubview:self.myCropRectView];
}

- (UIImage *)CropImage
{
    CGRect cropRect = [self convertRect:self.myCropRectView.frame toView:self.myZoomView];
    
    CGSize size = self.myImageView.image.size;
    
    CGFloat ratio = 1.0f;
    
    if (size.width > size.height) {
        ratio = CGRectGetWidth(AVMakeRectWithAspectRatioInsideRect(self.myImageView.image.size, self.myCropRectView.frame)) / size.height;
    }else{
        ratio = CGRectGetHeight(AVMakeRectWithAspectRatioInsideRect(self.myImageView.image.size, self.myCropRectView.frame)) / size.width;
    }
    
    CGRect zoomedCropRect = CGRectMake(cropRect.origin.x / ratio,
                                       cropRect.origin.y / ratio,
                                       cropRect.size.width / ratio,
                                       cropRect.size.height / ratio);
    
    UIImage *rotatedImage = [self rotatedImageWithImage:self.myImageView.image transform:self.myImageView.transform];
    
    CGImageRef croppedImage = CGImageCreateWithImageInRect(rotatedImage.CGImage, zoomedCropRect);
    UIImage *image = [UIImage imageWithCGImage:croppedImage scale:1.0f orientation:rotatedImage.imageOrientation];
    CGImageRelease(croppedImage);
    
    return image;
}

- (UIImage *)rotatedImageWithImage:(UIImage *)image transform:(CGAffineTransform)transform
{
    CGSize size = image.size;
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, size.width / 2, size.height / 2);
    CGContextConcatCTM(context, transform);
    CGContextTranslateCTM(context, size.width / -2, size.height / -2);
    [image drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    
    UIImage *rotatedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return rotatedImage;
}



- (void)handleRotation:(UIRotationGestureRecognizer *)gestureRecognizer
{
    CGFloat rotation = gestureRecognizer.rotation;
    
    CGAffineTransform transform = CGAffineTransformRotate(self.myImageView.transform, rotation);
    self.myImageView.transform = transform;
    gestureRecognizer.rotation = 0.0f;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.myZoomView;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGPoint contentOffset = scrollView.contentOffset;
    *targetContentOffset = contentOffset;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
