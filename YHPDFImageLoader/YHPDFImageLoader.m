//
//  YHPDFImageLoader.m
//  YHPDFImageLoader
//
//  Created by yaheng on 16/10/10.
//  Copyright © 2016年 yaheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHPDFImageLoader.h"
#import "YHPDFImageCache.h"
#import "YHPDFImageDraw.h"
#import "YHPDFImagePath.h"

@implementation YHPDFImageLoader

+ (UIImage *)getPDFImageWithURL:(NSURL *)url size:(CGSize)size canStretched:(BOOL)stretched {
    UIImage *image = nil;
    
    // get path
    NSString *cacheFilePath = [YHPDFImagePath cacheFilePathWithURL:url atSize:size canStretched:stretched];
    
    // load from cache
    image = [YHPDFImageCache getCachedImageWithCacheFilePath:cacheFilePath];
    
    // if not, draw image
    if (image) {
        return image;
    }else {
        image = [YHPDFImageDraw drawImageWithURL:url size:size canStretched:stretched];
        if (image) {
            // cache
            [YHPDFImageCache saveCacheImage:image cacheFilePath:cacheFilePath];
        }
    }

    return image;
}

@end
