//
//  UIImage+YHPDFIcon.m
//  YHPDFImageLoader
//
//  Created by yaheng on 16/10/10.
//  Copyright © 2016年 yaheng. All rights reserved.
//

#import "UIImage+YHPDFIcon.h"
#import "YHPDFImagePath.h"
#import "YHPDFImageLoader.h"

#define CheckString(str)    if (!str || !str.length) { \
                                return nil; \
                            }

@implementation UIImage (YHPDFIcon)

+ (UIImage *)yh_imageNamed:(NSString *)name {
    CheckString(name)
    
    UIImage *image = nil;
    image = [UIImage yh_imageWithPDFFileNamed:name];
    
    if (image) {
        return image;
    }else {
        return [UIImage imageNamed:name];
    }
}

+ (UIImage *)yh_imageWithContentsOfFile:(NSString *)path {
    CheckString(path)
    
    UIImage *image = nil;
    image = [UIImage yh_imageWithPDFFileURL:[NSURL fileURLWithPath:path]];
    
    if (image) {
        return image;
    }else {
        return [UIImage imageWithContentsOfFile:path];
    }
}

+ (UIImage *)yh_imageWithPDFFileNamed:(NSString *)fileName {
    return [UIImage yh_imageWithPDFFileNamed:fileName expectSize:CGSizeZero];
}

+ (UIImage *)yh_imageWithPDFFileNamed:(NSString *)fileName expectSize:(CGSize)size {
    return [UIImage yh_imageWithPDFFileNamed:fileName expectSize:(CGSize)size canStretched:NO];
}

+ (UIImage *)yh_imageWithPDFFileNamed:(NSString *)fileName expectSize:(CGSize)size canStretched:(BOOL)stretched {
    CheckString(fileName)
    
    if (![[fileName pathExtension] isEqualToString:@"pdf"]) {
        fileName = [fileName stringByAppendingString:@".pdf"];
    }
    NSURL *url = [YHPDFImagePath fileURLWithName:fileName];
    if (!url) { return nil; }
    
    return [YHPDFImageLoader getPDFImageWithURL:url size:size canStretched:stretched];
}

+ (UIImage *)yh_imageWithPDFFileURL:(NSURL *)fileURL {
    return [UIImage yh_imageWithPDFFileURL:fileURL expectSize:CGSizeZero];
}

+ (UIImage *)yh_imageWithPDFFileURL:(NSURL *)fileURL expectSize:(CGSize)size {
    return [UIImage yh_imageWithPDFFileURL:fileURL expectSize:size canStretched:NO];
}

+ (UIImage *)yh_imageWithPDFFileURL:(NSURL *)fileURL expectSize:(CGSize)size canStretched:(BOOL)stretched {
   return [YHPDFImageLoader getPDFImageWithURL:fileURL size:size canStretched:stretched];
}

@end
