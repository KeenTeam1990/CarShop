//
//  M_MyCollectCell.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/12.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_MyCollectCell.h"

#import "M_CarListModel.h"
#define KLeftOffset 10

@interface M_MyCollectCell ()

AS_MODEL_STRONG(UIImageView, myImageView);

AS_MODEL_STRONG(UILabel, myNameLabel);

AS_MODEL_STRONG(UILabel, myTimeLabel);

AS_MODEL_STRONG(UIImageView, myLineView);



AS_MODEL_STRONG(M_CarItemModel, myItemModel);

@property(nonatomic,assign)NSInteger indexCell;

@end

@implementation M_MyCollectCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];

        NSInteger tempImageW = self.frame.size.width/2-KLeftOffset*2;
        if (IS_SCREEN_35_INCH||IS_SCREEN_4_INCH) {
            tempImageW = 100;
        }
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(KLeftOffset, KLeftOffset, tempImageW, 100)
                            ];
    
        self.myImageView.image = [UIImage imageNamed:@"tempcar.jpg"];
        self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.myImageView];
        
        self.myNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(tempImageW+KLeftOffset*2, 15, self.bounds.size.width-tempImageW-KLeftOffset*3, 60)];
        self.myNameLabel.font = [UIFont systemFontOfSize:14];
        self.myNameLabel.textColor = [UIColor blackColor];
        self.myNameLabel.numberOfLines = 3;
        [self.contentView addSubview:self.myNameLabel];
        
        self.myTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(tempImageW+KLeftOffset*2, 75, self.bounds.size.width-tempImageW-KLeftOffset*3, 30)];
        self.myTimeLabel.font = [UIFont systemFontOfSize:12];
        self.myTimeLabel.textColor = RGBCOLOR(202, 202, 202);
        [self.contentView addSubview:self.myTimeLabel];
        
//        self.mydelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.mydelBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor];
//                                                   style.cornerRedius = 2;
//                                                   style.borderWidth =1;
//                                                   style.borderColor = [UIColor lightGrayColor];);
//        [self.mydelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//        self.mydelBtn.frame = CGRectMake(self.bounds.size.width-90, 80, 60, 20);
//        self.mydelBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//        [self.mydelBtn addTarget:self action:@selector(mydelBtnBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [self.mydelBtn setTitle:@"删除" forState:UIControlStateNormal];
//        [self.contentView addSubview:self.mydelBtn];

               self.myLineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 120, self.bounds.size.width, 5)];
        self.myLineView.backgroundColor = RGBCOLOR(234, 234, 234);
        [self.contentView addSubview:self.myLineView];
    }
    return self;
}


-(void)mydelBtnBtnPressed:(UIButton *)sender
{
    UIAlertView *delAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    delAlert.delegate = self;
    [delAlert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        if (self.myItemModel!=nil) {
             self.block(0,self.myItemModel);
        }
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];

    NSInteger tempImageW = self.frame.size.width/2-KLeftOffset*2;
    if (IS_SCREEN_35_INCH||IS_SCREEN_4_INCH) {
        tempImageW = 100;
    }
    CGRect tempFrame = self.myLineView.frame;
    tempFrame.size.width = self.bounds.size.width;
    self.myLineView.frame = tempFrame;

    
    tempFrame = self.myNameLabel.frame;
    tempFrame.size.width = self.bounds.size.width-tempImageW-KLeftOffset*3-20;
    self.myNameLabel.frame = tempFrame;
    
    tempFrame = self.myTimeLabel.frame;
    tempFrame.size.width = self.bounds.size.width-tempImageW-KLeftOffset*3;
    self.myTimeLabel.frame = tempFrame;
    
    tempFrame = self.mydelBtn.frame;
    tempFrame.origin.x = self.bounds.size.width -100;
    self.mydelBtn.frame = tempFrame;
    
    tempFrame = [self frame];
    tempFrame.size.height = CGRectGetMaxY(self.myLineView.frame);
    self.frame = tempFrame;
    
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    
       
    M_CarItemModel* tempItem = [array objectAtIndex:indexPath.row];
    if (tempItem!=nil) {
        
        self.myItemModel = tempItem;
        
        self.myNameLabel.text = @"";
        self.myTimeLabel.text = @"";
        
        if ([tempItem.myCar_Img notEmpty]) {
            [self.myImageView setImageWithURL:[NSURL URLWithString:tempItem.myCar_Img] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
        }else{
            [self.myImageView setImage:[UIImage imageNamed:@"tempcar.jpg"]];
            
        }

        
        if ([tempItem.myBrand_Name notEmpty] && [tempItem.mySubbrand_Name notEmpty] &&
            [tempItem.myCar_Name notEmpty] && [tempItem.myCar_Year notEmpty])
        {
            
                     self.myNameLabel.text =[NSString stringWithFormat:@"%@ %@ %@款 %@",tempItem.myBrand_Name,tempItem.mySubbrand_Name,tempItem.myCar_Year,tempItem.myCar_Name] ;
        }
        

        if ([tempItem.myCreated_at notEmpty]) {
            self.myTimeLabel.text = [Unity getTimeFromTimerLong:tempItem.myCreated_at];
        }
    }
}



@end
