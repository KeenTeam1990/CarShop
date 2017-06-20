//
//  DLPickerView.m
//  Traderoute
//
//  Created by 卢迎志 on 15-1-27.
//  Copyright (c) 2015年 卢迎志. All rights reserved.
//

#import "DLPickerView.h"

#define KPickerViewHeight 260

@implementation DLPickerView

DEF_FACTORY_FRAME(DLPickerView);
DEF_MODEL(delegate);
DEF_MODEL(myCancelBtn);
DEF_MODEL(myDataSource);
DEF_MODEL(myPickerView);
DEF_MODEL(mySureBtn);
DEF_MODEL(myTitleBackView);
DEF_MODEL(myTitleLabel);
DEF_MODEL(myDefaultDic);
DEF_MODEL(myView);

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        CGRect tempRect = CGRectMake(0, frame.size.height - KPickerViewHeight, frame.size.width, KPickerViewHeight);
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        UIView* tempView = [[UIView alloc]initWithFrame:tempRect];
        [tempView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:tempView];
        
        self.myView = tempView;
        
        self.myTitleBackView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tempRect.size.width, 44)];
        [self.myTitleBackView setBackgroundColor:RGBCOLOR(211, 211, 211)];
        [tempView addSubview:self.myTitleBackView];
        
        self.myCancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.myCancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.myCancelBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.myCancelBtn setTitleColor:[Unity getNavBarBackColor] forState:UIControlStateNormal];
        [self.myCancelBtn addTarget:self action:@selector(cancelBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.myCancelBtn.frame = CGRectMake(0, 0, 60, 44);
        [tempView addSubview:self.myCancelBtn];
        
        self.mySureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.mySureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self.mySureBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.mySureBtn setTitleColor:[Unity getNavBarBackColor] forState:UIControlStateNormal];
        [self.mySureBtn addTarget:self action:@selector(sureBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.mySureBtn.frame = CGRectMake(tempRect.size.width-60, 0, 60, 44);
        [tempView addSubview:self.mySureBtn];
        
        self.myTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, tempRect.size.width-120, 44)];
        [self.myTitleLabel setBackgroundColor:[UIColor clearColor]];
        [self.myTitleLabel setFont:[UIFont systemFontOfSize:16]];
        [self.myTitleLabel setTextColor:[UIColor blackColor]];
        [self.myTitleLabel setTextAlignment:UITextAlignmentCenter];
        [tempView addSubview:self.myTitleLabel];
        
        self.myPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, tempRect.size.width, tempRect.size.height-44)];
        self.myPickerView.delegate = self;
        self.myPickerView.dataSource = self;
        
        [tempView addSubview:self.myPickerView];
    }
    return self;
}

-(void)updateViewData:(NSString*)title withData:(DLPickerDataSource*)data withDefault:(NSDictionary*)dic
{
    if ([title notEmpty]) {
        self.myTitleLabel.text = title;
    }
    self.myDataSource = data;
    self.myDefaultDic = dic;
    //写数据，往初始化数据
    if (self.myDataSource!=nil && [self.myDataSource.firstArray count] > 0) {
        if (self.myDataSource.pickComponentsCount == 1) {
            if (dic!=nil) {
                if ([dic objectForKey:KPICKER_FIRST]!=nil) {
                    self.myDataSource.seleteFirstIndex = [[dic objectForKey:KPICKER_FIRST] integerValue];
                }
            }
            [self.myPickerView selectRow:self.myDataSource.seleteFirstIndex inComponent:0 animated:YES];
        }else if (self.myDataSource.pickComponentsCount == 2) {
            if (dic!=nil) {
                if ([dic objectForKey:KPICKER_FIRST]!=nil) {
                    self.myDataSource.seleteFirstIndex = [[dic objectForKey:KPICKER_FIRST] integerValue];
                }
                if ([dic objectForKey:KPICKER_SECOND]!=nil) {
                    self.myDataSource.seleteSecondIndex = [[dic objectForKey:KPICKER_SECOND] integerValue];
                }
            }
            
            NSMutableArray* tempArray = [[self.myDataSource.firstArray objectAtIndex:self.myDataSource.seleteFirstIndex] objectForKey:PopSubArray];
            if ([tempArray count]>0) {
                [self.myDataSource.secondArray removeAllObjects];
                [self.myDataSource.secondArray addObjectsFromArray:tempArray];
            }else{
                NSMutableDictionary* tempdic = [NSMutableDictionary dictionary];
                [tempdic setObject:@"" forKey:PopText];
                [self.myDataSource.secondArray addObject:tempdic];
                [self.mySureBtn setHidden:YES];
            }
            
            [self.myPickerView selectRow:self.myDataSource.seleteFirstIndex inComponent:0 animated:YES];
            [self.myPickerView selectRow:self.myDataSource.seleteSecondIndex inComponent:1 animated:YES];
        }else if (self.myDataSource.pickComponentsCount == 3){
            if (dic!=nil) {
                if ([dic objectForKey:KPICKER_FIRST]!=nil) {
                    self.myDataSource.seleteFirstIndex = [[dic objectForKey:KPICKER_FIRST] integerValue];
                }
                if ([dic objectForKey:KPICKER_SECOND]!=nil) {
                    self.myDataSource.seleteSecondIndex = [[dic objectForKey:KPICKER_SECOND] integerValue];
                }
                if ([dic objectForKey:KPICKER_THREE]!=nil) {
                    self.myDataSource.seleteThreeIndex = [[dic objectForKey:KPICKER_THREE] integerValue];
                }
            }
            NSMutableArray* tempArray = [[self.myDataSource.firstArray objectAtIndex:self.myDataSource.seleteFirstIndex] objectForKey:PopSubArray];
            if ([tempArray count]>0) {
                [self.myDataSource.secondArray removeAllObjects];
                [self.myDataSource.secondArray addObjectsFromArray:tempArray];
                
                if ([self.myDataSource.secondArray count]>0) {
                    tempArray = [[self.myDataSource.secondArray objectAtIndex:self.myDataSource.seleteSecondIndex] objectForKey:PopSubArray];
                    if ([tempArray count] > 0) {
                        [self.myDataSource.threeArray removeAllObjects];
                        [self.myDataSource.threeArray addObjectsFromArray:tempArray];
                    }else{
                        NSMutableDictionary* tempdic = [NSMutableDictionary dictionary];
                        [tempdic setObject:@"" forKey:PopText];
                        [self.myDataSource.threeArray addObject:tempdic];
                        [self.mySureBtn setHidden:YES];
                    }
                }
            }else{
                NSMutableDictionary* tempdic = [NSMutableDictionary dictionary];
                [tempdic setObject:@"" forKey:PopText];
                [self.myDataSource.secondArray addObject:tempdic];
                tempdic = [NSMutableDictionary dictionary];
                [tempdic setObject:@"" forKey:PopText];
                [self.myDataSource.threeArray addObject:tempdic];
                [self.mySureBtn setHidden:YES];
            }
            
            [self.myPickerView selectRow:self.myDataSource.seleteFirstIndex inComponent:0 animated:YES];
            [self.myPickerView selectRow:self.myDataSource.seleteSecondIndex inComponent:1 animated:YES];
            [self.myPickerView selectRow:self.myDataSource.seleteThreeIndex inComponent:2 animated:YES];
            
        }
    }else{
        self.myDataSource = [DLPickerDataSource allocInstance];
        self.myDataSource.pickComponentsCount = 0;
    }
    
    [self.myPickerView reloadAllComponents];
}

#pragma mark - PickerView lifecycle

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (self.myDataSource.pickComponentsCount == 3){
        if (component == 0) {
            if (self.myDataSource.pfirstWidth>0) {
                return self.myDataSource.pfirstWidth;
            }
        }else if (component == 1){
            if (self.myDataSource.psecondWidth>0) {
                return self.myDataSource.psecondWidth;
            }
        }else if (component == 2){
            if (self.myDataSource.pthreeWidth > 0) {
                return self.myDataSource.pthreeWidth;
            }
        }
    }
    return self.frame.size.width/self.myDataSource.pickComponentsCount;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.myDataSource.pickComponentsCount;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [self.myDataSource.firstArray count];
            break;
        case 1:
            return [self.myDataSource.secondArray count];
            break;
        case 2:
            return [self.myDataSource.threeArray count];
            break;
        default:
            break;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            if ([self.myDataSource.firstArray count]>0) {
                return [[self.myDataSource.firstArray objectAtIndex:row] objectForKey:PopText];
            }
        }
            break;
        case 1:
        {
            if ([self.myDataSource.secondArray count]>0) {
                return [[self.myDataSource.secondArray objectAtIndex:row] objectForKey:PopText];
            }
        }
            break;
        case 2:
        {
            if ([self.myDataSource.threeArray count]>0) {
                return [[self.myDataSource.threeArray objectAtIndex:row] objectForKey:PopText];
            }
        }
            break;
        default:
            break;
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    [self.mySureBtn setHidden:NO];
    
    switch (component) {
        case 0:
        {
            self.myDataSource.seleteFirstIndex = row;
            if (self.myDataSource.pickComponentsCount != 1) {
                self.myDataSource.seleteSecondIndex = 0;
                self.myDataSource.seleteThreeIndex = 0;
                NSMutableArray* tempArray = [[self.myDataSource.firstArray objectAtIndex:row] objectForKey:PopSubArray];
                if (tempArray!=nil && [tempArray count] > 0) {
                    [self.myDataSource.secondArray removeAllObjects];
                    [self.myDataSource.secondArray addObjectsFromArray:tempArray];
                    if (self.myDataSource.pickComponentsCount != 2) {
                        tempArray = [[self.myDataSource.secondArray objectAtIndex:self.myDataSource.seleteSecondIndex] objectForKey:PopSubArray];
                        if (tempArray!=nil && [tempArray count] > 0) {
                            [self.myDataSource.threeArray removeAllObjects];
                            [self.myDataSource.threeArray addObjectsFromArray:tempArray];
                        }else{
                            [self.myDataSource.threeArray removeAllObjects];
                            NSMutableDictionary* tempdic = [NSMutableDictionary dictionary];
                            [tempdic setObject:@"" forKey:PopText];
                            [self.myDataSource.threeArray addObject:tempdic];
                            [self.mySureBtn setHidden:YES];
                        }
                    }
                }else{
                    [self.myDataSource.secondArray removeAllObjects];
                    [self.myDataSource.threeArray removeAllObjects];
                    NSMutableDictionary* tempdic = [NSMutableDictionary dictionary];
                    [tempdic setObject:@"" forKey:PopText];
                    [self.myDataSource.secondArray addObject:tempdic];
                    tempdic = [NSMutableDictionary dictionary];
                    [tempdic setObject:@"" forKey:PopText];
                    [self.myDataSource.threeArray addObject:tempdic];
                    [self.mySureBtn setHidden:YES];
                }
            }
        }
            break;
        case 1:
        {
            self.myDataSource.seleteSecondIndex = row;
            if (self.myDataSource.pickComponentsCount != 2) {
                self.myDataSource.seleteThreeIndex = 0;
                if ([self.myDataSource.secondArray count]>0) {
                    NSMutableArray* tempArray = [[self.myDataSource.secondArray objectAtIndex:row] objectForKey:PopSubArray];
                    if (tempArray!=nil && [tempArray count] > 0) {
                        [self.myDataSource.threeArray removeAllObjects];
                        [self.myDataSource.threeArray addObjectsFromArray:tempArray];
                    }else{
                        [self.myDataSource.threeArray removeAllObjects];
                        NSMutableDictionary* tempdic = [NSMutableDictionary dictionary];
                        [tempdic setObject:@"" forKey:PopText];
                        [self.myDataSource.threeArray addObject:tempdic];
                        [self.mySureBtn setHidden:YES];
                    }
                }
            }
        }
            break;
        case 2:
        {
            self.myDataSource.seleteThreeIndex = row;
        }
            break;
        default:
            break;
    }
    
    [self.myPickerView reloadAllComponents];
}

-(void)sureBtnPressed:(id)sender
{
    NSString* tempstr = @"";
    
    if (self.myDataSource!=nil && [self.myDataSource.firstArray count] > 0) {
        if (self.myDataSource.pickComponentsCount == 1) {
            tempstr = [[self.myDataSource.firstArray objectAtIndex:self.myDataSource.seleteFirstIndex] objectForKey:PopText];
        }
        else if (self.myDataSource.pickComponentsCount == 2){
            if ([self.myDataSource.secondArray count] > 0) {
                tempstr = [[self.myDataSource.secondArray objectAtIndex:self.myDataSource.seleteSecondIndex] objectForKey:PopText];
            }
        }else if (self.myDataSource.pickComponentsCount == 3){
            if ([self.myDataSource.threeArray count] > 0) {
                tempstr = [[self.myDataSource.threeArray objectAtIndex:self.myDataSource.seleteThreeIndex] objectForKey:PopText];
            }
        }
    }
    
    if (tempstr.length > 0) {
        if (self.delegate !=nil && [self.delegate respondsToSelector:@selector(pickerSureBtnPressed:)]) {
            [self.delegate pickerSureBtnPressed:tempstr];
        }
    }

    [self stopAnimation];
    
    if (self.delegate !=nil && [self.delegate respondsToSelector:@selector(pickerCancelBtnPressed)]) {
        [self.delegate pickerCancelBtnPressed];
    }
}
-(void)cancelBtnPressed:(id)sender
{
    [self stopAnimation];
    if (self.delegate !=nil && [self.delegate respondsToSelector:@selector(pickerCancelBtnPressed)]) {
        [self.delegate pickerCancelBtnPressed];
    }
}

-(void)startAnimation
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect tempRect = self.myView.frame;
        tempRect.origin.y = self.frame.size.height-KPickerViewHeight;
        self.myView.frame = tempRect;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)stopAnimation
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect tempRect = self.myView.frame;
        tempRect.origin.y = self.frame.size.height;
        self.myView.frame = tempRect;
    } completion:^(BOOL finished) {
        
    }];
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
