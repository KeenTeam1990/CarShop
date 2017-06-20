//
//  MFooterView.h
//  Auction
//
//  Created by 卢迎志 on 14-12-14.
//
//

#import <UIKit/UIKit.h>

@protocol MFooterViewDelegate <NSObject>

-(void)footerToLeftBtn;
-(void)footerToRightBtn;

@end

@interface MFooterView : UIView

AS_FACTORY_FRAME(MFooterView);

AS_DELEGATE(id<MFooterViewDelegate>, delegate);

-(void)updateBackView:(UIColor*)color withImage:(NSString*)image;

-(void)addLeftIcon:(NSString*)icon withText:(NSString*)text;
-(void)addRightIcon:(NSString*)icon withText:(NSString*)text;

-(void)updateLeftBtn:(NSString*)text;
-(void)updateRightBtn:(NSString*)text;

-(void)updateLeftIcon:(NSString*)icon;
-(void)updateRightIcon:(NSString*)icon;


@end
