//
//  DLModel.h
//  DLBase
//
//  Created by lucaslu on 15/12/15.
//  Copyright © 2015年 lucaslu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#undef	AS_MODEL_STRONG
#define	AS_MODEL_STRONG( __class, __tag ) \
    @property (nonatomic, strong) __class *	__tag;

#undef	AS_MODEL_COPY
#define	AS_MODEL_COPY( __class, __tag ) \
@property (nonatomic, copy) __class *	__tag;

#undef	AS_MODEL_ASSIGN
#define	AS_MODEL_ASSIGN( __class, __tag ) \
    @property (nonatomic, assign) __class 	__tag;

#undef	AS_MODEL_WEEK
#define	AS_MODEL_WEEK( __class, __tag ) \
    @property (nonatomic, week) __class *	__tag;

#undef AS_MODEL_READONLY
#define AS_MODEL_READONLY( __class,  __tag) \
    @property (nonatomic,strong,readonly) __class *	__tag;

#undef	AS_BLOCK
#define	AS_BLOCK( __class, __tag) \
    @property (nonatomic,copy) __class __tag;

#undef	AS_DELEGATE
#define	AS_DELEGATE( __class, __tag) \
    @property (nonatomic,assign) __class __tag;

#undef	AS_MODEL
#define	AS_MODEL( __class, __tag ) \
    @property (nonatomic) __class __tag;

#undef	DEF_MODEL
#define	DEF_MODEL( __tag ) \
    @synthesize __tag;

#undef	DEF_DYNAMIC
#define	DEF_DYNAMIC( __tag ) \
    @dynamic __tag;

#undef  AS_INT_ASSIGN
#define AS_INT_ASSIGN(__tag) \
    @property (nonatomic,assign) NSInteger __tag;

#undef  AS_BOOL_ASSIGN
#define AS_BOOL_ASSIGN(__tag) \
    @property (nonatomic,assign) BOOL __tag;

#undef  AS_FLOAT_ASSIGN
#define AS_FLOAT_ASSIGN(__tag) \
    @property (nonatomic,assign) CGFloat __tag;

#undef  AS_POINT_ASSIGN
#define AS_POINT_ASSIGN(__tag) \
    @property (nonatomic,assign) CGPoint __tag;

#undef  AS_SIZE_ASSIGN
#define AS_SIZE_ASSIGN(__tag) \
    @property (nonatomic,assign) CGSize __tag;

#undef  AS_RECT_ASSIGN
#define AS_RECT_ASSIGN(__tag) \
    @property (nonatomic,assign) CGRect __tag;

#undef  AS_INT
#define AS_INT(__tag) \
    AS_MODEL(NSInteger, __tag)

#undef  AS_BOOL
#define AS_BOOL(__tag) \
    AS_MODEL(BOOL, __tag)

#undef  AS_FLOAT
#define AS_FLOAT(__tag) \
    AS_MODEL(CGFloat, __tag)

#undef  AS_POINT
#define AS_POINT(__tag) \
    AS_MODEL(CGPoint, __tag)

#undef  AS_SIZE
#define AS_SIZE(__tag) \
    AS_MODEL(CGSize, __tag)

#undef  AS_RECT
#define AS_RECT(__tag) \
    AS_MODEL(CGRect, __tag)


@interface DLModel : NSObject

@end
