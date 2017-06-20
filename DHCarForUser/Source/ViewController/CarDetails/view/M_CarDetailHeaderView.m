//
//  M_CarDetailHeaderView.m
//  DHCarForSales
//
//  Created by lucaslu on 15/11/1.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CarDetailHeaderView.h"
#import "M_CarImagesView.h"


#define KLeftOffset 20

@interface M_CarDetailHeaderView ()

AS_MODEL_STRONG(M_CarImagesView, myImagesView);
AS_MODEL_STRONG(UILabel, myNameLabel);
AS_MODEL_STRONG(UIImageView, myLine1View);
AS_MODEL_STRONG(UIImageView, myLine2View);
AS_MODEL_STRONG(UIImageView, myLine3View);
AS_MODEL_STRONG(UILabel, myPriceLabel);
AS_MODEL_STRONG(UILabel, myGuidePriceLabel);

AS_MODEL_STRONG(UILabel, myDepositLabel);

AS_MODEL_STRONG(UIView, myParameterView);
AS_MODEL_STRONG(UIButton, myCorolBtn);
AS_MODEL_STRONG(UIButton, myRentBtn);
@end

@implementation M_CarDetailHeaderView

DEF_FACTORY_FRAME(M_CarDetailHeaderView);

DEF_MODEL(myDepositLabel);
DEF_MODEL(myGuidePriceLabel);
DEF_MODEL(myImagesView);
DEF_MODEL(myLine1View);
DEF_MODEL(myLine2View);
DEF_MODEL(myNameLabel);
DEF_MODEL(myPriceLabel);
DEF_MODEL(myParameterView);
DEF_MODEL(myRentBtn);
DEF_MODEL(myCorolBtn);

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setClipsToBounds:YES];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        NSInteger imageheight = 220;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            imageheight = 440;
        }
        
        [self initImagesView:CGRectMake(0, 0, frame.size.width, imageheight)];
        
        [self initNameView:CGRectMake(0, imageheight, frame.size.width, 40)];
        
        [self initDepositView:CGRectMake(0, imageheight+40, frame.size.width, 50)];
        
        [self initParameterView:CGRectMake(0, imageheight+90, frame.size.width, 0)];
        
//        [self initCorolBtnWithFrame:CGRectMake(0, imageheight+90, frame.size.width, 44)];
//        [self initRentBtnWithFrame:CGRectMake(0, imageheight+90, frame.size.width, 44)];
        
        self.myLine3View = [[UIImageView alloc]initWithFrame:CGRectMake(0, imageheight+90, frame.size.width, 1)];
        [self.myLine3View setBackgroundColor:RGBCOLOR(186, 186, 187)];
        [self addSubview:self.myLine3View];
        
        self.myLine2View = [[UIImageView alloc]initWithFrame:CGRectMake(0, imageheight+91, frame.size.width, 10)];
        [self.myLine2View setBackgroundColor:RGBCOLOR(233, 233, 233)];//
        [self addSubview:self.myLine2View];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}
-(void)initCorolBtnWithFrame:(CGRect)frame
{
    self.myCorolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.myCorolBtn setTitle:@"请选择外观颜色" forState:UIControlStateNormal];
    [self.myCorolBtn setTitleColor:[Unity getColor:@"#f81d25"] forState:UIControlStateNormal];
    self.myCorolBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.myCorolBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor]; style.borderWidth = 1;
                                            style.borderColor = [UIColor grayColor];
                                            style.cornerRedius = 5;);
    [self addSubview:self.myCorolBtn];
    self.myCorolBtn.hidden = YES;
    self.myCorolBtn.tag = 99991;
     [self.myCorolBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchDown];
    
}
-(void)initRentBtnWithFrame:(CGRect)frame
{
    self.myRentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.myRentBtn setTitle:@"请进行选择分期" forState:UIControlStateNormal];
    [self.myRentBtn setTitleColor:[Unity getColor:@"#f81d25"] forState:UIControlStateNormal];
    self.myRentBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.myRentBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor]; style.borderWidth = 1;
                                              style.borderColor = [UIColor grayColor];
                                              style.cornerRedius = 5;);
    [self addSubview:self.myRentBtn];
    self.myRentBtn.tag = 99990;
    self.myRentBtn.hidden = YES;
    [self.myRentBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchDown];
    
}
-(void)buttonClickAction:(UIButton *)button
{
    if (self.myBlock != nil) {
        switch (button.tag) {
            case 99991:
            {
                NSLog(@"选择颜色");
                self.myBlock (button.tag);
            }
                break;
            case 99990:
            {
                NSLog(@"分期");
                self.myBlock(button.tag);
            }
                break;
            default:
                break;
        }
    }
}
-(UILabel*)getParameter:(CGRect)frame withView:(UIView*)view
{
    UILabel* tempLabel = [[UILabel alloc]initWithFrame:frame];
    [tempLabel setBackgroundColor:[UIColor clearColor]];
    [tempLabel setTextColor:RGBCOLOR(103, 102, 102)];
    [tempLabel setFont:[UIFont systemFontOfSize:14]];
    
    [view addSubview:tempLabel];
    return tempLabel;
}

-(void)initImagesView:(CGRect)frame
{
    self.myImagesView = [M_CarImagesView allocInstanceFrame:frame];
    [self.myImagesView setClipsToBounds:YES];
    [self addSubview:self.myImagesView];
}

-(void)initNameView:(CGRect)frame
{
    self.myNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(KLeftOffset, frame.origin.y, frame.size.width-KLeftOffset*2, frame.size.height)];
    [self.myNameLabel setBackgroundColor:[UIColor clearColor]];
    [self.myNameLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [self.myNameLabel setTextColor:[UIColor blackColor]];
    self.myNameLabel.numberOfLines = 3;
    [self addSubview:self.myNameLabel];
}

-(void)initParameterView:(CGRect)frame
{
    self.myParameterView = [[UIView alloc]initWithFrame:frame];
    [self.myParameterView setBackgroundColor:RGBCOLOR(234, 234, 234)];
    [self addSubview:self.myParameterView];
}

-(void)initDepositView:(CGRect)frame
{
    self.myDepositLabel = [self getParameter:CGRectMake(KLeftOffset, frame.origin.y, 40, frame.size.height) withView:self];
    [self.myDepositLabel setTextColor:[UIColor redColor]];
    
    self.myPriceLabel = [self getParameter:CGRectMake(KLeftOffset+40, frame.origin.y, 80, frame.size.height) withView:self];
    [self.myPriceLabel setTextColor:[UIColor redColor]];
    [self.myPriceLabel setFont:[UIFont boldSystemFontOfSize:20]];
    
    self.myLine1View = [[UIImageView alloc]initWithFrame:CGRectMake(KLeftOffset+40+90, frame.origin.y+10, 1, 30)];
    [self.myLine1View setBackgroundColor:RGBCOLOR(186, 186, 187)];
    [self addSubview:self.myLine1View];
    
    self.myGuidePriceLabel = [self getParameter:CGRectMake(self.myLine1View.frame.origin.x+10, frame.origin.y, frame.size.width/2-KLeftOffset, frame.size.height) withView:self];

}

-(void)updateData:(M_CarItemModel*)data
{
    if (data!=nil) {

       
        if ([data.myBrand_Name notEmpty] && [data.mySubbrand_Name notEmpty] && [data.myCar_Year notEmpty] &&[data.myCar_Name notEmpty]) {
            self.myNameLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",data.myBrand_Name,data.mySubbrand_Name,data.myCar_Year,data.myCar_Name];
        }
        
        if ([data.myCarImgArray count]>0) {
            [self.myImagesView upDateData:data.myCarImgArray];
        }else{
            [self.myImagesView upDateData:[NSMutableArray arrayWithObjects:@"1", nil]];
        }
        self.myDepositLabel.text = @"订金";
        if ([data.myCar_Deposit notEmpty]) {
            self.myPriceLabel.text = [NSString stringWithFormat:@"%@元",data.myCar_Deposit];;
        }
        
        if ([data.myCar_Price notEmpty]) {
            self.myGuidePriceLabel.text = [NSString stringWithFormat:@"指导价%@万元",data.myCar_Price];
        }
        
        if ([data.myParameterArray count]>0) {
            
            CGRect tempFrame = self.myParameterView.frame;
            tempFrame.size.height = 30*([data.myParameterArray count]%2==0?[data.myParameterArray count]/2:([data.myParameterArray count]/2)+1);
            self.myParameterView.frame = tempFrame;
            
            tempFrame = self.myLine3View.frame;
            tempFrame.origin.y = CGRectGetMaxY(self.myParameterView.frame);
            self.myLine3View.frame = tempFrame;
            
            tempFrame = self.myLine2View.frame;
            tempFrame.origin.y = CGRectGetMaxY(self.myLine3View.frame);
            self.myLine2View.frame = tempFrame;
            
            for (int i=0; i<[self.myParameterView.subviews count]; i++) {
                UIView* tempView = [self.myParameterView.subviews objectAtIndex:i];
                if (tempView!=nil) {
                    [tempView removeFromSuperview];
                }
            }
            
            NSInteger x = KLeftOffset;
            NSInteger y = 0;
            NSInteger w = (self.myParameterView.frame.size.width-KLeftOffset*2)/2;
            NSInteger h = 30;
            
            for (int i=0; i<[data.myParameterArray count]; i++) {
                M_CarParameterItemModel* tempItem = [data.myParameterArray objectAtIndex:i];
                if (tempItem!=nil) {
                    
                    UILabel* tempLabel = [self getParameter:CGRectMake(x, y, w, h) withView:self.myParameterView];
                    tempLabel.font = SYSTEMFONT(12);
                    tempLabel.text = [NSString stringWithFormat:@"%@:%@",tempItem.myParameter_Name,tempItem.myParameter_Value];
                    
                    if (i!=0 && (i+1)%2==0) {
                        x = KLeftOffset;
                        y += h;
                    }else{
                        x+=w;
                    }
                }
            }
        }
//        if([data.myColorArray count] != 0)
//        {
//            self.myCorolBtn.hidden = NO;
//            CGRect tempFrame = self.myCorolBtn.frame;
//            tempFrame.origin.y = CGRectGetMaxY(self.myParameterView.frame)+1;
//            tempFrame.origin.x = 8;
//            tempFrame.size.width = self.frame.size.width-16;
//            self.myCorolBtn.frame = tempFrame;
//            if ([data.myLeaseArray count] != 0 ) {
//                self.myRentBtn.hidden = NO;
//                CGRect tempFram = self.myRentBtn.frame;
//                tempFram.origin.x = 8;
//                tempFram.size.width = self.frame.size.width -16;
//                tempFram.origin.y = CGRectGetMaxY(self.myRentBtn.frame)+6;
//                self.myRentBtn.frame = tempFram;
//                
//                tempFrame = self.frame;
//                tempFrame.size.height = CGRectGetMaxY(self.myRentBtn.frame);
//                self.frame = tempFrame;
//            }
//            else{
//                tempFrame = self.frame;
//                tempFrame.size.height = CGRectGetMaxY(self.myCorolBtn.frame);
//                self.frame = tempFrame;
//            }
//        }
//        else
//        {
//            if ([data.myLeaseArray count] !=0) {
//                CGRect tempFrame= self.myRentBtn.frame;
//                tempFrame.origin.x = 8;
//                tempFrame.size.width = self.frame.size.width-16;
//                tempFrame.origin.y = CGRectGetMaxY(self.myParameterView.frame)+5;
//                self.myRentBtn.frame = tempFrame;
//                tempFrame =self.frame ;
//                tempFrame.size.height = CGRectGetMaxY(self.myRentBtn.frame);
//                
//            }
//        }
    }
}



@end
