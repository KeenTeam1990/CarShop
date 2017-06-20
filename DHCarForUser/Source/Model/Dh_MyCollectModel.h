//
//  Dh_MyCollectModel.h
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/12.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"
#import "DLBaseModel.h"
#import "M_CarListModel.h"
@interface Dh_MyCollectItemModel : DLBaseModel
AS_FACTORY(Dh_MyCollectItemModel);

AS_MODEL_STRONG(NSString, collect_id);//收藏ID
AS_MODEL_STRONG(NSString, collect_time);//收藏时间
AS_MODEL_STRONG(M_CarItemModel, car);

@end

@interface Dh_MyCollectModel : DLBaseModel

AS_FACTORY(Dh_MyCollectModel);
AS_MODEL_STRONG(NSMutableArray, itemArray);



@end
