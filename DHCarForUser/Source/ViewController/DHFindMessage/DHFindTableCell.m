//
//  DHFindTableCell.m
//  DHCarForUser
//
//  Created by 张海亮 on 16/3/24.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "DHFindTableCell.h"

@implementation DHFindTableCell

DEF_MODEL(messageTitleLabel);
DEF_MODEL(messageReadLabel);
DEF_MODEL(carImageView);
DEF_MODEL(messageReleaseTimeLabel);

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.carImageView = [[UIImageView alloc] init];
        self.carImageView.frame = CGRectMake(8, 10, 110, 80);
        [self.carImageView setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
        [self addSubview:self.carImageView];
        
        self.messageTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, SCREEN_WIDTH -130, 50)];
        self.messageTitleLabel.textColor = [UIColor blackColor];
        self.messageTitleLabel.backgroundColor = [UIColor clearColor];
        self.messageTitleLabel.font = [UIFont systemFontOfSize:18.0f];
        self.messageTitleLabel.textAlignment = NSTextAlignmentLeft;
        self.messageTitleLabel.text = @"我呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜呜";
        self.messageTitleLabel.numberOfLines = 0;
        [self addSubview:self.messageTitleLabel];
        
        self.messageReadLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 70, 150, 20)];
        self.messageReadLabel.textColor = [UIColor lightGrayColor];
        self.messageReadLabel.backgroundColor = [UIColor clearColor];
        self.messageReadLabel.font = [UIFont systemFontOfSize:12.0f];
        self.messageReadLabel.textAlignment = NSTextAlignmentLeft;
        self.messageReadLabel.text = @"易车网   阅读:  1290";
        [self addSubview:self.messageReadLabel];

        self.messageReleaseTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake( SCREEN_WIDTH -120, 70, 110, 20)];
        self.messageReleaseTimeLabel.textColor = [UIColor lightGrayColor];
        self.messageReleaseTimeLabel.backgroundColor = [UIColor clearColor];
        self.messageReleaseTimeLabel.font = [UIFont systemFontOfSize:12.0f];
        self.messageReleaseTimeLabel.textAlignment = NSTextAlignmentRight;
        self.messageReleaseTimeLabel.text = @"一分钟前";
        [self addSubview:self.messageReleaseTimeLabel];
        
        
        UIImageView*line = [[UIImageView alloc] init];
        line.frame = CGRectMake(0, 95, ScreenWidth, 5);
        line.backgroundColor = [Unity getGrayBackColor];
        [self addSubview:line];

    }
    return self;
}
@end
