//
//  M_CertificateView.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/15.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"

typedef void (^TCertificateViewBlock)(NSInteger tag,NSString* content);

@interface M_CertificateView : DLView

AS_FACTORY_FRAME(M_CertificateView);

AS_BLOCK(TCertificateViewBlock, block);

-(void)updateImage:(UIImage*)image;

@end
