//
//  M_ShaixuanBrandView.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/22.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_ShaixuanBrandView.h"
#import "M_ShaixuanBrandTableView.h"

@interface M_ShaixuanBrandView ()

AS_MODEL_STRONG(M_SeriesListModel, myListModel);

AS_MODEL_STRONG(M_ShaixuanBrandTableView, myLeftView);
AS_MODEL_STRONG(M_ShaixuanBrandTableView, myRightView);

AS_MODEL_STRONG(UIButton, myTouchBtn);

AS_POINT(currPoint);

@end

@implementation M_ShaixuanBrandView

DEF_FACTORY_FRAME(M_ShaixuanBrandView);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.myTouchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.myTouchBtn addTarget:self action:@selector(touchBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.myTouchBtn.frame = self.bounds;
        [self addSubview:self.myTouchBtn];
        
        self.myLeftView = [M_ShaixuanBrandTableView allocInstanceFrame:CGRectZero];
        [self addSubview:self.myLeftView];

        self.myRightView = [M_ShaixuanBrandTableView allocInstanceFrame:CGRectZero];
        self.myRightView.hidden = YES;
        [self addSubview:self.myRightView];
        
        __weak M_ShaixuanBrandView* tempSelf = self;
        self.myLeftView.block = ^(NSInteger tabIndex,id data){
            if (tabIndex == 0) {
                M_SeriesBrandModel* tempItem = (M_SeriesBrandModel*)data;
                if (tempItem!=nil) {
                    tempSelf.myBid = tempItem.myId;
                    [tempSelf showSeriesView:tempItem.mySeriesArray];
                }else{
                    tempSelf.myBid = @"";
                    if (tempSelf.block!=nil) {
                        tempSelf.block(0,nil);
                    }
                }
            }
        };
        
        self.myRightView.block = ^(NSInteger tabIndex,id data){
            if (tabIndex == 1){
                M_SeriesItemModel* tempItem = (M_SeriesItemModel*)data;
                if (tempItem!=nil) {
                    tempSelf.mySid = tempItem.myId;
                    if (tempSelf.block!=nil) {
                        tempSelf.block(0,tempItem);
                    }
                }else{
                    tempSelf.mySid = @"";
                    tempSelf.myBid = @"";
                    tempSelf.myRightView.hidden = YES;
                    if (tempSelf.block!=nil) {
                        tempSelf.block(0,nil);
                    }
                }
            }
        };
        
        self.myRightView.userInteractionEnabled = YES;
        
        UIPanGestureRecognizer* tempPanTap = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        tempPanTap.maximumNumberOfTouches=1;
        [self.myRightView addGestureRecognizer:tempPanTap];
        
    }
    
    return self;
}

- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    CGPoint translation = [recognizer translationInView:self.myRightView];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        CGPoint velocity = [recognizer velocityInView:self.myRightView];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x)) ;//+ (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;
        NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
        
        float slideFactor = 0.1 * slideMult; // Increase for more of a slide
        CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideFactor),
                                         recognizer.view.center.y );//+ (velocity.y * slideFactor));
        finalPoint.x = MIN(MAX(finalPoint.x, 0), self.myRightView.bounds.size.width);
        //finalPoint.y = MIN(MAX(finalPoint.y, 0), self.myRightView.bounds.size.height);
        
        [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            //recognizer.view.center = finalPoint;
            
            CGRect tempFrame = self.myRightView.frame;
            tempFrame.origin.x = self.bounds.size.width;
            self.myRightView.frame = tempFrame;
            
        } completion:nil];
    }else if (recognizer.state == UIGestureRecognizerStateBegan){
        self.currPoint = translation;
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        
        if (self.currPoint.x <translation.x) {
            recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                                 recognizer.view.center.y);
            [recognizer setTranslation:CGPointZero inView:self.myRightView];
        }
    }
}

-(void)touchBtnPressed:(id)sender
{
    if (self.block!=nil) {
        self.block(1,nil);
    }
}

-(void)updateTableFrame:(CGRect)frame
{
    CGRect tempFrame = self.myLeftView.frame;
    tempFrame.origin = frame.origin;
    tempFrame.size   = frame.size;
    self.myLeftView.frame= tempFrame;
    
    tempFrame = self.myRightView.frame;
    tempFrame.origin.x = self.myLeftView.frame.size.width/3;
    tempFrame.origin.y = self.myLeftView.frame.origin.y;
    tempFrame.size.width  = (self.myLeftView.frame.size.width/3)*2;
    tempFrame.size.height = self.myLeftView.frame.size.height;
    self.myRightView.frame= tempFrame;
}

//-(void)singleTap:(UITapGestureRecognizer*)gesture
//{
//
//}

-(void)upDateData:(M_SeriesListModel*)data
{
    self.myListModel = data;
    
    [self.myLeftView updateData:data.myItemArray withType:0];
}

-(void)showSeriesView:(NSMutableArray*)data
{
    self.myRightView.hidden = NO;
    [self.myRightView updateData:data withType:1];
    [UIView animateWithDuration:0.5
                     animations:^{
                         CGRect tempFrame = self.myRightView.frame;
                         tempFrame.origin.x = self.bounds.size.width/3;
                         tempFrame.size.width = (self.bounds.size.width/3)*2;
                         self.myRightView.frame = tempFrame;
                     } completion:^(BOOL finished) {
                         
                     }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
