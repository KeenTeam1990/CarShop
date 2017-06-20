//
//  M_SpikeItemCell.m
//  DHCarForUser
//
//  Created by lucaslu on 16/1/14.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "M_SpikeItemCell.h"
#import "M_SpikeListModel.h"
typedef enum {
    KUnStart,
    KSkiping,
    KSkipEnd
}KStaticType;

@interface M_SpikeItemCell ()

AS_MODEL_STRONG(UIImageView, myImageView);
AS_MODEL_STRONG(UIImageView, myLineView);

AS_MODEL_STRONG(UIView, myBottomView);

AS_MODEL_STRONG(UIButton, myTimeBtn);

AS_MODEL_STRONG(UILabel, myNameLabel);
AS_MODEL_STRONG(UILabel, myName2Label);

AS_MODEL_STRONG(UIButton, mySpikeBtn);

AS_INT(currState);
AS_MODEL_STRONG(NSTimer, myTimer);

AS_INT(currIndex);

AS_MODEL_STRONG(NSDate, myCurrDate);

AS_MODEL_STRONG(M_SpikeItemModel, myModel);

AS_MODEL(KStaticType, mySkipeStatic);
AS_BOOL(isTimer);

@end

@implementation M_SpikeItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        self.currIndex = 60;
        
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, self.bounds.size.width, 200)];
        self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.myImageView];
        
        self.myTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.myTimeBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor blackColor];
                                                 style.cornerRedius = 5;);
        self.myTimeBtn.titleLabel.font = SYSTEMFONT(12);
        [self.myTimeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.myTimeBtn.userInteractionEnabled = NO;
        self.myTimeBtn.frame = CGRectMake(self.bounds.size.width-210, 15, 200, 30);
        [self.contentView addSubview:self.myTimeBtn];
        
        self.myBottomView = [[UIView alloc]initWithFrame:CGRectMake(10, 220-60, self.bounds.size.width-20, 60)];
        [self.myBottomView setBackgroundColor:[UIColor redColor]];
        [self.contentView addSubview:self.myBottomView];
        
        self.mySpikeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.mySpikeBtn.style = DLButtonStyleMake(style.backgroundColor = [Unity getColor:@"#f9e117"];
                                                  style.cornerRedius = 5;);
        [self.mySpikeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.mySpikeBtn setTitle:@"立即秒拍" forState:UIControlStateNormal];
        [self.mySpikeBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self.mySpikeBtn addTarget:self action:@selector(spikeBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.mySpikeBtn.frame = CGRectMake(self.myBottomView.bounds.size.width-110, 10, 100, 40);
        [self.myBottomView addSubview:self.mySpikeBtn];
        
        self.myNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.myBottomView.frame.size.width-self.mySpikeBtn.frame.size.width-40, 30)];
        self.myNameLabel.font = [UIFont systemFontOfSize:14];
        [self.myNameLabel setTextColor:[UIColor whiteColor]];
        [self.myBottomView addSubview:self.myNameLabel];
        
        self.myName2Label = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, self.myBottomView.frame.size.width-self.mySpikeBtn.frame.size.width-40, 30)];
        self.myName2Label.font = [UIFont systemFontOfSize:16];
        [self.myName2Label setTextColor:[UIColor whiteColor]];
        [self.myBottomView addSubview:self.myName2Label];
        
        self.myLineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 219, self.bounds.size.width, 6)];
        self.myLineView.backgroundColor = [Unity getGrayBackColor];
        [self.contentView addSubview:self.myLineView];
        
        [self initTimer];
    }
    return self;
}

-(void)spikeBtnPressed:(id)sender
{
    if (self.block!=nil) {
        self.block(0,self.myModel);
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect tempFrame = self.myLineView.frame;
    tempFrame.size.width = self.bounds.size.width;
    tempFrame.origin.y = self.bounds.size.height-6;
    self.myLineView.frame = tempFrame;
    
    tempFrame = self.myImageView.frame;
    tempFrame.size.width = self.bounds.size.width;
    self.myImageView.frame = tempFrame;
    
    tempFrame = self.myBottomView.frame;
    tempFrame.size.width = self.bounds.size.width-20;
    self.myBottomView.frame = tempFrame;
    
    tempFrame = self.myTimeBtn.frame;
    tempFrame.origin.x = self.bounds.size.width-210;
    self.myTimeBtn.frame = tempFrame;
    
    tempFrame = self.mySpikeBtn.frame;
    tempFrame.origin.x = self.myBottomView.bounds.size.width-110;
    self.mySpikeBtn.frame = tempFrame;
    
    tempFrame = self.myNameLabel.frame;
    tempFrame.size.width = self.myBottomView.bounds.size.width-40-self.mySpikeBtn.frame.size.width;
    self.myNameLabel.frame = tempFrame;
    
    tempFrame = self.myName2Label.frame;
    tempFrame.size.width = self.myBottomView.bounds.size.width-40-self.mySpikeBtn.frame.size.width;
    self.myName2Label.frame = tempFrame;
}

- (UIImage *)clipImage:(UIImage *)image
{
//    NSLog(@"修改之前的宽   %f",image.size.width);
//    NSLog(@"修改之前的高   %f",image.size.height);
    float ato = 200.0/ScreenWidth;
    float wh = image.size.height/image.size.width;
    
    UIImage *thumbScale;
    CGRect imageRect;
    if (wh< ato) {
        
        float orginx = (image.size.width - image.size.height*ScreenWidth/200)/2;
//        NSLog(@"orginx＝＝＝＝＝＝＝＝＝＝   %f",orginx);
        imageRect = CGRectMake(orginx, 0, image.size.width-2*orginx, image.size.height);
    }
    else{
        float orginy = (image.size.height - 200*image.size.width/ScreenWidth)/2;
//        NSLog(@"orginy＝＝＝＝＝＝＝＝＝＝   %f",orginy);
        imageRect = CGRectMake(0, orginy, image.size.width, image.size.height-2*orginy);
    }
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], imageRect);
    thumbScale = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
//    NSLog(@"修改之后的宽   %f",thumbScale.size.width);
//    NSLog(@"修改之后的高   %f",thumbScale.size.height);
    
    return thumbScale;
}


-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    M_SpikeItemModel* tempItem = [array objectAtIndex:indexPath.row];
    if (tempItem!=nil) {
        self.isTimer  = NO;
        self.myModel = tempItem;
        self.myImageView.image = [UIImage imageNamed:@"tempcar.jpg"];
        
        [self.mySpikeBtn setUserInteractionEnabled:NO];
        [self.mySpikeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.mySpikeBtn setBackgroundColor:[UIColor lightGrayColor]];
        
        self.myNameLabel.text = @"";
        self.myName2Label.text = @"";
        
        if ([tempItem.myCover notEmpty]) {
//            [self.myImageView setImageWithURL:[NSURL URLWithString:tempItem.myCover] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
            self.myImageView.image = [UIImage imageNamed:@"tempcar.jpg"];

            
            UIImage *coverImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:tempItem.myCover]]];
            UIImage *changeImage = [self clipImage:coverImage];
            self.myImageView.image = changeImage;
//            [self.myImageView setImageWithURL:[NSURL URLWithString:tempItem.myCover] placeholderImage:[UIImage imageNamed:@"tempcar"]];
//            self.myImageView.image.resizingMode=UIImageResizingModeStretch;
        }
        

        
        if ([tempItem.myCar_Name notEmpty]) {
            NSString *carType = [NSString stringWithFormat:@"%@  %@  %@",tempItem.myBrand_Name,tempItem.mySubbrand_Name,tempItem.myCar_Name];
            self.myNameLabel.text = carType;
        }
        if ([tempItem.spike_price notEmpty]&&[tempItem.myCar_Price notEmpty]) {
            float price = [tempItem.myCar_Price floatValue] - [tempItem.spike_price floatValue];
            self.myName2Label.text = [NSString stringWithFormat:@"商城直降%.2f万",price];
        }
//        if([tempItem.spike_has_order isEqualToString:@"0"])
//        {
//            [self.mySpikeBtn setTitle:@"立即秒拍" forState:UIControlStateNormal];
//        }
//        if ([tempItem.spike_has_order isEqualToString:@"1"]) {
//            NSLog(@"秒拍已成功");
//            [self.mySpikeBtn setTitle:@"秒拍成功" forState:UIControlStateNormal];
//        }
//        if ([tempItem.spike_isopened isEqualToString:@"1"]) {
//            
//            if ([tempItem.timestamp notEmpty] &&
//                [tempItem.spike_ended_at notEmpty] &&
//                [tempItem.spike_started_at notEmpty]) {
//                
//                NSTimeInterval secondsInterval1 = [tempItem.spike_started_at doubleValue] - [tempItem.timestamp doubleValue];
//                
//                NSTimeInterval secondsInterval2 = [tempItem.spike_ended_at doubleValue] - [tempItem.timestamp doubleValue];
//                
//                //[self.mySpikeBtn setUserInteractionEnabled:NO];
//                [self.mySpikeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//                [self.mySpikeBtn setBackgroundColor:[Unity getColor:@"#f9e117"]];
//                
//                if (secondsInterval1>=0) {
//                    
//                    self.currState = 1;
//                    
//                    if (secondsInterval2 < 0) {
//                        
//                        self.currState = 3;
//                        
//                        NSString* tempbtnText = @"已结束";
//                        
//                        [self.myTimeBtn setTitle:tempbtnText forState:UIControlStateNormal];
//                        
//                        //[self.mySpikeBtn setUserInteractionEnabled:NO];
//                        [self.mySpikeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//                        [self.mySpikeBtn setBackgroundColor:[UIColor lightGrayColor]];
//                        
//                        [self stop];
//                    }
//                }else{
//                    
//                    self.currState = 2;
//                }
//                
//                if (!self.isTimer && (self.currState==1 || self.currState==2)) {
//                    [self start];
//                }
//            }
//        }
        
        //
        
        
        if ([self.myModel.timestamp notEmpty] &&
            [self.myModel.spike_ended_at notEmpty] &&
            [self.myModel.spike_started_at notEmpty]) {
            NSTimeInterval secondsInterval1 = [self.myModel.spike_started_at doubleValue] - [self.myModel.timestamp doubleValue];
            
            NSTimeInterval secondsInterval2 = [self.myModel.spike_ended_at doubleValue] - [self.myModel.timestamp doubleValue];
            self.mySpikeBtn.backgroundColor = [Unity getColor:@"#f9e117"];

            if (secondsInterval1>=0) {
                
                self.currState = 1;
                NSLog(@"未开启");
                [self start];
                if ([self.myModel.myCar_Deposit notEmpty] ) {
                    self.mySpikeBtn.hidden = NO;
                    [self.mySpikeBtn setTitle:@"立即秒拍" forState:UIControlStateNormal];
                    [self.mySpikeBtn setBackgroundColor:[Unity getColor:@"#f9e117"]];
                    [self.mySpikeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

                    NSLog(@"测试这个方法是否一直走");
                }
                
                if (secondsInterval2<0) {
                    self.myTimeBtn.hidden = YES;
                    [self.mySpikeBtn setUserInteractionEnabled:NO];
                    [self.mySpikeBtn setTitle:@"已结束" forState:UIControlStateNormal];
                    [self.mySpikeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [self.mySpikeBtn setBackgroundColor:[UIColor lightGrayColor]];
                    self.currState = 3;
                    NSLog(@"秒拍结束");
//                    [self stop];
//                    self.myTimeBtn.hidden = YES;
                }
            }else{
                
                self.currState = 2;
                [self start];
                NSLog(@"正在秒拍");
                if ([self.myModel.spike_isopened isEqualToString:@"0"] && [self.myModel.spike_has_order isEqualToString:@"1"]) {
                    NSLog(@"我已秒拍成功");
                    self.myTimeBtn.hidden = YES;
                    [self.myTimeBtn setTitle:@"已结束" forState:UIControlStateNormal];
                    [self stop];
                    [self.mySpikeBtn setTitle:[NSString stringWithFormat:@"秒拍成功"] forState:UIControlStateNormal];
                    [self.mySpikeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [self.mySpikeBtn setBackgroundColor:[UIColor lightGrayColor]];
                  
                }
                else if([self.myModel.spike_isopened isEqualToString:@"0"] && [self.myModel.spike_has_order isEqualToString:@"0"])
                {
                    NSLog(@"我秒拍失败，别人秒拍了");
                     self.myTimeBtn.hidden = YES;
                    [self.myTimeBtn setTitle:@"已结束" forState:UIControlStateNormal];
                    [self stop];
                    [self.mySpikeBtn setTitle:[NSString stringWithFormat:@"已结束"] forState:UIControlStateNormal];
                    [self.mySpikeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [self.mySpikeBtn setBackgroundColor:[UIColor lightGrayColor]];
                    
                }
                else if([self.myModel.spike_isopened isEqualToString:@"1"]&&[self.myModel.spike_has_order isEqualToString:@"1"])
                {
                    NSLog(@"还在秒拍，我已秒拍成功");
                    [self.myTimeBtn setTitle:@"已结束" forState:UIControlStateNormal];
                    [self stop];
                    [self.mySpikeBtn setTitle:[NSString stringWithFormat:@"秒拍成功"] forState:UIControlStateNormal];
                    [self.mySpikeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [self.mySpikeBtn setBackgroundColor:[UIColor lightGrayColor]];

                }
                else if([self.myModel.spike_isopened isEqualToString:@"1"] &&[self.myModel.spike_has_order isEqualToString:@"0"])
                {
                    NSLog(@"已开启，我未秒拍");
                    self.mySpikeBtn.userInteractionEnabled = YES;
                    [self.mySpikeBtn setTitle:@"立即秒拍" forState:UIControlStateNormal];
                    [self.mySpikeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [self.mySpikeBtn setBackgroundColor:[UIColor redColor]];
                    [self.mySpikeBtn setBackgroundColor:[Unity getColor:@"#f9e117"]];
                    [self.mySpikeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                }

            }
        }
        
//        if([self.myModel.spike_isopened isEqualToString:@"0"] && [self.myModel.spike_has_order isEqualToString:@"0"])
//        {
//            self.myTimeBtn.hidden = YES;
//            [self.mySpikeBtn setTitle:@"已结束" forState:UIControlStateNormal];
//            [self stop];
//        }
//        else if ([tempItem.spike_has_order isEqualToString:@"1"]) {
//            NSLog(@"秒拍已成功");
//            self.myTimeBtn.hidden = YES;
//            [self.mySpikeBtn setTitle:@"已结束" forState:UIControlStateNormal];
//            [self stop];
//        }
//        else if ([self.myModel.spike_isopened isEqualToString:@"1"]) {
//            [self.mySpikeBtn setTitle:@"立即秒拍" forState:UIControlStateNormal];
//        }

        
        if ([tempItem.spike_has_order notEmpty]) {
            if ([tempItem.spike_has_order isEqualToString:@"1"]) {

            }
        }
        else{
            self.myCurrDate = nil;
            //self.mySureBtn.hidden = YES;
            self.myTimeBtn.hidden = YES;
        }

        //
//        if ([tempItem.spike_has_order notEmpty]) {
//            if ([tempItem.spike_has_order isEqualToString:@"1"]) {
//                
//                //[self.mySpikeBtn setUserInteractionEnabled:NO];
//                [self.mySpikeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//                [self.mySpikeBtn setBackgroundColor:[UIColor lightGrayColor]];
//            }
//        }
//        
//        NSString *endTime = self.myModel.spike_ended_at;
//        NSDate *tempDate = [NSDate dateWithTimeIntervalSince1970:[endTime doubleValue]];
//        NSTimeInterval timetrave = [tempDate timeIntervalSinceNow];
//        if (timetrave <=0 ) {
//            self.myTimeBtn.hidden = YES;
//            [self.mySpikeBtn setTitle:@"已结束" forState:UIControlStateNormal];
//        }
//        else{
//            self.myTimeBtn.hidden = NO;
//        }
//        
        
    }
}

-(void)initTimer
{
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.myTimer forMode:NSRunLoopCommonModes];
    [self stop];
}

-(void)scrollTimer
{
    if (self.currState>0) {
        
        if (self.currState == 1) {
            self.myTimeBtn.hidden = NO;
            NSString* tempStr = [Unity dayOrTime:self.myModel.spike_started_at];
            if (tempStr == nil||[tempStr isEqualToString:@"0秒"]) {
                //首页更新数据
                //[self stop];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SpikeEnd" object:nil];
            } else {
                NSString* tempbtnText = [NSString stringWithFormat:@"秒拍还有%@开始",tempStr];
                [self.myTimeBtn setTitle:tempbtnText forState:UIControlStateNormal];
            }

            
        }else if (self.currState == 2){
            NSString* tempStr = [Unity dayOrTime:self.myModel.spike_ended_at];
            if (tempStr == nil||[tempStr isEqualToString:@"0秒"]) {
                //首页更新数据
                NSLog(@"秒拍结束了");
                self.myTimeBtn.hidden = YES;
                [self stop];
                [self.mySpikeBtn setTitle:@"已结束" forState:UIControlStateNormal];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SpikeEnd" object:nil];
            } else {
                self.myTimeBtn.hidden = NO;
                NSLog(@"更新秒拍倒计时");
                NSString* tempbtnText = [NSString stringWithFormat:@"秒拍还有%@结束",tempStr];
                [self.myTimeBtn setTitle:tempbtnText forState:UIControlStateNormal];
            }
            NSString* tempbtnText = [NSString stringWithFormat:@"秒拍还有%@结束",tempStr];
            [self.myTimeBtn setTitle:tempbtnText forState:UIControlStateNormal];
        }
        else{
            self.myTimeBtn.hidden = YES;
            [self.mySpikeBtn setTitle:@"已结束" forState:UIControlStateNormal];
        }
    }
}

-(void)start
{
    //开启定时器
    [self.myTimer setFireDate:[NSDate distantPast]];
    
    self.isTimer = YES;
}
-(void)stop
{
    //关闭定时器
    [self.myTimer setFireDate:[NSDate distantFuture]];
    
    self.isTimer = NO;
}
-(void)didMoveToWindow
{
    NSLog(@"这个哥哥哥");
}
-(void)afterInterval:(float)interval
{
    [self.myTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
