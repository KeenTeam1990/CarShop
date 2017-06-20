//
//  UIImage+DLExtension.h
//  Auction
//
//  Created by 卢迎志 on 14-12-10.
//
//

#import <UIKit/UIKit.h>

@interface UIImage(DLExtension)

//将UIImage缩放到指定大小尺寸
- (UIImage *)scaleToSize:(CGSize)size;

//gif
+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)url;
+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)data;
+ (UIImage *)animatedImageWithAnimatedGIFName:(NSString *)name;

//alpha
- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;
- (CGImageRef)newBorderMask:(NSUInteger)borderSize size:(CGSize)size;

//cut
- (UIImage *)clipImageWithScaleWithsize:(CGSize)asize;
- (UIImage *)clipImageWithScaleWithsize:(CGSize)asize roundedCornerImage:(NSInteger)roundedCornerImage borderSize:(NSInteger)borderSize;
//Enhancing
-(UIImage*)autoEnhance;

-(UIImage*)redEyeCorrection;

- (UIImage*)saturateImage:(float)saturationAmount withContrast:(float)contrastAmount;

//resize

- (UIImage *)croppedImage:(CGRect)bounds;
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality;
- (CGAffineTransform)transformForOrientation:(CGSize)newSize;

- (UIImage *)fixOrientation;


- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

//roundedcorner

- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;
- (void)addRoundedRectToPath:(CGRect)rect context:(CGContextRef)context ovalWidth:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight;

//splitImageIntoTwoParts
+ (NSArray*)splitImageIntoTwoParts:(UIImage*)image;

@end
