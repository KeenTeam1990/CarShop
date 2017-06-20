//
//  DLVoiceModel.h
//  Auction
//
//  Created by 卢迎志 on 15-1-6.
//
//

#import <Foundation/Foundation.h>
#import "DLFactory.h"
#import "DLModel.h"

@interface DLVoiceModel : NSObject

AS_FACTORY(DLVoiceModel);

AS_MODEL_STRONG(NSString, voiceAmrPath);
AS_MODEL_STRONG(NSString, voiceLenght);
AS_MODEL_STRONG(NSString, voiceWavPath);

-(void)setWavPath:(NSString*)path withLenght:(NSString*)lenght;

-(void)setAmrPath:(NSString*)path withLenght:(NSString*)lenght;

@end
