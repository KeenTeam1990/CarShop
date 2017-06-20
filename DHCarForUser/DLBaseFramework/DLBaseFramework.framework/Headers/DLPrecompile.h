//
//  DLPrecompile.h
//  TickTock
//
//  Created by 卢迎志 on 14-11-28.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <Foundation/Foundation.h>


// ----------------------------------
// Option values
// ----------------------------------

#undef	__ON__
#define __ON__		(1)

#undef	__OFF__
#define __OFF__		(0)

#undef	__AUTO__

#if defined(_DEBUG) || defined(DEBUG)
    #define __AUTO__	(1)
#else
    #define __AUTO__	(0)
#endif

// ----------------------------------
// Global compile option
// ----------------------------------

#define __DL_DEVELOPMENT__				(__ON__)
#define	__DL_PERFORMANCE__				(__OFF__)
#define __DL_LOG__						(__ON__)
#define __DL_UNITTEST__                (__OFF__)
#define __DL_LIVELOAD__				(__ON__)

#pragma mark -

#if defined(__DL_LOG__) && __DL_LOG__
    #if DEBUG
        #undef	NSLog
        #define	NSLog	PRINT

        #undef  DLog
        #define DLog NSLog
    #else
        #undef NSLog
        #define NSLog(...)

        #undef  DLog
        #define DLog(...)
    #endif //DEBUG
#else
    #undef NSLog
    #define NSLog(...)

    #undef  DLog
    #define DLog(...)
#endif	// #if (__ON__ == __DL_LOG__)

#undef	UNUSED
#define	UNUSED( __x ) \
{ \
    id __unused_var__ __attribute__((unused)) = (__x); \
}

#undef	ALIAS
#define	ALIAS( __a, __b ) \
    __typeof__(__a) __b = __a;

#pragma mark -

#if !defined(__clang__) || __clang_major__ < 3

    #ifndef __bridge
    #define __bridge
#endif

    #ifndef __bridge_retain
    #define __bridge_retain
#endif

    #ifndef __bridge_retained
    #define __bridge_retained
#endif

    #ifndef __autoreleasing
    #define __autoreleasing
#endif

    #ifndef __strong
    #define __strong
#endif

    #ifndef __unsafe_unretained
    #define __unsafe_unretained
#endif

    #ifndef __weak
    #define __weak
#endif

#endif

#if __has_feature(objc_arc)

    #define DL_PROP_RETAIN					strong
    #define DL_PROP_ASSIGN					assign

    #define DL_RETAIN( x )					(x)
    #define DL_RELEASE( x )				(x)
    #define DL_AUTORELEASE( x )			(x)

    #define DL_BLOCK_COPY( x )				(x)
    #define DL_BLOCK_RELEASE( x )			(x)
    #define DL_SUPER_DEALLOC()

    #define DL_AUTORELEASE_POOL_START()	@autoreleasepool {
    #define DL_AUTORELEASE_POOL_END()		}

#else

    #define DL_PROP_RETAIN					retain
    #define DL_PROP_ASSIGN					assign

    #define DL_RETAIN( x )					[(x) retain]
    #define DL_RELEASE( x )				[(x) release]
    #define DL_AUTORELEASE( x )			[(x) autorelease]

    #define DL_BLOCK_COPY( x )				Block_copy( x )
    #define DL_BLOCK_RELEASE( x )			Block_release( x )
    #define DL_SUPER_DEALLOC()				[super dealloc]

    #define DL_AUTORELEASE_POOL_START()	NSAutoreleasePool * __pool = [[NSAutoreleasePool alloc] init];
    #define DL_AUTORELEASE_POOL_END()		[__pool release];

#endif

#undef	DL_DEPRECATED
#define	DL_DEPRECATED	__attribute__((deprecated))

#undef	DL_EXTERN
#if defined(__cplusplus)
    #define DL_EXTERN		extern "C"
#else	// #if defined(__cplusplus)
    #define DL_EXTERN		extern
#endif	// #if defined(__cplusplus)

#pragma mark -

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000

#define UILineBreakMode					NSLineBreakMode
#define UILineBreakModeWordWrap			NSLineBreakByWordWrapping
#define UILineBreakModeCharacterWrap	NSLineBreakByCharWrapping
#define UILineBreakModeClip				NSLineBreakByClipping
#define UILineBreakModeHeadTruncation	NSLineBreakByTruncatingHead
#define UILineBreakModeTailTruncation	NSLineBreakByTruncatingTail
#define UILineBreakModeMiddleTruncation	NSLineBreakByTruncatingMiddle

#define UITextAlignmentLeft				NSTextAlignmentLeft
#define UITextAlignmentCenter			NSTextAlignmentCenter
#define UITextAlignmentRight			NSTextAlignmentRight
#define	UITextAlignment					NSTextAlignment

#endif	// #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000

#ifndef	weakify
    #if __has_feature(objc_arc)
        #define weakify( x )	autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x;
    #else	// #if __has_feature(objc_arc)
        #define weakify( x )	autoreleasepool{} __block __typeof__(x) __block_##x##__ = x;
    #endif	// #if __has_feature(objc_arc)
#endif	// #ifndef	weakify

#ifndef	normalize
    #if __has_feature(objc_arc)
        #define normalize( x )	try{} @finally{} __typeof__(x) x = __weak_##x##__;
    #else	// #if __has_feature(objc_arc)
        #define normalize( x )	try{} @finally{} __typeof__(x) x = __block_##x##__;
    #endif	// #if __has_feature(objc_arc)
#endif	// #ifndef	@normalize

#pragma mark -

typedef void ( *ImpFuncType )( id a, SEL b, void * c );

