//
//  DLStyle.h
//  DLBase
//
//  Created by lucaslu on 15/12/16.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DLSingleton.h"
#import "DLModel.h"

#define DEF_ZERO_STYLE \
    + (DLStyle*) zeroStyle; \
    { \
        static DLStyle* style = nil; \
        static dispatch_once_t onceToken; \
        dispatch_once(&onceToken, ^{ \
        style = [[[self class] alloc] init]; \
        \
    }); \
    return style; \
}

#define DEF_SHARE_STYLE(name , initCode, cla) \
    cla* DLStyle##name(){ \
    static cla* style = nil; \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        \
        style = DLStyleMake(initCode, cla); \
    }); \
    return style; \
}

#define AS_SHARE_STYLE(name, cla)  FOUNDATION_EXTERN cla* DLStyle##name();

#define DLBeginCopyAttribute(cla) \
    cla* origin = (cla*)style; \
    [super copyAttributesWithStyle:style]; \

#define DLFinishCopyAttribute  [self setAttributeNeedRefresh];

#define DLStyleCopyAttribute(attr) \
    if ([style respondsToSelector:@selector(attr)]) { \
        self.attr = origin.attr; \
    }

#define DLStyleCopyAttribute_Copy(attr)\
    if ([style respondsToSelector:@selector(attr)]) {\
        self.attr = [origin.attr copy];\
    }


@interface DLStyle : NSObject<NSCopying>

AS_MODEL_STRONG(NSMutableArray, childStyle);

@property (nonatomic, strong, readonly) NSString* key;
@property (nonatomic, weak, readonly) UIView* linkedView;

/**
 *  标准的样式，采用空的默认样式
 *
 *  @return 空的默认样式
 */
+ (DLStyle*) zeroStyle;
/**
 *  用该模式渲染制定的View
 *
 *  @param aView 需要渲染的View
 */
- (void) decorateView:(UIView*)aView;

//
/**
 *  将该样式关联到制定的View，当样式改变的时候会及时改变该View的样式
 *
 *  @param aView 关联的View
 */
- (void) installOnView:(UIView*)aView;
/**
 *  取消关联
 *
 *  @param aView 取消关联View
 */
- (void) unInstallOnView:(UIView*)aView;
//

/**
 *  当样式的属性改变的时候，调用该函数，会重新进行渲染。
 */
- (void) setAttributeNeedRefresh;

- (void) copyAttributesWithStyle:(id)style;

- (void) addChildStyle:(DLStyle*)style;

- (void) removeChildStyle:(DLStyle*)style;

- (void) removeAllChildStyle;;

@end
