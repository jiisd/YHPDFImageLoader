//
//  YHPDFImageLoaderAppDelegate.m
//  Demo
//
//  Created by yaheng on 16/10/15.
//  Copyright © 2016年 yaheng. All rights reserved.
//

#import "YHPDFImageLoaderAppDelegate.h"
#import "YHPDFImageLoaderViewController.h"

@implementation YHPDFImageLoaderAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[YHPDFImageLoaderViewController alloc] init];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
