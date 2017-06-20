//
//  H_HomeHeaderView.m
//  DHCarForUser
//
//  Created by 陈斌 on 15/11/6.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "H_HomeHeaderView.h"
#import "M_IconListView.h"

#define KIconListHeight 100
#define KBannerHeight 200
@implementation H_HomeHeaderView

DEF_FACTORY_FRAME(H_HomeHeaderView);

@synthesize myImage;
@synthesize delegate;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self initData];
        
        [self initView];
    }
    return self;
}

-(void)initView
{

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.myBannerView = [MBannerView allocInstanceFrame:CGRectMake(0, 0, self.frame.size.width, KBannerHeight*2)];
        self.myBannerView.delegate = self;
        self.myBannerView.hidden = YES;
        [self addSubview:self.myBannerView];
        
        self.myIconListView = [M_IconListView allocInstanceFrame:CGRectMake(0, 0, self.frame.size.width, KIconListHeight*2)];
        self.myIconListView.hidden = YES;
        [self addSubview:self.myIconListView];
        
        self.myLLIconListView = [[LL_HomeListView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, KIconListHeight*2)];
        self.myLLIconListView.hidden = YES;
        
        [self addSubview:self.myLLIconListView];
    
    }
    else
    {
        self.myBannerView = [MBannerView allocInstanceFrame:CGRectMake(0, 0, self.frame.size.width, KBannerHeight)];
        self.myBannerView.delegate = self;
        self.myBannerView.hidden = YES;
        [self addSubview:self.myBannerView];
        
        self.myIconListView = [M_IconListView allocInstanceFrame:CGRectMake(0, 0, self.frame.size.width, KIconListHeight)];
        self.myIconListView.hidden = YES;
        [self addSubview:self.myIconListView];
        
        self.myLLIconListView = [[LL_HomeListView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, KIconListHeight)];
        self.myLLIconListView.hidden = YES;
        //设置点击事件响应方法
        
        [self addSubview:self.myLLIconListView];
    }

    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-10,self.frame.size.width, 10)];
    lineView.backgroundColor = [Unity getColor:@"#eeeeee"];
    lineView.hidden = YES;
    [self addSubview:lineView];
    
    [self initIconView];
}

-(void)initData
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        self.myImage = @[@"签到.png",@"七天乐.png",@"车险.png",@"公益.png",@"积分.png",@"车商.png",@"汇生活.png",@"服务.png"];
        self.myImage = @[@"SpecialCar1",@"RentCar1",@"BuyCar1"];
    }else{

        self.myImage = @[@"SpecialCar",@"RentCar",@"BuyCar"];
    }

}

-(void)initIconView
{
    NSMutableArray* tempArray = [NSMutableArray allocInstance];
    
    for (int i=0; i<[self.myImage count]; i++) {
        
        NSString* tempImage = [self.myImage objectAtIndex:i];
        NSString* tempText = [self.myTitle objectAtIndex:i];
        
        M_BannerItemModel* tempItem = [M_BannerItemModel allocInstance];
//        if (i == 0) {
//            if ([APPDELEGATE.viewController.myUserModel.user_has_sign notEmpty] &&
//                [APPDELEGATE.viewController.myUserModel.user_has_sign isEqualToString:@"1"]) {
//                tempItem.itemImage = @"已签到.png";
//                tempItem.itemName = @"已签到";
//            }else{
//                tempItem.itemImage = tempImage;
//                tempItem.itemName = tempText;
//            }
//        }else{
            tempItem.itemImage = tempImage;
            tempItem.itemName = tempText;
//        }
        [tempArray addObject:tempItem];
        [self updateLLHomeData:self.myImage];
    }
    
    [self updateIconData:tempArray];
    
    
    __weak H_HomeHeaderView* tempSelf = self;
    self.myIconListView.block = ^(NSInteger tag,id data){
        if (tempSelf.delegate !=nil && [tempSelf.delegate respondsToSelector:@selector(selectIconForTag:withModel:)]) {
            [tempSelf.delegate selectIconForTag:tag withModel:data];
        }
    };

    self.myLLIconListView.myClickBlock =^(NSInteger tag){
        if (tempSelf.delegate !=nil && [tempSelf.delegate respondsToSelector:@selector(selectIconForTag:withModel:)]) {
            [tempSelf.delegate selectIconForTag:tag withModel:nil];
        }
    };

    
}

-(void)updateBannerData:(NSMutableArray*)array
{
    [self.myBannerView updateViewArray:array];
    
    if ([array count]>0) {
        
        self.myBannerView.hidden = NO;
        self.myLLIconListView.hidden = NO;
        CGRect tempFrame ;
        tempFrame = self.myLLIconListView.frame;
        tempFrame.origin.y = CGRectGetMaxY(self.myBannerView.frame)+10;
        self.myLLIconListView.frame= tempFrame;
    }
    else{
        self.myBannerView.hidden = YES;
        self.myLLIconListView.hidden = NO;
        CGRect tempFrame = self.myLLIconListView.frame;
        tempFrame.origin.y = 0;
        self.myLLIconListView.frame =tempFrame;
        
    }
}

-(void)updateIconData:(NSMutableArray*)array
{
    [self.myIconListView updateViewArray:array];
}
-(void)updateLLHomeData:(NSArray *)array
{
    [self.myLLIconListView upDataWithMyArr:array];
}

-(void)bannerItem:(M_BannerItemModel*)data
{
    if (self.delegate !=nil && [self.delegate respondsToSelector:@selector(tapBannerModel:)]) {
        [self.delegate tapBannerModel:data];
    }
}

-(void)updatePoints_Sign
{
    if ([[DLAppData sharedInstance].myUserKey notEmpty]) {
        
        if (APPDELEGATE.viewController.myUserModel!=nil) {
            NSMutableArray* tempArray = [NSMutableArray allocInstance];
            
            for (int i=0; i<[self.myImage count]; i++) {
                
                NSString* tempImage = [self.myImage objectAtIndex:i];
                NSString* tempText = [self.myTitle objectAtIndex:i];
                
                M_BannerItemModel* tempItem = [M_BannerItemModel allocInstance];
//                if (i == 0) {
//                    if ([APPDELEGATE.viewController.myUserModel.user_has_sign notEmpty] &&
//                        [APPDELEGATE.viewController.myUserModel.user_has_sign isEqualToString:@"1"]) {
//                        tempItem.itemImage = @"已签到.png";
//                        tempItem.itemName = @"已签到";
//                    }else{
//                        tempItem.itemImage = tempImage;
//                        tempItem.itemName = tempText;
//                    }
//                }else{
                    tempItem.itemImage = tempImage;
                    tempItem.itemName = tempText;
//                }
                
                
                [tempArray addObject:tempItem];
            }
            
            [self updateIconData:tempArray];
        }
    }
}
-(void)showAniw
{
    [self.myIconListView showAniw];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
