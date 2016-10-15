//
//  YH_config.h
//  YHPDFImageLoader
//
//  Created by yaheng on 16/10/10.
//  Copyright © 2016年 yaheng. All rights reserved.
//

/**
 @abstract   You can set the pdf file deeper directory path based on mainBundle use this param.
 @discussion If nil, Will load the mainBundle.
 
 @note Here are some examples: 
 @code
 static NSString *const fileDeeperPath = nil;
 static NSString *const fileDeeperPath = @"/pdf";
 static NSString *const fileDeeperPath = @"YHPDFImage.bundle";
 static NSString *const fileDeeperPath = @"YHPDFImage.bundle/pdf";
 @endcode
 
 @since Available in YHPDFImageLoader 1.0.
 */
static NSString *const fileDeeperPath = nil;


/** 
 @abstract If the parameter is 1, will display the log message to the console.
 */
#define YHPDFImageLogShow 0
