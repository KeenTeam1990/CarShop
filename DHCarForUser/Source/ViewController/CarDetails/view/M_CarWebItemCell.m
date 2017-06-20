//
//  M_CarWebItemCell.m
//  DHCarForUser
//
//  Created by lucaslu on 15/11/13.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarWebItemCell.h"

@interface M_CarWebItemCell ()<UIWebViewDelegate>

AS_MODEL_STRONG(UIWebView, myWebView);
AS_MODEL_STRONG(UIImageView, myImageView);

@end

@implementation M_CarWebItemCell

DEF_MODEL(myWebView);
DEF_MODEL(myImageView);
DEF_MODEL(block);

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor redColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        self.myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 50)];
        self.myWebView.delegate  =self;
        self.myWebView.scrollView.showsHorizontalScrollIndicator = NO;
        self.myWebView.scrollView.showsVerticalScrollIndicator = NO;
        self.myWebView.scrollView.bounces = NO ;
        self.myWebView.scalesPageToFit = YES ;
        self.myWebView.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:self.myWebView];
        
        
        UIImage* tempImage = [UIImage imageNamed:@"sh.png"];
        
        NSInteger tempHeight = (self.bounds.size.width/tempImage.size.width)*tempImage.size.height;
        
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, tempHeight)];
        self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.myImageView.tag =1001;
        [self.contentView addSubview:self.myImageView];
        
        self.myImageView.image = tempImage;

    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempFrame = self.myWebView.frame;
    tempFrame.size.width = self.bounds.size.width;
    self.myWebView.frame = tempFrame;
    
    UIImage* tempImage = [UIImage imageNamed:@"sh.png"];
    tempFrame = self.myImageView.frame;
    NSInteger tempHeight = (self.bounds.size.width/tempImage.size.width)*tempImage.size.height;
    tempFrame.size.width = self.bounds.size.width;
    tempFrame.size.height = tempHeight;
    self.myImageView.frame = tempFrame;
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withData:(NSString*)url
{
    self.myWebView.hidden = YES;
    self.myImageView.hidden = YES;
    
    if (self.currType == 1 || self.currType == 2) {
        if ([url notEmpty]) {
            [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        }else{
            [self.myWebView loadHTMLString:@" " baseURL:nil];
        }
        self.myWebView.hidden = NO;
    }else if (self.currType == 3){
        self.myImageView.hidden = NO;
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSInteger htmlHeight = [[self.myWebView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] integerValue];
    
//    htmlHeight= [[webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"] integerValue];
    
    UIScrollView *tempView=(UIScrollView *)[self.myWebView.subviews objectAtIndex:0];
    tempView.scrollEnabled=NO;

    CGRect tempFrame = self.myWebView.frame;
    tempFrame.size.width = self.bounds.size.width;
    tempFrame.size.height = htmlHeight;
    
    self.myWebView.frame = tempFrame;
    
    if (self.block!=nil) {
        self.block(0,self.myWebView.frame.size.height);
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
