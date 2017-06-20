//
//  M_BannerItemModel.h
//  Auction
//
//  Created by 卢迎志 on 14-12-9.
//
//

#import <UIKit/UIKit.h>

@interface M_BannerItemModel : DLBaseModel

AS_FACTORY(M_BannerItemModel);

AS_MODEL_STRONG(NSString, itemId);
AS_MODEL_STRONG(NSString, itemName);
AS_MODEL_STRONG(NSString, itemImage);
AS_MODEL_STRONG(NSString, itemUrl);
AS_MODEL_STRONG(NSString, itemSource);
AS_MODEL_STRONG(NSString, itemStatus);
AS_MODEL_STRONG(NSString, itemCity_Id);

@end

@interface M_BannerModel : DLBaseModel

AS_FACTORY(M_BannerModel);

AS_MODEL_STRONG(NSMutableArray, myItemArray);

@end
