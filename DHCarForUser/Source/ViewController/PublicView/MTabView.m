//
//  MTabView.m
//  Auction
//
//  Created by 卢迎志 on 14-12-9.
//
//

#import "MTabView.h"


@interface MTabView ()

AS_MODEL_STRONG(NSMutableArray, myDataArray);
AS_MODEL_STRONG(NSMutableArray, myViewArray);
AS_MODEL_STRONG(UIImageView, mySeleteView);

@end

@implementation MTabView

DEF_FACTORY_FRAME(MTabView);

DEF_MODEL(myDataArray);
DEF_MODEL(myViewArray);
DEF_MODEL(delegate);
DEF_MODEL(mySeleteView);

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.myDataArray = [NSMutableArray allocInstance];
        self.myViewArray = [NSMutableArray allocInstance];
        
        UIImageView* tempBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        tempBack.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:tempBack];
        
        UIImageView* tempLineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-5, frame.size.width, 5)];
        [tempLineView setBackgroundColor:RGBCOLOR(239, 239, 239)];
        [self addSubview:tempLineView];
        
        self.mySeleteView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-5, frame.size.width, 5)];
        self.mySeleteView.hidden = YES;
        [self.mySeleteView setBackgroundColor:[UIColor redColor]];
        [self addSubview:self.mySeleteView];
    }
    return self;
}

-(void)addTabItem:(NSString*)title
{
    [self.myDataArray addObject:title];
}

-(void)show
{
    for (int i=0; i<[self.myViewArray count]; i++) {
        UIView* tempView = [self.myViewArray objectAtIndex:i];
        if (tempView!=nil) {
            [tempView removeFromSuperview];
        }
    }
    
    [self.myViewArray removeAllObjects];
    
    int w = self.frame.size.width/[self.myDataArray count];
    int h = self.frame.size.height;
    
    int x = 0;
    int y = 0;
    
    for (int i=0; i<[self.myDataArray count]; i++) {
        NSString* tempStr = [self.myDataArray objectAtIndex:i];
        if (tempStr!=nil) {
            UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            tempBtn.frame = CGRectMake(x+i*w, y, w, h);
            [tempBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [tempBtn setTitleColor:[UIColor colorWithRed:161/255.0 green:100/255.0 blue:0/255.0 alpha:1.0] forState:UIControlStateSelected];
            [tempBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
            tempBtn.tag = 1000+i;
            
            [tempBtn setTitle:tempStr forState:UIControlStateNormal];
            
            [self.myViewArray addObject:tempBtn];
            [self addSubview:tempBtn];
        }
    }
    
    CGRect tempRect = self.mySeleteView.frame;
    tempRect.size.width = w;
    self.mySeleteView.frame = tempRect;
    self.mySeleteView.hidden = NO;
    
    [self showFirst];
}

-(void)showFirst
{
    [self seleteTabItem:0];
}

-(void)btnPressed:(id)sender
{
    UIButton* tempBtn = (UIButton*)sender;
    if (tempBtn!=nil) {
        int temptag = (int)tempBtn.tag-1000;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [tempBtn setSelected:YES];
            
            for (int i=0; i<[self.myViewArray count]; i++) {
                UIButton* tempItem = [self.myViewArray objectAtIndex:i];
                if (tempItem!=nil) {
                    if (tempItem.tag != tempBtn.tag) {
                        [tempItem setSelected:NO];
                    }
                }
            }
            
            CGRect tempRect = self.mySeleteView.frame;
            tempRect.origin.x = temptag*tempRect.size.width;
            self.mySeleteView.frame = tempRect;
        } completion:^(BOOL finished) {
            if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(seleteTabItem:)]) {
                [self.delegate seleteTabItem:temptag];
            }
        }];
    }
}

-(void)seleteTabItem:(int)item
{
    if ([self.myViewArray count] == 0 ) {
        return;
    }
    
    UIButton* tempBtn = [self.myViewArray objectAtIndex:item];
    
    if (tempBtn!=nil) {
        [UIView animateWithDuration:0.3 animations:^{
            
            [tempBtn setSelected:YES];
            
            for (int i=0; i<[self.myViewArray count]; i++) {
                UIButton* tempItem = [self.myViewArray objectAtIndex:i];
                if (tempItem!=nil) {
                    if (tempItem.tag != tempBtn.tag) {
                        [tempItem setSelected:NO];
                    }
                }
            }
            
            CGRect tempRect = self.mySeleteView.frame;
            tempRect.origin.x = item*tempRect.size.width;
            self.mySeleteView.frame = tempRect;
        } completion:^(BOOL finished) {
            
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
