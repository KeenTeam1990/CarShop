//
//  M_ShaixuanBrandTableView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/22.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_ShaixuanBrandTableView.h"

#import "M_ShaixuanItemCell.h"
#import "M_SeriesListModel.h"


@interface M_ShaixuanBrandTableView ()

AS_INT(showTableIndex);
AS_MODEL_STRONG(NSMutableArray, sectionHeadsKeys);
AS_MODEL_STRONG(NSMutableArray, sortedArrForArrays);

@end

@implementation M_ShaixuanBrandTableView

DEF_FACTORY_FRAME(M_ShaixuanBrandTableView);

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

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempFrame =self.myTableView.frame;
    tempFrame.size = self.bounds.size;
    self.myTableView.frame = tempFrame;
}

-(void)updateData:(NSMutableArray*)data withType:(NSInteger)showTab
{
    self.showTableIndex = showTab;
    
    if (showTab == 0) {
        [self.sortedArrForArrays removeAllObjects];
        [self.sectionHeadsKeys removeAllObjects];
        [self.sortedArrForArrays addObjectsFromArray:[self getChineseStringArr:data]];
    }else if (showTab == 1){
        [self.myDataArray removeAllObjects];
        [self.myDataArray addObjectsFromArray:data];
    }
    
    [self.myTableView reloadData];
}

//固定代码,每次使用只需要将数据模型替换就好,这个方法是获取首字母,将填充给cell的值按照首字母排序
- (NSMutableArray *)getChineseStringArr:(NSMutableArray *)arrToSort
{
    //sort(排序) the ChineseStringArr by pinYin(首字母)
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"myFirst"ascending:YES]];
    [arrToSort sortUsingDescriptors:sortDescriptors];
    NSMutableArray *arrayForArrays = [NSMutableArray array];
    BOOL checkValueAtIndex=NO; //flag to check
    NSMutableArray *TempArrForGrouping =nil;
    for(int index =0; index < [arrToSort count]; index++)
    {
        M_SeriesBrandModel *chineseStr = (M_SeriesBrandModel *)[arrToSort objectAtIndex:index];
        
        NSString *sr = chineseStr.myFirst;
        
        //sr containing here the first character of each string  (这里包含的每个字符串的第一个字符)
        //        NSLog(@"%@",sr);
        //here I'm checking whether the character already in the selection header keys or not  (检查字符是否已经选择头键)
        
        if ([sr notEmpty]) {
            if(![self.sectionHeadsKeys containsObject:[sr uppercaseString]])
            {
                [self.sectionHeadsKeys addObject:[sr uppercaseString]];
                TempArrForGrouping = [NSMutableArray array];
                checkValueAtIndex = NO;
            }
            if([self.sectionHeadsKeys containsObject:[sr uppercaseString]])
            {
                [TempArrForGrouping addObject:[arrToSort objectAtIndex:index]];
                if(checkValueAtIndex ==NO)
                {
                    if (TempArrForGrouping!=nil) {
                        [arrayForArrays addObject:TempArrForGrouping];
                    }
                    checkValueAtIndex = YES;
                }
            }
        }
    }
    return arrayForArrays;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.showTableIndex == 0) {
        return [self.sortedArrForArrays count];
    }
    return 1;
}

//为section添加标题
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* tempView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.myTableView.frame.size.width, 30.0)];
    
    [tempView setBackgroundColor:RGBCOLOR(202, 202, 203)];
    
    UILabel* tempLabel = (UILabel*)[tempView viewWithTag:1001];
    
    if (tempLabel == nil) {
        tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, tempView.frame.size.width-40, tempView.frame.size.height)];
        [tempLabel setBackgroundColor:[UIColor clearColor]];
        [tempLabel setFont:[UIFont systemFontOfSize:14]];
        [tempLabel setTextColor:[UIColor orangeColor]];
        [tempView addSubview:tempLabel];
    }
    
    NSString* tempStr = [self.sectionHeadsKeys objectAtIndex:section];
    if ([tempStr notEmpty]) {
        tempLabel.text = tempStr;
    }
    
    return tempView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.showTableIndex == 0) {
        return 30.0;
    }
    return 0;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionHeadsKeys;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count2 = [self.myDataArray count];
    
    if (self.showTableIndex == 0) {
        NSArray* tempArray = [self.sortedArrForArrays objectAtIndex:section];
        count2 = [tempArray count];
    }
    
    return count2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_ShaixuanItemCell *cell = [M_ShaixuanItemCell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
    
    if (self.showTableIndex == 0) {
        NSMutableArray* tempArray = [self.sortedArrForArrays objectAtIndex:indexPath.section];
        if ([tempArray count]>indexPath.row) {
            [cell configCellIndexPath:indexPath withDataArray:tempArray withTab:self.showTableIndex];
        }
    }else{
    
        if ([self.myDataArray count] > indexPath.row) {
            [cell configCellIndexPath:indexPath withDataArray:self.myDataArray withTab:self.showTableIndex];
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.block = ^(){
        id data = nil;
        switch (self.showTableIndex) {
            case 0:
            {
                for (int i=0; i<[self.sortedArrForArrays count]; i++) {
                    NSMutableArray* tempArray = [self.sortedArrForArrays objectAtIndex:i];
                    if (tempArray!=nil) {
                        for (int j=0; j<[tempArray count]; j++) {
                            M_SeriesBrandModel* tempItem = [tempArray objectAtIndex:j];
                            if (tempItem!=nil) {
                                if (indexPath.row == j && indexPath.section == i) {
                                    tempItem.isSelete = YES;
                                    data = tempItem;
                                }else{
                                    tempItem.isSelete = NO;
                                }
                            }
                        }
                    }
                }
            }
                break;
            case 1:
            {
                for (int i=0; i<[self.myDataArray count]; i++) {
                    M_SeriesItemModel* tempItem = [self.myDataArray objectAtIndex:i];
                    if (tempItem!=nil) {
                        if (indexPath.row == i) {
                            tempItem.isSelete = !tempItem.isSelete;
                            
                        }else{
                            tempItem.isSelete = NO;
                        }
                        if (tempItem.isSelete) {
                            data = tempItem;
                        }
                    }
                }
            }
                break;
            default:
                break;
        }
        
        if (self.block!=nil) {
            self.block(self.showTableIndex,data);
        }
        
        [self.myTableView reloadData];
        
    };
    
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
