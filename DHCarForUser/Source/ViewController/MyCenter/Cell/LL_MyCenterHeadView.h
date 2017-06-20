//
//  LL_MyCenterHeadView.h
//  DHCarForUser
//
//  Created by leiyu on 16/3/23.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MyBtnBlock)();
@interface LL_MyCenterHeadView : UICollectionReusableView
AS_BLOCK(MyBtnBlock, myBlock);
AS_MODEL_STRONG(UIButton, myNameAndSexbtn);
-(void)updateMyHeadImage:(NSString *)url andWithMyName:(NSString *)name andWihtSex:(NSString *)sex;
@end
