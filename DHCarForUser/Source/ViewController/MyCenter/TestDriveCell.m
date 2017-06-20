//
//  TestDriveCell.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/11.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "TestDriveCell.h"
#import "M_TestDriverModel.h"

#define KLeftOffset 10
@interface TestDriveCell()
AS_MODEL_STRONG(UIButton, myOpenCallBtn);
@end
@implementation TestDriveCell

@synthesize label1,label2,label3,label4,label5,label6,dealerView,mydelBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        [self initView];
        
    }
    return self;
}


-(void)initView
{

    NSInteger tempImageW = 100;
    
    UIImage *tempIamge = [UIImage imageNamed:@"tempcar.jpg"];
    self.carImageView = [[UIImageView alloc]init];
    self.carImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.carImageView setClipsToBounds:YES];

    self.carImageView.frame = CGRectMake(self.bounds.size.width-tempImageW-20,0, tempImageW,100);
    
    self.carImageView.image = tempIamge;
    self.carImageView.userInteractionEnabled = NO;
    [self.contentView addSubview:self.carImageView];
    
    UILabel *templabel = [[UILabel alloc]init];
    templabel.textColor = [UIColor blackColor];
    templabel.text = @"试驾车辆";
    templabel.frame = CGRectMake( 20 , 10, self.bounds.size.width-130, 20);
    templabel.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:templabel];
    
    self.label1 = [[UILabel alloc]init];
    self.label1.textColor = [UIColor blackColor];
    self.label1.frame = CGRectMake( 20 , 30, self.bounds.size.width-tempImageW-30, 40);
    self.label1.numberOfLines = 2;
    self.label1.font = [UIFont systemFontOfSize:14];
   
    [self.contentView addSubview:self.label1];
    

    UILabel *testDriveLabel = [[UILabel alloc]init];
    testDriveLabel.frame = CGRectMake(20, 70, 80, 30);
    testDriveLabel.font = [UIFont systemFontOfSize:14];
    testDriveLabel.textColor = [UIColor redColor];
    testDriveLabel.text = @"预约时间:";
     [self.contentView addSubview:testDriveLabel];
    
    
    self.testDriveDate = [[UILabel alloc]init];
    self.testDriveDate.frame = CGRectMake(90, 70, 150, 30);
    self.testDriveDate.font = [UIFont systemFontOfSize:14];
    self.testDriveDate.textColor = GrayText;
    [self.contentView addSubview:self.testDriveDate];
    
    
    UIImageView *lineView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 110,ScreenWidth, 1)];
    lineView1.image = [UIImage imageNamed:@"dashedLine.png"];
    [self.contentView addSubview:lineView1];
    
    self.dealerView = [[M_CarDistributorItemView1 alloc]initWithFrame:CGRectMake(0, 111, ScreenWidth, 80)];
    [self.contentView addSubview:self.dealerView];
    self.dealerView.showDistance = NO;
    self.dealerView.showPrice = NO;
    self.dealerView.showLine = NO;
    self.dealerView.showSelete = NO;
    self.dealerView.showCellPhone = NO;
    
    UIImageView *lineView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.dealerView.frame.origin.y+80,ScreenWidth, 1)];
    lineView2.image = [UIImage imageNamed:@"dashedLine.png"];
    [self.contentView addSubview:lineView2];
    
    UILabel *templabel1 = [[UILabel alloc]init];
    templabel1.textColor = [UIColor redColor];
    templabel1.text = @"提交时间:";
    templabel1.frame = CGRectMake( 20 ,lineView2.frame.origin.y+6+5, 80, 20);
    templabel1.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:templabel1];

    self.label6 = [[UILabel alloc]init];
    self.label6.frame = CGRectMake(templabel1.frame.size.width , templabel1.frame.origin.y,180, 20);
    self.label6.textAlignment = NSTextAlignmentLeft;
    self.label6.textColor = [Unity getColor:@"#666666"];
    self.label6.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.label6];
    
    UIView *footView = [[UIView alloc]init];
    footView.frame = CGRectMake(0, self.label6.frame.origin.y+30, ScreenWidth, 5);
    footView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.1];
    [self.contentView addSubview:footView];
    
    self.mydelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mydelBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor];
                                            style.cornerRedius = 2;
                                            style.borderWidth =1;
                                            style.borderColor = [UIColor lightGrayColor];);
    [self.mydelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.mydelBtn.frame = CGRectMake(self.contentView.frame.size.width-100,  templabel1.frame.origin.y, 80, 20);
    self.mydelBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.mydelBtn addTarget:self action:@selector(mydelBtnBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.mydelBtn setTitle:@"删除试驾" forState:UIControlStateNormal];
    [self.contentView addSubview:self.mydelBtn];

    self.myOpenCallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myOpenCallBtn.style = DLButtonStyleMake(style.backgroundColor = [UIColor whiteColor]; style.borderWidth = 1;
                                                 style.borderColor = [UIColor blackColor];
                                                 style.cornerRedius = 5;);
    self.myOpenCallBtn.tintColor = [UIColor blackColor];
    [self.myOpenCallBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.myOpenCallBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    self.myOpenCallBtn.frame = CGRectMake(self.dealerView.frame.size.width-110, 80-35, 80, 30);
    [self.myOpenCallBtn addTarget:self action:@selector(openCallBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.myOpenCallBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
    self.myOpenCallBtn.userInteractionEnabled = YES;
    [self.dealerView addSubview:self.myOpenCallBtn];
    
}
-(void)openCallBtnPressed:(UIButton *)button
{
    
    if ([self.myItemModel.dealer_tel notEmpty]) {
        [Unity openCallPhone:self.myItemModel.dealer_tel];
    }
}
-(void)mydelBtnBtnPressed:(id)sender
{
    
    UIAlertView *alertView= [[UIAlertView alloc]initWithTitle:@"提示"
                                                      message:@"是否删除该订单"
                                                     delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.delegate = self;
    [alertView show];
    
}

#pragma mark - alertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (self.myItemModel !=nil) {
            if (self.block!=nil) {
                self.block(0,self.myItemModel);
            }
        }
        
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger tempImageW = 100;
    
    CGRect  tempRect = self.label1.frame;
    tempRect.size.width = self.bounds.size.width-tempImageW-30;
    self.label1.frame = tempRect;
    
    tempRect = self.mydelBtn.frame;
    tempRect.origin.x = self.bounds.size.width - 110;
    self.mydelBtn.frame = tempRect;
    
    tempRect = self.carImageView.frame;
    tempRect.origin.x = self.bounds.size.width - tempImageW-20;
    self.carImageView.frame = tempRect;
    
    tempRect = self.myOpenCallBtn.frame;
    tempRect.origin.x = self.bounds.size.width -110;
    self.myOpenCallBtn.frame = tempRect;
    
    
}

-(void)configCellIndexPath:(NSIndexPath*)indexPath withDataArray:(NSMutableArray*)array
{
    M_TestDriverItemModel *tempItem = [array objectAtIndex:indexPath.row];
    if (tempItem !=nil) {
        
        self.myItemModel  = tempItem;
        
        self.label1.text = @"";
        self.label2.text = @"";
        self.label3.text = @"";
        self.label4.text = @"";
        self.label5.text = @"";
        self.label6.text = @"";
        self.testDriveDate.text = @"";
        self.carImageView.image = nil;
        
        if ([tempItem.myCar_Img notEmpty]) {
            [self.carImageView setImageWithURL:[NSURL URLWithString:tempItem.myCar_Img] placeholderImage:[UIImage imageNamed:@"tempcar.jpg"]];
        }
        
        
        if ([tempItem.myCar_Name notEmpty] &&
            [tempItem.myCar_Year notEmpty] &&
            [tempItem.myBrand_Name notEmpty] &&
            [tempItem.mySubbrand_Name notEmpty]) {
            self.label1.text =[NSString stringWithFormat:@"%@ %@ %@款 %@",tempItem.myBrand_Name,tempItem.mySubbrand_Name,tempItem.myCar_Year,tempItem.myCar_Name] ;
        }
        
        if ([tempItem.myGreated_at notEmpty]) {
            self.label6.text = tempItem.myGreated_at;
        }
        
        if ([tempItem.test_drive_make_time notEmpty]) {
            self.testDriveDate.text = tempItem.test_drive_make_time;
        }
        
        M_DealerItemModel *tempModel = [[M_DealerItemModel alloc]init];
        //拼接预约车地址
        NSMutableString *addressStr = [NSMutableString string];

        if ([tempItem.dealer_address notEmpty])
        {
            addressStr = [NSMutableString stringWithFormat:@"%@ ",tempItem.dealer_address];
            
        }
        
        tempModel.dealer_address = addressStr;
        
        if ([tempItem.dealer_tel notEmpty])
        {
            tempModel.dealer_tel = tempItem.dealer_tel;
            
        }
        
        if ([tempItem.dealer_name notEmpty])
        {
            tempModel.dealer_sname = tempItem.dealer_name;
        }
        
        
        [self.dealerView updateData:tempModel];
        
       
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
