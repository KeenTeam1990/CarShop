//
//  M_CarDetailTabView.m
//  DHCarForSales
//
//  Created by lucaslu on 15/11/1.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarDetailTabView.h"

@interface M_CarDetailTabView ()

AS_MODEL_STRONG(NSMutableArray, myTabsArray);
AS_MODEL_STRONG(UIView, myView);

@end

@implementation M_CarDetailTabView

DEF_FACTORY_FRAME(M_CarDetailTabView);
DEF_MODEL(block);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.myTabsArray = [NSMutableArray allocInstance];
        
        self.myView = [[UIView alloc]initWithFrame:CGRectZero];
        [self.myView.layer setMasksToBounds:YES];
        [self.myView.layer setCornerRadius:5];
        [self.myView.layer setBorderWidth:1];
        [self.myView.layer setBorderColor:[UIColor redColor].CGColor];
        [self addSubview:self.myView];
    }
    return self;
}

-(void)addTabItem:(M_CarDetailTabItemModel*)tabModel
{
    [self.myTabsArray addObject:tabModel];
}

-(void)defaultShow
{
    if ([self.myTabsArray count]>0) {
        
        M_CarDetailTabItemModel* tempItem = [self.myTabsArray objectAtIndex:0];
        if (tempItem!=nil) {
            tempItem.isSelete = YES;
            
            if (self.block!=nil) {
                self.block(0);
            }
        }
    }
}

-(NSInteger)count
{
    return [self.myTabsArray count];
}

-(void)updateData
{
    if ([self.myTabsArray count]>0) {

        NSInteger count = [self.myTabsArray count];
        
        NSInteger tempOffset = 20;
        
        NSInteger hcount = 1;
        NSInteger wcount = count;
        NSInteger line = 0;
        
        NSInteger btn_X = 0;
        NSInteger btn_Y = 0;
        NSInteger btn_W = (self.frame.size.width-tempOffset*2)/wcount;
        NSInteger btn_H = 40;
        
        NSInteger view_H = btn_H*hcount-1;
        
        self.myView.frame = CGRectMake(tempOffset, (self.frame.size.height-view_H)/2, self.frame.size.width-tempOffset*2-4, view_H);
        
        for (int i=0; i<count; i++) {
            
            M_CarDetailTabItemModel* tempModel = [self.myTabsArray objectAtIndex:i];
            if (tempModel != nil) {
                
                UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                
                [tempBtn.layer setMasksToBounds:YES];
                [tempBtn.layer setBorderWidth:1];
                [tempBtn.layer setBorderColor:[UIColor redColor].CGColor];
                if (tempModel.isSelete) {
                    [tempBtn.layer setBackgroundColor:[UIColor redColor].CGColor];
                    [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }else{
                    [tempBtn.layer setBackgroundColor:[UIColor whiteColor].CGColor];
                    [tempBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                }
                
                [tempBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [tempBtn setTitle:tempModel.myName forState:UIControlStateNormal];
                tempBtn.tag = 1000+i;
                tempBtn.frame = CGRectMake(btn_X, btn_Y, btn_W, btn_H);
                [tempBtn addTarget:self action:@selector(tabBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
                [self.myView addSubview:tempBtn];
                
                btn_X+=btn_W-line;
                if (i!=0 && (i+1)%wcount==0) {
                    btn_Y+=btn_H-1;
                    btn_X = 0;
                }
            }
        }
    }
}

-(void)tabBtnPressed:(id)sender
{
    UIButton* tempbtn = (UIButton*)sender;
    
    for (int i=0; i<[self.myView.subviews count]; i++) {
        UIButton* tempItem = (UIButton*)[self.myView.subviews objectAtIndex:i];
        M_CarDetailTabItemModel* tempModel = [self.myTabsArray objectAtIndex:i];
        if (tempItem!=nil) {
            if (tempItem.tag == tempbtn.tag) {
                tempModel.isSelete = YES;
                [tempItem.layer setBackgroundColor:[UIColor redColor].CGColor];
                [tempItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }else{
                tempModel.isSelete = NO;
                [tempItem.layer setBackgroundColor:[UIColor whiteColor].CGColor];
                [tempItem setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
            
        }
    }
    
    if (self.block!=nil) {
        self.block(tempbtn.tag-1000);
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
