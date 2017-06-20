//
//  D_SeleteCityViewController.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_SeleteCityViewController.h"
#import "M_SearchView.h"
#import "TTReqEngine.h"
#import "M_CityListModel.h"
#import "M_CityItemCell.h"

@interface D_SeleteCityViewController ()

AS_MODEL_STRONG(M_SearchView, mySearchView);
AS_MODEL_STRONG(NSMutableArray, sectionHeadsKeys);
AS_MODEL_STRONG(NSMutableArray, sortedArrForArrays);
AS_MODEL_STRONG(NSMutableArray,myCityDataArray);

AS_INT(currReqIndex);

@end

@implementation D_SeleteCityViewController

DEF_FACTORY(D_SeleteCityViewController);

DEF_MODEL(mySearchView);
DEF_MODEL(sortedArrForArrays);
DEF_MODEL(sectionHeadsKeys);
DEF_MODEL(currReqIndex);
DEF_MODEL(myCityDataArray);

DEF_MODEL(block);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.myCityDataArray = [NSMutableArray allocInstance];
    self.sortedArrForArrays = [NSMutableArray allocInstance];
    self.sectionHeadsKeys = [NSMutableArray allocInstance];
    
    [self initView];
    
    [self initData];
}

-(void)initView
{
    [self addCustomNavBar:@"选择城市"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:nil];
    
    self.mySearchView = [M_SearchView allocInstanceFrame:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, 50)];
//    [self.baseView addSubview:self.mySearchView];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    
}

-(void)initData
{
    __weak D_SeleteCityViewController* tempSelf = self;
    self.mySearchView.block = ^(NSString* keyword){
        [tempSelf search:keyword];
    };
    
    [self.myDataArray removeAllObjects];
    
    [self getData];
}

-(void)getData
{

    [TTReqEngine C_GetCity_listprovince_id:nil
                                withStatus:@"1"
                                 withBlock:^(BOOL success, id dataModel) {
        if (success) {
            
            M_CityList2Model* tempModel = (M_CityList2Model*)dataModel;
            if (tempModel!=nil) {
                
                [self.myCityDataArray removeAllObjects];
                [self.myCityDataArray addObjectsFromArray:tempModel.myAllCityArray];
                self.currReqIndex = 0;
                
                [self.myDataArray removeAllObjects];
                [self.myDataArray addObjectsFromArray:tempModel.myAllCityArray];
                
                [self.sortedArrForArrays removeAllObjects];
                [self.sectionHeadsKeys removeAllObjects];
                
                [self.sortedArrForArrays addObjectsFromArray:[self getChineseStringArr:self.myDataArray]];
                
                //[self defaultAddr];
                
                [self.myTableView reloadData];
            }
        }
    }];
}

-(void)defaultAddr
{
    if ([[DLAppData sharedInstance].myCurrCityId notEmpty]) {
        [self.sectionHeadsKeys insertObject:@"当前" atIndex:0];
        
        M_CityItemModel* tempItem = [M_CityItemModel allocInstance];
        
        tempItem.myCity_Id = [DLAppData sharedInstance].myCurrCityId;
        tempItem.myCity_Code = [DLAppData sharedInstance].myCurrCityCode;
        tempItem.myCity_Name = [DLAppData sharedInstance].myCurrCityName;
        
        NSMutableArray* tempArray = [NSMutableArray allocInstance];
        [tempArray addObject:tempItem];
        [self.sortedArrForArrays insertObject:tempArray atIndex:0];
    }
}

-(void)search:(NSString*)keyword
{
    NSString* tempKeyword = keyword;
    
    if ([tempKeyword notEmpty]) {
        NSMutableArray* tempArray = [NSMutableArray array];
        
        for (int i=0; i<[self.myDataArray count]; i++) {
            M_CityItemModel* tempItem = [self.myDataArray objectAtIndex:i];
            if (tempItem!=nil) {
                NSRange tempRange = [tempItem.myCity_Name rangeOfString:tempKeyword];
                
                if (tempRange.length>0) {
                    [tempArray addObject:tempItem];
                }
            }
        }
        if ([tempArray count]>0) {
            [self.sortedArrForArrays removeAllObjects];
            [self.sectionHeadsKeys removeAllObjects];
            
            [self.sortedArrForArrays addObjectsFromArray:[self getChineseStringArr:tempArray]];
            
            [self.myTableView reloadData];
        }else{
            [self.sortedArrForArrays removeAllObjects];
            [self.sectionHeadsKeys removeAllObjects];
            [self.sortedArrForArrays addObjectsFromArray:[self getChineseStringArr:self.myDataArray]];
            [self.myTableView reloadData];
        }
    }else{
        [self.sortedArrForArrays removeAllObjects];
        [self.sectionHeadsKeys removeAllObjects];
        [self.sortedArrForArrays addObjectsFromArray:[self getChineseStringArr:self.myDataArray]];
        [self.myTableView reloadData];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [APPDELEGATE.viewController.homeController showOrHideCustomTabaBar:NO];
}

-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


//固定代码,每次使用只需要将数据模型替换就好,这个方法是获取首字母,将填充给cell的值按照首字母排序
- (NSMutableArray *)getChineseStringArr:(NSMutableArray *)arrToSort
{
    //sort(排序) the ChineseStringArr by pinYin(首字母)
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"myCity_First"ascending:YES]];
    [arrToSort sortUsingDescriptors:sortDescriptors];
    NSMutableArray *arrayForArrays = [NSMutableArray array];
    BOOL checkValueAtIndex=NO; //flag to check
    NSMutableArray *TempArrForGrouping =nil;
    for(int index =0; index < [arrToSort count]; index++)
    {
        M_CityItemModel *chineseStr = (M_CityItemModel *)[arrToSort objectAtIndex:index];
        
        NSString *sr = chineseStr.myCity_First;
        
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

#pragma table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sortedArrForArrays count];
}

//为section添加标题
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* tempView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.myTableView.frame.size.width, 40.0)];
    
    [tempView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel* tempLabel = (UILabel*)[tempView viewWithTag:1001];
    
    if (tempLabel == nil) {
        tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, tempView.frame.size.width-40, tempView.frame.size.height)];
        [tempLabel setBackgroundColor:[UIColor clearColor]];
        [tempLabel setFont:[UIFont systemFontOfSize:16]];
        [tempLabel setTextColor:[UIColor redColor]];
        [tempView addSubview:tempLabel];
    }
    
    NSString* tempStr = [self.sectionHeadsKeys objectAtIndex:section];
    if ([tempStr notEmpty]) {
        tempLabel.text = tempStr;
    }
    
    UIImageView* tempLine = [tempView viewWithTag:1002];
    if (tempLine == nil) {
        tempLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, tempView.frame.size.height-1, tempView.frame.size.width-30, 1)];
        tempLine.tag = 1002;
        tempLine.backgroundColor = RGBCOLOR(202, 202, 202);
        [tempView addSubview:tempLine];
    }
    
    return tempView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionHeadsKeys;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_CityItemCell *cell = [M_CityItemCell reusableCellOfTableView:tableView style:UITableViewCellStyleValue1];
    NSMutableArray* tempArray = [self.sortedArrForArrays objectAtIndex:indexPath.section];
    if ([tempArray count]>indexPath.row) {
        [cell configCellIndexPath:indexPath withDataArray:tempArray];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* tempArray = [self.sortedArrForArrays objectAtIndex:section];
    NSInteger count = [tempArray count];

    return count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray* tempArray = [self.sortedArrForArrays objectAtIndex:indexPath.section];
    if (tempArray!=nil) {
        M_CityItemModel* tempItem = [tempArray objectAtIndex:indexPath.row];
        if (tempItem!=nil) {
            if (self.block!=nil) {
                self.block(tempItem);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
