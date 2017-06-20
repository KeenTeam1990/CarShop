//
//  LL_MyCenterCollectionCell.h
//  DHCarForUser
//
//  Created by leiyu on 16/3/23.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LL_MyCenterCollectionCell : UICollectionViewCell
-(void)updateMyCell:(NSString *)title andWithImageName:(NSString *)imageName;

-(void)upDateOnlyMytitle:(NSString *)title;
@end
