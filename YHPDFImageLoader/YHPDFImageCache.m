//
//  YHPDFImageCache.m
//  YHPDFImageLoader
//
//  Created by yaheng on 16/10/10.
//  Copyright © 2016年 yaheng. All rights reserved.
//

#import "YHPDFImageCache.h"
#import "YHPDFImagePath.h"
#include "YH_config.h"

#if defined (YHPDFImageLogShow) && (YHPDFImageLogShow == 1)
    #define YHPDFLog(...) NSLog(__VA_ARGS__)

#else
    #define YHPDFLog(...)
#endif

static NSCache *_imagesCache;
static BOOL _imageShouldCacheWithMemory;
static BOOL _imageShouldCacheWithDisk;

@implementation YHPDFImageCache

+ (void)initialize {
    [super initialize];
    
    [YHPDFImageCache setShouldCacheWithMemory:NO];
    [YHPDFImageCache setShouldCacheWithDisk:YES];
}

+ (void)setShouldCacheWithMemory:(BOOL)shouldCache {
    _imageShouldCacheWithMemory = shouldCache;
    
    if(_imageShouldCacheWithMemory && !_imagesCache) {
        _imagesCache = [[NSCache alloc] init];
    }
    
    if (!_imageShouldCacheWithMemory && _imagesCache) {
        [YHPDFImageCache removeCacheWithMemory];
        _imagesCache = nil;
    }
}

+ (void)setShouldCacheWithDisk:(BOOL)shouldCache {
    _imageShouldCacheWithDisk = shouldCache;
    
    if (!_imageShouldCacheWithDisk) {
        [YHPDFImageCache removeCacheWithDisk];
    }
}

+ (void)removeCacheWithMemory {
    [_imagesCache removeAllObjects];
}

+ (void)removeCacheWithDisk {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *cacheFileDirectory = [YHPDFImagePath getCacheFileDirectory];
    if ([fileManager fileExistsAtPath:cacheFileDirectory]) {
        NSError *err;
        [fileManager removeItemAtPath:cacheFileDirectory error:&err];
        if (err) {
            YHPDFLog(@"remove failed err:%@",err);
        }else {
            YHPDFLog(@"remove succeed");
        }
    }
}

+ (NSUInteger)getDiskCacheSize {
    NSUInteger size = 0;
    NSString *cacheFileDirectory = [YHPDFImagePath getCacheFileDirectory];
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:cacheFileDirectory];
    
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [cacheFileDirectory stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        size += [attrs fileSize];
    }
    
    return size;
}

+ (UIImage *)getCachedImageWithCacheFilePath:(NSString *)cacheFilePath {
    UIImage *image;
    
    // Memory
    if (_imageShouldCacheWithMemory && _imagesCache) {
        image = [_imagesCache objectForKey:cacheFilePath];
    }
    if (image) {
        YHPDFLog(@"--------- load image frome memory %@---------", [cacheFilePath lastPathComponent]);
        return image;
    }
    
    // Disk
    if (_imageShouldCacheWithDisk && [[NSFileManager defaultManager] fileExistsAtPath:cacheFilePath]) {
        image = [UIImage imageWithContentsOfFile:cacheFilePath];
        // need transform image scale
        image = [UIImage imageWithCGImage:image.CGImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
        
        // save to Memory
        if (_imageShouldCacheWithMemory && _imagesCache) {
            [_imagesCache setObject:image forKey:cacheFilePath];
        }
    }
    if (image) {
        YHPDFLog(@"--------- load image frome disk %@---------", [cacheFilePath lastPathComponent]);
        return image;
    }
    
    return nil;
}

+ (void)saveCacheImage:(UIImage *)image cacheFilePath:(NSString *)cacheFilePath {
    if (!image || !cacheFilePath) { return ; }
    YHPDFLog(@"--------- create new image %@---------", [cacheFilePath lastPathComponent]);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // Memory
        if (_imageShouldCacheWithMemory && _imagesCache) {
            [_imagesCache setObject:image forKey:cacheFilePath];
        }
        
        // Disk
        if (_imageShouldCacheWithDisk) {
            // if not, creat
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *cacheFileDirectory = [YHPDFImagePath getCacheFileDirectory];
            if (![fileManager fileExistsAtPath:cacheFileDirectory]) {
                NSError *err;
                [fileManager createDirectoryAtPath:cacheFileDirectory withIntermediateDirectories:YES attributes:nil error:&err];
                if (err) {
                    YHPDFLog(@"create cache file directory failed err:%@",err);
                }else {
                    YHPDFLog(@"create cache file directory succeed");
                }
            }
            // save
            BOOL write = [UIImagePNGRepresentation(image) writeToFile:cacheFilePath atomically:YES];
            if (write) {
                YHPDFLog(@"image write succeed");
            }else {
                YHPDFLog(@"image write failed");
            }
        }
    });
}

@end
