//
//  M_CarDetailsView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/23.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarDetailsView.h"
#import "M_CarDetailHeaderView.h"
#import "M_SeleteDealerItemCell.h"
#import "DLTableViewCell.h"
#import "M_CarListModel.h"
#import "M_CarDealerRanterItemCell.h"
#import "M_CarDealerSpecialItemCell.h"
#import "M_SeleteDealerItemCell.h"

@implementation M_DetailIconTextModel

DEF_FACTORY(M_DetailIconTextModel);

DEF_MODEL(myImage);
DEF_MODEL(myTag);
DEF_MODEL(myText);
DEF_MODEL(myUrl);

@end

@interface M_CarDetailsView ()

AS_MODEL_STRONG(UIView, myTableHeaderView);
AS_MODEL_STRONG(M_CarDetailHeaderView, myHeaderView);
AS_MODEL_STRONG(NSMutableArray, myIconTextArray);

AS_INT(currTabIndex);

AS_MODEL_STRONG(M_DealerItemModel, mySeleteItemModel);
AS_MODEL_STRONG(M_DealerItemModel, myFirstSeleteItemModel);
AS_MODEL_STRONG(UIView, myLeaseView);
AS_MODEL_STRONG(UILabel, myLeasePriceLabel);
AS_MODEL_STRONG(M_CarItemModel, myCarModel);//车的对象
AS_INT(currSortIndex);

@end

@implementation M_CarDetailsView

DEF_FACTORY_FRAME(M_CarDetailsView);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.currSortIndex = 0;
        
        self.myIconTextArray = [NSMutableArray allocInstance];
        
        [self initTableView:CGRectMake(0, 0, frame.size.width, frame.size.height) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
        
        NSInteger headerHeight = 220+100;
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            headerHeight = 440+100;
        }
        
        self.myHeaderView = [M_CarDetailHeaderView allocInstanceFrame:CGRectMake(0, 0, self.frame.size.width, headerHeight)];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempFrame = self.myTableView.frame;
    tempFrame.size.width = self.bounds.size.width;
    tempFrame.size.height = self.bounds.size.height;
    self.myTableView.frame = tempFrame;
}

-(void)updateHeaderData:(M_CarItemModel*)model
{
    self.myCarModel = [M_CarItemModel  allocInstance];
    self.myCarModel = model;
    [self.myHeaderView updateData:model];
    
    if ([model.myParameterArray count]>0) {

        NSInteger headerHeight = 220+100;
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            headerHeight = 440+100;
        }
        
        CGRect tempFrame = self.myHeaderView.frame;
        tempFrame.size.height = headerHeight+30*([model.myParameterArray count]%2==0?[model.myParameterArray count]/2:([model.myParameterArray count]/2)+1);
        self.myHeaderView.frame = tempFrame;
    }
    
    self.myTableView.tableHeaderView = self.myHeaderView;
    
    [self initLineData];
    
    [self.myTableView reloadData];
}

-(void)updateData:(NSMutableArray*)data withTabIndex:(NSInteger)tabIndex
{
    self.currTabIndex = tabIndex;
    
    [self.myDataArray removeAllObjects];
    
    [self.myDataArray addObjectsFromArray:data];
    
    if (self.currTabIndex == 1) {
        
        if ([self.myDataArray count]>0) {
            self.myFirstSeleteItemModel = [self.myDataArray objectAtIndex:0];
            self.mySeleteItemModel = nil;
        }
    }
    
    [self initLineData];
    
    if (tabIndex == 1) {
        
        if ([self.myDataArray count]>0) {
            
            M_DealerItemModel* tempItemModel = [self.myDataArray objectAtIndex:0];
            
            M_CarLeaseItemModel* tempLItem = [tempItemModel.myLeaseArray objectAtIndex:0];
            self.payMonth = [NSString stringWithFormat:@"%@期 首付：%@万元",tempLItem.myLease_Loan,tempLItem.myLease_Panyment];
        }
        
    }

    [self.myTableView reloadData];
}

-(void)initLineData
{
    [self.myIconTextArray removeAllObjects];
    
    M_DetailIconTextModel* temoITItem = [M_DetailIconTextModel allocInstance];
    temoITItem.myText = @"车型说明";
    temoITItem.myImage = @"icon_car.png";
     NSString *str = [NSString stringWithFormat:@"%@/customservice?car_id=%@&type=explain",KH5Host,self.myCarModel.myCar_Id];
    temoITItem.myUrl = str;
    temoITItem.myTag = 0;
    [self.myIconTextArray addObject:temoITItem];
    
    
    temoITItem = [M_DetailIconTextModel allocInstance];
    temoITItem.myText = @"产品参数";
    temoITItem.myImage = @"icon_spec.png";
    str = [NSString stringWithFormat:@"%@/customservice?car_id=%@&type=parameter",KH5Host,self.myCarModel.myCar_Id];
    temoITItem.myUrl = str;
    temoITItem.myTag = 1;
    [self.myIconTextArray addObject:temoITItem];
    
    temoITItem = [M_DetailIconTextModel allocInstance];
    temoITItem.myText = @"售后政策";
    temoITItem.myImage = @"icon_shou.png";
    str = [NSString stringWithFormat:@"%@/customservice?car_id=%@&type=policy",KH5Host,self.myCarModel.myCar_Id];
    temoITItem.myUrl = str;
    temoITItem.myTag = 2;
    [self.myIconTextArray addObject:temoITItem];
    
    if (self.currTabIndex == 1) {
        temoITItem = [M_DetailIconTextModel allocInstance];
        temoITItem.myText = @"租购说明";
        temoITItem.myImage = @"icon_sound2.png";
        str = [NSString stringWithFormat:@"%@/customservice?car_id=%@&type=hire&city_id=%@",KH5Host,self.myCarModel.myCar_Id,APPDELEGATE.viewController.myCityModel.myCity_Id];
        temoITItem.myUrl = str;
        temoITItem.myTag = 3;
        [self.myIconTextArray addObject:temoITItem];
    }
}

#pragma mark-
#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    
    if (section == 0) {
        count = [self.myIconTextArray count];
    }else if (section == 1){
        count = [self.myDataArray count];
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        DLTableViewCell* cell = [DLTableViewCell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        if ([self.myIconTextArray count]>indexPath.row) {
            M_DetailIconTextModel* tempItem = [self.myIconTextArray objectAtIndex:indexPath.row];
            if (tempItem!=nil) {
                cell.textLabel.text = tempItem.myText;
                cell.imageView.image = [UIImage imageNamed:tempItem.myImage];
            }
        }
        
        UIImageView* tempLine = [cell.contentView viewWithTag:1001];
        if (tempLine == nil) {
            tempLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, tableView.frame.size.width, 1)];
            tempLine.backgroundColor = RGBCOLOR(202, 202, 202);
            [cell.contentView addSubview:tempLine];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else if (indexPath.section == 1){
        
        switch (self.currTabIndex) {
            case 0:
                {
                    M_CarDealerSpecialItemCell* cell = [M_CarDealerSpecialItemCell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    [cell configCellIndexPath:indexPath withDataArray:self.myDataArray];
                    
                    cell.block = ^(NSInteger tag,id data){
                        if (tag == 0) {
                            M_DealerItemModel* tempItem = (M_DealerItemModel*)data;
                            if (tempItem!=nil) {
                                
                                for (int i=0; i<[self.myDataArray count]; i++) {
                                    M_DealerItemModel* tempDIM = [self.myDataArray objectAtIndex:i];
                                    if (tempDIM!=nil) {
                                        if (![tempDIM.dealer_id isEqualToString:tempItem.dealer_id]) {
                                            tempDIM.selete = NO;
                                        }else{
                                            tempDIM.selete = YES;
                                        }
                                    }
                                }
                                
                                if (self.block!=nil) {
                                    self.block(9999,nil);
                                }
                                
                                [self.myTableView reloadData];
                            }
                        }
                    };
                    
                    return cell;
                }
                break;
            case 1:
                {
                    M_CarDealerRanterItemCell* cell = [M_CarDealerRanterItemCell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.showFirstSelete = self.myFirstSeleteItemModel!=nil?YES:NO;
                    
                    [cell configCellIndexPath:indexPath withDataArray:self.myDataArray];
                    
                    cell.block = ^(NSInteger tag,id data){
                        if (tag == 0) {
                            M_DealerItemModel* tempItem = (M_DealerItemModel*)data;
                            if (tempItem!=nil) {
                                
                                self.mySeleteItemModel = tempItem;
                                
                                self.myFirstSeleteItemModel = nil;
                                
                                for (int i=0; i<[self.myDataArray count]; i++) {
                                    M_DealerItemModel* tempDIM = [self.myDataArray objectAtIndex:i];
                                    if (tempDIM!=nil) {
                                        if (![tempDIM.dealer_id isEqualToString:tempItem.dealer_id]) {
                                            tempDIM.selete = NO;
                                        }
                                    }
                                }
                                
                                if (self.block!=nil) {
                                    self.block(9999,nil);
                                }
                                
                                [self.myTableView reloadData];
                                
                            }
                        }
                    };
                    
                    return cell;
                }
                break;
            case 2:
                {
                    M_SeleteDealerItemCell* cell = [M_SeleteDealerItemCell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.isRadio = NO;
                    
                    [cell configCellIndexPath:indexPath withDataArray:self.myDataArray];
                    
                    cell.block = ^(NSInteger tag,M_DealerItemModel* model){
                        if(tag == 1){//试乘试驾
                            if (self.block!=nil) {
                                self.block(0,model);
                            }
                        }else if(tag == 2){//预定
                            if (self.block!=nil) {
                                self.block(-2,model);
                            }
                        }else if(tag == 3){//拨打电话
                            if (self.block!=nil) {
                                self.block(-1,model);
                            }
                        }
                    };
                    
                    return cell;
                }
                break;
            default:
                break;
        }
    }
    
    return nil;
}

#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    
    if (indexPath.section == 0) {
        height = 50;
    }else if (indexPath.section == 1){
       
        switch (self.currTabIndex) {
            case 0:
                height = 120;
                break;
            case 1:
                height = 120;
                break;
            case 2:
                height = 150;
                break;
            default:
                break;
        }
    }
    
    return height;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0;
    
    if (section == 1 && [self.myDataArray count] > 0) {
        height = 70;
        
        if (self.currTabIndex == 1) {
            if (self.myFirstSeleteItemModel!=nil) {
                NSInteger num = [self.myFirstSeleteItemModel.myLeaseArray count]%4==0?([self.myFirstSeleteItemModel.myLeaseArray count]/4):([self.myFirstSeleteItemModel.myLeaseArray count]/4)+1;
                height+=40+50*num;
            }else if(self.mySeleteItemModel!=nil){
                if ([self.mySeleteItemModel.myLeaseArray count]>0) {
                    NSInteger num = [self.mySeleteItemModel.myLeaseArray count]%4==0?([self.mySeleteItemModel.myLeaseArray count]/4):([self.mySeleteItemModel.myLeaseArray count]/4)+1;
                    height+=40+50*num;
                }
            }
        }
    }
    
    return height;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 70)];
    [tempView setBackgroundColor:[UIColor whiteColor]];
    
    UIView* tempLine = [tempView viewWithTag:1000];
    if (tempLine == nil) {
        tempLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tempView.frame.size.width, 10)];
        [tempLine setBackgroundColor:RGBCOLOR(233, 233, 233)];
        tempLine.tag = 1000;
        [tempView addSubview:tempLine];
    }
    
    UILabel* tempLabel = [tempView viewWithTag:1001];
    if (tempLabel == nil) {
        tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, tempView.frame.size.width-100, tempView.frame.size.height-10)];
        tempLabel.style = DLLabelStyleMake(style.backgroundColor = [UIColor clearColor];
                                           style.textStyle.font = [UIFont systemFontOfSize:14];
                                           style.textStyle.textColor = [UIColor blackColor];);
        tempLabel.tag = 1001;
        [tempView addSubview:tempLabel];
    }
    
    UIButton* tempBtn = [tempView viewWithTag:1002];
    if (tempBtn == nil) {
        tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [tempBtn addTarget:self action:@selector(headerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        tempBtn.tag = 1002;
        tempBtn.frame = CGRectMake(tempView.frame.size.width-110, 10+(tempView.frame.size.height-10-30)/2, 100, 30);
        tempBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor];
                                          style.cornerRedius = 2;
                                          style.borderWidth = 1;
                                          style.borderColor = RGBCOLOR(202, 202, 202););
        
        [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tempBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [tempView addSubview:tempBtn];
    }
    
    if (self.currTabIndex == 1 ) {
        
        M_DealerItemModel* tempDealerModel = nil;
        
        if (self.myFirstSeleteItemModel!=nil) {
            tempDealerModel = self.myFirstSeleteItemModel;
        }else if (self.mySeleteItemModel!=nil){
            tempDealerModel = self.mySeleteItemModel;
        }
        NSInteger num = 0;
        
        if (tempDealerModel!=nil) {
            num = [tempDealerModel.myLeaseArray count]%4==0?([tempDealerModel.myLeaseArray count]/4):([tempDealerModel.myLeaseArray count]/4)+1;
        }
        
        UIImageView* tempbV = [tempView viewWithTag:1008];
        if (tempbV == nil) {
            tempbV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 70, tempView.frame.size.width, 40+50*num)];
            tempbV.tag = 1008;
            [tempbV setBackgroundColor:RGBCOLOR(234, 234, 234)];
            [tempView addSubview:tempbV];
        }
        
        UILabel* tempPrice = [tempView viewWithTag:1003];
        
        if (tempPrice == nil) {
            tempPrice = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, tempView.frame.size.width-20, 40)];
            [tempPrice setBackgroundColor:[UIColor clearColor]];
            
            tempPrice.font = [UIFont systemFontOfSize:16];
            [tempPrice setTextColor:[UIColor redColor]];
            tempPrice.tag = 1003;
            [tempView addSubview:tempPrice];
        }
        
        UILabel* tempLeaseLabel = [tempView viewWithTag:1004];
        
        if (tempLeaseLabel==nil) {
            tempLeaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, 40, 50)];
            [tempLeaseLabel setBackgroundColor:[UIColor clearColor]];
            tempLeaseLabel.text = @"租期";
            tempLeaseLabel.font = [UIFont systemFontOfSize:12];
            tempLeaseLabel.textColor = [UIColor blackColor];
            tempLeaseLabel.tag = 1004;
            [tempView addSubview:tempLeaseLabel];
        }
        
        UIView* tempLeaseView = [tempView viewWithTag:1005];
        if (tempLeaseView == nil) {
            tempLeaseView = [[UIView alloc]initWithFrame:CGRectMake(50, 110, tempView.frame.size.width-70, 50*num)];
            tempLeaseView.tag = 1005;
            [tempView addSubview:tempLeaseView];
        }
    
        self.myLeaseView = tempLeaseView;
        self.myLeasePriceLabel = tempPrice;
        
        if (tempDealerModel!=nil) {
            if ([tempDealerModel.myLeaseArray count]>0) {
                for (int i=0; i<[tempLeaseView.subviews count]; i++) {
                    UIButton* tempBtn = [tempLeaseView.subviews objectAtIndex:i];
                    if (tempBtn!=nil) {
                        [tempBtn removeFromSuperview];
                    }
                }
                
                NSInteger count = [tempDealerModel.myLeaseArray count];
                
                NSInteger wcount = 4;
                
                NSInteger w = (tempLeaseView.frame.size.width-5*(wcount+1))/wcount;
                NSInteger h = 30;
                
                NSInteger x = 0;
                NSInteger y = (tempLeaseView.frame.size.height-h*num+5*(num-1))/2;
                
                for (int i=0; i<count; i++) {
                    
                    M_CarLeaseItemModel* tempLItem = [tempDealerModel.myLeaseArray objectAtIndex:i];
                    if (tempLItem!=nil) {
                        
                        UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                        [tempBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                        tempBtn.tag = 1000+i;
                        
                        tempBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                        
                        if (tempLItem.isSelete) {
                            tempBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor];
                                                              style.cornerRedius = 2;
                                                              style.borderWidth = 1;
                                                              style.borderColor = [UIColor redColor];);
                            [tempBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                            
                            if ([tempLItem.myLease_Panyment notEmpty]) {
                                tempPrice.text = [NSString stringWithFormat:@"首付：%@万元",tempLItem.myLease_Panyment];
                            }
                        }else{
                            tempBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor];
                                                              style.cornerRedius = 2;
                                                              style.borderWidth = 1;
                                                              style.borderColor = RGBCOLOR(202, 202, 202););
                            [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        }
                        
                        if ([tempLItem.myLease_Loan notEmpty]) {
                            [tempBtn setTitle:[NSString stringWithFormat:@"%@期",tempLItem.myLease_Loan] forState:UIControlStateNormal];
                        }
                        
                        tempBtn.frame = CGRectMake(x, y, w, h);
                        
                        [tempLeaseView addSubview:tempBtn];
                        
                        if (i!=0 && (i+1)%wcount == 0) {
                            x = 0;
                            y += h+5;
                        }else{
                            x+=w+5;
                        }
                    }
                }
            }
        }
    }
    
    if (self.currTabIndex == 0) {
        tempLabel.text = @"选择经销商(单选)";
    }else if (self.currTabIndex == 1) {
        tempLabel.text = @"选择经销商(单选)";
    }else if (self.currTabIndex == 2) {
        tempLabel.text = @"选择经销商(可多选)";
    }
    
    if (self.currSortIndex == 0) {
        [tempBtn setTitle:@"距离排序" forState:UIControlStateNormal];
    }else if (self.currSortIndex == 1){
        [tempBtn setTitle:@"价格排序" forState:UIControlStateNormal];
    }
    
    tempBtn.hidden = YES;
    if (self.currTabIndex == 1) {
        tempBtn.hidden = YES;
    }
    
    return tempView;
}

-(void)updateMonth:(NSInteger)selectIndex
{
        for (int i=0; i<[self.mySeleteItemModel.myLeaseArray count]; i++) {
            
            M_CarLeaseItemModel* tempLItem = [self.mySeleteItemModel.myLeaseArray objectAtIndex:i];
            if (tempLItem!=nil) {
                
                UIButton* tempItemBtn = [self.myLeaseView viewWithTag:1000+i];
                if (tempItemBtn!=nil) {
                    
                    if (selectIndex+1000 == tempItemBtn.tag) {
                        tempLItem.isSelete = YES;
                    }else{
                        tempLItem.isSelete = NO;
                    }
                    
                    if (tempLItem.isSelete) {
                        tempItemBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor];
                                                              style.cornerRedius = 2;
                                                              style.borderWidth = 1;
                                                              style.borderColor = [UIColor redColor];);
                        [tempItemBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                        
                        if ([tempLItem.myLease_Panyment notEmpty]) {
                            self.myLeasePriceLabel.text = [NSString stringWithFormat:@"首付：%@万元",tempLItem.myLease_Panyment];
                        }
                    }else{
                        tempItemBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor];
                                                              style.cornerRedius = 2;
                                                              style.borderWidth = 1;
                                                              style.borderColor = RGBCOLOR(202, 202, 202););
                        [tempItemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    }
                }
            }
        }
}

-(void)buttonPressed:(id)sender
{
    UIButton* tempBtn = (UIButton*)sender;
    self.selectIndex =tempBtn.tag -1000;
    NSString *month = tempBtn.titleLabel.text;
    if (tempBtn!=nil) {
        
        for (int i=0; i<[self.mySeleteItemModel.myLeaseArray count]; i++) {
            
            M_CarLeaseItemModel* tempLItem = [self.mySeleteItemModel.myLeaseArray objectAtIndex:i];
            if (tempLItem!=nil) {
                
                UIButton* tempItemBtn = [self.myLeaseView viewWithTag:1000+i];
                if (tempItemBtn!=nil) {
                    
                    if (tempBtn.tag == tempItemBtn.tag) {
                        tempLItem.isSelete = YES;
                    }else{
                        tempLItem.isSelete = NO;
                    }
                    
                    if (tempLItem.isSelete) {
                        tempItemBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor];
                                                              style.cornerRedius = 2;
                                                              style.borderWidth = 1;
                                                              style.borderColor = [UIColor redColor];);
                        [tempItemBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                        
                        if ([tempLItem.myLease_Panyment notEmpty]) {
                            self.myLeasePriceLabel.text = [NSString stringWithFormat:@"首付：%@万元",tempLItem.myLease_Panyment];
                            self.payMonth = [NSString stringWithFormat:@"%@ %@",month,self.myLeasePriceLabel.text];
                        }
                    }else{
                        tempItemBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor];
                                                              style.cornerRedius = 2;
                                                              style.borderWidth = 1;
                                                              style.borderColor = RGBCOLOR(202, 202, 202););
                        [tempItemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    }
                }
            }
        }
    }
}

-(void)headerBtnPressed:(id)sender
{
    if (self.currSortIndex == 0) {
        NSSortDescriptor * sortByA = [NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:YES];
        [self.myDataArray sortUsingDescriptors:[NSArray arrayWithObjects:sortByA, nil]];
        self.currSortIndex  = 1;
    }else if (self.currSortIndex == 1){
        NSSortDescriptor * sortByA = [NSSortDescriptor sortDescriptorWithKey:@"price" ascending:YES];
        [self.myDataArray sortUsingDescriptors:[NSArray arrayWithObjects:sortByA, nil]];
        self.currSortIndex  = 0;
    }
    
    [self.myTableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        M_DetailIconTextModel* tempItem = [self.myIconTextArray objectAtIndex:indexPath.row];
        if (tempItem!=nil) {
            if (self.block!=nil) {
                self.block(tempItem.myTag+1,tempItem);
            }
        }
    }else if (indexPath.section == 1){
        if (self.currTabIndex == 2) {
            M_DealerItemModel* tempItme = [self.myDataArray objectAtIndex:indexPath.row];
            if (tempItme!=nil) {
                tempItme.selete = !tempItme.selete;
                
                [self.myTableView reloadData];
            }
        }
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
