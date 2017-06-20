//
//  MTabView.h
//  Auction
//
//  Created by 卢迎志 on 14-12-9.
//
//

@protocol MTabViewDelegate <NSObject>

-(void)seleteTabItem:(int)index;

@end

@interface MTabView : UIView

AS_FACTORY_FRAME(MTabView);

AS_DELEGATE(id<MTabViewDelegate>, delegate);

-(void)addTabItem:(NSString*)title;

-(void)show;

-(void)seleteTabItem:(int)item;

@end
