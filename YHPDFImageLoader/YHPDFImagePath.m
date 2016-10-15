//
//  YHPDFImagePath.m
//  YHPDFImageLoader
//
//  Created by yaheng on 16/10/10.
//  Copyright © 2016年 yaheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHPDFImagePath.h"
#import "YH_config.h"
#import "NSString+YHMD5.h"

@implementation YHPDFImagePath

+ (NSURL *)fileURLWithName:(NSString *)name {
    if (!name || !name.length) {
        return nil;
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil inDirectory:fileDeeperPath];
    
    return path ? [ NSURL fileURLWithPath:path] : nil;
}

+ (NSString *)cacheFilePathWithURL:(NSURL *)url atSize:(CGSize)size canStretched:(BOOL)stretched {
    
    NSString *cachePath = [NSString stringWithFormat:@"%@&%@&%i",
                           [[url path] lastPathComponent],
                           NSStringFromCGSize(size),
                           stretched];
    
    NSString *cacheName = [cachePath yh_MD5];
    
    NSString *cacheFilePath = [NSString stringWithFormat:@"%@/%@.png", [self getCacheFileDirectory],cacheName];
    
    return cacheFilePath;
}

+ (NSString *)getCacheFileDirectory {
    NSString *cachesDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSString *cacheFileDirectory = [NSString stringWithFormat:@"%@/YHPDFIMAGE_CACHE", cachesDirectoryPath];
    
    return cacheFileDirectory;
}

@end
