//
//  YHPDFImageDraw.h
//  YHPDFImageLoader
//
//  Created by yaheng on 16/10/10.
//  Copyright © 2016年 yaheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPDFImageDraw : NSObject

/**
 @abstract Draw image use PDF file.

 @param url       the native PDF file url
 @param size      image size of expected
 @param stretched if the expected size is different from the specified PDF icon file aspect ratio，stretch it or not.

 @return the image of generated.
 */
+ (UIImage *)drawImageWithURL:(NSURL *)url size:(CGSize)size canStretched:(BOOL)stretched;

@end
