//
//  M_Shaixuan3View.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/22.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_Shaixuan3View.h"
#import "M_Shaixuan3Cell.h"
#import "M_ConfigDataModel.h"

@interface M_Shaixuan3View ()


@end

@implementation M_Shaixuan3View

DEF_FACTORY_FRAME(M_Shaixuan3View);

DEF_MODEL(block);
DEF_MODEL(topTag);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        [self initTableView:CGRectMake(0, NavigationBarHeight+50, self.frame.size.width, self.frame.size.height - NavigationBarHeight - TabBarHeight - 50) withSeparatoStyle:UITableViewCellSeparatorStyleNone];
        
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tempsingleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
        tempsingleTap.numberOfTapsRequired=1;
        [self addGestureRecognizer:tempsingleTap];
    }
    return self;
}

-(void)singleTap:(UITapGestureRecognizer*)gesture
{
    if (self.block!=nil) {
        self.block(1,-1,nil);
    }
}

-(void)updateShowFrame:(CGRect)frame
{
    CGRect tempFrame = self.myTableView.frame;
    tempFrame.origin = frame.origin;
    tempFrame.size   = frame.size;
    self.myTableView.frame = tempFrame;
}

-(void)updateData:(NSMutableArray*)data
{
    [self.myDataArray removeAllObjects];
    
    [self.myDataArray addObjectsFromArray:data];
    
    NSInteger count1 = [self.myDataArray count]%3==0?[self.myDataArray count]/3:([self.myDataArray count]/3)+1;
    
    CGRect tempFrame = self.myTableView.frame;
    tempFrame.size.height   = 44*count1;
    self.myTableView.frame = tempFrame;
    
    [self.myTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myDataArray count]%3==0?[self.myDataArray count]/3:([self.myDataArray count]/3)+1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_Shaixuan3Cell* cell = [M_Shaixuan3Cell reusableCellOfTableView:tableView style:UITableViewCellStyleDefault];
    
    [cell configCellIndexPath:indexPath withDataArray:self.myDataArray];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.block = ^(id data){
        
        M_ConfigDataItemModel* tempModel = (M_ConfigDataItemModel*)data;
        
        for (int i=0; i<[self.myDataArray count]; i++) {
            M_ConfigDataItemModel* tempItem = [self.myDataArray objectAtIndex:i];
            if (tempItem!=nil) {
                if ([tempItem.myName isEqualToString:tempModel.myName]) {
                }else{
                    tempItem.isSelete = NO;
                }
            }
        }
        
        if (self.block!=nil) {
            self.block(0,self.topTag,data);
        }
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
