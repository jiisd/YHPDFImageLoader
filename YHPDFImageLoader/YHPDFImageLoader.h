//
//  YHPDFImageLoader.h
//  YHPDFImageLoader
//
//  Created by yaheng on 16/10/10.
//  Copyright © 2016年 yaheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPDFImageLoader : NSObject

/**
 @abstract Load image 
 @discussion Get image will use the following way: Memory -> Disk -> Draw
 
 @param url       the native PDF file url
 @param size      image size of expected
 @param stretched if the expected size is different from the specified PDF icon file aspect ratio，stretch it or not.

 @return image
 */
+ (UIImage *)getPDFImageWithURL:(NSURL *)url size:(CGSize)size canStretched:(BOOL)stretched;

@end
