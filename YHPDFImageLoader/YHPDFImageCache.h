//
//  YHPDFImageCache.h
//  YHPDFImageLoader
//
//  Created by yaheng on 16/10/10.
//  Copyright © 2016年 yaheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YHPDFImageCache : NSObject

/**
 @abstract Set the caching in memory of images.
 @discussion Default : NO
 
 @param shouldCache Open or close the function
 */
+ (void)setShouldCacheWithMemory:(BOOL)shouldCache;

/**
 @abstract Set the caching in disk of images.
 @discussion Default : YES
 
 @param shouldCache Open or close the function
 */
+ (void)setShouldCacheWithDisk:(BOOL)shouldCache;

/**
 @abstract Get the size used by the disk cache.
 */
+ (NSUInteger)getDiskCacheSize;

/**
 @abstract To remove data in memory.
 */
+ (void)removeCacheWithMemory;

/**
 @abstract To remove data in disk.
 */
+ (void)removeCacheWithDisk;

/**
 @abstract Cache image on memory and disk if needed.

 @param image         need the image of the cache
 @param cacheFilePath cache of native path.
 */
+ (void)saveCacheImage:(UIImage *)image cacheFilePath:(NSString *)cacheFilePath;

/**
 @abstract Get image from the memory or disk.
 @discussion if not, return nil.
 
 @param cacheFilePath cache of native path

 @return cached image.
 */
+ (UIImage *)getCachedImageWithCacheFilePath:(NSString *)cacheFilePath;

@end
