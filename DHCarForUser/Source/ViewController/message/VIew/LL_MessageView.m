//
//  LL_MessageView.m
//  DHCarForUser
//
//  Created by leiyu on 15/12/24.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "LL_MessageView.h"
#import "M_MessageFirstCell.h"

#import "M_CarMessageDetailModel.h"

@implementation LL_MessageView

DEF_FACTORY_FRAME(LL_MessageView);
DEF_MODEL(block);
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initTableView:CGRectMake(0, 0, frame.size.width, frame.size.height) withSeparatoStyle:UITableViewCellSeparatorStyleSingleLine];
    }
    return self;
}

-(void)resetGetData
{
    if (self.block!=nil) {
        self.block(0,nil);
    }
}

-(void)updateData:(NSMutableArray *)dataArr
{
    if ([dataArr count] == 0) {
        [self showPageError:YES withIsError:NO];
    }else{
        [self showPageError:NO withIsError:NO];
        [self.myDataArray removeAllObjects];
        
        [self.myDataArray addObjectsFromArray:dataArr];
        
        [self.myTableView reloadData];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myDataArray count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_MessageFirstCell *cell=[M_MessageFirstCell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
    
    if ([self.myDataArray count]>indexPath.row) {
        M_MyMessageItemModel *model=self.myDataArray[indexPath.row];
        if (model!=nil) {
            [cell updataItemModel:model];
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_MyMessageItemModel *tempItem = [self.myDataArray objectAtIndex:indexPath.row];
    if (tempItem!= nil) {
        if (self.block != nil) {
            self.block(1,tempItem);
        }
    }

}
@end
