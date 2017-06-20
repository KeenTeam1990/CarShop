//
//  D_SeleteDealerViewController.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "D_SeleteDealerViewController.h"
#import "TTReqEngine.h"
#import "M_DealerListModel.h"
#import "M_DealerItemModel.h"
#import "M_SeleteDealerItemCell.h"

@interface D_SeleteDealerViewController ()

AS_MODEL_STRONG(UIView, myBottomView);

@end

@implementation D_SeleteDealerViewController

DEF_FACTORY(D_SeleteDealerViewController);

DEF_MODEL(myCarItemModel);
DEF_MODEL(myCityItemModel);
DEF_MODEL(carType);
DEF_MODEL(myBottomView);
DEF_MODEL(myInquiryData);

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initView];
    
    [self initData];
}

-(void)initView
{
    
    NSString* tempRight = @"";
    NSInteger temptabHeight =TabBarHeight;
    if (self.isRadio) {
        tempRight = @"确定";
        temptabHeight = 0;
    }
    
    // 初始化导航条
    [self addCustomNavBar:@"选择经销商"
              withLeftBtn:@"icon_back.png"
             withRightBtn:nil
            withLeftLabel:@"返回"
           withRightLabel:tempRight];
    
    [self initTablePlainView:CGRectMake(0, NavigationBarHeight, self.baseView.frame.size.width, self.baseView.frame.size.height-NavigationBarHeight-temptabHeight) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
    
    self.myBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.baseView.frame.size.height-TabBarHeight, self.baseView.frame.size.width, TabBarHeight)];
    [self.baseView addSubview:self.myBottomView];
    
    UIImageView* tempLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.myBottomView.frame.size.width, 1)];
    tempLine.backgroundColor = RGBCOLOR(186, 186, 187);
    [self.myBottomView addSubview:tempLine];
    
    UIButton* tempAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tempAllBtn.frame = CGRectMake(10, (self.myBottomView.frame.size.height-40)/2, 80, 40);
    [tempAllBtn addTarget:self action:@selector(allBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [tempAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    [tempAllBtn setTitle:@"反选" forState:UIControlStateSelected];
    [tempAllBtn setTitleColor:RGBCOLOR(202, 202, 202) forState:UIControlStateNormal];
    [tempAllBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [tempAllBtn.layer setMasksToBounds:YES];
    [tempAllBtn.layer setBorderWidth:1];
    [tempAllBtn.layer setBorderColor:RGBCOLOR(202, 202, 202).CGColor];
    [tempAllBtn.layer setCornerRadius:5];
    tempAllBtn.tag = 9990;
    [self.myBottomView addSubview:tempAllBtn];
    
    UIImage* tempBtnBg = [UIImage imageNamed:@"登录.png"];
    UIImage* tempBtn_HBg = [UIImage imageNamed:@"登录按下.png"];
    
    UIButton* tempInquiryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tempInquiryBtn addTarget:self action:@selector(inquiryBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [tempInquiryBtn setBackgroundImage:[tempBtnBg stretchableImageWithLeftCapWidth:tempBtnBg.size.width/2 topCapHeight:tempBtnBg.size.height/2] forState:UIControlStateNormal];
    [tempInquiryBtn setBackgroundImage:[tempBtn_HBg stretchableImageWithLeftCapWidth:tempBtn_HBg.size.width/2 topCapHeight:tempBtn_HBg.size.height/2] forState:UIControlStateHighlighted];
    [tempInquiryBtn setTitle:@"我要询价" forState:UIControlStateNormal];
    [tempInquiryBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    tempInquiryBtn.frame = CGRectMake(self.myBottomView.frame.size.width-80-10 , (self.myBottomView.frame.size.height-40)/2, 80, 40);
    tempInquiryBtn.tag = 9991;
    [self.myBottomView addSubview:tempInquiryBtn];
    
    self.myBottomView.hidden = self.isRadio;
}

-(void)allBtnPressed:(id)sender
{
    if ([self.myDataArray count]>0) {
        UIButton* tempBtn = [self.myBottomView viewWithTag:9990];
        if (tempBtn!=nil) {
            if (tempBtn.isSelected) {
                [tempBtn setSelected:NO];
                for (int i=0; i<[self.myDataArray count]; i++) {
                    M_DealerItemModel* tempItem = [self.myDataArray objectAtIndex:i];
                    if (tempItem!=nil) {
                        tempItem.selete = NO;
                    }
                }
            }else{
                [tempBtn setSelected:YES];
                
                for (int i=0; i<[self.myDataArray count]; i++) {
                    M_DealerItemModel* tempItem = [self.myDataArray objectAtIndex:i];
                    if (tempItem!=nil) {
                        tempItem.selete = YES;
                    }
                }
            }
        }
        
        [self.myTableView reloadData];
    }
}

-(void)inquiryBtnPressed:(id)sender
{
    if (self.myInquiryData!=nil) {
        
        NSDictionary* tempDic = self.myInquiryData;
        
        NSString* tempName = [tempDic hasItemAndBack:@"name"];
        NSString* tempCode = [tempDic hasItemAndBack:@"code"];
        NSString* tempMemo = [tempDic hasItemAndBack:@"memo"];
        NSString* tempPhone =  [tempDic hasItemAndBack:@"phone"];
        
        NSString* tempDealerids = @"";
        
        if ([self.myDataArray count]>0) {
            for (int i=0; i<[self.myDataArray count]; i++) {
                M_DealerItemModel* tempItem = [self.myDataArray objectAtIndex:i];
                if (tempItem!=nil) {
                    if (tempItem.selete) {
                        if (tempDealerids.length == 0) {
                            tempDealerids = tempItem.dealer_car_id;
                        }else{
                            tempDealerids = [NSString stringWithFormat:@"%@^%@",tempDealerids,tempItem.dealer_car_id];
                        }
                    }
                }
            }
        }
        
        if (tempDealerids.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请至少选择一个经销商进行询价"];
            return;
        }
        
        NSString* temptype = @"";
        if(self.carType == EB_NewCar){
            temptype = @"1";
        }else if(self.carType == EB_SpeciaiCar){
            temptype = @"2";
        }else if(self.carType == EB_RentaiCar){
            temptype = @"3";
        }
        
        
    }
}

-(void)initData
{
    [self getData];
}


-(void)getData
{
    NSString* tempCarLtype = @"";
    if (self.carType == EB_NewCar) {
        tempCarLtype = @"3";
    }else if (self.carType == EB_RentaiCar){
        tempCarLtype = @"2";
    }else if (self.carType == EB_SpeciaiCar){
        tempCarLtype = @"1";
    }
    
    if (self.myCarItemModel!=nil) {
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_SeleteDealerItemCell *cell = [M_SeleteDealerItemCell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
    
    if ([self.myDataArray count] > indexPath.row) {
        [cell configCellIndexPath:indexPath withDataArray:self.myDataArray];
    }
    
    cell.isRadio = self.isRadio;
    
    cell.block = ^(NSInteger tag,M_DealerItemModel* model){
        
        if (tag == 1) {
            
        }else{
            if (model!=nil) {
                [self seleteItem:model];
            }
        }
    };
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_DealerItemModel* tempItem = [self.myDataArray objectAtIndex:indexPath.row];
    if (tempItem!=nil) {
        [self seleteItem:tempItem];
    }
}

-(void)seleteItem:(M_DealerItemModel*)data
{
    if (self.isRadio) {
        data.selete = !data.selete;
        
        for (int i=0; i<[self.myDataArray count]; i++) {
            M_DealerItemModel* tempItem = [self.myDataArray objectAtIndex:i];
            if (tempItem!=nil) {
                if (tempItem.dealer_id != data.dealer_id) {
                    tempItem.selete = NO;
                }
            }
        }
    }else{
        data.selete  =!data.selete;
        
        BOOL tempSelete = NO;
        
        for (int i=0; i<[self.myDataArray count]; i++) {
            M_DealerItemModel* tempItem = [self.myDataArray objectAtIndex:i];
            if (tempItem!=nil) {
                if (tempItem.selete) {
                    tempSelete = YES;
                    break;
                }
            }
        }
        
        UIButton* tempBtn = [self.myBottomView viewWithTag:9990];
        if (tempBtn!=nil) {
            [tempBtn setSelected:tempSelete];
        }
        
    }
    [self.myTableView reloadData];

}

-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnPressed:(id)sender
{
    if ([self.myDataArray count]>0) {
        M_DealerItemModel* tempresult = nil;
        for (int i=0; i<[self.myDataArray count]; i++) {
            M_DealerItemModel* tempItem = [self.myDataArray objectAtIndex:i];
            if (tempItem!=nil) {
                if (tempItem.selete) {
                    tempresult = tempItem;
                    break;
                }
            }
        }
        if (tempresult!=nil) {
            if (self.block!=nil) {
                self.block(tempresult);
            }
        }
        
        [self.navigationController popViewControllerAnimated:YES];
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
