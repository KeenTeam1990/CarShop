//
//  MM_SpecialCarCell.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/3.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "MM_SpecialCarCell.h"
#import "MM_SpecialCarItemView.h"
#import "Dh_SpecialCarModel.h"
@implementation MM_SpecialCarCell

DEF_MODEL(myViewArray);
DEF_MODEL(myDataArray);



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
        
//        int w = self.bounds.size.width/2-10;
//        int h = 200;
//        int x = 6;
//        int y = 5;
        
        for (int i=0; i<2; i++) {
            
            MM_SpecialCarItemView *tempView = [[MM_SpecialCarItemView alloc]initWithFrame:CGRectMake((ScreenWidth-290)/2+i*(ScreenWidth/2), 0, 145, 343/2)];
            
            [self.myViewArray addObject:tempView];
            [self.contentView addSubview:tempView];
            
//            [tempView setUserInteractionEnabled:YES];
//            UITapGestureRecognizer *tempsingleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
//            tempsingleTap.numberOfTapsRequired=1;
//            [tempView addGestureRecognizer:tempsingleTap];
            
           // x+=w+6;
        }
        

    }
    return self;
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    for (int i=0; i<[self.myViewArray count]; i++)
    {
        MM_SpecialCarItemView* tempView = [self.myViewArray objectAtIndex:i];
        if (tempView!=nil)
        {
            
            tempView.hidden = YES;
        }
    }
    
    NSInteger row = indexPath.row*2;
    NSInteger count = row+2;
    
    if (count >= [array count])
    {
        count = [array count];
    }
    
    int index = 0;
    for (NSInteger i=row; i<count; i++)
    {
        Dh_SpecialCarModel* tempItem = [array objectAtIndex:i];
        if (tempItem!=nil)
        {
            
            [self.myDataArray addObject:tempItem];
            
            MM_SpecialCarItemView* tempView = [self.myViewArray objectAtIndex:index];
            if (tempView!=nil)
            {
                [tempView setHidden:NO];
                
                            index++;
            }
    
        
        }
    }
}



@end
