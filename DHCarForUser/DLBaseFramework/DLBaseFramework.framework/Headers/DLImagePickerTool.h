//
//  DLImagePickerTool.h
//  TickTock
//
//  Created by 卢迎志 on 14-12-3.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DLSingleton.h"

typedef void (^ImagePickerToolBlock)(UIImage* image);

typedef void (^ImagePickerVideoToolBlock)(NSString* path,NSString* logo,NSString* lenght);

@interface DLImagePickerTool : NSObject<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

AS_SINGLETON(DLImagePickerTool);
/**
 *  对话框显示选择图片或拍照
 *
 *  @param controller 当前页面
 *  @param block      block
 *  @param edit       edit
 */
-(void)showImagePickerSheet:(UIViewController*)controller
                  withBlock:(ImagePickerToolBlock)block
                 withIsEdit:(BOOL)edit;

-(void)showImagePickerCamera:(UIViewController*)controller
                   withBlock:(ImagePickerToolBlock)block
                  withIsEdit:(BOOL)edit;

-(void)showImagePickerLibs:(UIViewController*)controller
                 withBlock:(ImagePickerToolBlock)block
                withIsEdit:(BOOL)edit;

-(void)showImagePickerVideo:(UIViewController*)controller
                  withBlock:(ImagePickerVideoToolBlock)block
                withMaxTime:(CGFloat)time;

- (void)encodeMovToMp4:(NSURL*)vUrl withPath:(NSString*)filepath;
- (CGFloat) getVideoDuration:(NSURL*) URL;
-(void)videoAv:(NSURL*)pathUrl withPath:(NSString*)path;

@end
