//
//  M_RentalCarView.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/2.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_RentalCarView.h"
#import "MM_RentalCarItemView.h"
#import "Dh_RentalCarModel.h"
@implementation M_RentalCarView
@synthesize myTableView,myDataArray;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = [UIColor grayColor];
        
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NavigationBarHeight-44) style:UITableViewStylePlain];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.rowHeight = 190;
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tempTableView.backgroundColor = [UIColor whiteColor];
        tempTableView.showsVerticalScrollIndicator = NO;
        self.myTableView = tempTableView;
        [self addSubview:self.myTableView];
        
        [self initData];
        
        
    }
    return self;
}

-(void)initData
{
    NSMutableArray *tempArray = [NSMutableArray array];
    
    self.myDataArray = tempArray;
    
    
    
    for (int i= 0; i<69; i++) {
        Dh_RentalCarModel *rentalCarModel = [[Dh_RentalCarModel alloc]init];
        //buyCarModel.carName = [NSString stringWithFormat:@"carname_%d",i];
        if (i == 1 ||i == 5 ||i == 8||i == 15 ||i == 18||i == 25 ||i == 28) {
            rentalCarModel.discountStr = @"1";
        }else
        {
            rentalCarModel.discountStr = @"2";
        }
        
        
        rentalCarModel.originalPrice = [NSString stringWithFormat:@"4%d万",i];
        rentalCarModel.presentPrice = [NSString stringWithFormat:@"5%d万",i];
        
        [self.myDataArray addObject:rentalCarModel];
        
    }
}

-(void)updateViewData:(NSMutableArray*)data withIsRefresh:(BOOL)refresh
{
    if (refresh) {
        [self.myDataArray removeAllObjects];
    }
    
    [self.myDataArray addObjectsFromArray:data];
    
    // [self.myTableView reloadData];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.myDataArray.count%2) {
        NSLog(@"iiii%d",self.myDataArray.count/2+1);
        
        return self.myDataArray.count/2+1;
    }
    else
    {
        NSLog(@"pppp%d",self.myDataArray.count/2);
        return self.myDataArray.count/2;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger indexForModel = indexPath.row *2;
    
    Dh_RentalCarModel *rentalCarModel1 = [self.myDataArray objectAtIndex:indexForModel];
    Dh_RentalCarModel *rentalCarModel2 = [[Dh_RentalCarModel alloc]init];
    if (self.myDataArray.count-1>indexForModel)
    {
        rentalCarModel2 = [self.myDataArray objectAtIndex:(indexForModel+1)];
    }
    
    
    NSString *reuseString = @"cell_reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseString];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseString];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        
    }
    else
    {
        //删除cell的所有子视图
        while ([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    
    MM_RentalCarItemView *rentalCarItemView1= [[MM_RentalCarItemView alloc]initWithFrame:CGRectMake((ScreenWidth-290)/2, 10, 145, 343/2)];
    rentalCarItemView1.delegate = self;
    rentalCarItemView1.tag = 100+indexPath.row;
    [rentalCarItemView1 showUI:rentalCarModel1];
    [cell.contentView addSubview:rentalCarItemView1];
    
    if (self.myDataArray.count-1>indexForModel) {
        MM_RentalCarItemView *rentalCarItemView2= [[MM_RentalCarItemView alloc]initWithFrame:CGRectMake(ScreenWidth/2, 10, 145, 343/2)];
        rentalCarItemView2.delegate = self;
        rentalCarItemView2.tag = 1000+indexPath.row;
        [rentalCarItemView2 showUI:rentalCarModel2];
        [cell.contentView addSubview:rentalCarItemView2];
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)selectTheCarForTag:(NSUInteger)tag
{
    //    for (id View in [self.myTableView subviews])
    //    {
    //        if ([View isKindOfClass:[MM_BuyCarItemView class]])
    //        {
    //            MM_BuyCarItemView *buyCarItemView =(MM_BuyCarItemView *)View;
    //
    //        }
    //
    //    }
    
//    if (tag<=1000) {
////        NSUInteger indexForModel = (tag-100)*2;
//        
//    }else{
//        NSUInteger indexForModel = (tag-1000)*2+1;
//    }
}


@end
