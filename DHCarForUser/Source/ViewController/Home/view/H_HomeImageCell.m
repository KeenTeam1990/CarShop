//
//  H_HomeImageCell.m
//  DHCarForUser
//
//  Created by lucaslu on 15/12/21.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "H_HomeImageCell.h"
#import "M_IndexModel.h"

@interface H_HomeImageCell ()

AS_MODEL_STRONG(UIImageView, myImageView);

AS_MODEL_STRONG(UIImageView, myLineView);

@end

@implementation H_HomeImageCell

DEF_MODEL(myImageView);

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, self.contentView.frame.size.width, 180)];
//        self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.myImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.myImageView];
        
        self.myLineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 180, self.bounds.size.width, 5)];
        self.myLineView.backgroundColor = [Unity getGrayBackColor];
        [self.contentView addSubview:self.myLineView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempFrame = self.myLineView.frame;
    tempFrame.size.width = self.bounds.size.width;
    tempFrame.origin.y = self.bounds.size.height-5;
    self.myLineView.frame = tempFrame;
    
    tempFrame = self.myImageView.frame;
    tempFrame.origin.y = 5;
    tempFrame.size.width = self.contentView.bounds.size.width;
    // 打印图片的frame 和 cell contentview的size,width
//    NSLog(@"88888888=%f,%f",self.myImageView.frame ,self.contentView.bounds.size.width);
    tempFrame.size.height = 180;
    self.myImageView.frame = tempFrame;
}

-(void)configCellIndexPath:(NSIndexPath *)indexPath withDataArray:(NSMutableArray *)array
{
    M_IndexLineItemModel* tempModel = [array objectAtIndex:0];
    if (tempModel!=nil) {
        if (tempModel.myCoverModel!=nil) {
            if ([tempModel.myCoverModel.myCover notEmpty]) {
                [self.myImageView setImageWithURL:[NSURL URLWithString:tempModel.myCoverModel.myCover] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
            }
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
