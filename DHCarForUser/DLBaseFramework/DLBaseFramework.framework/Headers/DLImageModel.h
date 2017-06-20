//
//  DLImageModel.h
//  Auction
//
//  Created by 卢迎志 on 15-1-6.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DLFactory.h"
#import "DLModel.h"

@interface DLImageModel : NSObject

AS_FACTORY(DLImageModel);

AS_MODEL_STRONG(NSString, imagePath);
AS_MODEL_STRONG(UIImage, image);

-(void)setImage:(UIImage *)img withPath:(NSString*)path;

@end
