//
//  M_CertificateView.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/15.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "M_CertificateView.h"
#import "CB_Label.h"
#import "DLPlaceHolderTextView.h"
#import "CB_Button.h"


@interface M_CertificateView()

AS_MODEL_STRONG(DLPlaceHolderTextView, signature);
AS_MODEL_STRONG(UIButton, commitButtom);
AS_MODEL_STRONG(UIButton, addPictureBtn);

@end

@implementation M_CertificateView

DEF_FACTORY_FRAME(M_CertificateView);

DEF_MODEL(signature);
DEF_MODEL(commitButtom);
DEF_MODEL(addPictureBtn);

DEF_MODEL(block);

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel  = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 30)];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.text=@"评论内容：";
        [self addSubview:titleLabel];
        
        
        self.signature=[[DLPlaceHolderTextView alloc]initWithFrame:CGRectMake(10, 35, self.frame.size.width-20, 100)];
        self.signature.backgroundColor = RGBCOLOR(234, 234, 234);
        self.signature.placeholder=@"请输入评论内容";
        self.signature.layer.borderColor = RGBCOLOR(222, 222, 222).CGColor;
        self.signature.layer.borderWidth =1.0;//该属性显示外边框
        self.signature.layer.cornerRadius = 5.0;//通过该值来设置textView边角的弧度
        self.signature.layer.masksToBounds = YES;
        [self.signature.font fontWithSize:14];
        [self addSubview:self.signature];
        
        UIImageView* temoLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 150, self.frame.size.width, 1)];
        temoLine.backgroundColor = RGBCOLOR(202, 202, 202);
        [self addSubview:temoLine];
        
        UILabel *titleLabel2  = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, 150, 30)];
        titleLabel2.font = [UIFont systemFontOfSize:14];
        titleLabel2.textColor = [UIColor blackColor];
        titleLabel2.text=@"凭证图片：";
        [self addSubview:titleLabel2];
        
        
        self.addPictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.addPictureBtn setBackgroundImage:[UIImage imageNamed:@"upload.png"] forState:UIControlStateNormal];
        [self.addPictureBtn addTarget:self action:@selector(addPicture:) forControlEvents:UIControlEventTouchUpInside];
        self.addPictureBtn.frame = CGRectMake(10, 180, 100, 100);
        [self addSubview:self.addPictureBtn];
        
        
        self.commitButtom = [UIButton buttonWithType:UIButtonTypeCustom];
        self.commitButtom.frame  = CGRectMake(10,200+100, self.frame.size.width-20, 40);
        self.commitButtom.backgroundColor= [UIColor redColor];
        self.commitButtom.layer.cornerRadius = 5;
        [self.commitButtom.layer setMasksToBounds:YES];
        [self.commitButtom setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.commitButtom addTarget:self action:@selector(commitBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.commitButtom setTitle:@"上传" forState:UIControlStateNormal];
        [self.commitButtom.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:self.commitButtom];
        
    }
    return self;
}

-(void)commitBtnPressed:(id)sender
{
    NSString* tempContent = self.signature.text;
    
    if ([tempContent empty]) {
        [SVProgressHUD showErrorWithStatus:@"请输入评论内容"];
        return ;
    }
    
    if (self.block!=nil) {
        self.block(1 ,tempContent);
    }
}

-(void)addPicture:(UIButton *)sender
{
    if (self.block!=nil) {
        self.block(0,nil);
    }
}

-(void)updateImage:(UIImage*)image
{
    [self.addPictureBtn setBackgroundImage:image forState:UIControlStateNormal];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
