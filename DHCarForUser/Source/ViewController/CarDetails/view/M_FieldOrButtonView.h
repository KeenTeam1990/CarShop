//
//  M_FieldOrButtonView.h
//  DHCarForUser
//
//  Created by lucaslu on 15/11/14.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import "DLView.h"

// tag
// 0 seleteBtn
// 1 btn
// 2 filed
typedef void (^TFieldOrButtonViewBlock)(NSInteger tag,id data);

@interface M_FieldOrButtonView : DLView<UITextFieldDelegate>

AS_FACTORY_FRAME(M_FieldOrButtonView);

AS_BLOCK(TFieldOrButtonViewBlock, block);

-(void)updateSetting:(BOOL)showField withShowBtn:(BOOL)showBtn withShowDrowBtn:(BOOL)showDrow withLabel:(NSString*)label withPlaceholder:(NSString*)placeholder;

-(void)updateContent:(NSString*)content;

-(void)updateFiledContent:(NSString*)content;

-(NSString*)getText;
-(NSString*)getTextViewText;


-(void)getCodeFinish;

-(void)showDrowButton:(BOOL)showDrow;

-(void)showCodeButton;

-(void)getTextView:(CGRect)frame withImage:(NSString *)image withPlaceholder:(NSString *)placeholder;


@end
