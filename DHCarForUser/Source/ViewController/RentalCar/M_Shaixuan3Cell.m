//
//  M_Shaixuan3Cell.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/22.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_Shaixuan3Cell.h"
#import "M_ConfigDataModel.h"

AS_SHARE_BUTTON_STYLE(Content1);

DEF_SHARE_BUTTON_STYLE(Content1,
                       style.backgroundColor = [UIColor whiteColor];
                       style.borderWidth = 1;
                       style.borderColor = [UIColor blackColor];
                       style.cornerRedius = 2;);


@interface M_Shaixuan3Cell ()

AS_MODEL_STRONG(NSMutableArray, myDataArray);
AS_MODEL_STRONG(NSMutableArray, myViewArray);

@end

@implementation M_Shaixuan3Cell

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
        
        NSInteger w = (self.bounds.size.width-10*4)/3;
        NSInteger h = 30;
        NSInteger x = 10;
        NSInteger y = 10;
        
        for (int i=0; i<3; i++) {
            
            UIButton* tempView = [UIButton buttonWithType:UIButtonTypeCustom];
            tempView.style = DLStyleContent1();
            tempView.frame = CGRectMake(x, y, w, h);
            tempView.tag = 1000+i;
            [tempView.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [tempView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [tempView setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [tempView addTarget:self action:@selector(buttonBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.myViewArray addObject:tempView];
            [self.contentView addSubview:tempView];
            
            x+=w+10;
        }
    }
    return self;
}

-(void)buttonBtnPressed:(id)sender
{
    UIButton* tempBtn = (UIButton*)sender;
    
    if ([self.myDataArray count]>0) {
        
        for (int i=0; i<[self.myDataArray count]; i++) {
            M_ConfigDataItemModel* tempItem = [self.myDataArray objectAtIndex:i];
            if (tempItem!=nil) {
                if ((tempBtn.tag-1000)==i) {
                    
                    tempItem.isSelete = !tempItem.isSelete;
                    
                    UIButton* tempView = [self.myViewArray objectAtIndex:i];
                    if (tempView!=nil) {
                        if (tempItem.isSelete) {
                            [tempView.layer setBorderColor:[UIColor redColor].CGColor];
                        }else{
                            [tempView.layer setBorderColor:[UIColor blackColor].CGColor];
                        }
                    }
                    
                    if (self.block!=nil ) {
                        self.block(tempItem);
                    }
                    
                }else{
                    tempItem.isSelete = NO;
                }
                
            }
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger w = (self.bounds.size.width-10*4)/3;
    NSInteger x = 10;
    for (int i=0; i<[self.myViewArray count]; i++) {
        UIButton* tempView = [self.myViewArray objectAtIndex:i];
        if (tempView!=nil) {
            
            CGRect tempFrame = tempView.frame;
            tempFrame.origin.x = x;
            tempFrame.size.width = w;
            tempView.frame = tempFrame;
            
            x+=w+10;
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
    
    NSInteger row = indexPath.row*3;
    NSInteger count = row+3;
    
    if (count >= [array count]) {
        count = [array count];
    }
    
    [self.myDataArray removeAllObjects];
    
    int index = 0;
    for (NSInteger i=row; i<count; i++) {
        
        M_ConfigDataItemModel* tempItem = [array objectAtIndex:i];
        if (tempItem!=nil) {
            
            [self.myDataArray addObject:tempItem];
            
            UIButton* tempView = [self.myViewArray objectAtIndex:index];
            if (tempView!=nil) {
                [tempView setHidden:NO];
                
                if ([tempItem.myName notEmpty]) {
                    [tempView setTitle:tempItem.myName forState:UIControlStateNormal];
                }
                
                if (tempItem.isSelete) {
                    [tempView.layer setBorderColor:[UIColor redColor].CGColor];
                }else{
                    [tempView.layer setBorderColor:[UIColor blackColor].CGColor];
                }
                
                [tempView setSelected:tempItem.isSelete];
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
