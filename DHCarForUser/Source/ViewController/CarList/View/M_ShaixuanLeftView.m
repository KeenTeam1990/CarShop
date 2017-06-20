//
//  M_ShaixuanLeftView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_ShaixuanLeftView.h"
#import "M_ShaixuanLeftItemCell.h"

@interface M_ShaixuanLeftView ()

@end

@implementation M_ShaixuanLeftView

DEF_FACTORY_FRAME(M_ShaixuanLeftView);
DEF_MODEL(block);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initTableView:CGRectMake(0, 0, frame.size.width, frame.size.height) withSeparatoStyle:UITableViewCellSeparatorStyleSingleLine];
        self.myTableView.backgroundColor = RGBCOLOR(238, 238, 238);
    }
    
    return self;
}
-(void)updateData:(NSMutableArray*)array
{
    [self.myDataArray removeAllObjects];
    [self.myDataArray addObjectsFromArray:array];
    
    [self.myTableView reloadData];
}

-(void)updateTabIndex:(NSInteger)tabIndex
{
    if ([self.myDataArray count]>0) {
        for (int i=0; i<[self.myDataArray count]; i++) {
            M_ShaiXuanLeftItemModel* tempItem = [self.myDataArray objectAtIndex:i];
            if (tempItem!=nil) {
                if (tabIndex == i) {
                    tempItem.currSeleted = YES;
                }else{
                    tempItem.currSeleted = NO;
                }
            }
        }
        
        if (self.block!=nil) {
            self.block(tabIndex);
        }
    }
    
    [self.myTableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_ShaixuanLeftItemCell *cell = [M_ShaixuanLeftItemCell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
    
    if ([self.myDataArray count] > indexPath.row) {
        [cell configCellIndexPath:indexPath withDataArray:self.myDataArray];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_ShaiXuanLeftItemModel* tempItem = [self.myDataArray objectAtIndex:indexPath.row];
    if (tempItem!=nil) {
        
        for (int i=0; i<[self.myDataArray count]; i++) {
            M_ShaiXuanLeftItemModel* tempModel = [self.myDataArray objectAtIndex:i];
            if (tempModel!=nil) {
                tempModel.currSeleted = NO;
            }
        }
        
        tempItem.currSeleted = YES;
        
        if (self.block!=nil) {
            self.block(indexPath.row);
        }
        
        [self.myTableView reloadData];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
