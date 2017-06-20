//
//  M_CollectSeleteView.m
//  DHCarForUser
//
//  Created by lucaslu on 16/4/3.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "M_CollectSeleteView.h"

#define KDialogWidth 200

@interface M_CollectSeleteView ()

AS_MODEL_STRONG(UIView, myDialogView);

AS_MODEL_STRONG(UILabel, myTitleLabel);

AS_MODEL_STRONG(NSMutableArray, myDataArray);
AS_MODEL_STRONG(NSMutableArray, myViewArray);

@end

@implementation M_CollectSeleteView

DEF_FACTORY_FRAME(M_CollectSeleteView);

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.myDataArray = [NSMutableArray allocInstance];
        self.myViewArray = [NSMutableArray allocInstance];
        
        [self setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.6]];
        
        self.myDialogView = [[UIView alloc]initWithFrame:CGRectMake((frame.size.width-KDialogWidth)/2, (frame.size.height-KDialogWidth)/2, KDialogWidth, KDialogWidth)];
        [self.myDialogView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.myDialogView];
        
        self.myTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.myDialogView.frame.size.width, 40)];
        [self.myTitleLabel setTextAlignment:UITextAlignmentCenter];
        [self.myTitleLabel setTextColor:[UIColor redColor]];
        [self.myTitleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.myTitleLabel setText:@"请选择购车方式"];
        [self.myDialogView addSubview:self.myTitleLabel];
        
        
        
        NSInteger x = 10;
        NSInteger y = 50;
        NSInteger w = self.myDialogView.frame.size.width-20;
        NSInteger h = 40;
        
        for (int i=0; i<3; i++) {
            
            UIButton* tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            ViewBorderRadius(tempBtn, 5, 1, [UIColor grayColor]);
        
            [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [tempBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            
            [tempBtn addTarget:self action:@selector(btnItemPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            tempBtn.frame = CGRectMake(x, y, w, h);
            tempBtn.hidden = YES;
            [self.myDialogView addSubview:tempBtn];
            [self.myViewArray addObject:tempBtn];
            y += h+10;
        }
        
        [self setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *tempsingleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
        tempsingleTap.numberOfTapsRequired=1;
        [self addGestureRecognizer:tempsingleTap];
    }
    
    return self;
}

-(void)singleTap:(UITapGestureRecognizer*)gesture
{
    self.hidden = YES;
}

-(void)showDialog:(M_CarItemModel*)model
{
    self.myModel = model;
    
    [self.myDataArray removeAllObjects];
    
    
    
    if (self.showSpecia) {
        [self.myDataArray addObject:@"特价"];
    }
    if (self.showRental) {
        [self.myDataArray addObject:@"租购"];
    }
    if (self.showNew) {
        [self.myDataArray addObject:@"优选"];
    }
    
    CGRect tempFrame = self.myDialogView.frame;
    tempFrame.size.height =40 +self.myDataArray.count *50+10;
    self.myDialogView.frame = tempFrame;
    
    if ([self.myDataArray count]==1) {
        if (self.myModel!=nil) {
            NSString *itemtag ;
            if (self.showSpecia) {
                itemtag =@"特价" ;
            }
            if (self.showRental) {
                itemtag = @"租购";
            }
            if (self.showNew) {
                itemtag = @"优选";
            }
            if (self.block!=nil) {
                self.block(itemtag,self.myModel);
            }
        }
        
        self.hidden = YES;
        return;
    }
    
    for (int i=0; i<[self.myDataArray count]; i++) {
        NSString* tempStr = [self.myDataArray objectAtIndex:i];
        if ([tempStr notEmpty]) {
            UIButton* tempBtn = [self.myViewArray objectAtIndex:i];
            
            if (tempBtn!=nil) {
                [tempBtn setTitle:tempStr forState:UIControlStateNormal];
                tempBtn.hidden = NO;
                
                tempBtn.tag = 1000+i;
            }
            
        }
    }
   
    
    self.hidden = NO;
}

-(void)btnItemPressed:(id)sender
{
    UIButton* tempbtn = (UIButton*)sender;
    if (tempbtn!=nil) {
        
//        [self seleteItem:tempbtn.tag-1000];
        if (self.block != nil) {
            self.block(tempbtn.titleLabel.text ,self.myModel);
            self.hidden = YES;
        }
    }
}

-(void)seleteItem:(NSInteger)tag
{
//    NSInteger itemtag = -1;
//    
//    if (tag == 0 && self.showSpecia) {
//        itemtag = 0;
//    }else if (tag == 1&& self.showRental){
//        itemtag = 1;
//    }else if (tag == 2&& self.showNew){
//        itemtag = 2;
//    }else if (tag == 0 && self.showRental) {
//        itemtag = 1;
//    }else if (tag == 1&& self.showNew){
//        itemtag = 2;
//    }
//    
//    if (self.myModel!=nil) {
//        if (self.block!=nil) {
//            self.block(tag,self.myModel);
//        }
//    }
//    
//    self.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
