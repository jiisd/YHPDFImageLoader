//
//  YHPDFImageDraw.m
//  YHPDFImageLoader
//
//  Created by yaheng on 16/10/10.
//  Copyright © 2016年 yaheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHPDFImageDraw.h"

@implementation YHPDFImageDraw

+ (UIImage *)drawImageWithURL:(NSURL *)url size:(CGSize)size canStretched:(BOOL)stretched {
    return [YHPDFImageDraw drawImageWithURL:url size:size canStretched:stretched page:1];
}

+ (UIImage *)drawImageWithURL:(NSURL *)url size:(CGSize)size canStretched:(BOOL)stretched page:(NSUInteger)page {
    CGFloat screenScale = [UIScreen mainScreen].scale;
    
    CGPDFDocumentRef pdfRef = CGPDFDocumentCreateWithURL((__bridge CFURLRef)url);
    
    CGPDFPageRef imagePage = CGPDFDocumentGetPage(pdfRef, page);
    CGRect pdfRect = CGPDFPageGetBoxRect(imagePage, kCGPDFCropBox);
    
    CGSize contextSize;
    if (size.width <= 0 || size.height <= 0) {
        contextSize = pdfRect.size;
    }else {
        contextSize = size;
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, contextSize.width * screenScale, contextSize.height * screenScale, 8, 0, colorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGContextScaleCTM(context, screenScale, screenScale);
    
    if (size.width > 0 && size.height > 0) {
        CGFloat widthScale = size.width / pdfRect.size.width;
        CGFloat heightScale = size.height / pdfRect.size.height;
        
        if (!stretched) {
            heightScale = widthScale < heightScale ? widthScale : heightScale;
            widthScale = heightScale < widthScale ? heightScale : widthScale;
        }
    
        CGContextScaleCTM(context, widthScale, heightScale);
        
    }else {
        CGAffineTransform drawingTransform = CGPDFPageGetDrawingTransform(imagePage, kCGPDFCropBox, pdfRect, 0, true);
        CGContextConcatCTM(context, drawingTransform);
    }
    
    CGContextDrawPDFPage(context, imagePage);
    CGPDFDocumentRelease(pdfRef);
    
    CGImageRef image = CGBitmapContextCreateImage(context);
    UIImage *pdfImage = [[UIImage alloc] initWithCGImage:image scale:screenScale orientation:UIImageOrientationUp];
    
    CGImageRelease(image);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    return pdfImage;
}

@end
