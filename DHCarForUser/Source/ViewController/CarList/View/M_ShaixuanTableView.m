//
//  M_ShaixuanTableView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_ShaixuanTableView.h"
#import "M_ShaixuanItemCell.h"
#import "M_BrandListModel.h"
#import "M_SubBrandListModel.h"
#import "M_CarTypeListModel.h"
#import "M_CarPriceListModel.h"
#import "M_CarYearListModel.h"

@interface M_ShaixuanTableView ()

AS_INT(showTableIndex);
AS_MODEL_STRONG(NSMutableArray, sectionHeadsKeys);
AS_MODEL_STRONG(NSMutableArray, sortedArrForArrays);

@end

@implementation M_ShaixuanTableView

DEF_FACTORY_FRAME(M_ShaixuanTableView);

DEF_MODEL(showTableIndex);
DEF_MODEL(sortedArrForArrays);
DEF_MODEL(sectionHeadsKeys);
DEF_MODEL(block);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.sortedArrForArrays = [NSMutableArray allocInstance];
        self.sectionHeadsKeys = [NSMutableArray allocInstance];
        
        [self initTableView:self.bounds withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    }
    
    return self;
}

-(void)updateData:(NSMutableArray*)data withType:(NSInteger)showTab
{
    self.showTableIndex = showTab;
    
    [self.myDataArray removeAllObjects];
    
    [self.myDataArray addObjectsFromArray:data];
    
    [self.myTableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_ShaixuanItemCell *cell = [M_ShaixuanItemCell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
    
    if ([self.myDataArray count] > indexPath.row) {
        [cell configCellIndexPath:indexPath withDataArray:self.myDataArray withTab:self.showTableIndex];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (self.showTableIndex) {
        case 0:
            {
                for (int i=0; i<[self.myDataArray count]; i++) {
                    M_BrandBigItemModel* tempItem = [self.myDataArray objectAtIndex:i];
                    if (tempItem!=nil) {
                        if (indexPath.row == i) {
                            tempItem.seleted = !tempItem.seleted;
                        }else{
                            tempItem.seleted = NO;
                        }
                    }
                }
            }
            break;
        case 1:
        {
            for (int i=0; i<[self.myDataArray count]; i++) {
                M_BrandItemModel* tempItem = [self.myDataArray objectAtIndex:i];
                if (tempItem!=nil) {
                    if (indexPath.row == i) {
                        tempItem.seleted = !tempItem.seleted;
                    }else{
                        tempItem.seleted = NO;
                    }
                }
            }
        }
            break;
        case 2:
        {
            for (int i=0; i<[self.myDataArray count]; i++) {
                M_SubBrandItemModel* tempItem = [self.myDataArray objectAtIndex:i];
                if (tempItem!=nil) {
                    if (indexPath.row == i) {
                        tempItem.seleted = !tempItem.seleted;
                    }else{
                        tempItem.seleted = NO;
                    }
                }
            }
        }
            break;
        case 3:
        {
            for (int i=0; i<[self.myDataArray count]; i++) {
                M_CarYearItemModel* tempItem = [self.myDataArray objectAtIndex:i];
                if (tempItem!=nil) {
                    if (indexPath.row == i) {
                        tempItem.seleted = !tempItem.seleted;
                    }else{
                        tempItem.seleted = NO;
                    }
                }
            }
        }
            break;
        case 4:
        {
            for (int i=0; i<[self.myDataArray count]; i++) {
                M_CarTypeItemModel* tempItem = [self.myDataArray objectAtIndex:i];
                if (tempItem!=nil) {
                    if (indexPath.row == i) {
                        tempItem.seleted = !tempItem.seleted;
                    }else{
                        tempItem.seleted = NO;
                    }
                }
            }
        }
            break;
        case 5:
        {
            for (int i=0; i<[self.myDataArray count]; i++) {
                M_CarPriceItemModel* tempItem = [self.myDataArray objectAtIndex:i];
                if (tempItem!=nil) {
                    if (indexPath.row == i) {
                        tempItem.seleted = !tempItem.seleted;
                    }else{
                        tempItem.seleted = NO;
                    }
                }
            }
        }
            break;
        default:
            break;
    }
    
    if (self.block!=nil) {
        self.block(self.showTableIndex,[self.myDataArray objectAtIndex:indexPath.row]);
    }
    
    [self.myTableView reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
