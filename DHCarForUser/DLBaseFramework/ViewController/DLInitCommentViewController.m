//
//  DLInitCommentViewController.m
//  Auction
//
//  Created by 卢迎志 on 14-12-16.
//
//

#import "DLInitCommentViewController.h"

@interface DLInitCommentViewController ()

@end

@implementation DLInitCommentViewController

DEF_MODEL(commentView);
DEF_MODEL(touchBtn);

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.touchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.touchBtn addTarget:self action:@selector(touchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.touchBtn.hidden = YES;
    self.touchBtn.frame = CGRectMake(0, 0, self.baseView.frame.size.width, self.baseView.frame.size.height);
    [self.baseView addSubview:self.touchBtn];
    
    self.commentView  = [DLCommentView allocInstanceFrame:CGRectMake(0, self.baseView.frame.size.height-NavigationBarHeight, self.baseView.frame.size.width, NavigationBarHeight)];
    self.commentView.delegate = self;
    [self.baseView addSubview:self.commentView];
    
    [self addKeywordNotify];
}

-(void)notifyhideKeyword
{
    self.touchBtn.hidden = YES;
    
    CGRect tempFrame = self.commentView.frame;
    tempFrame.origin.y = self.baseView.frame.size.height-NavigationBarHeight;
    tempFrame.size.height = NavigationBarHeight;
    self.commentView.frame = tempFrame;
    
    tempFrame = self.touchBtn.frame;
    tempFrame.size.height = self.baseView.frame.size.height;
    self.touchBtn.frame = tempFrame;
    
//    self.commentView.showAddImage = NO;
}

-(void)notifyshowKeyword:(CGRect)keyRect
{
    self.touchBtn.hidden = NO;
    [self.baseView bringSubviewToFront:self.touchBtn];
    [self.baseView bringSubviewToFront:self.commentView];
    
    CGRect tempFrame = self.commentView.frame;
    tempFrame.origin.y = self.baseView.frame.size.height-NavigationBarHeight - keyRect.size.height;
    tempFrame.size.height = NavigationBarHeight;
    self.commentView.frame = tempFrame;
    
    tempFrame = self.touchBtn.frame;
    tempFrame.size.height = self.commentView.frame.origin.y;
    self.touchBtn.frame = tempFrame;
    
//    self.commentView.showAddImage = YES;
}

-(void)touchButtonClick:(id)sender
{
    [self.commentView hidekeyword];
}

#pragma DLCommentViewDelegate

-(void)showAttachment:(id)sender withType:(NSInteger)type
{
    
}

-(void)send:(NSString *)text
{
    
}

-(void)seleteFaceItem:(id)sender
{
    
}

-(void)addImageBtnPressed:(id)sender
{
    [[DLImagePickerTool sharedInstance] showImagePickerSheet:self withBlock:^(UIImage *image) {
        if (image!=nil) {
            
        }
    } withIsEdit:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
