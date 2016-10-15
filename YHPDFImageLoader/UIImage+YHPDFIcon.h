//
//  UIImage+YHPDFIcon.h
//  YHPDFImageLoader
//
//  Created by yaheng on 16/10/10.
//  Copyright © 2016年 yaheng. All rights reserved.
//
/*! Please contact me if you have any questions.
 
    __GitHub__:  https://github.com/jiisd/YHPDFImageLoader
    __E-mail__:  yahengzheng@163.com
 
 */

#import <UIKit/UIKit.h>
#import "YHPDFImageCache.h"

@interface UIImage (YHPDFIcon)

/**
@abstract Can be used to load the PDF icon file or original image.
 
@param name  the native PDF icon file (the image to be created using the PDF icon file of original size) or the original image name.
 
@return the image of request
*/
+ (UIImage *)yh_imageNamed:(NSString *)name;
+ (UIImage *)yh_imageWithContentsOfFile:(NSString *)path;

/**
 @abstract load the PDF icon file.
 @discussion the image to be created using the PDF icon file of original size.
 
 @param fileName  the native PDF icon file name
 
 @return the image of request
 */
+ (UIImage *)yh_imageWithPDFFileNamed:(NSString *)fileName;

/**
 @abstract load the PDF icon file.
 @discussion created image will use expect size, not stretch.
 
 @param fileName    the native PDF icon file name
 @param size        image size of expected
 
 @return the image of request
 */
+ (UIImage *)yh_imageWithPDFFileNamed:(NSString *)fileName expectSize:(CGSize)size;

/**
 @abstract load the PDF icon file.
 
 @param fileName    the native PDF icon file name
 @param size        image size of expected
 @param stretched   if the expected size is different from the specified PDF icon file aspect ratio，stretch it or not.
 
 @return the image of request
 */
+ (UIImage *)yh_imageWithPDFFileNamed:(NSString *)fileName expectSize:(CGSize)size canStretched:(BOOL)stretched;

/**
 @abstract load the PDF icon file.
 @discussion the image to be created using the PDF icon file of original size.
 
 @param fileURL  the native PDF icon file url
 
 @return the image of request
 */
+ (UIImage *)yh_imageWithPDFFileURL:(NSURL *)fileURL;

/**
 @abstract load the PDF icon file.
 @discussion created image will use expect size, not stretch.
 
 @param fileURL     the native PDF icon file url
 @param size        image size of expected
 
 @return the image of request
 */
+ (UIImage *)yh_imageWithPDFFileURL:(NSURL *)fileURL expectSize:(CGSize)size;

/**
 @abstract load the PDF icon file.
 
 @param fileURL     the native PDF icon file url
 @param size        image size of expected
 @param stretched   if the expected size is different from the specified PDF icon file aspect ratio，stretch it or not.
 
 @return the image of request
 */
+ (UIImage *)yh_imageWithPDFFileURL:(NSURL *)fileURL expectSize:(CGSize)size canStretched:(BOOL)stretched;

@end
