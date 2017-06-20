//
//  SVProgressGifHUD.h
//  Auction
//
//  Created by 卢迎志 on 14-12-10.
//
//

#import <UIKit/UIKit.h>
#import "DLSingleton.h"

@interface SVProgressGifHUD : UIView

AS_SINGLETON(SVProgressGifHUD);

+ (void)show;
+ (void)showWithOverlay;

+ (void)dismiss;

+ (void)setGifWithImages:(NSArray *)images;
+ (void)setGifWithImageName:(NSString *)imageName;
+ (void)setGifWithURL:(NSURL *)gifUrl;


@end
