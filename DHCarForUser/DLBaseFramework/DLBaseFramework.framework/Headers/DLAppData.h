//
//  DLAppData.h
//  FinanceIM
//
//  Created by lucaslu on 15/10/27.
//  Copyright © 2015年 lucaslu. All rights reserved.
//  用户数据类

#import <Foundation/Foundation.h>
#import "DLSingleton.h"
#import "DLModel.h"

typedef enum {
    
    EADTNotNULL,
    EADTEndEditing,
}TDLAppDataType;

typedef void (^TDLAppDataBlock)(TDLAppDataType tag,id data);

@interface DLAppData : NSObject

AS_SINGLETON(DLAppData);

AS_FLOAT(httpTimerOut);

AS_BLOCK(TDLAppDataBlock, block);

AS_MODEL_STRONG(NSString, myUserName);
AS_MODEL_STRONG(NSString, myPassword);

AS_MODEL_STRONG(NSString, myUserKey);

AS_MODEL_STRONG(NSString, myCurrCityName);
AS_MODEL_STRONG(NSString, myCurrCityCode);
AS_MODEL_STRONG(NSString, myCurrCityId);

AS_MODEL_STRONG(NSString, myUserCity);

AS_BOOL(currCityChangeToSpecial);
AS_BOOL(currCityChangeToRental);
AS_BOOL(currCityChangeToNew);
AS_BOOL(currCityChangeToDealer);


@end
