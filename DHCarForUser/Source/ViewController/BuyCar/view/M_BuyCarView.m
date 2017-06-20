//
//  M_BuyCarView.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/10/30.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_BuyCarView.h"
#import "MM_BuyCarItemView.h"
#import "Dh_BuyCarModel.h"
@implementation M_BuyCarView
@synthesize mySearchBar,myTableView,buyCarItem,myDataArray;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = [UIColor grayColor];
        self.mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake((ScreenWidth-290)/2, 10, 290, 30)];
        self.mySearchBar.placeholder = @"请输入车型名称";
        [self addSubview:mySearchBar];
        

//        [self.myTableView initTableView:CGRectMake((ScreenWidth-290)/2, 10, 290, 30) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
//        
//        [self addSubview:self.myTableView];
        
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight-NavigationBarHeight-94) style:UITableViewStylePlain];
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
        Dh_BuyCarModel *buyCarModel = [[Dh_BuyCarModel alloc]init];
        //buyCarModel.carName = [NSString stringWithFormat:@"carname_%d",i];
        if (i == 1 ||i == 5 ||i == 8||i == 15 ||i == 18||i == 25 ||i == 28) {
            buyCarModel.discountStr = @"1";
        }else
        {
            buyCarModel.discountStr = @"2";
        }
        
        
         buyCarModel.originalPrice = [NSString stringWithFormat:@"4%d万元",i];
         buyCarModel.presentPrice = [NSString stringWithFormat:@"5%d万元",i];
        
        [self.myDataArray addObject:buyCarModel];
        
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
      
        return self.myDataArray.count/2+1;
    }
    else
    {
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
    
    Dh_BuyCarModel *buyCarModel1 = [self.myDataArray objectAtIndex:indexForModel];
    Dh_BuyCarModel *buyCarModel2 = [[Dh_BuyCarModel alloc]init];
    if (self.myDataArray.count-1>indexForModel)
    {
       buyCarModel2 = [self.myDataArray objectAtIndex:(indexForModel+1)];
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
    
    
    MM_BuyCarItemView *buyCarItemView1= [[MM_BuyCarItemView alloc]initWithFrame:CGRectMake((ScreenWidth-290)/2, 10, 145, 343/2)];
    buyCarItemView1.delegate = self;
    buyCarItemView1.tag = 100+indexPath.row;
    [buyCarItemView1 showUI:buyCarModel1];
    [cell.contentView addSubview:buyCarItemView1];
    
    if (self.myDataArray.count-1>indexForModel) {
        MM_BuyCarItemView *buyCarItemView2= [[MM_BuyCarItemView alloc]initWithFrame:CGRectMake(ScreenWidth/2, 10, 145, 343/2)];
        buyCarItemView2.delegate = self;
        buyCarItemView2.tag = 1000+indexPath.row;
        [buyCarItemView2 showUI:buyCarModel2];
        [cell.contentView addSubview:buyCarItemView2];
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
//        NSUInteger indexForModel = (tag-100)*2;
//        
//    }else{
//        NSUInteger indexForModel = (tag-1000)*2+1;
//    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
