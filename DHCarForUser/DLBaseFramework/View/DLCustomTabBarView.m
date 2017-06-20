//
//  DLCustomTabBarView.m
//  TickTock
//
//  Created by 卢迎志 on 14-11-26.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import "DLCustomTabBarView.h"
#import "Unity.h"

@implementation DLCustomTabBarView

DEF_FACTORY_FRAME(DLCustomTabBarView);

DEF_MODEL(itemArray);
DEF_MODEL(seleteImageView);
DEF_MODEL(seleteImage);
DEF_MODEL(backImage);
DEF_MODEL(tabItemArray);
DEF_MODEL(delegate);

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.itemArray = [NSMutableArray allocInstance];
        self.tabItemArray = [NSMutableArray allocInstance];
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        [self initBackView];
        
        [self initSeleteImageView];
        
    }
    return self;
}

-(void)addTabItem:(DLTabItemModel*)item
{
    [self.tabItemArray addObject:item];
}

-(void)addTabItem:(NSString*)title withIcon:(NSString*)icon withIcon_H:(NSString*)icon_h
{
    [self.tabItemArray addObject:[[DLTabItemModel alloc] initWithIcon:icon
                                                           withIcon_H:icon_h
                                                             withItem:title
                                                        withItemColor:[Unity getTabItemColor]
                                                      withItemColor_H:[Unity getTabItem_HColor]]];
}

-(void)updateData
{
    int w = self.frame.size.width/[self.tabItemArray count];
    int h = self.frame.size.height;
    int x = 0;
    int y = 0;
    
    for (int i=0; i<[self.tabItemArray count]; i++) {
        DLTabItemModel* tempItem = [self.tabItemArray objectAtIndex:i];
        if (tempItem!=nil) {
            [self initButton:tempItem withFrame:CGRectMake(x+w*i, y, w, h) withTag:1000+i];
        }
    }
    
    self.seleteImageView.frame = CGRectMake(x, y, w, h);
    
    [self seleteTabIndex:0];
}

-(void)initBackView
{
    UIImageView* tempBackView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    tempBackView.backgroundColor = [UIColor whiteColor];
    UIImage* tempImage = [UIImage imageNamed:@"bg_bottom_indx.png"];
    if (tempImage!=nil) {
        tempBackView.image = [tempImage stretchableImageWithLeftCapWidth:tempImage.size.width/2 topCapHeight:tempImage.size.height/2];
    }

    [self addSubview:tempBackView];
}

-(void)initButton:(DLTabItemModel*)item withFrame:(CGRect)btnframe withTag:(int)tag
{
    UIButton* tempBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [tempBtn setFrame:btnframe];
    tempBtn.tag = tag;
    [tempBtn setBackgroundColor:[UIColor clearColor]];
    
    
    if (item.tabIcon!=nil) {
        UIImage* tempIcon = [UIImage imageNamed:item.tabIcon];
        if (tempIcon!=nil) {
            [tempBtn setImage:tempIcon forState:UIControlStateNormal];
        }
        [tempBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [tempBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [tempBtn setImageEdgeInsets:UIEdgeInsetsMake(3, (btnframe.size.width-tempIcon.size.width)/2, 20, 0)];
       
        if (item.tabIcon_H!=nil) {
            UIImage* tempIcon_H = [UIImage imageNamed:item.tabIcon_H];
            if (tempIcon_H!=nil) {
                [tempBtn setImage:tempIcon_H forState:UIControlStateSelected];
            }
        }
    }
    
    if (item.tabItem!=nil) {
        [tempBtn setTitle:item.tabItem forState:UIControlStateNormal];
        if (item.tabIcon!=nil) {
            UIImage* tempIcon = [UIImage imageNamed:item.tabIcon];
            [tempBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
            CGSize tempTextW = [item.tabItem sizeWithFont:[UIFont systemFontOfSize:12] byWidth:btnframe.size.width];
            
            [tempBtn setTitleEdgeInsets:UIEdgeInsetsMake(btnframe.size.height-20, (0-tempIcon.size.width)+(btnframe.size.width-tempTextW.width)/2, 0, 0)];
        }else{
            
        }
        
        if (item.tabItemColor!=nil) {
            [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        if (item.tabItemColor_H!=nil) {
            [tempBtn setTitleColor:[UIColor redColor]forState:UIControlStateSelected];
        }
    }else{
        [tempBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [tempBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    [tempBtn addTarget:self action:@selector(tempBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.itemArray addObject:tempBtn];
    [self addSubview:tempBtn];
}

-(void)initSeleteImageView
{
    self.seleteImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.seleteImageView  setBackgroundColor:[UIColor clearColor]];
    
    if (self.seleteImage!=nil) {
        UIImage* tempImage = [UIImage imageNamed:self.seleteImage];
        if (tempImage!=nil) {
            self.seleteImageView.image = [tempImage stretchableImageWithLeftCapWidth:tempImage.size.width/2 topCapHeight:tempImage.size.height/2];
        }
    }
    self.seleteImageView.hidden = YES;
    [self addSubview:self.seleteImageView ];
}

-(void)tempBtnPressed:(id)sender
{
    UIButton* tempBtn = (UIButton*)sender;
    if (tempBtn!=nil) {
        
        self.seleteImageView.frame = tempBtn.frame;
        [tempBtn setSelected:YES];
        for (int i=0; i<[self.itemArray count]; i++) {
            UIButton* tempItem = [self.itemArray objectAtIndex:i];
            if (tempItem!=nil) {
                if (tempItem.tag!=tempBtn.tag) {
                    [tempItem setSelected:NO];
                }
            }
        }
        
        if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(seleteTabBar:)]) {
            [self.delegate seleteTabBar:tempBtn.tag-1000];
        }
    }
}

-(void)seleteTabIndex:(int)tag
{
    UIButton *btn = (UIButton *)[self viewWithTag:tag+1000];
    
    self.seleteImageView.frame =btn.frame;
    
    [btn setSelected:YES];
    
    for (int i=0; i<[self.itemArray count]; i++) {
        UIButton* tempBtn = [self.itemArray objectAtIndex:i];
        if (tempBtn!=nil) {
            if (tempBtn.tag!=btn.tag) {
                [tempBtn setSelected:NO];
            }
        }
    }
    
    if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(seleteTabBar:)]) {
        [self.delegate seleteTabBar:btn.tag-1000];
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
