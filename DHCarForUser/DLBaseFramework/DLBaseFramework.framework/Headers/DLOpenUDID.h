//
//  OpenUDID.h
//  openudid
//
//  initiated by Yann Lechelle (cofounder @Appsfire) on 8/28/11.
//  Copyright 2011 OpenUDID.org
//

/*
    !!! IMPORTANT !!!

    IF YOU ARE GOING TO INTEGRATE OpenUDID INSIDE A (STATIC) LIBRARY,
    PLEASE MAKE SURE YOU REFACTOR THE OpenUDID CLASS WITH A PREFIX OF YOUR OWN,
    E.G. ACME_OpenUDID. THIS WILL AVOID CONFUSION BY DEVELOPERS WHO ARE ALSO
    USING OpenUDID IN THEIR OWN CODE. 

    !!! IMPORTANT !!!
*/

#import <Foundation/Foundation.h>

#define kOpenUDIDErrorNone          0
#define kOpenUDIDErrorOptedOut      1
#define kOpenUDIDErrorCompromised   2

@interface DLOpenUDID : NSObject

+ (NSString*) value;
+ (NSString*) valueWithError:(NSError**)error;
+ (void) setOptOut:(BOOL)optOutValue;

@end
