//
//  DLVideoModel.h
//  Auction
//
//  Created by 卢迎志 on 15-1-6.
//
//

#import <Foundation/Foundation.h>
#import "DLFactory.h"
#import "DLModel.h"

@interface DLVideoModel : NSObject

AS_FACTORY(DLVideoModel);

AS_MODEL_STRONG(NSString, videoLogo);
AS_MODEL_STRONG(NSString, videoSize);
AS_MODEL_STRONG(NSString, videoLenght);
AS_MODEL_STRONG(NSString, videoPath);
AS_MODEL_STRONG(NSURL, videoUrl);

@end
