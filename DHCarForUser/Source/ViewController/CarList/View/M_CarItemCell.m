//
//  M_CarItemCell.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarItemCell.h"
#import "M_CarItemView.h"
#import "M_IndexModel.h"

@interface M_CarItemCell ()

AS_MODEL_STRONG(NSMutableArray, myDataArray);
AS_MODEL_STRONG(NSMutableArray, myViewArray);

@end

@implementation M_CarItemCell

DEF_MODEL(myDataArray);
DEF_MODEL(myViewArray);
DEF_MODEL(block);
DEF_MODEL(carType);

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        self.myViewArray = [NSMutableArray allocInstance];
        self.myDataArray = [NSMutableArray allocInstance];
        
        NSInteger w = self.bounds.size.width/2;
        NSInteger h = 200;
        NSInteger x = 0;
        NSInteger y = 0;
        
        for (int i=0; i<2; i++) {
            
            M_CarItemView* tempView = [M_CarItemView allocInstanceFrame:CGRectMake(x, y, w, h)];

            tempView.tag = 1000+i;
            if (i==1) {
                tempView.showLine = NO;
            }else{
                tempView.showLine = YES;
            }
            [self.myViewArray addObject:tempView];
            [self.contentView addSubview:tempView];
            
            [tempView setUserInteractionEnabled:YES];
            
            UITapGestureRecognizer *tempsingleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
            tempsingleTap.numberOfTapsRequired=1;
            [tempView addGestureRecognizer:tempsingleTap];
            
            x+=w;
        }
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger w = self.bounds.size.width/2;
    NSInteger x = 0;
    for (int i=0; i<[self.myViewArray count]; i++) {
        M_CarItemView* tempView = [self.myViewArray objectAtIndex:i];
        if (tempView!=nil) {
            
            CGRect tempFrame = tempView.frame;
            tempFrame.origin.x = x;
            tempFrame.size.width = w;
            tempView.frame = tempFrame;
            
            x+=w;
        }
    }
}

-(void)singleTap:(UITapGestureRecognizer*)gesture
{
    M_CarItemView* tempView = (M_CarItemView*)gesture.view;
    
    M_CarItemModel* tempModel = [self.myDataArray objectAtIndex:tempView.tag-1000];
    if (tempModel!=nil) {
        
        if (self.block!=nil) {
            self.block(tempModel);
        }
    }
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    for (int i=0; i<[self.myViewArray count]; i++) {
        UIView* tempView = [self.myViewArray objectAtIndex:i];
        if (tempView!=nil) {
            tempView.hidden = YES;
        }
    }
    
    NSInteger row = 0;
    NSInteger count = row+2;
    
    if (count >= [array count]) {
        count = [array count];
    }
    
    [self.myDataArray removeAllObjects];
    
    int index = 0;
    for (NSInteger i=row; i<count; i++) {
        
        M_IndexLineItemModel* tempLineItem = [array objectAtIndex:i];
        
        M_CarItemModel* tempItem = tempLineItem.myCarModel;
        if (tempItem!=nil) {
            
            [self.myDataArray addObject:tempItem];
            
            M_CarItemView* tempView = [self.myViewArray objectAtIndex:index];
            if (tempView!=nil) {
                [tempView setHidden:NO];
                
                [tempView updateData:tempItem];
            }
            index++;
        }
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
