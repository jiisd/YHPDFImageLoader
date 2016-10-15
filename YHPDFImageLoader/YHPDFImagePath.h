//
//  YHPDFImagePath.h
//  YHPDFImageLoader
//
//  Created by yaheng on 16/10/10.
//  Copyright © 2016年 yaheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPDFImagePath : NSObject

+ (NSURL *)fileURLWithName:(NSString *)name;

+ (NSString *)cacheFilePathWithURL:(NSURL *)url atSize:(CGSize)size canStretched:(BOOL)stretched;

+ (NSString *)getCacheFileDirectory;

@end
