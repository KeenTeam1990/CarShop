//
//  DLPickerDataSource.h
//  Traderoute
//
//  Created by 卢迎志 on 15-1-27.
//  Copyright (c) 2015年 卢迎志. All rights reserved.
//

#import "DLModel.h"
#import "DLFactory.h"

@interface DLPickerDataSource : NSObject

AS_FACTORY(DLPickerDataSource);

AS_INT(pickComponentsCount);

AS_MODEL_STRONG(NSMutableArray, firstArray);
AS_MODEL_STRONG(NSMutableArray, secondArray);
AS_MODEL_STRONG(NSMutableArray, threeArray);

AS_FLOAT(pfirstWidth);
AS_FLOAT(psecondWidth);
AS_FLOAT(pthreeWidth);

AS_INT(seleteFirstIndex);
AS_INT(seleteSecondIndex);
AS_INT(seleteThreeIndex);


@end
