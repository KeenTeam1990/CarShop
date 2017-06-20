//
//  M_DealerCarItemCell.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/10.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLTableViewCell.h"
#import "AppPublicData.h"

@interface M_DealerCarItemCell : DLTableViewCell

AS_MODEL(TCarBottomType, carType);

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array;

@end
