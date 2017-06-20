//
//  RentalCarCell.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/7.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "RentalCarCell.h"
#import "RentalCarView.h"
#import "M_CarListModel.h"

@interface RentalCarCell ()

AS_MODEL_STRONG(NSMutableArray, myViewArray);
AS_MODEL_STRONG(NSMutableArray, myDataArray);

@end

@implementation RentalCarCell

DEF_MODEL(myDataArray);
DEF_MODEL(myViewArray);

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
        
        NSInteger x = 10;
        NSInteger y = 0;
        NSInteger w = (self.bounds.size.width-20)/3;
        NSInteger h = 230;
        
        for (int i=0; i<3; i++) {
            
            RentalCarView* tempView = [RentalCarView allocInstanceFrame:CGRectMake(x, y, w, h)];
            [tempView.layer setMasksToBounds:YES];
            [tempView.layer setBorderWidth:1];
            [tempView.layer setBorderColor:RGBCOLOR(102, 102, 102).CGColor];
            [self.contentView addSubview:tempView];
            [self.myViewArray addObject:tempView];
            
            x+=w-1;
        }
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger x = 10;
    NSInteger w = (self.bounds.size.width-20)/3;
    
    for (int i=0; i<[self.myViewArray count]; i++) {
        
        RentalCarView* tempView = [self.myViewArray objectAtIndex:i];
        if (tempView!=nil) {
            
            CGRect tempframe = tempView.frame;
            tempframe.size.width = w;
            tempframe.origin.x = x;
            tempView.frame = tempframe;
        }
        
        x+=w-1;
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
    
    NSInteger row = indexPath.row*3;
    NSInteger count = row+3;
    
    if (count >= [array count]) {
        count = [array count];
    }
    
    int index = 0;
    for (NSInteger i=row; i<count; i++) {
        
        M_CarItemModel* tempItem = [array objectAtIndex:i];
        if (tempItem!=nil) {
            
            [self.myDataArray addObject:tempItem];
            
            RentalCarView* tempView = [self.myViewArray objectAtIndex:index];
            if (tempView!=nil) {
                [tempView setHidden:NO];
                
                [tempView updateData:tempItem];
            }
            
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
