//
//  YHPDFImageLoaderViewController.m
//  Demo
//
//  Created by yaheng on 16/10/15.
//  Copyright © 2016年 yaheng. All rights reserved.
//

#import "YHPDFImageLoaderViewController.h"
#import "UIImage+YHPDFIcon.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)
#define CONTROLVIEW_HEIGHT (SCREEN_HEIGHT - SCREEN_WIDTH)
#define RANDOM_COLOR [UIColor colorWithRed:arc4random_uniform(250)/250.0 green:arc4random_uniform(250)/250.0 blue:arc4random_uniform(250)/250.0 alpha:1]

#define BUTTON_COUNT   6
#define BUTTON_0_TITLE @"original size"
#define BUTTON_1_TITLE @"10 * 10 size"
#define BUTTON_2_TITLE @"200 * 200 size"
#define BUTTON_3_TITLE @"400 * 400 size"
#define BUTTON_4_TITLE @"400 * 400 size (stretch)"
#define BUTTON_5_TITLE @"2000 * 2000 size"

@interface YHPDFImageLoaderViewController ()
@property (nonatomic, strong) UIImageView *pdfImageView;
@property (nonatomic, strong) UIView *controlView;

@end

@implementation YHPDFImageLoaderViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // if need
//    [YHPDFImageCache removeCacheWithMemory];
}

#pragma mark - private method
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.pdfImageView];
    [self.view addSubview:self.controlView];
    
    /* if fileDeeperPath = nil */
    NSString *pdfName = @"home_page_location_icon";
    
    /* if fileDeeperPath = @"/pdf" */
//     pdfName = @"pdf-test";
    
    /* if fileDeeperPath = @"YHPDFImage.bundle" */
//     pdfName = @"bundle-test";
    
    /* if fileDeeperPath = @"YHPDFImage.bundle/pdf" */
//     pdfName = @"bundle-pdf-test";
    
    UIImage *image = [UIImage yh_imageNamed:pdfName];
    [self updatePdfImageViewWithImage:image];
}

- (void)buttonAction:(UIButton *)button {
    NSString *title = button.currentTitle;
    
    UIImage *image;
    if ([title isEqualToString:BUTTON_0_TITLE]) {
        image = [UIImage yh_imageWithPDFFileNamed:@"home_page_location_icon"];
        
    }else if ([title isEqualToString:BUTTON_1_TITLE]) {
        image = [UIImage yh_imageWithPDFFileNamed:@"home_page_location_icon" expectSize:CGSizeMake(10, 10)];
        
    }else if ([title isEqualToString:BUTTON_2_TITLE]) {
        image = [UIImage yh_imageWithPDFFileNamed:@"home_page_location_icon" expectSize:CGSizeMake(200, 200)];
        
    }else if ([title isEqualToString:BUTTON_3_TITLE]) {
        image = [UIImage yh_imageWithPDFFileNamed:@"home_page_location_icon.pdf" expectSize:CGSizeMake(400, 400)];
        
    }else if ([title isEqualToString:BUTTON_4_TITLE]) {
        image = [UIImage yh_imageWithPDFFileNamed:@"home_page_location_icon.pdf" expectSize:CGSizeMake(400, 400) canStretched:YES];
        
    }else {
        image = [UIImage yh_imageWithPDFFileNamed:@"home_page_location_icon" expectSize:CGSizeMake(2000, 2000)];
    }
    
    [self updatePdfImageViewWithImage:image];
}

- (void)updatePdfImageViewWithImage:(UIImage *)image {
    self.pdfImageView.image = image;
    [self.pdfImageView sizeToFit];
    CGFloat pdfImageViewCenterFloat = SCREEN_WIDTH * 0.5;
    self.pdfImageView.center = CGPointMake(pdfImageViewCenterFloat, pdfImageViewCenterFloat);
}

#pragma mark - getter
- (UIImageView *)pdfImageView {
    if (!_pdfImageView) {
        _pdfImageView = [[UIImageView alloc] init];
        _pdfImageView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
    }
    return _pdfImageView;
}

- (UIView *)controlView {
    if (!_controlView) {
        _controlView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - CONTROLVIEW_HEIGHT, SCREEN_WIDTH, CONTROLVIEW_HEIGHT)];
        _controlView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
        
        CGFloat btnHeight = CONTROLVIEW_HEIGHT / BUTTON_COUNT;
        for (int i = 0; i < BUTTON_COUNT; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, btnHeight * i, SCREEN_WIDTH, btnHeight)];
            btn.backgroundColor = RANDOM_COLOR;
            [btn addTarget:nil action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            NSString *title;
            if (0 == i) {
                title = BUTTON_0_TITLE;
            }else if (1 == i) {
                title = BUTTON_1_TITLE;
            }else if (2 == i) {
                title = BUTTON_2_TITLE;
            }else if (3 == i) {
                title = BUTTON_3_TITLE;
            }else if (4 == i) {
                title = BUTTON_4_TITLE;
            }else{
                title = BUTTON_5_TITLE;
            }
            
            [btn setTitle:title forState:UIControlStateNormal];
            [_controlView addSubview:btn];
        }
    }
    return _controlView;
}

@end
