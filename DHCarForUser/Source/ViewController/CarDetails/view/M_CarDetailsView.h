//
//  M_CarDetailsView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/23.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableView.h"
#import "M_CarListModel.h"

//tag
// 0试乘试驾
// -1 拨打电话
// -2 预定
// 9999 单项选择（预定和租购使用）
typedef void (^TCarDetailsViewBlock)(NSInteger tag,id data);

@interface M_DetailIconTextModel : NSObject

AS_FACTORY(M_DetailIconTextModel);

AS_MODEL_STRONG(NSString, myImage);
AS_MODEL_STRONG(NSString, myText);
AS_MODEL_STRONG(NSString, myUrl);

AS_INT(myTag);

@end

@interface M_CarDetailsView : DLTableView

AS_FACTORY_FRAME(M_CarDetailsView);

AS_BLOCK(TCarDetailsViewBlock, block);

AS_MODEL_STRONG(NSString, payMonth);
AS_INT(selectIndex);

-(void)updateHeaderData:(M_CarItemModel*)model;

-(void)updateData:(NSMutableArray*)data withTabIndex:(NSInteger)tabIndex;
-(void)updateMonth:(NSInteger)selectIndex;

@end
