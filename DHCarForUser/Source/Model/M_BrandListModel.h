//
//  M_BrandListModel.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLBaseModel.h"

@class M_BrandBigItemModel;

@interface M_BrandItemModel : DLBaseModel

AS_FACTORY(M_BrandItemModel);

AS_MODEL_STRONG(NSString, myBrand_id);
AS_MODEL_STRONG(NSString, myBrand_name);
AS_MODEL_STRONG(NSString, myBrand_code);
AS_MODEL_STRONG(NSString, myBrand_img);
AS_MODEL_STRONG(NSString, myBrand_first);

AS_MODEL_STRONG(M_BrandBigItemModel, myBigItemModel);

AS_BOOL(seleted);

@end

@interface M_BrandBigItemModel : DLBaseModel

AS_FACTORY(M_BrandBigItemModel);

AS_MODEL_STRONG(NSString, myBigBrand_id);
AS_MODEL_STRONG(NSString, myBigBrand_name);
AS_MODEL_STRONG(NSString, myBigBrand_code);
AS_MODEL_STRONG(NSString, myBigBrand_img);
AS_MODEL_STRONG(NSString, myBigBrand_first);

AS_MODEL_STRONG(NSMutableArray, myBrandArray);

AS_BOOL(seleted);

@end

@interface M_BrandListModel : DLBaseModel

AS_FACTORY(M_BrandListModel);

AS_MODEL_STRONG(NSMutableArray,myBigBrandArray);
AS_MODEL_STRONG(NSMutableArray, myBrandArray);

@end
