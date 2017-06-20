//
//  M_DealerHomeTabView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/9.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_DealerHomeTabView.h"

@implementation M_DealerHomeTabItemModel

DEF_FACTORY(M_DealerHomeTabItemModel);
DEF_MODEL(myName);
DEF_MODEL(isSelete);

-(instancetype)initData:(NSString *)name withSelete:(BOOL)selete
{
    self = [super init];
    
    if (self) {
        self.myName = name;
        self.isSelete = selete;
    }
    return self;
}

@end


@interface M_DealerHomeTabView ()

AS_MODEL_STRONG(NSMutableArray, myTabViewArray);
AS_MODEL_STRONG(UIView, myTabView);
AS_MODEL_STRONG(NSMutableArray, myTabItemArray);

@end

@implementation M_DealerHomeTabView

DEF_FACTORY_FRAME(M_DealerHomeTabView);
DEF_MODEL(myTabItemArray);
DEF_MODEL(myTabView);
DEF_MODEL(myTabViewArray);
DEF_MODEL(block);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:RGBCOLOR(238, 238, 238)];
        
        self.myTabViewArray = [NSMutableArray allocInstance];
        self.myTabItemArray = [NSMutableArray allocInstance];
        
        self.myTabView = [[UIView alloc]initWithFrame:CGRectMake(20, (frame.size.height-30)/2, frame.size.width-40, 30)];
        [self.myTabView.layer setMasksToBounds:YES];
        [self.myTabView.layer setCornerRadius:5];
        [self.myTabView.layer setBorderWidth:1];
        [self.myTabView.layer setBorderColor:[UIColor redColor].CGColor];
        [self addSubview:self.myTabView];
        
    }
    return self;
}

-(void)addItem:(M_DealerHomeTabItemModel*)tabItem
{
    [self.myTabItemArray addObject:tabItem];
}

-(void)updateData
{
    NSInteger x = 0;
    NSInteger y = -1;
    NSInteger w = self.myTabView.frame.size.width/[self.myTabItemArray count];
    NSInteger h = 32;
    
    for (int i=0; i<[self.myTabItemArray count]; i++) {
        
        M_DealerHomeTabItemModel* tempItem = [self.myTabItemArray objectAtIndex:i];
        
        if (tempItem!=nil) {
            
            UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [tempBtn setTitle:tempItem.myName forState:UIControlStateNormal];
            [tempBtn setSelected:tempItem.isSelete];
            [tempBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            
            if (tempItem.isSelete) {
                [tempBtn setBackgroundColor:[UIColor redColor]];
                
                [tempBtn.layer setMasksToBounds:NO];
                [tempBtn.layer setBorderWidth:0];
            }else{
                [tempBtn setBackgroundColor:[UIColor whiteColor]];
            
                [tempBtn.layer setMasksToBounds:YES];
                [tempBtn.layer setBorderWidth:1];
                [tempBtn.layer setBorderColor:RGBCOLOR(238, 238, 238).CGColor];
            }
            
            tempBtn.frame = CGRectMake(x, y, w, h);
            
            tempBtn.tag = 1000+i;
            
            [tempBtn addTarget:self action:@selector(tabBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.myTabView addSubview:tempBtn];
            [self.myTabViewArray addObject:tempBtn];
            
            x+=w;
        }
    }
    
}

-(void)tabBtnPressed:(id)sender
{
    UIButton* tempBtn = (UIButton*)sender;
    if (tempBtn!=nil) {
        
        for (int i=0; i<[self.myTabViewArray count]; i++) {
            UIButton* tempItem = [self.myTabViewArray objectAtIndex:i];
            if (tempItem!=nil) {
                
                M_DealerHomeTabItemModel* tempModel = [self.myTabItemArray objectAtIndex:i];
                if (tempItem.tag == tempBtn.tag) {
                    tempModel.isSelete = YES;
                    [tempBtn setSelected:YES];
                }else{
                    tempModel.isSelete = NO;
                    [tempItem setSelected:NO];
                }
                
                if (tempModel.isSelete) {
                    [tempBtn setBackgroundColor:[UIColor redColor]];
                    
                    [tempBtn.layer setMasksToBounds:NO];
                    [tempBtn.layer setBorderWidth:0];
                }else{
                    [tempItem setBackgroundColor:[UIColor whiteColor]];
                    
                    [tempItem.layer setMasksToBounds:YES];
                    [tempItem.layer setBorderWidth:1];
                    [tempItem.layer setBorderColor:RGBCOLOR(238, 238, 238).CGColor];
                }
            }
        }
        
        if (self.block!=nil) {
            self.block(tempBtn.tag-1000);
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
