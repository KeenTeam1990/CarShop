//
//  M_SeriesListModel.h
//  DHCarForUser
//
//  Created by lucaslu on 15/12/22.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@interface M_SeriesItemModel : DLBaseModel

AS_FACTORY(M_SeriesItemModel);

AS_MODEL_STRONG(NSString, myId);
AS_MODEL_STRONG(NSString, myBid);
AS_MODEL_STRONG(NSString, myBBid);
AS_MODEL_STRONG(NSString, myName);

AS_BOOL(isSelete);

@end

@interface M_SeriesBrandModel : DLBaseModel

AS_FACTORY(M_SeriesBrandModel);

AS_MODEL_STRONG(NSString, myId);
AS_MODEL_STRONG(NSString, myName);
AS_MODEL_STRONG(NSString, myFirst);
AS_MODEL_STRONG(NSString, myImg);
AS_MODEL_STRONG(NSString, myCode);

AS_BOOL(isSelete);

AS_MODEL_STRONG(NSMutableArray, mySeriesArray);

@end

@interface M_SeriesListModel : DLBaseModel

AS_FACTORY(M_SeriesListModel);

AS_MODEL_STRONG(NSMutableArray, myItemArray);

@end
