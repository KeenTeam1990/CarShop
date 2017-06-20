//
//  LL_HomeListView.h
//  DHCarForUser
//
//  Created by leiyu on 16/3/23.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MyClickImageBlock)(NSInteger tag);
@interface LL_HomeListView : UIView
AS_BLOCK(MyClickImageBlock, myClickBlock);
/**
 *  循环创建ImageView
 *
 *  @param myArr 存放三个图片的数组
 */
-(void)upDataWithMyArr:(NSArray *)myArr;
@end
