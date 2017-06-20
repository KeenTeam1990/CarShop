//
//  H_HomeCar2Cell.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/21.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "H_HomeCar2Cell.h"

#import "H_HomeItemView.h"
#import "M_IndexModel.h"

@interface H_HomeCar2Cell ()

AS_MODEL_STRONG(NSMutableArray, myDataArray);
AS_MODEL_STRONG(NSMutableArray, myViewArray);

@end

@implementation H_HomeCar2Cell

DEF_MODEL(myDataArray);
DEF_MODEL(myViewArray);
DEF_MODEL(block);

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
        
        NSInteger w = (self.bounds.size.width-5)/2;
        NSInteger h = 190;
        NSInteger x = 0;
        NSInteger y = 5;
        
        for (int i=0; i<2; i++) {
            
            H_HomeItemView* tempView = [H_HomeItemView allocInstanceFrame:CGRectMake(x, y, w, h)];
            
            tempView.tag = 1000+i;
            
            [self.myViewArray addObject:tempView];
            [self.contentView addSubview:tempView];
            
            [tempView setUserInteractionEnabled:YES];
            
            UITapGestureRecognizer *tempsingleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
            tempsingleTap.numberOfTapsRequired=1;
            [tempView addGestureRecognizer:tempsingleTap];
            
            x+=w+5;
        }
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger w = (self.bounds.size.width-5)/2;
    NSInteger x = 0;
    for (int i=0; i<[self.myViewArray count]; i++) {
        H_HomeItemView* tempView = [self.myViewArray objectAtIndex:i];
        if (tempView!=nil) {
            
            CGRect tempFrame = tempView.frame;
            tempFrame.origin.x = x;
            tempFrame.size.width = w;
            tempView.frame = tempFrame;
            
            x+=w+5;
        }
    }
    // 打印cellbounds的宽度
//    NSLog(@"555555==%f",self.bounds.size.width);
}

-(void)singleTap:(UITapGestureRecognizer*)gesture
{
    H_HomeItemView* tempView = (H_HomeItemView*)gesture.view;
    
    M_IndexLineItemModel* tempModel = [self.myDataArray objectAtIndex:tempView.tag-1000];
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

        [self.myDataArray addObject:tempLineItem];
        
        H_HomeItemView* tempView = [self.myViewArray objectAtIndex:index];
        if (tempView!=nil) {
            [tempView setHidden:NO];
            
            [tempView updateData:tempLineItem];
        }
        index++;
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
