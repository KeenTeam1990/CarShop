//
//  DLScreenImageView.m
//  Auction
//
//  Created by 卢迎志 on 15-1-6.
//
//

#import "DLScreenImageView.h"

@implementation DLScreenImageView

DEF_FACTORY_FRAME(DLScreenImageView);

DEF_MODEL(myImageView);
DEF_MODEL(myDelBtn);
DEF_MODEL(showDelBtn);

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor blackColor]];
        
        self.myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.myImageView];
        
        self.myDelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.myDelBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.myDelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.myDelBtn addTarget:self action:@selector(delBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.myDelBtn.frame = CGRectMake(self.frame.size.width - 80, self.frame.size.height-50, 60, 30);
        self.myDelBtn.hidden = YES;
        [self addSubview:self.myDelBtn];
    }
    return self;
}

-(void)setShowDelBtn:(BOOL)show
{
    showDelBtn = show;
    
    self.myDelBtn.hidden = !show;
}

-(void)updateImage:(UIImage*)image
{
    self.myImageView.image = image;
}

-(void)delBtnPressed:(id)sender
{
    
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
